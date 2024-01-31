if lockstep_stop
	exit

if other.team != team && other.hp > 0 {
    with other {
        hp -= round(other.dmg * other.image_xscale)
        
		image_index = 0
        sprite_index = spr_hurt
		
        motion_add(other.direction, 4)

        if speed > 16 {
            speed = 16
        }
    }
	
	scrShake(4)
	
    image_xscale -= 0.1
	
    x -= hspeed
    y -= vspeed

    snd_play_hit(other.snd_hurt, 0.2)
	
	instance_create(x, y, BulletHit)
}