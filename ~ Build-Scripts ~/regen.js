const fs = require("fs");
const path = require("node:path");

function parseProgramArguments() {
    let regenParameters = {
        // makes the game check for the specified
        // file name in the game directory
        prioritizedWAD: null,

        // overrides the output of `locateSteamLibraryGame`
        customGameDirectory: null,
        
        // dry run only disables filesystem writes
        // other behaviors should remain intact 
        isDryRun: false,

        // allows file overwrites
        isForce: false,

        // control flags for specific extraction modes
        extractSounds: true,
        extractSprites: true,
        auditIgnores: false
    };

    const parametersExpectedArgs = {
        "--include-wad": 1,
        "--game-path": 1
    };

    const disableAllExtractionModes = () => {
        for(let key in regenParameters) if (key.startsWith("extract")) regenParameters[key] = false;
    };

    const parameters = process.argv;
    for(let parameterIndex = 2; parameterIndex < parameters.length; ++parameterIndex) {
        let parameterName = parameters[parameterIndex];
        let argCount = parametersExpectedArgs[parameterName];
        let args = [];

        if (parameterName.indexOf("=") != -1) {
            const parameterParts = parameterName.split("=", 2);
            parameterName = parameterParts.shift();
            args = parameterParts;
        }
        else if (argCount) {
            for(let i = 0; i < argCount; ++i) {
                args.push(parameters[++ parameterIndex]);
                if (parameterIndex >= parameters.length) break;
            }
        }

        if (argCount && args.length < argCount) {
            console.error("Not enough parameters provided.");
            break;
        }

        switch (parameterName) {
            case "--game-path":
                if (!args[0]) args[0] = null;
                regenParameters.customGameDirectory = args[0];
                break;
            case "--include-wad":
                let wadFilename = args[0];
                if (!path.extname(wadFilename)) wadFilename += ".win";
                regenParameters.prioritizedWAD = wadFilename;
                break;
            case "--dryrun":
            case "--dry-run":
                regenParameters.isDryRun = true;
                break;
            case "--force":
                regenParameters.isForce = true;
                break;
            case "--regen-ignore-file":
                regenParameters.auditIgnores = true;
                break;
            case "--just-sounds":
                disableAllExtractionModes();
                regenParameters.extractSounds = true;
                break;
            case "--just-sprites":
                disableAllExtractionModes();    
                regenParameters.extractSprites = true;
                break;
        }
    }

    return regenParameters;
}

const options = parseProgramArguments();
fs.writeFileSync("options.json", JSON.stringify(options, null, 2));

try {
    // these modules run automatically when required
    if (options.extractSprites) require("./import-sprites.js");
    if (options.extractSounds) require("./import-sounds.js");
    require("./project-audit.js");
}
finally {
    if (options.doCleanup) {
        fs.rmSync("./game_sounds.json");
        fs.rmSync("./game_sprites.json");
    }
}