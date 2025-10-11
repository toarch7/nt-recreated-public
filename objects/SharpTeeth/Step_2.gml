if lockstep_stop exit

if !hit {
	if instance_exists(Player) && instance_exists(target) {
	    x = target.x
	    y = target.y
	}
	
	if image_index >= 2 {
		with target {
			projectile_hit_self(other.damage)
		}
		
		hit = true
		snd_play_pitch(sndSharpTeeth)
	}
}