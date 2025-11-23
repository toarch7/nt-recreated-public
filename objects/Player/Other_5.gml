if skill_get(Mut.StrongSpirit) {
	if !can_spirit && !spirit {
		can_spirit = true
	}
}

if skill_get(Mut.Patience) && !GameCont.patient {
    GameCont.skillpoints ++
}

if race == Race.Frog {
    snd_stop(sndFrogLoopButt)
    snd_stop(sndFrogLoop)
    frogcharge = 0
}

instance_destroy(JoystickMove)
instance_destroy(JoystickAttack)
instance_destroy(ButtonSwap)
instance_destroy(ButtonActive)
instance_destroy(ButtonAct)

snd_stop(sndCarLoop)
