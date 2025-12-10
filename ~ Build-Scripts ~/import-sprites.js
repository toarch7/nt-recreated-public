const fs = require("node:fs");
const path = require("node:path");
const assert = require("node:assert");
const project = require("./project.js");
const WadTools = require("./wad-tools.js");
const { PNG } = require("pngjs");
const { GameMakerWAD } = WadTools;
const Options = require("./options.json");
const { isDryRun } = Options;

const spriteOverridesMap = require("./sprite-overrides.json");

const gameInstallationDirectory = project.locateSteamLibraryGame("Nuclear Throne");
const gameWadFilePath = WadTools.locateGameWADFilePath();

// BZ2+QOI support is currently not prioritized by me.
const flagBZ2QOIDisabled = true;
const EMBEDDED_TEXTURE_SIGNATURE_PNG = "PNG";
const EMBEDDED_TEXTURE_SIGNATURE_BZ2QOI = "2zoq";
const EMBEDDED_TEXTURE_SIGNATURE_QOI = "fioq";

class TextureGroupInformation {
    groupName;
    groupDirectory;
    groupExtension;
    constructor(name, directory = null, extension = "") {
        this.groupName = name;
        this.groupDirectory = directory;
        this.groupExtension = extension;
    }
}

/** @param {Buffer} buffer */
function checkPngSignature(buffer) {
    return buffer[0] === 0x89
        && buffer[1] === 0x50
        && buffer[2] === 0x4E
        && buffer[3] === 0x47;
}

/** @param {Buffer} buffer */
function getPngDimensions(buffer) {
    assert.ok(checkPngSignature(buffer), "Invalid PNG data");
    
    return {
        width: buffer.readUInt32BE(16),
        height: buffer.readUInt32BE(20)
    };
}

function getPngFileDimensions(filePath) {
    return getPngDimensions(fs.readFileSync(filePath));
}

function performSpriteImport(isForce) {
    const wad = GameMakerWAD.loadFromFile(gameWadFilePath);
    const chunks = wad.parseChunkOffsets();
    const isGMS2 = wad.isAssumedlyGMS2();

    const projectSpritesLocation = project.locate("sprites/");
    const projectSpriteDirectories = project.readResourceDir("sprites");

    assert.ok("SPRT" in chunks, "Couldn't find chunk SPRT.");
    assert.ok("TXTR" in chunks, "Couldn't find chunk TXTR.");

    const checkSignatureAt = (offset, sig) => wad.readCharacters(offset, 4).endsWith(sig);

    function readTexturePageItemAt(offset) {
        return {
            sourcePosition: [
                wad.readUint16(offset),
                wad.readUint16(offset += 2)
            ],
            sourceSize: [
                wad.readUint16(offset += 2),
                wad.readUint16(offset += 2)
            ],
            targetPosition: [
                wad.readUint16(offset += 2),
                wad.readUint16(offset += 2)
            ],
            targetSize: [
                wad.readUint16(offset += 2),
                wad.readUint16(offset += 2)
            ],
            boundingSize: [
                wad.readUint16(offset += 2),
                wad.readUint16(offset += 2)
            ],
            texturePageId: wad.readInt16(offset += 2)
        };
    }

    function loadTexturePageInformation() {
        assert.ok("TGIN" in chunks, "Couldn't find chunk TGIN - perhaps because it's a GMS1.4 format?");
        let offset = chunks["TGIN"];
        const chunkFormatVersion = wad.readUint32(offset += 8);
        assert.equal(chunkFormatVersion, 1, "This version of TGIN format is not supported.");
        const textureCount = wad.readUint32(offset += 4);
        /** @type {Array<TextureGroupInformation>} */
        const texturePageInfo = new Array(textureCount).fill(null);
        for(let textureIndex = 0; textureIndex < textureCount; ++textureIndex) {
            let pos = wad.readUint32(offset + (textureIndex + 1) * 4);
            let groupName = wad.readRefSTRG(pos);
            let groupDirectory = wad.readRefSTRG(pos += 4);
            let groupExtension = wad.readRefSTRG(pos += 4);

            if (!groupDirectory || groupDirectory === "DynTex") {
                groupDirectory = null;
            }

            const tginEntry = new TextureGroupInformation(groupName, groupDirectory, groupExtension);
            texturePageInfo[textureIndex] = tginEntry;
        }
        return texturePageInfo;
    }

    
    function loadGameTextures() {
        let offset = chunks["TXTR"];
        const chunkSize = wad.readUint32(offset += 4);
        const textureCount = wad.readUint32(offset += 4);
        /** @type {Array<{textureInfo: TextureGroupInformation, textureData: Buffer, textureImageWidth: number, textureImageHeight: number}>} */
        const texturePageData = new Array(textureCount).fill(null);
        const textureInformation = isGMS2 ? loadTexturePageInformation() : null;

        if (textureInformation) {
            assert.equal(textureCount, textureInformation.length, "Different amount of TXTR and TGIN entries");
        }
        
        /**@type {Array<{texInfo: TextureGroupInformation, textureIndex: number, indexInGroup: number, texturePtr: number}>} */
        const twoPassEmbeddedTextures = [];
        let hasBZ2QOI = false;

        for(let textureIndex = 0; textureIndex < textureCount; ++textureIndex) {
            let pos = wad.readUint32(offset + (textureIndex + 1) * 4);
            let indexInGroup, width, height;
            let isExternal = false;
            if (isGMS2) {
                width = wad.readUint32(pos += 12);
                height = wad.readUint32(pos += 4);
                indexInGroup = wad.readUint32(pos += 4);
                isExternal = wad.readUint32(pos += 4) === 0;
                let texInfo = textureInformation[textureIndex];
                if (texInfo.groupDirectory && texInfo.groupExtension === ".png") {
                    const textureLocation = path.join(gameInstallationDirectory, texInfo.groupDirectory);
                    const textureFile = texInfo.groupName + "_" + indexInGroup + texInfo.groupExtension;
                    const texturePath = path.join(textureLocation, textureFile);
                    assert.ok(fs.existsSync(texturePath),
                        "External texture not found: " + texInfo.groupDirectory + "/" + textureFile);
                    // got 'em
                    texturePageData[textureIndex] = {
                        textureInfo: texInfo,
                        textureData: fs.readFileSync(texturePath),
                        textureImageWidth: width,
                        textureImageHeight: height
                    };
                }
                else {
                    const texturePtr = wad.readUint32(pos);
                    if (checkSignatureAt(texturePtr, EMBEDDED_TEXTURE_SIGNATURE_QOI)
                    || checkSignatureAt(texturePtr, EMBEDDED_TEXTURE_SIGNATURE_BZ2QOI)) {
                        hasBZ2QOI = true;
                    }
                    else {
                        twoPassEmbeddedTextures.push({
                            texInfo, indexInGroup, texturePtr
                        });
                    }
                }
            }
            else {
                const texturePtr = wad.readUint32(pos += 4);
                let texInfo = new TextureGroupInformation("texture_" + textureIndex + ".png");
                twoPassEmbeddedTextures.push({
                    texInfo, textureIndex, indexInGroup: -1, texturePtr
                });
            }
        }

        if (hasBZ2QOI && flagBZ2QOIDisabled) {
            console.warn("It appears like the game has some textures encoded with BZ2+QOI (or just QOI) format, which are not currently supported. Please report if some of the game sprites will be missing.");
        }
        
        // 2nd pass for embedded textures
        for(const texture of twoPassEmbeddedTextures) {
            const { texInfo, textureIndex, indexInGroup, texturePtr } = texture;
            let startPos = texturePtr, endPos = -1;
            let textureIndexInList = twoPassEmbeddedTextures.indexOf(texture);

            if (textureIndexInList < twoPassEmbeddedTextures.length - 1) {
                endPos = twoPassEmbeddedTextures[textureIndexInList + 1].texturePtr;
            }
            else endPos = chunks["TXTR"] + chunkSize;

            assert.ok(startPos < endPos);
            let textureData, textureImageWidth, textureImageHeight;
            
            if (isGMS2) {
                textureImageWidth = wad.readUint16(texturePtr + 4);
                textureImageHeight = wad.readUint16(texturePtr + 6);
                let textureUncompressedSize = -1;

                // BZ2 trim padding
                if (checkSignatureAt(texturePtr, EMBEDDED_TEXTURE_SIGNATURE_BZ2QOI)) {
                    textureUncompressedSize = wad.readUint32(texturePtr + 8);
                    while (wad.readUint8(endPos - 1) == 0) endPos --;
                    startPos += 12;
                }

                textureData = wad.subarray(startPos, endPos);
            }
            else {
                textureData = wad.subarray(startPos, endPos);
                let dims = getPngDimensions(textureData);
                textureImageWidth = dims.width;
                textureImageHeight = dims.height;
            }

            if (textureData) {
                texturePageData[textureIndex] = {
                    textureInfo: texInfo, textureData, textureImageWidth, textureImageHeight
                };
            }
        }

        return texturePageData;
    }

    const texturePages = loadGameTextures();

    function generateSpriteInfoMap() {
        let offset = chunks["SPRT"];
        const spriteCount = wad.readUint32(offset += 8);
        const spriteMap = {};
        
        for(let spriteIndex = 0; spriteIndex < spriteCount; ++spriteIndex) {
            let pos = wad.readUint32(offset + (spriteIndex + 1) * 4);
            let start = pos;
            let name = wad.readRefSTRG(pos);
            let width = wad.readUint32(pos += 4);
            let height = wad.readUint32(pos += 4);
            let margin = {
                left: wad.readInt32(pos += 4),
                right: wad.readInt32(pos += 4),
                bottom: wad.readInt32(pos += 4),
                top: wad.readInt32(pos += 4)
            };
            pos += 9;
            let transparent = wad.readBool(pos ++);
            let smooth = wad.readBool(pos ++);
            let preload = wad.readBool(pos ++);
            let bboxMode = wad.readUint32(pos += 4);
            let sepMasks = wad.readUint32(pos += 4);
            let originX = wad.readInt32(pos += 4);
            let originY = wad.readInt32(pos += 4);
            
            if (isGMS2) pos += 28;
            let imageNumber = wad.readUint32(pos += 4);
            let tPageItems = new Array(imageNumber).fill(null);
            for(let frameIndex = 0; frameIndex < imageNumber; ++frameIndex) {
                let tPageEntry = wad.readUint32(pos += 4);
                tPageItems[frameIndex] = readTexturePageItemAt(tPageEntry);
            }
            
            spriteMap[name] = {
                name, width, height, margin, transparent, smooth, preload,
                bboxMode, sepMasks, originX, originY, imageNumber, tPageItems
            };
        }
        return spriteMap;
    }
    
    const chunkSPRTMap = generateSpriteInfoMap();
    fs.writeFileSync("game_sprites.json", JSON.stringify(chunkSPRTMap, null, 2));
    
    const loadedTextures = new Array(texturePages.length).fill(null);
    
    function importSpriteImages() {
        const projectSpritesLocation = project.locate("sprites/");
        const missingProjectSprites = [];
        let totalSprites = Object.keys(chunkSPRTMap).length;
        let spriteCounter = 0;

        for(const [ spriteName, sprite ] of Object.entries(chunkSPRTMap)) {
            // not-so-fancy progress bar
            spriteCounter ++;
            if (spriteCounter % 50 === 0 || (spriteCounter + 1) >= totalSprites) {
                let progress = spriteCounter / totalSprites * 100;
                if (progress >= 100) {
                    process.stdout.write("...Complete!\n\n");
                }
                else process.stdout.write(Math.floor(progress) + "%");
            }
            else if (spriteCounter % 5 === 0) {
                process.stdout.write(".");
            }

            if (Options.saveResourceDumps) {
                if (!fs.existsSync("dumped_sprites")) fs.mkdirSync("dumped_sprites");
                let imageNumber = sprite.imageNumber;

                if (imageNumber > 0 && sprite.width && sprite.height) {
                    let png;
                    try {
                        png = createSpriteStripPNG(sprite, 0, imageNumber);
                    }
                    catch(e) { console.error(e.message); continue; }

                    let pngWriteBuffer = PNG.sync.write(png);
                    fs.writeFileSync("dumped_sprites/" + spriteName + "_strip" + imageNumber + ".png", pngWriteBuffer);
                }
            }

            const spriteLocation = projectSpritesLocation + spriteName + "/";
            if (!fs.existsSync(spriteLocation)) {
                missingProjectSprites.push(spriteName);
                continue;
            }
            const spriteYYFileName = project.findFileByExtension(spriteLocation, ".yy");
            const spriteYYLocation = spriteLocation + spriteYYFileName;
            if (!fs.existsSync(spriteYYLocation)) {
                console.error(spriteName, "is missing its .yy resource file");
                continue;
            }
            
            if (isDryRun) continue;
            
            const resourceInfo = project.parseYY(fs.readFileSync(spriteYYLocation, "utf-8"));
            assert.ok(resourceInfo);

            const layersLocation = spriteLocation + "layers/";
            if (!fs.existsSync(layersLocation)) fs.mkdirSync(layersLocation);
            
            const layers = resourceInfo.layers;
            const frames = resourceInfo.frames;
            
            if (!(spriteName in spriteOverridesMap)) {
                assert.equal(frames.length, sprite.imageNumber, spriteName + " has a varying amount of frames than it's resource file specifies");
            }

            let frameCount = Math.min(sprite.imageNumber, frames.length);

            for(let frameNumber = 0; frameNumber < frameCount; ++frameNumber) {
                const frameInfo = frames[frameNumber], frameName = frameInfo.name;
                const frameFileLocation = spriteLocation + frameName + ".png";
                const layerInfo = layers[0], layerName = layerInfo.name;
                const layerDirLocation = layersLocation + frameName + "/";
                const layerFileLocation = layerDirLocation + layerName + ".png";
                if (!fs.existsSync(layerDirLocation)) fs.mkdirSync(layerDirLocation);
                let framePresent = fs.existsSync(frameFileLocation);
                let layerPresent = fs.existsSync(layerFileLocation);

                if (isForce) {
                    if (framePresent) fs.rmSync(frameFileLocation);
                    if (layerPresent) fs.rmSync(layerFileLocation);
                }
                else if (layerPresent && framePresent) {
                    continue;
                }

                let png;
                
                try {
                    png = createSpriteStripPNG(sprite, frameNumber, 1);
                }
                catch(e) {
                    console.error(e.message);
                    continue;
                }
                
                let pngWriteBuffer = PNG.sync.write(png);
                if (!framePresent) fs.writeFileSync(frameFileLocation, pngWriteBuffer);
                if (!layerPresent) fs.writeFileSync(layerFileLocation, pngWriteBuffer);
            }
        }

        if (missingProjectSprites.length) {
            console.log("\x1b[90m" + missingProjectSprites.join(",  ") + "\x1b[0m\x1b[1m\nThe listed sprite names (" + missingProjectSprites.length + ") are missing from the project.");
            console.log("\x1b[1mThis isn't a critical error. It's just a list of things that still need to be added to the game.\x1b[0m");
            console.log("Sprite extraction complete.\n\n");
        }
    }

    importSpriteImages();

    function createSpriteStripPNG(sprite, startFrame, frameCount = 1) {
        let png = new PNG({
            filterType: -1,
            width: sprite.width * frameCount,
            height: sprite.height
        });
        
        for(let subimageIndex = 0; subimageIndex < frameCount; ++subimageIndex) {
            const frameNumber = startFrame + subimageIndex;
            const frameData = sprite.tPageItems[frameNumber];
            const texturePageId = frameData.texturePageId;
            const texturePage = texturePages[texturePageId];

            assert.ok(texturePage, "Frame " + frameNumber + " of " + sprite.name + " is located on an unknown texture page!");
            
            const [ srcX, srcY ] = frameData.sourcePosition;
            const [ cropWidth, cropHeight ] = frameData.sourceSize;
            const [ targetX, targetY ] = frameData.targetPosition;
            const [ frameWidth, frameHeight ] = frameData.boundingSize;
            const stripFrameOffset = sprite.width * subimageIndex;
            const textureW = texturePage.textureImageWidth;
            
            let canvas = loadedTextures[texturePageId];
            
            if (!canvas) {
                canvas = PNG.sync.read(texturePage.textureData);
                loadedTextures[texturePageId] = canvas;
            }

            for(let y = 0; y < cropHeight; ++y) {
                for(let x = 0; x < cropWidth; ++x) {
                    let x1 = x + srcX;
                    let y1 = y + srcY;
                    let x2 = x + targetX + stripFrameOffset;
                    let y2 = y + targetY;
                    let sourceIdx = (y1 * textureW + x1) << 2;
                    let targetIdx = (y2 * png.width + x2) << 2;
                    png.data[targetIdx + 0] = canvas.data[sourceIdx + 0];
                    png.data[targetIdx + 1] = canvas.data[sourceIdx + 1];
                    png.data[targetIdx + 2] = canvas.data[sourceIdx + 2];
                    png.data[targetIdx + 3] = canvas.data[sourceIdx + 3];
                }
            }
        }
        
        return png;
    }

    function performSpriteSizeFixes() {
        for(let dirname of projectSpriteDirectories) {
            const spriteLocation = projectSpritesLocation + dirname + "/";
            const yyName = project.findFileByExtension(spriteLocation, ".yy");
            if (!yyName) {
                console.error(dirname, "doesn't have a .yy resource file");
                continue;
            }

            const spriteInfo = project.parseYY(fs.readFileSync(spriteLocation + yyName, "utf-8"));
            let { name, width, height, bbox_left, bbox_right, bbox_top, bbox_bottom, bboxMode, collisionKind } = spriteInfo;
            let { xorigin, yorigin } = spriteInfo.sequence;

            if (name in spriteOverridesMap) {
                let overrides = spriteOverridesMap[name];
                if (overrides.custom) continue;
            }

            if (!(name in chunkSPRTMap)) {
                console.log(name, "was not found in SPRT chunk.");
                continue;
            }

            const sprtData = chunkSPRTMap[name];
            const sprtImageDimensions = {
                width: sprtData.width,
                height: sprtData.height
            };
            
            for(let frame of spriteInfo.frames) {
                const frameImageLocation = spriteLocation + frame.name + ".png";
                const frameImageDims = getPngFileDimensions(frameImageLocation);
                let correctWidth = sprtImageDimensions.width;
                let correctHeight = sprtImageDimensions.height;
                let changesWereMade = false;

                assert.ok((frameImageDims.width === correctWidth && frameImageDims.height === correctHeight),
                        dirname + " sprite image dimensions are not equal to its dimensions size information from SPRT. Please make sure that your exported sprites are up-to-date!");

                if (width != correctWidth || height != correctHeight) {
                    console.error(name, "sprite width/height doesn't match with image dimensions! Sprite:",
                            width + "/" + height, "and Image:", correctWidth + "/" + correctHeight);
                    spriteInfo.width = correctWidth;
                    spriteInfo.height = correctHeight;
                    changesWereMade = true;
                }

                if (bboxMode != sprtData.bboxMode) {
                    console.log(name, "BBox mode mismatch! Sprite:", bboxMode, "and SPRT:", sprtData.bboxMode);
                    spriteInfo.bboxMode = sprtData.bboxMode;
                    changesWereMade = true;
                }

                if (bboxMode != sprtData.bboxMode) {
                    console.log(name, "BBox mode mismatch! Sprite:", bboxMode, "and SPRT:", sprtData.bboxMode);
                    spriteInfo.bboxMode = sprtData.bboxMode;
                    changesWereMade = true;
                }

                if (collisionKind == sprtData.sepMasks) {
                    let correctValue = sprtData.sepMasks ? 0 : 1;
                    console.log(name, "BBox sep. masks kind mismatch! Sprite:", collisionKind, "and SPRT:", correctValue);
                    spriteInfo.collisionKind = correctValue;
                    changesWereMade = true;
                }

                if (!(xorigin == sprtData.originX && yorigin == sprtData.originY)) {
                    console.log(name, "Sprite origin points mismatch! Sprite:", xorigin, yorigin, "and SPRT:", sprtData.originX, sprtData.originY);
                    spriteInfo.sequence.xorigin = sprtData.originX;
                    spriteInfo.sequence.yorigin = sprtData.originY;
                    console.log(spriteInfo.sequence.xorigin, spriteInfo.sequence.yorigin);
                    changesWereMade = true;
                }
                
                const margin = sprtData.margin;
                if (margin.left != bbox_left
                    || margin.right != bbox_right
                    || margin.top != bbox_top
                    || margin.bottom != bbox_bottom
                ) {
                    console.log(name, "margin/bbox size mismatch!",
                        "Margin:", (margin.right - margin.left) + "/" + (margin.bottom - margin.top),
                        "BBox:", (bbox_right - bbox_left) + "/" + (bbox_bottom - bbox_top));
                    spriteInfo.bbox_left = margin.left;
                    spriteInfo.bbox_right = margin.right;
                    spriteInfo.bbox_top = margin.top;
                    spriteInfo.bbox_bottom = margin.bottom;
                    changesWereMade = true;
                }

                if (changesWereMade) {
                    console.log("Saving changes...");
                    let spriteJSON = JSON.stringify(spriteInfo, null, 2);
                    fs.writeFileSync(spriteLocation + yyName, spriteJSON);
                }
            }
        }
    }

    performSpriteSizeFixes();
}

console.log("\x1b[32mExtracting sprites...\x1b[0m");
performSpriteImport(Options.isForce);