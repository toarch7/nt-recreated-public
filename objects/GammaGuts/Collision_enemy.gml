if other.object_index == Van || !scr_can_hit(other.id, false) exit

if scr_hit(other.id, damage) && other.hp <= 0 {
    sprite_index = sprGammaBlast
    image_index = 0
	
    with enemy {
        if point_distance(x, y, other.x, other.y) <= 32 {
			scr_hit_self(8)
        }
    }
	
    image_alpha = 0.2
    snd_play(sndGammaGutsKill)
}