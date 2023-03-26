if ammo <= 0 exit

snd_play_hit_big(sndGruntFire, 0.2)
wkick = 5

with instance_create(x, y, IDPDBullet) {
    hit_id = sprEliteGruntIdle
    motion_add(other.gunangle + orandom(2), 10)
    image_angle = direction
    team = other.team
}

ammo--alarm[2] = 3