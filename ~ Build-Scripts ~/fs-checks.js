const fs = require("fs");
const project = require("./project.js");

function runDirChecks(dirName) {
    const dirPath = project.locate(dirName);
    const directoryFiles = fs.readdirSync(dirPath);
    
    const directoryFilesUniqueAllLower = Array.from(new Set(directoryFiles.map(s => s.toLowerCase())));

    if (directoryFilesUniqueAllLower.length == directoryFiles.length) {
        console.log("Case insensitivity check in directory \"", dirName, "\" passed (this can be a false positive if your fs is case-insensitive)");
        return;
    }

    console.log("Case sensitivity test failed: file name count differs (sensitive:", directoryFiles.length, ", insensitive:", directoryFilesUniqueAllLower.length, ")");
    
    for(const fileName of directoryFiles) {
        if (directoryFiles.indexOf(fileName.toLowerCase()) != -1 && directoryFiles.indexOf(fileName) != -1) {
            console.log(fileName);
        }
    }
}

runDirChecks("sprites");
runDirChecks("sounds");