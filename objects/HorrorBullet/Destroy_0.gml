if sprite_index != sprHorrorBullet && spr_fade == sprHorrorHit {
	/**/ if (sprite_index == sprHorrorBBullet) spr_fade = sprHorrorHitB
	else if (sprite_index == sprHorrorCBullet) spr_fade = sprHorrorBulletHitC
}

event_inherited()