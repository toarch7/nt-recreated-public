drawspr = sprTechnoMancer
drawimg = 0

if instance_exists(target) {
    if !intro && !collision_line(x, y, target.x, target.y, Wall, 0, 0) {
        alarm[3] = 2
		
        with TechnoMancer
			intro = 1
        
		with MusCont
			alarm[2] = 1
    }
}