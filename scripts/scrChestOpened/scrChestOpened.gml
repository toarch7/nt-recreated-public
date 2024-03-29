// called whenever chest is being opened
// return any value >=0.5 to prevent further event code
function scrChestOpened() {
	if instance_exists(GenCont)
		return true
	
	var p = instance_nearest(x, y, Player)
	
	if !instance_exists(p)
		exit
	
	// crown of hatred
	if instance_is(other, Player) {
		var p = other.id
		
		if GameCont.crown == 6 {
		    with p {
		        hp -= 1
			
		        sprite_index = spr_hurt
		        image_index = 0
			
		        snd_play_hit(snd_hurt, 0.2)
				last_hit = sprCrown6Idle
				
				var a = 16
				
				if object_is_ancestor(other.object_index, RadChest)
					a = 24
				
		        repeat a {
		            with instance_create(x, y, Rad)
						motion_add(random_angle, 2 + random(4))
		        }
		    }
		}
	}
}