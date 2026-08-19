const fs = require("fs");
const project = require("./project.js");
const assert = require("node:assert");
const { gatherProjectSourceTags, TagInfo } = require("./project-tags.js");
const { IniFile } = require("./ini-file.js");

const locTags = gatherProjectSourceTags().filter(tag => {
    return tag.type.startsWith("loc:");
})

const LangDirectory = project.locate("datafiles", "lang", "");
const LangMobileDirectory = project.locate("datafiles", "lang_mobile", "");

const LanguageList = [ "Base" ];

function loadLanguageSheetInfo() {
    const csvFileNames = fs.readdirSync(LangDirectory).filter(s => s.endsWith(".csv"));
    const languageStartColumnTitle = "Text";
    const languageStartColumnOffset = languageStartColumnTitle.length;
    
    for(const tableName of csvFileNames) {
        const csvFilePath = LangDirectory + tableName;
        const csvContents = fs.readFileSync(csvFilePath, "utf-8");
        const newlineIndex = csvContents.indexOf("\n");
        assert.notEqual(newlineIndex, -1);
        const startColumnTitle = csvContents.indexOf(languageStartColumnTitle);
        const line = csvContents.substring(startColumnTitle + languageStartColumnOffset + 1, newlineIndex).trim();
        const languages = line.split(",").filter(s => s.length);
        LanguageList.push(...languages);
    }
}
loadLanguageSheetInfo();

function generateTemplateFiles() {
    const timestamp = new Date().toLocaleDateString("en-UK", {
        year: "numeric",
        month: "long",
        day: "numeric",
        hour: "numeric",
        minute: "numeric",
        timeZoneName: "short"
    });
    const header = "# Last updated on " + timestamp + "\n";
    for(const language of LanguageList) {
        const mobileLangFileName = language + ".ini";
        const mobileTemplatePath = LangMobileDirectory + mobileLangFileName;
        console.log("Updating", mobileLangFileName);
        if (language == "Base") {
            let ini = generateTemplateIni(null);
            fs.writeFileSync(mobileTemplatePath, header
                + "# This file is a template for custom new localizations. It's unused in game and any changes made made here here won't persist after re-generation.\n\n"
                + ini.toIniFileString());
            continue;
        }
        if (fs.existsSync(mobileTemplatePath)) {
            let contents = fs.readFileSync(mobileTemplatePath, "utf-8");
            let ini = IniFile.fromString(contents);

            // update the ini with new fields
            generateTemplateIni(ini);
            
            fs.writeFileSync(mobileTemplatePath, header + "\n" + ini.toIniFileString());
        }
        else {
            let ini = generateTemplateIni();
            fs.writeFileSync(mobileTemplatePath, header + "\n" + ini.toIniFileString());
            console.log(mobileLangFileName, "file didn't exist, so an empty template was created.");
        }
    }
}
generateTemplateFiles();

/** @returns {IniFile} */
function generateTemplateIni(originalIni, includeTokenLocations=false) {
    let ini = new IniFile();
    for(let tag of locTags) {
        let type = tag.type;
        let section = tag.section.slice(1, tag.section.length - 1);
        if (type == "loc:note") {
            ini.insertComment(section, tag.string);
        }
        else if (type == "loc:token") {
            ini.setValue(section, tag.key, tag.string, includeTokenLocations ? tag.getLocation() : null);
        }
    }
    
    if (originalIni) {
        originalIni.safeMerge(ini, true);
        return originalIni;
    }
    return ini;
}