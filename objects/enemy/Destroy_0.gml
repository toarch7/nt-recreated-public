if !instance_exists(id) exit

if givekill && instance_exists(GameCont) {
    GameCont.kills++
}

if instance_number(enemy) == 2 with Player snd_play_hit_big(sndLastEnemy, 0.2)

if corpse {
    with instance_create(x, y, CorpseActive) {
        size = other.size
        mask_index = other.mask_index
        motion_add(other.direction, other.speed)
        speed += max(0, - other.hp / 5)
        sprite_index = other.spr_dead
        image_xscale = other.right

        if instance_exists(Player) {
            if skill_get(20) {
                speed += 8
            }
        }

        if speed > 16 speed = 16

        if size > 0 {
            speed /= size
        }
    }
}

snd_play(snd_dead)

sleep(20 + size * 15)
if instance_exists(Player) {
    with Player {
        if race == 4 other.raddrop += 1
    }
}

do {
    if raddrop >= 15 {
        raddrop -= 10

        with instance_create(x, y, BigRad) {
            motion_add(other.direction, other.speed)
            motion_add(random(360), random(other.raddrop / 2) + 5)

            repeat speed
            speed *= 0.9

            if instance_exists(Player) && Player.race == 11 && ultra_get(1) {
                repeat 4 {
                    with instance_create(x, y, HorrorBullet) {
                        creator = Player.id
                        direction = other.direction + random_range(-8, 8)

                        if instance_exists(creator) && creator.bskin sprite_index = sprHorrorBullet2

                        speed = 9
                        image_angle = direction
                        team = creator.team
                    }
                }
            }
        }
    }
} until raddrop <= 15

repeat raddrop {
    with instance_create(x, y, Rad) {
        motion_add(other.direction, other.speed)
        motion_add(random(360), random(other.raddrop / 2) + 5)

        repeat speed
        speed *= 0.9

        if instance_exists(Player) && Player.race == 11 && ultra_get(1) {
            with instance_create(x, y, HorrorBullet) {
                creator = Player.id
                direction = other.direction

                if instance_exists(creator) && creator.bskin sprite_index = sprHorrorBullet2

                speed = 9
                image_angle = direction
                team = creator.team
            }
        }
    }
}

if !hp {
    //SOME KILLS REGENERATE AMMO
    with Player {
        if race == 9 && ultra == 1 && hp <= 0 {
            bleed = 1
        }

        if skill_get(6) && random(10) < 1 {
            type = irandom(4) + 1

            ammo[type] += round(typ_ammo[type] / 2)

            if ammo[type] > typ_amax[type] {
                ammo[type] = typ_amax[type]
            }

            dir = instance_create(x, y, PopupText)
            dir.mytext = "+" + string(round(typ_ammo[type] / 2)) + " " + string(typ_name[type])

            if Player.ammo[type] >= typ_amax[type] {
                dir.mytext = "MAX " + string(typ_name[type])
            }
        }

        //SOME KILLS REGENERATE HEALTH
        if skill_get(7) && random(15) < 1 {
            num = 1
            hp += num
            if hp > max_hp {
                hp = max_hp
            }

            dir = instance_create(x, y, PopupText)
            dir.mytext = "+" + string(num) + " HP"

            if hp >= max_hp {
                dir.mytext = "MAX HP"
            }

            with instance_create(x, y, AnimParticle) {
                sprite_index = sprBloodLust
                image_speed = 0.4

                creator = other.id
            }

            snd_play(sndBloodlustProc)
        }

        if skill_get(23) {
            if reload reload = max(1, floor(reload * 0.6)) if breload breload = max(1, floor(breload * 0.6)) fingers = 6
        }
    }
    if instance_exists(Player) && place_meeting(x, y, Tangle) && Player.race == 5 && ultra_get(2) {
        instance_create(x, y, Sapling)
    }
}

if instance_exists(CoopController) {
    buffer_seek(global.buffer, buffer_seek_start, 0)
    buffer_write(global.buffer, buffer_u8, event.hitmekill)
    buffer_write(global.buffer, buffer_string, string(index))
    buffer_write(global.buffer, buffer_string, string(x))
    buffer_write(global.buffer, buffer_string, string(y))
    buffer_write(global.buffer, buffer_string, string(direction))
    buffer_write(global.buffer, buffer_string, string(speed))
    buffer_write(global.buffer, buffer_string, string(hp))
    buffer_send(global.buffer)

    global.coopenemylist[$ string(index)] = undefined
}