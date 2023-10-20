view_xview = 0
view_yview = 0

// align
var objects = [ SkillIcon, CrownIcon, UltraIcon ]

for(var i = 0; i < array_length(objects); i ++) {
	var obj = objects[i],
		step = 34, xx
	
	if !instance_exists(obj)
		continue
	
	do {
		xx = view_width / 2 + (step * max(0, instance_number(obj) - 1) * 0.5)
		
		step -= 2
	}
	until xx < view_width
	
	xx = view_xview + xx
	
	with obj {
		x = xx
		xx -= step
	}
}
