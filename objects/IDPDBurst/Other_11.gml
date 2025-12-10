/// @function Fire shots
snd_play(sndRogueRifle)

scrBulletShotShellFX(Shell)

with scr_projectile_create(x, y, Bullet1, direction, 16) {
	sprite_index = sprRogueBullet
	spr_fade = sprIDPDBulletHit
	scr_projectile_spread(2)
}

scr_weapon_post(direction, 6, 3, 4)