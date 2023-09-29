const fs = require("fs");

let remove = false;

if (process.argv.indexOf("--remove") != -1)
	remove = true;

function doTheThing(path) {
	let str = "if lockstep_stop\n\texit\n\n";

	fs.readFile(path, "utf-8", function(_, f) {
		if (!f.startsWith(str)) {
			fs.writeFile(path, str + f, err => console.log(err));
		}
		else if (remove) {
			fs.writeFile(path, f.replace(str, ""), err => console.log(err));
		}
	});
}

const objectblacklist = [
	"UberCont", "CoopController", "MobileUI", "ButtonAttack",
	"JoystickMove", "JoystickAttack", "ButtonActive", "ButtonSwap",
	"ButtonAct"
];




function funny() {
	fs.readdir("objects", function(err, dirs) {
		dirs.forEach(function(dir) {
			if (objectblacklist.indexOf(dir) != -1) {
				return;
			}
			
			let path = "objects/" + dir + "/";
			
			let str = fs.readFileSync(path + dir + ".yy", "utf-8");
			
			let key = "\"parentObjectId\": {";
			
			let p1 = str.indexOf(key);
			
			if (p1 == -1)
				return;
			
			let part = str.slice(p1, str.length);
			let p2 = part.indexOf("}");
			
			let needed = part.slice(key.length - 1, p2 + 1);
			let parent = JSON.parse(needed.replace("\",\r\n  }", "\"\n  }")).name;
			
			if (parent != "projectile")
				return;
			
			let create = fs.readFileSync(path + "Create_0.gml", "utf-8");
			
			if (!create || create.indexOf("event_inherited()") == -1) {
				console.log(dir, "doesn't inherit projectile's create event");
				fs.writeFileSync(path + "Create_0.gml", "event_inherited()\n" + create);
			}
		});
	});
}


funny();

return;

fs.readdir("objects", function(err, dirs) {
	dirs.forEach(function(dir) {
		if (objectblacklist.indexOf(dir) != -1) {
			return;
		}

		let path = "objects/" + dir + "/";
		
		let events = [ "Step_0.gml", "Step_1.gml", "Step_2.gml", "Draw_0.gml", "Draw_1.gml", "Draw_2.gml", "Draw_64.gml" ];
		
		for(let i in events) {
			let ev = events[i];
			
			fs.exists(path + ev, exists => {
				if(exists)
					doTheThing(path + ev);
			});
		}
		
		fs.readdir(path, function(err, f) {
			f.forEach(f => {
				if (f.startsWith("Collision") || f.startsWith("Mouse"))
					doTheThing(path + f);
			});
		});
	});
});