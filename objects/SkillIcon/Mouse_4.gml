if selected {
    event_user(0)
} else {
    LevCont.splat = 1
    snd_play(sndMenuSelect)
    with SkillIcon selected = (id == other.id)
}