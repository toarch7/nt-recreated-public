const { projectDirectory } = require("./project.js");

const ScriptsDir = projectDirectory + "scripts/";
const ObjectsDir = projectDirectory + "objects/";

const fs = require("fs");

function parseEnums(input) {
    if (input.trim().length === 0) return;

    /** @type string */
    let string = input.replace(/\/\/.*$|\/\*[\s\S]*?\*\//gm, '').trim();;
    let tokens = [];

    const isIdentifierName = (name) => {
        const regex = /^[a-zA-Z_$][0-9a-zA-Z_$]*$/;
        return regex.test(name);
    };

    const checkNextEntryStart = (index) => {
        return tokens[index] != "enum" && isIdentifierName(tokens[index]) && (tokens[index + 1] == "=" || tokens[index + 1] == "," || tokens[index + 1] == "}");
    }

    while (string.length > 0) {
        let str = string.trimStart();
        let end = str.search(/[\n\s\t=,{}]/);
        if (end == -1) end = str.length;
        let tk = end ? str.slice(0, end) : str[0];
        tokens.push(tk.trim());
        string = str.replace(tk, "");
    }

    let enumList = [];

    // console.log(tokens);
    
    for(let i = 0; i < tokens.length; i ++) {
        let enumName, enumAssumedValue = -1, enumEntries = [], tk = tokens[i];
        // find declaration
        if (!(tk == "enum" && tokens[i + 2] == "{")) continue;
        // extract name & begin body parsing
        enumName = tokens[i + 1];
        i += 2;
        let halt = false;
        // parse entries
        while(i < tokens.length && !halt) {
            // entry name
            let prev = tokens[i];
            if (prev == "}") break;
            let name = tokens[++ i];
            if (name == "{" || name == "}") break;
            let next = tokens[++ i];
            // console.log({prev, name, next});
            if ((prev == "," || prev == "{") && next == "," || next == "}") {
                enumEntries.push([name, ++ enumAssumedValue]);
                continue;
            }
            else if (next != "=") {
                console.log("Unable to parse entry", "\"" + name + "\"", "of", enumName, "so we skip it.");
                continue;
            }
            let value = "";
            while ((i ++) < tokens.length) {
                let check = checkNextEntryStart(i + 1);
                if (check && (prev == "," || prev == "{")) break;
                value += tokens[i];
                let after = tokens[i + 1];
                if (after == "enum" || (!isIdentifierName(after) && !(after == "," || after == "}"))) {
                    halt = true;
                    break;
                }
            }
            if (!isNaN(parseInt(value))) {
                value = parseInt(value)
                enumAssumedValue = value;
            }
            enumEntries.push([name, value]);
            if (next == "}") break;
        }
        enumList.push({
            name: enumName,
            entries: enumEntries
        });
    }

    return enumList;
}

// const testContents = ``;
// let res = parseEnums(testContents);
// console.log(JSON.stringify(res, null, 2));
// return;

function generateEnumDumpFile() {
    const dumpScript = "__EnumsDump";
    const funcScript = "EnumFunctions";

    let fileOutput = "/// @ignore\n/// Feather ignore GM1014\n\nprint(\"Writing Enums start\")\n\n";

    const processDirectory = (codeDirectoryPath) => {
        fs.readdirSync(codeDirectoryPath).forEach((dirName) => {
            if (dirName == dumpScript || dirName == funcScript) return;

            // const srcFilePath = codeDirectoryPath + dirName + "/" + dirName + ".gml";
            const resourcePath = codeDirectoryPath + dirName + "/";

            if (!fs.existsSync(resourcePath)) return;

            fs.readdirSync(resourcePath).forEach((filePath) => {
                if (!filePath.endsWith(".gml")) return;
                const contents = fs.readFileSync(resourcePath + filePath, "utf-8");
                const enums = parseEnums(contents.replaceAll("\n\r", "\n"));
                
                if (!enums) return;

                for(let enumInfo of enums) {
                    let fName = "__enum_" + enumInfo.name;
                    fileOutput += "#region " + dirName + "/" + filePath + "\n\n"
                    fileOutput += "if development_mode\n\tprint(\"    Enum." + enumInfo.name + "\")\n\n"
                    fileOutput += "function " + fName + "() {\n";
                    fileOutput += "\tvar _static = static_get(" + fName + ")\n";

                    let entries = enumInfo.entries;

                    for(let entry of entries) {
                        if (entry[0].startsWith("//"))
                            continue;
                        
                        fileOutput += "\t_static[$ \"" + entry[0] + "\"] = " + enumInfo.name + "." + entry[0] + "\n";
                    }

                    fileOutput = fileOutput.trimEnd() + "\n}\n\n" + fName + "()\n\n#endregion\n\n";
                }
            });
        });
    };

    processDirectory(ScriptsDir);
    processDirectory(ObjectsDir);
    
    fileOutput += "print(\"Enum dump complete\")\n\n"

    fs.writeFileSync(ScriptsDir + dumpScript + "/" + dumpScript + ".gml", fileOutput);
}

generateEnumDumpFile();