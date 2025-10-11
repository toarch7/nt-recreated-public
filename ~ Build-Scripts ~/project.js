const assert = require("assert");
const cp = require("child_process");
const path = require("path");
const fs = require("fs");
const Options = require("./options.json");

function stringSimilarity(s1, s2) {
    function editDistance(s1, s2) {
        s1 = s1.toLowerCase();
        s2 = s2.toLowerCase();

        var costs = new Array();
        for (var i = 0; i <= s1.length; i++) {
            var lastValue = i;
            for (var j = 0; j <= s2.length; j++) {
                if (i == 0)
                    costs[j] = j;
                else {
                    if (j > 0) {
                        var newValue = costs[j - 1];
                        if (s1.charAt(i - 1) != s2.charAt(j - 1))
                            newValue = Math.min(Math.min(newValue, lastValue),
                                costs[j]) + 1;
                        costs[j - 1] = lastValue;
                        lastValue = newValue;
                    }
                }
            }
            if (i > 0)
                costs[s2.length] = lastValue;
        }
        return costs[s2.length];
    }
    let longer = s1;
    let shorter = s2;
    if (s1.length < s2.length) {
        longer = s2;
        shorter = s1;
    }
    let longerLength = longer.length;
    if (longerLength == 0) return 1.0;
    return (longerLength - editDistance(longer, shorter)) / parseFloat(longerLength);
}
const showSelectDirectoryDialog = () => {
    // todo: implement something similar for Linux using zenity
    let cmd = `powershell -command "[System.Reflection.Assembly]::LoadWithPartialName(\'System.Windows.Forms\');`
            + `$dialog = New-Object System.Windows.Forms.FolderBrowserDialog;`
            + `$dialog.Description = \'Please select the directory where the game is installed.\';`
            + `$dialog.SelectedPath = \'C:\\Program Files (x86)\\';`
            + `$dialog.ShowNewFolderButton = $false;`
            + `$dialog.ShowDialog();`
            + `$dialog.SelectedPath"`;
    
    let result = cp.execSync(cmd).toString("utf-8");
    let lines = result.split("\n").map(s => s.trim()).filter(s => s.length != 0);
    let chosenDirectory = lines.pop();
    
    return chosenDirectory;
};
const projectDirectory = path.dirname(__dirname.slice(0, __dirname.length - 1)) + path.sep;
const parseYY = yyString => JSON.parse(yyString.replaceAll(/,(?=\s*[\]}])/g, ""));
const findFileByExtension = (dirPath, ext) => {
    const dirname = path.basename(dirPath);
    return fs.readdirSync(dirPath)
        .filter(f => f.endsWith(ext))
        .sort((a, b) => {
            let x = stringSimilarity(a, dirname);
            let y = stringSimilarity(b, dirname);
            if (x === y) return 0;
            if (x > y) return -1;
            return 1;
        })[0];
};
const parseProjectFile = () => {
    const yypLocation = projectDirectory + findFileByExtension(projectDirectory, ".yyp");
    const yypContents = fs.readFileSync(yypLocation, "utf-8");
    return parseYY(yypContents);
};
const locateSteamLibrary = (theRest) => {
    let libraryfoldersPath = null;

    if (process.platform == "win32") {
        const driveLetters = [ "C", "D", "E", "F" ];
        for(let driveLetter of driveLetters) {
            let testPath = driveLetter + ":\\Program Files (x86)\\Steam\\steamapps\\libraryfolders.vdf";
            
            if (fs.existsSync(testPath)) {
                libraryfoldersPath = testPath;
                break;
            }
        }
    }
    else if (process.platform == "linux") {
        libraryfoldersPath = path.join(process.env.HOME, '.local', 'share', 'Steam', 'steamapps', 'libraryfolders.vdf');
    }
    else assert.ok(false, "Unsupported platform: " + process.platform);

    assert.ok(libraryfoldersPath !== null);
    const libraryfoldersContents = fs.readFileSync(libraryfoldersPath, "utf-8").split("\n");

    for(const line of libraryfoldersContents) {
        const parts = line.split("\t").filter(s => s.length);
        if (parts[0] == "\"path\"") {
            const steamPath = parts[1].slice(1, parts[1].length - 1);
            const filePath = steamPath + path.sep + theRest;
            if (fs.existsSync(filePath)) return filePath;
        }
    }

    if (process.platform == "win32") {
        try {
            let openDirectoryResult = showSelectDirectoryDialog();
            if (openDirectoryResult) {
                Options.customGameDirectory = openDirectoryResult;
                fs.writeFileSync("options.json", JSON.stringify(Options, null, 2));
            }
        }
        catch(e) {
            console.error("showSelectDirectoryDialog() failed:", e);
        }
    }

    assert.ok(false, "Couldn't locate \"path\" in libraryfolders.vdf");
};
const locateSteamLibraryGame = (gameDirectoryName) => {
    if (Options.customGameDirectory) return Options.customGameDirectory + path.sep;
    return locateSteamLibrary("steamapps/common/" + gameDirectoryName) + path.sep;
}

const readResourceDir = resourceLocation => {
    const projectResourceLocation = projectDirectory + resourceLocation + path.sep;
    assert.ok(fs.existsSync(projectResourceLocation), "Directory doesn't exist", projectResourceLocation);
    return fs.readdirSync(projectResourceLocation).filter(s => {
        return fs.statSync(projectResourceLocation + s).isDirectory();
    });
};

const locate = (...locationParts) => path.join(projectDirectory) + locationParts.join(path.sep);

module.exports = {
    projectDirectory,
    parseYY,
    findFileByExtension,
    parseProjectFile,
    locateSteamLibrary,
    locateSteamLibraryGame,
    readResourceDir,
    locate
};