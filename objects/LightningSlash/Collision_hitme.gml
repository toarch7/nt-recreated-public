if lockstep_stop
	exit

if other.inframes && other.object_index == Player exit

if other.team != team {
    with other {
        if !inframes {
            snd_play_hit(snd_hurt, 0.2)
            hp -= other.dmg
            sprite_index = spr_hurt
            image_index = 0

            motion_addm(other.direction, 8)

            BackCont.shake += 5
            inframes = 5
        }
    }

    if instance_exists(creator) {
        with instance_create(other.x, other.y, Lightning) {
            image_angle = other.direction + (random(3) - 6)

            creator = other.creator.id
            team = creator.team

            ammo = 7

            event_perform(ev_alarm, 0)

            visible = 0

            with instance_create(other.x, other.y, LightningSpawn)
            image_angle = other.image_angle
        }
    }
}