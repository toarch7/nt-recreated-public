const fs = require("node:fs");
const assert = require("node:assert");
const project = require("./project.js");
const path = require("node:path");
const overrides = require("./sprite-overrides.json");
const Options = require("./options.json");

const gameInstallationDirectory = project.locateSteamLibraryGameAssets("Nuclear Throne");
const projectSpriteNames = project.readResourceDir("sprites");
const projectSoundNames = project.readResourceDir("sounds");

const spriteMap = require("./game_sprites.json");
const soundMap = require("./game_sounds.json");

const alwaysIgnored = [ "mskFloorMiddle" ];

function shouldAssetBeIgnored(name) {
    return !(name.startsWith("msk") || name.startsWith("bak") || name.startsWith("shd")) && alwaysIgnored.indexOf(name) == -1;
}

const ignoreFileHeader = "# Generated at " + (new Date()) + "\n#\n# This file excludes all image assets from the repo that are unallowed to be used.\n# The only assets that are present here are the ones exclusive to NTM.\n# Execute `node project-audit.js --regen-ignore-file` to refresh this list.\n\n";

let problemCounter = 0;

function performSpriteAudit() {
    let ignoreOutput = "";
    for(const spriteName of projectSpriteNames) {
        if (spriteName in overrides) continue;
        const spriteLocation = project.locate("sprites", spriteName);
        const yyName = project.findFileByExtension(spriteLocation, ".yy");
        if (!yyName) {
            console.log("Missing .yy file at", spriteLocation);
            problemCounter ++;
            continue;
        }
        const yyPath = path.join(spriteLocation, yyName);
        const spriteInfo = project.parseYY(fs.readFileSync(yyPath, "utf-8"));
        
        if (spriteName in spriteMap) {
            const frames = spriteInfo.frames;
            const basegameFrameCount = spriteMap[spriteName].imageNumber;
            if (!frames) {
                console.log("Missing frames field in sprite", spriteName);
                problemCounter ++;
                continue;
            }
            const myFrameCount = frames.length;
            if (basegameFrameCount != myFrameCount) {
                let diff = basegameFrameCount - myFrameCount;
                let sign = (diff > 0) ? "-" : "+";
                console.log("( " + sign + Math.abs(diff) + " )", spriteName,
                    "amount of frames mismatch", `${myFrameCount} to original ${basegameFrameCount}`);
                problemCounter ++;
            }
            if (shouldAssetBeIgnored(spriteName)) {
                ignoreOutput += spriteName + "/*.png\n";
                ignoreOutput += spriteName + "/layers/*\n";
            }
        }
        else {
            if (spriteName.toLowerCase() === spriteName) {
                console.log(spriteName, "is all lower-case.");
            }
            else console.log(spriteName, "is not found");
            problemCounter ++;
        }
    }

    if (Options.auditIgnores && ignoreOutput) {
        fs.writeFileSync(project.locate("sprites/.gitignore"), ignoreFileHeader + ignoreOutput);
        console.log("Sprite audit complete");
    }

    console.log("Sprite audit complete");
}

function performSoundAudit() {
    let ignoreOutput = "";
    for(const soundName of projectSoundNames) {
        if (soundName in overrides) continue;
        const spriteLocation = project.locate("sounds", soundName);
        const yyName = project.findFileByExtension(spriteLocation, ".yy");
        if (!yyName) {
            console.log("Missing .yy file at", spriteLocation);
            problemCounter ++;
            continue;
        }
        const yyPath = path.join(spriteLocation, yyName);
        const soundInfo = project.parseYY(fs.readFileSync(yyPath, "utf-8"));

        if (shouldAssetBeIgnored(soundName)) {
            ignoreOutput += soundName + "/" + soundInfo.soundFile + "\n";
        }

        if (!(soundName in soundMap)) {
            if (soundName.toLowerCase() === soundName) {
                console.log(soundName, "is all lower-case");
            }
            else console.log(soundName, "is not found");
            problemCounter ++;
        }
    }

    if (Options.auditIgnores && ignoreOutput) {
        fs.writeFileSync(project.locate("sounds/.gitignore"), ignoreFileHeader + ignoreOutput);
    }
}

function performCompletenesAudit() {
    // check sprites
    let spritesBrokenCount = 0;
    for(let spriteName of projectSpriteNames) {
        const spriteLocation = project.locate("sprites", spriteName);
        const yyName = project.findFileByExtension(spriteLocation, ".yy");
        if (!yyName) {
            console.log("Missing .yy file at", spriteLocation);
            continue;
        }
        const yyPath = path.join(spriteLocation, yyName);
        const spriteInfo = project.parseYY(fs.readFileSync(yyPath, "utf-8"));
        let frames = spriteInfo.frames, missingFrames = null;
        if (!frames) {
            console.log("Missing frames field in sprite", spriteName);
            problemCounter ++;
            continue;
        }
        for(const frameInfo of frames) {
            const frameImageLocation = path.join(spriteLocation, frameInfo.name + ".png");
            if (!fs.existsSync(frameImageLocation)) {
                if (!missingFrames) missingFrames = [];
                missingFrames.push(frameInfo.name);
            }
        }
        if (missingFrames) {
            console.log(spriteName, "is missing", missingFrames.length + "/" + frames.length, "frames:\n    " + missingFrames.join("\n    "));
            spritesBrokenCount ++;
            problemCounter ++;
        }
    }

    // check sounds
    let soundsBrokenCount = 0;
    for(let soundName of projectSoundNames) {
        const soundLocation = project.locate("sounds", soundName);
        const yyName = project.findFileByExtension(soundLocation, ".yy");
        if (!yyName) {
            console.log("Missing .yy file at", soundLocation);
            continue;
        }
        const yyPath = path.join(soundLocation, yyName);
        const soundInfo = project.parseYY(fs.readFileSync(yyPath, "utf-8"));
        if (!fs.existsSync(path.join(soundLocation, soundInfo.soundFile))) {
            console.log(soundName, "is missing its sound file (" + soundInfo.soundFile + ")");
            soundsBrokenCount ++;
            problemCounter ++;
        }
    }
    
    // print results
    if (spritesBrokenCount) {
        console.log(spritesBrokenCount, "out of", projectSpriteNames.length, "sprites are still missing after the regeneration process.");
    }
    else console.log("All project sprites were regenerated successfully!");

    if (soundsBrokenCount) {
        console.log(soundsBrokenCount, "out of", projectSoundNames.length, "sounds are still missing after the regeneration process.");
    }
    else console.log("All project sounds were regenerated successfully!");
}

function performLangFolderCheck() {
    let langPath = project.locate("datafiles/lang/");
    if (!fs.existsSync(langPath)) fs.mkdirSync(langPath);
    if (!fs.existsSync(gameInstallationDirectory + "/lang")) {
        console.log("No \"lang\" directory found at", gameInstallationDirectory);
        return;
    }
    try {
        fs.cpSync(gameInstallationDirectory + "lang/", langPath, { recursive: true, force: true });
    }
    catch (e) {
        console.log("Exception occured while copying localization files. Won't crash.", e.message);
    }
}

console.log("\x1b[32mCopying language files...\x1b[0m");
performLangFolderCheck();

console.log("\x1b[32mValidating sprite names...\x1b[0m");
performSpriteAudit();

console.log("\n\x1b[32mValidating sound names...\x1b[0m");
performSoundAudit();

console.log("\n\x1b[32mChecking for missing assets...\x1b[0m");
performCompletenesAudit();

if (problemCounter != 0) {
    console.log("\nAudit found", problemCounter, "problems with the assets...");
    process.exit(1);
}