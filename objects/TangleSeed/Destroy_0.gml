if scr_ultra_get(Race.Plant, UltraSkill.Trapper) {
    var _ang = random_angle
	
	repeat (5) {
        with instance_create(x, y, Tangle) {
            move_contact_solid(_ang, 26 + irandom(8))
			creator = other.creator
			team = other.team
        }
		
		_ang += 72
    }
}