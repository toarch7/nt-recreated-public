event_inherited()

if walk {
    motion_add(direction, 0.8)
    walk--
}

if speed > 4 speed = 4
if speed < 1 speed = 1

if dodge {
    move_contact_solid(direction, 6)
    dodge--
}

if instance_exists(Player) {
    if random(90) < 1 && instance_exists(target) {
        if point_distance(x, y, target.x, target.y) <= 64 {
            direction = target_direction
        }

        dodge = 4
        alarm[0] += 4
    }
}

if hp < max_hp / 2 && !sndhalfhp {
    snd_play(sndLilHunterHalfHP)
    sndhalfhp = 1
}

if !instance_exists(Player) && !sndtaunt {
    if tauntdelay > 50 {
        snd_play(sndLilHunterTaunt)
        sndtaunt = 1
    }

    tauntdelay++
}