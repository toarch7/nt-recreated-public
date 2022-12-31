num = 2
if skill_get(9) num = 4

instance_create(x, y, HealFX)

//RUSH CROWN
if GameCont.crown = 4 num += 1

instance_destroy()

if other.max_hp > 1 {
    other.hp += num
    if other.hp > other.max_hp other.hp = other.max_hp

    dir = instance_create(x, y, PopupText)
    dir.mytext = "+" + string(num) + " HP"
    if other.hp = other.max_hp dir.mytext = "MAX HP"
}

instance_create(x, y, SmallChestPickup)
snd_play(sndHPPickup)

if GameCont.coopultra == 2 {
    var plr = other.id

    with Player
    if id != plr {
        hp += other.num
        if hp > max_hp

        hp = max_hp
    }
}