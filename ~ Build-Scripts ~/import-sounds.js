const fs = require("fs");
const path = require("node:path");
const assert = require("node:assert");
const project = require("./project.js");
const WadTools = require("./wad-tools.js");
const zlib = require("node:zlib");
const Options = require("./options.json");
const { GameMakerWAD } = WadTools;

const AUDIO_FLAG_IS_EMBEDDED = 0x1;
const AUDIO_FLAG_IS_COMPRESSED = 0x2;
const AUDIO_FLAG_IS_DECOMPRESSED_ON_LOAD = 0x3;
const AUDIO_FLAG_IS_REGULAR = 0x64;

const gameInstallationDirectory = project.locateSteamLibraryGame("Nuclear Throne");

function processSoundImport(doExtractSounds) {
    const gameWadFilePath = WadTools.locateGameWADFilePath();
    const wad = GameMakerWAD.loadFromFile(gameWadFilePath);
    const chunks = wad.parseChunkOffsets();

    assert.ok("SOND" in chunks, "Couldn't find chunk SOND.");
    assert.ok("AUDO" in chunks, "Couldn't find chunk AUDO.");

    function processChunkSOND() {
        let offset = chunks.SOND;
        const entryCount = wad.readUint32(offset += 8);
        let soundInformation = new Array(entryCount).fill(null);
        for(let soundIndex = 0; soundIndex < entryCount; ++soundIndex) {
            let pos = wad.readUint32(offset + (soundIndex + 1) * 4);
            let name = wad.readRefSTRG(pos);
            let flags = wad.readUint32(pos += 4);
            let unknown = wad.readRefSTRG(pos += 4);
            let soundPath = wad.readRefSTRG(pos += 4);
            
            soundInformation[soundIndex] = {
                name, flags, soundPath
            };
        }
        return soundInformation;
    }

    function processChunkAUDO() {
        let offset = chunks.AUDO;
        const entryCount = wad.readUint32(offset += 8);
        let audioBuffers = new Array(entryCount).fill(null);
        for(let soundIndex = 0; soundIndex < entryCount; ++soundIndex) {
            let pos = wad.readUint32(offset + (soundIndex + 1) * 4);

            let bufferLength = wad.readUint32(pos);
            let isRIFF = wad.readCharacters(pos += 4, 4) === "RIFF";
            
            audioBuffers[soundIndex] = {
                offset: pos - 4,
                length: bufferLength,
                data: wad.subarray(pos, pos + bufferLength),
                isRIFF
            };
        };

        return audioBuffers;
    }

    const projectSoundsMap = {};
    const projectSoundDirs = project.readResourceDir("sounds");
    const unknownSounds = [ ...projectSoundDirs ];

    for(let soundDirName of projectSoundDirs) {
        projectSoundsMap[soundDirName] = true;
    }
    
    const soundInformation = processChunkSOND();
    const soundBuffers = processChunkAUDO();
    const soundCount = soundInformation.length;
    let soundBufferIndex = 0;

    (() => {
        let soundMap = {};
        for(let soundInfo of soundInformation) {
            soundMap[soundInfo.name] = soundInfo;
        }
        // fix typo
        if ("sndHeavyRevoler" in soundMap) {
            soundMap["sndHeavyRevolver"] = soundMap["sndHeavyRevoler"];
            delete soundMap["sndHeavyRevoler"];
            // update name & path
            soundMap["sndHeavyRevolver"].name = "sndHeavyRevolver";
            soundMap["sndHeavyRevolver"].soundPath = "sndHeavyRevolver";
        }
        fs.writeFileSync("game_sounds.json", JSON.stringify(soundMap, null, 2));
    })();

    const ignoredSounds = [ "sndMutRecycleGland2", "sndPlantPower" ];

    // perform import
    for(let soundIndex = 0; soundIndex < soundCount; ++soundIndex) {
        // not-so-fancy progress bar
        if (soundIndex % 50 === 0 || (soundIndex + 1) >= soundCount) {
            let progress = (soundIndex + 1) / soundCount * 100;
            if (progress >= 100) {
                process.stdout.write("...Complete!\n\n");
            }
            else process.stdout.write(Math.floor(progress) + "%");
        }
        else if (soundIndex % 5 === 0) {
            process.stdout.write(".");
        }

        const soundInfo = soundInformation[soundIndex];
        const isExternal = soundInfo.flags === AUDIO_FLAG_IS_REGULAR;
        const soundName = soundInfo.name;
        let soundFileName, bufferInfo;

        if (!isExternal) {
            bufferInfo = soundBuffers[soundBufferIndex ++];
            soundFileName = soundName + (bufferInfo.isRIFF ? ".wav" : ".ogg");
        }
        else {
            // not sure if these sounds are always OGG, but it should work in our case
            soundFileName = soundName + ".ogg";
        }

        if (Options.saveResourceDumps) {
            if (!fs.existsSync("dumped_sounds")) fs.mkdirSync("dumped_sounds");

            if (isExternal) {
                const externalSoundPath = gameInstallationDirectory + soundInfo.soundPath;
                assert.ok(fs.existsSync(externalSoundPath), "Couldn't find external sound file" + externalSoundPath);
                fs.copyFileSync(externalSoundPath, "dumped_sounds/" + soundFileName);
            }
            else {
                fs.writeFileSync("dumped_sounds/" + soundFileName, bufferInfo.data);
            }
        }

        let index = unknownSounds.indexOf(soundName);
        if (index != -1) unknownSounds.splice(index, 1);
        
        if (!(soundName in projectSoundsMap)) {
            if (ignoredSounds.indexOf(soundName) != -1) continue;

            let lower = soundName.toLowerCase();
            // fixing bugs that yoyon't
            if (lower in projectSoundsMap) {
                console.log(soundName, "path is full lowercase!");

                if (doExtractSounds) {
                    const soundLocation = project.locate("sounds", lower) + "/";
                    const soundYYName = project.findFileByExtension(soundLocation, ".yy");
                    const soundYY = soundLocation + soundYYName;
                    assert.ok(fs.existsSync(soundYY));
                    const resource = project.parseYY(fs.readFileSync(soundYY, "utf-8"));
                    fs.rmSync(soundLocation, { force: true, recursive: true });
                    let newSoundLocation = project.locate("sounds", soundName);
                    fs.mkdirSync(newSoundLocation);
                    fs.writeFileSync(soundYY, JSON.stringify(resource, null, 2));
                }
                else console.warn(soundName, "has it's resource name in full lowercase.");
            }
            else {
                console.log(soundName, "is missing from the project!");
            }
            
            continue;
        }

        if (doExtractSounds) {
            const soundLocation = project.locate("sounds", soundName) + "/";
            const importingTo = soundLocation + soundFileName;
            const soundYY = soundLocation + soundName + ".yy";
            assert.ok(fs.existsSync(soundYY), "Couldn't find resource file for " + soundName);
            const resource = project.parseYY(fs.readFileSync(soundYY, "utf-8"));
            // remove old sound file
            let soundFile = soundLocation + resource.soundFile;
            if (fs.existsSync(soundFile)) fs.rmSync(soundFile);
            // update sound file path & save resource
            resource.soundFile = soundFileName;
            fs.writeFileSync(soundYY, JSON.stringify(resource, null, 2));
            
            // copy the files from the game
            if (isExternal) {
                const externalSoundPath = gameInstallationDirectory + soundInfo.soundPath;
                assert.ok(fs.existsSync(externalSoundPath), "Couldn't find external sound file" + externalSoundPath);
                fs.copyFileSync(externalSoundPath, importingTo);
                continue;
            }

            fs.writeFileSync(importingTo, bufferInfo.data);
        }
    }
}

console.log("\x1b[32mExtracting sounds...\x1b[0m");
processSoundImport(!Options.isDryRun);