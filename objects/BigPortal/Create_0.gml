image_speed = 0.4

endgame = 100

snd_play(sndPortalOpen)
snd_loop(sndPortalLoop)

if instance_exists(Player) {
    with projectile {
        if team != 2 {
			instance_destroy(id, 0)
		}
	}
}

with Wall {
    if distance_to_object(other) <= 12 {
        instance_destroy()
        instance_create(x, y, FloorExplo)
    }
}

instance_create(x, y, PortalShock)

with prop {
    if distance_to_object(other) <= 32 {
        hp = 0
    }
}

if instance_exists(Player) with WeaponChest {
    if distance_to_object(other) <= 32 {
        pickup = instance_create(x, y, WepPickup)
        with pickup {
            scrWeapons()
            scrDecideWep(1 + other.curse * 2)
            name = wep_name[wep]
            ammo = 50
            type = wep_type[wep]
            curse = other.curse
            sprite_index = wep_sprt[wep]
        }
		
		var p = instance_nearest(x, y, Player)

        if p.race == 7 && p.ultra == 1 {
			with pickup {
	            instance_copy(0)
	            motion_add(random(360), 2)
	        }
		}

        snd_play(sndWeaponChest)
    }
}

with AmmoChest {
    if distance_to_object(other) <= 32 {
        repeat 2 instance_create(x, y, AmmoPickup)
        instance_destroy()
    }
}

with HealthChest {
    if distance_to_object(other) <= 32 {
        repeat 2 instance_create(x, y, AmmoPickup)
        instance_destroy()
    }
}