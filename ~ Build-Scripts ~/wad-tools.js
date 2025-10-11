const fs = require("fs");
const project = require("./project.js");
const assert = require("node:assert");
const Options = require("./options.json");

const byteArrayToString = b => [...b].map(s => String.fromCharCode(s)).join("");

let iota = 0;
const GameChunk = {
    "GEN8": iota++,
    "OPTN": iota++,
    "LANG": iota++,
    "EXTN": iota++,
    "SOND": iota++,
    "AGRP": iota++,
    "SPRT": iota++,
    "BGND": iota++,
    "PATH": iota++,
    "SCPT": iota++,
    "GLOB": iota++,
    "SHDR": iota++,
    "FONT": iota++,
    "TMLN": iota++,
    "OBJT": iota++,
    "FEDS": iota++,
    "ACRV": iota++,
    "SEQN": iota++,
    "TAGS": iota++,
    "ROOM": iota++,
    "DAFL": iota++,
    "EMBI": iota++,
    "PSEM": iota++,
    "PSYS": iota++,
    "TPAG": iota++,
    "TGIN": iota++,
    "FEAT": iota++,
    "STRG": iota++,
    "TXTR": iota++,
    "AUDO": iota++,
    // GM1.4 chunks
    "CODE": iota++,
    "VARI": iota++,
    "FUNC": iota++
};


class GameMakerWAD {
    /** @type {Buffer} */
    internalBuffer = null;
    assumedlyGMS2 = null;

    /** @param {Buffer} buffer */
    set internalBuffer(buffer) {
        this.internalBuffer = buffer;
        assert.equal(this.readCharacters(0, 4), "FORM", "Invalid FORM header.");
    }
    
    /** @param {Buffer} buffer */
    constructor(buffer) { this.internalBuffer = buffer; }

    getBuffer() {
        return this.internalBuffer;
    }

    /** 
     * @description Must only be called after `parseChunkOffsets`
     * @returns {Boolean?} */
    isAssumedlyGMS2() {
        assert.notEqual(this.assumedlyGMS2, null, "`isAssumedlyGMS2()` can only work after calling `parseChunkOffsets()`");
        return this.assumedlyGMS2;
    }

    /** @param {String} path */
    static loadFromFile(path) {
        return new GameMakerWAD(fs.readFileSync(path));
    }

    readCharacters(offset, n) {
        return byteArrayToString(this.internalBuffer.subarray(offset, offset + n));
    }

    parseChunkOffsets() {
        let offset = 8, maxSize = this.internalBuffer.byteLength, chunkOffsets = {};
        while (offset < maxSize) {
            let chunkName = this.readCharacters(offset, 4);
            let size = this.readUint32(offset + 4);
            if (!(chunkName in GameChunk)) {
                assert.ok(/^[\x00-\x7F]*$/.test(chunkName), "Invalid chunk name found at offset " + offset);
                console.warn("Unrecognized chunk", chunkName);
            }
            chunkOffsets[chunkName] = offset;
            offset += size + 8;
        }
        this.assumedlyGMS2 = "TGIN" in chunkOffsets;
        return chunkOffsets;
    }

    readUint32(offset) { return this.internalBuffer.readUint32LE(offset); }
    readInt32(offset) { return this.internalBuffer.readInt32LE(offset); }
    readUint16(offset) { return this.internalBuffer.readInt16LE(offset); }
    readInt16(offset) { return this.internalBuffer.readInt16LE(offset); }
    readUint8(offset) { return this.internalBuffer.readUint8(offset); }
    readInt8(offset) { return this.internalBuffer.readInt8(offset) != 0; }
    readBool(offset) { return this.internalBuffer.readInt8(offset) > 0; }
    readDouble(offset) { return this.internalBuffer.readDoubleLE(offset); }
    readFloat(offset) { return this.internalBuffer.readFloatLE(offset); }
    readRefSTRG(offset) { return this.readSTRG(this.internalBuffer.readUint32LE(offset)); }
    subarray(start, end) { return this.internalBuffer.subarray(start, end); }
    
    readSTRG(offset) {
        for(var strlen = 0; this.internalBuffer.readUint8(offset + strlen) != 0; ++ strlen);
        return byteArrayToString(this.internalBuffer.subarray(offset, offset + strlen));
    }
}

function locateGameWADFilePath(throwIfNotFound = true) {
    const wadFileTypes = [ "data.win", "game.unx", "game.ios", "game.droid" ];
    const gameInstallationDirectory = project.locateSteamLibraryGame("Nuclear Throne");

    if (Options.prioritizedWAD) {
        console.log("Including", Options.prioritizedWAD, "as WAD file.");
        wadFileTypes.splice(0, 0, Options.prioritizedWAD);
    }
    
    for(const wadFile of wadFileTypes) {
        const gameWadFilePath = gameInstallationDirectory + wadFile;
        if (fs.existsSync(gameWadFilePath)) return gameWadFilePath;
    }

    if (throwIfNotFound) {
        throw new Error("Couldn't locate any WAD files - please make sure you have installed the game from Steam.");
    }

    return null;
}


module.exports = { GameMakerWAD, locateGameWADFilePath, byteArrayToString };