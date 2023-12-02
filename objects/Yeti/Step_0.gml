if alarm[1] > 0 {
	if sprite_index == sprYetiIdle && (x > view_xview && y > view_yview && x < view_xview + view_width && y < view_yview + view_height) {
		
		if instance_exists(Player) && alarm[1] > 12
			image_xscale = sign(Player.x - x)
	}
	else alarm[1] = 15
}