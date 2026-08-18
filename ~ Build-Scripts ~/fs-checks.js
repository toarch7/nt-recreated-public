const fs = require("fs");
const project = require("./project.js");
const soundMap = require("./game_sounds.json");

const soundMapLower = {};
for(const key in soundMap) {
    soundMapLower[key.toLowerCase()] = key;
}

function runDirChecks(dirName) {
    const dirPath = project.locate(dirName);
    const directoryFiles = fs.readdirSync(dirPath);
    
    const directoryFilesUniqueAllLower = Array.from(new Set(directoryFiles.map(s => s.toLowerCase())));

    if (directoryFilesUniqueAllLower.length == directoryFiles.length) {
        console.log("Case insensitivity file count check in directory \"" + dirName + "\" passed (this can be a false positive if your fs is case-insensitive)");
    }
    else {
        console.log("Case sensitivity file count check failed: file name count differs (sensitive:", directoryFiles.length, ", insensitive:", directoryFilesUniqueAllLower.length, ")");
        
        const foundMap = {};
    
        for(const fileName of directoryFiles) {
            const fileNameLower = fileName.toLowerCase();
            if (fileNameLower in foundMap) {
                console.log(fileName);
            }
            foundMap[fileNameLower] = true;
        }
    }

    const onlyChars = /[a-z|A-Z]*/;
    for(const fileName of directoryFiles) {
        if (fileName.startsWith("amb") || fileName.startsWith("mus") || fileName.startsWith("shd") || fileName.startsWith(".")) continue;
        const fileNameChars = fileName.replaceAll(/[^a-zA-Z]/g, "");
        const fileNameLow = fileName.toLowerCase();
        if (fileName == fileNameLow) {
            console.log(dirName + "/" + fileName, "is all lower-case (change to: " + soundMapLower[fileName.toLowerCase()] + ")");
            continue;
        }
        let yyPath = dirPath + "/" + fileName + "/" + fileName + ".yy";
        let yyPathLower = dirPath + "/" + fileName + "/" + fileName.toLowerCase() + ".yy";
        let contents = null;
        if (fs.existsSync(yyPathLower)) {
            console.log(dirName + "/" + fileName + "/" + fileName + ".yy file is all lower case (change to: " + soundMapLower[fileName.toLowerCase()] + ")");
            contents = fs.readFileSync(yyPathLower, "utf-8");
        }
    }
}

runDirChecks("sprites");
runDirChecks("sounds");