if skill_get(27) && !can_spirit && !spirit {
    can_spirit = 1
}

snd_stop(sndCarLoop)

with(JoystickMove) instance_destroy()
with(JoystickAttack) instance_destroy()
with(ButtonSwap) instance_destroy()
with(ButtonActive) instance_destroy()
with(ButtonAct) instance_destroy()

if skill_get(25) && !GameCont.patient {
    GameCont.skillpoints++
}

if race == 15 {
    frogcharge = 0
    snd_stop(sndFrogLoopButt)
    snd_stop(sndFrogLoop)
}