max_hp = 10
size = 1

spr_idle = sprServer
spr_hurt = sprServerHurt
spr_dead = sprServerDead


event_inherited()


snd_hurt = sndHitMetal

if random(10) < 1 {
    max_hp = 6
    hp = 6
    spr_idle = sprTerminal
    spr_hurt = sprTerminalHurt
    spr_dead = sprTerminalDead

    instance_change(Terminal, false)
}