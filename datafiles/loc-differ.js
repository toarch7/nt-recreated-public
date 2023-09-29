const fs = require("fs");

const ReadFile = path => fs.readFileSync(path, "utf-8");
const ReadJSON = path => JSON.parse(ReadFile(path));

function makeKeys() {
	const source = ReadJSON("./localizations/ru.loc");
	const target = ReadJSON("./localizations/ua.loc");
	
	let diff = {};
	let keys = "";
	
	let header = "Can you translate the following text to Ukrainian, while keeping special characters like `@`, `#` and `%` where they should be\n```\n"
	
	let str = header;
	
	let line = 0;

	for(let [key, val] of Object.entries(source)) {
		if (target[key])
			continue;
		
		keys += key + "\n";
		str += key + "\n";
		
		line ++;
		
		if (line % 30 == 0)
			str += "```\n\n" + header + "\n";
		console.log(line);
		
		diff[key] = "";//val;
	}

	fs.writeFileSync("keys.txt", keys.trim());
	fs.writeFileSync("out.txt", str + "```");
	fs.writeFileSync("diff.loc", JSON.stringify(diff, null, 2));
}

function makeLocale() {
	const keys = ReadFile("./keys.txt").split("\n");
	const values = ReadFile("./values.txt").split("\n");
	
	let str = "";

	for(let i in keys) {
		str += "\t\"" + keys[i] + "\": \"" + values[i].trim() + "\",\n"
	}

	fs.writeFileSync("loc.txt", str);
}

makeKeys();