class IniFile {
    sections = {};
    sectionEntries = {};
    addSection(name) {
        if (name in this.sections) {
            return this.sections[name];
        }
        this.sectionEntries[name] = {};
        return this.sections[name] = [];
    }
    getSection(name) {
        return this.sections[name];
    }
    getSectionFields(name) {
        let fields = {};
        let section = this.sections[name];
        for(let [ key, value ] of section) {
            if (key.startsWith("#") && !(key in fields)) {
                fields[key] = value;
            }
        }
        return fields;
    }
    setValue(section, key, value, inlineComment=null) {
        let list = this.sectionEntries[section];
        if (list && (key in list)) {
            list[key][1] = value;
        }
        else {
            let entry = this.addEntry(section, key, value);
            if (!list) {
                list = this.sectionEntries[section] = {};
            }
            list[key] = entry;
        }
        if (inlineComment) list[key][2] = inlineComment;
    }
    addEntry(section, key, value, inlineComment=null) {
        if (typeof(value) == "string" && value.indexOf("#") != -1 && !value.startsWith("\"")) {
            value = "\"" + value + "\"";
        }
        let entry = [ key, value, inlineComment ]
        this.addSection(section).push(entry);
        return entry;
    }
    insertComment(section, comment) {
        if (comment.indexOf("#") === -1) {
            comment = "# " + comment;
        }
        this.addSection(section).push([ comment, null, null ]);
    }
    static fromString(string) {
        let ini = new IniFile();
        let currentSection = null;
        const lines = string.split("\n");
        for(let line of lines) {
            line = line.trim();
            if (line.length == 0 || line[0] == "#") continue;
            if (line.startsWith("[") && line.endsWith("]")) {
                currentSection = line.slice(1, line.length - 1);
                ini.addSection(currentSection);
                continue;
            }
            let equalsSign = line.indexOf("=");
            if (!currentSection || equalsSign == -1) continue;
            let lhs = line.slice(0, equalsSign);
            let rhs = line.substring(equalsSign + 1);
            let q = rhs.indexOf("\"");
            if (q != -1) {
                let end = rhs.indexOf("\"", ++q);
                if (end != -1) rhs = rhs.slice(q, end);
            }
            else {
                q = rhs.indexOf("#");
                if (q != -1) {
                    rhs = rhs.slice(0, q).trimEnd();
                }
            }
            ini.setValue(currentSection, lhs, rhs);
        }
        return ini;
    }
    toIniFileString() {
        let result = "";
        for(let [ section, entries ] of Object.entries(this.sections)) {
            result += "[" + section + "]\n";
            for(let [key, value, comment] of entries) {
                if (value === null) {
                    if (key.startsWith("#")) {
                        result += (key === "#\n") ? "\n" : key + "\n";
                    }
                    continue;
                }
                if (typeof(value) === "string" && value.indexOf("#") != -1 && !value.startsWith("\"")) {
                    value = "\"" + value + "\"";
                }
                if (comment) {
                    result += key + "=" + value + " # " + comment + "\n";
                }
                else result += key + "=" + value + "\n";
            }
            result += "\n";
        }
        return result.trimEnd();
    }
    safeMerge(iniFile, overrideNulls=false) {
        const mySections = this.sections;
        const mergeSectionEntries = Object.entries(iniFile.sections);

        for (const [ msectName, msectEntries ] of mergeSectionEntries) {
            if (!(msectName in mySections)) {
                let newSection = [];
                for(let entry of msectEntries) newSection.push([ ...entry ]);
                mySections[msectName] = newSection;
                continue;
            }
            
            for(let j = 0; j < msectEntries.length; ++j) {
                let any = false;
                let newSection = mySections[msectName];
                let newEntry = msectEntries[j];
                for(let i = 0; i < newSection.length; ++i) {
                    let currentEntry = newSection[i];
                    if (currentEntry[0] == newEntry[0]) {
                        if ((typeof currentEntry[0] === "string")
                            && currentEntry[0].startsWith("#")
                        ) {
                            continue;
                        }
                        if (overrideNulls && (currentEntry[1] === null || currentEntry[1] === "")) {
                            newSection.splice(i --, 1);
                            break;
                        }
                        // try match the order from merged .ini file so that
                        // comments are placed in their expected locations
                        mySections[msectName].splice(i, 1);
                        mySections[msectName].splice(j, 0, currentEntry);
                        any = true;
                        break;
                    }
                }
                if (!any) {
                    mySections[msectName].splice(j, 0, newEntry);
                }
            }
        }

        this.sections = Object.fromEntries(Object.entries(this.sections).sort((a, b) => {
            return String(b[1]).length - String(a[1]).length;
        }));

        this.sectionEntries = {};
        for(let [ name, entries ] of Object.entries(this.sections)) {
            let list = this.sectionEntries[name] = {};
            for(let entry of entries) {
                list[entry[0]] = entry;
            }
        }
    }
}

module.exports = { IniFile };