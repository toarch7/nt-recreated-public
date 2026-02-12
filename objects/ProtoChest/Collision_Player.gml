/// @description Open chest

if (sprite_index == sprProtoChestOpen) exit

sprite_index = sprProtoChestOpen

with (scrWeaponPickupCreate(x, y, wep)) {
	curse = other.curse
	depth = other.depth - 1
}

instance_create(x, y, FXChestOpen)

if scrCrownCheck(Crown.Hatred) with (other) {
    scr_hit_self(1, HitId.CrownOfHatred)
	
	repeat (16) {
        with (instance_create(x, y, Rad)) {
	        motion_add(random_angle, 2 + random(4))
	    }
	}
}

snd_play(sndWeaponChest)

