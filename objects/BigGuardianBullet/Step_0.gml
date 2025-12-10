if lockstep_stop
	exit

if sprite_index == sprBigGuardianBulletSpawn {
    x -= hspeed
    y -= vspeed
}
else friction = 0.1

if (speed == 0) instance_destroy()