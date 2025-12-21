var _butt = buttgot, _cskin = (instance_is(creator, Player) && creator.bskin == SkinLetter.C)

with instance_create(x + explo_x, y + explo_y, PopoExplosion) {
    team = team_none
	creator = other.creator
	
	x += orandom(4)
	y += orandom(4)
	
	if (_cskin) {
		sprite_index = (_butt ? sprRogueExplosionCTB : sprRogueExplosionC)
	}
	else {
		sprite_index = (_butt ? sprRogueExplosionTB : sprRogueExplosion)
	}
	
	hitid = [ sprite_index, scrDeathCauseGetName(HitId.PopoExplosion) ]
	
    if (_butt) {
		repeat (4 + random(8)) {
			var _angle = random_angle,
				_x = x + lengthdir_x(random(48), _angle),
				_y = y + lengthdir_y(random(48), _angle)
            
			instance_create(_x, _y, _cskin ? GreenFlame : BlueFlame)
		}
	}
	else {
		mask_index = mskExplosion
	}
	
    snd_play(sndIDPDNadeExplo)
}

explo_x += ldrx(size, direction)
explo_y += ldry(size, direction)

if ((--ammo) <= 0) {
	instance_destroy()
}
else alarm[0] = 2