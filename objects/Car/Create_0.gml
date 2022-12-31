max_hp = 20

spr_idle = sprCarIdle
spr_hurt = sprCarHurt
spr_dead = sprScorchmark
if instance_exists(Player) {
    if GameCont.area = 5 {
        spr_idle = sprFrozenCar
        spr_hurt = sprFrozenCarHurt
        spr_dead = sprScorchmark
    }
}
size = 1

event_inherited()


snd_hurt = sndHitMetal