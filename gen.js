let remove = false;

if (process.argv.indexOf("--remove") == -1)
	remove = true;

function doTheThing(path, remove) {
	let str = "if lockstep_stop\n\texit";

	fs.readFile(path, "utf-8", function(_, f) {
		if (!f.startsWith(str)) {
			fs.writeFile(path, str + "\n" + f, err => console.log(err));
		}
		else if (remove) {
			fs.writeFile(path, str.replace("\n" + f, ""), err => console.log(err));
		}
	});
}

const objectblacklist = [
	"UberCont", "CoopController"
];

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
					injectNetcode(path + ev);
			});
		}
		
		fs.readdir(path, function(err, f) {
			f.forEach(f => {
				if (f.startsWith("Collision") || f.startsWith("Mouse")) {
					doTheThing(path + f);
			});
		});
	});
});