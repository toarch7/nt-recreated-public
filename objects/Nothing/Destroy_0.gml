instance_create(x, y, NothingDeath)

with (MusCont) alarm[1] = 1

snd_play(sndNothingDeath1)
scrAchievementUnlock(33)
audio_stop_sound(sndNothingBeamLoop)

with (enemy) hp = 0

with (projectile) {
    if (team != team_player) instance_destroy()
}

with (BigGenerator) {
    instance_create(x, y, BigGeneratorInactive)
    instance_destroy(id, false)
}

scrOnBossKill()