const fs = require("fs");
const project = require("./project.js");
const projectDirectory = project.projectDirectory;
const path = require("node:path");

const trimStringQuotemarks = s => (s.startsWith("\"") && s.endsWith("\"")) ? s.slice(1, s.length - 1) : s;

class TagInfo {
    type;
    source;
    line = -1;
    section;
    key;
    string;
    constructor(source, line, string) {
        let parts = string.split(" ").filter(s => s.trim().length);
        this.type = parts.shift();
        if (this.type == "loc:token") {
            this.section = parts.shift();
            this.key = parts.shift();
            this.string = trimStringQuotemarks(parts.join(" "));
        }
        else if (this.type == "loc:note") {
            this.section = parts.shift();
            this.string = parts.join(" ");
        }
        else {
            this.string = parts.join(" ");
        }
        this.line = line;
        this.source = source;
    }
    getLocation() {
        return this.source.replace(projectDirectory, "") + ":" + this.line;
    }
}

const matchTagsExpr = new RegExp("(?<=/// *@)\s*(.*)", "g");
function gatherSourceTags(srcPath, srcText) {
    const result = [];
    if (srcText.indexOf("///") == -1) {
        return result;
    }
    const lines = srcText.split("\n");
    for(let lineIndex = 0; lineIndex < lines.length; ++lineIndex) {
        let lineString = lines[lineIndex].match(matchTagsExpr);
        if (lineString) {
            result.push(new TagInfo(srcPath, lineIndex, String(lineString)));
        }
    }
    return result;
}

/** @returns {Array<TagInfo>} */
function gatherProjectSourceTags() {
    const scripts = project.readResourceDir("scripts");
    const objects = project.readResourceDir("objects");
    const gmlDirs = [
        ...scripts.map(s => project.locate("scripts", s)),
        ...objects.map(s => project.locate("objects", s))
    ]
    const gatheredTags = [];
    for(const gmlDir of gmlDirs) {
        const gmlFiles = fs.readdirSync(gmlDir).filter(s => s.endsWith(".gml"));
        for(const gmlFile of gmlFiles) {
            const fileLocation = gmlDir + "/" + gmlFile;
            const fileContents = fs.readFileSync(fileLocation, "utf-8");
            const tags = gatherSourceTags(fileLocation, fileContents);
            gatheredTags.push(...tags);
        }
    }
    return gatheredTags;
}
module.exports = { TagInfo, gatherSourceTags, gatherProjectSourceTags }