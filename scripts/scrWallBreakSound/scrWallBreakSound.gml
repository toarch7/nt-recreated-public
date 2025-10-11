function scrWallBreakSound() {
    var _snd = sndWallBreak,
		_area = GameCont.area

    switch (_area) {
        case area_sewers:
        case area_palace:
        case area_mansion:
        case area_crib:
        case area_pizza_sewers:
            _snd = sndWallBreakBrick
            break
        case area_scrapyards:
            _snd = sndWallBreakScrap
            break
        case area_caves:
        case area_cursed_caves:
            _snd = sndWallBreakCrystal
            break
        case area_labs:
            _snd = sndWallBreakLabs
            break
        case area_jungle:
            _snd = sndWallBreakJungle
            break
        case area_oasis:
            _snd = sndOasisExplosionSmall
            break
    }
	
    snd_play_pitchvol(_snd, 0.2, 0.4)
}
