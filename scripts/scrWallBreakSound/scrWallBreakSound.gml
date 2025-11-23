function scrWallBreakSound() {
    var _snd = sndWallBreak,
		_area = GameCont.area

    switch (_area) {
        case Area.Sewers:
        case Area.Palace:
        case Area.VenusMansion:
        case Area.YVCrib:
        case Area.PizzaSewers:
            _snd = sndWallBreakBrick
            break
        case Area.Scrapyards:
            _snd = sndWallBreakScrap
            break
        case Area.CrystalCaves:
        case Area.CursedCaves:
            _snd = sndWallBreakCrystal
            break
        case Area.Labs:
            _snd = sndWallBreakLabs
            break
        case Area.Jungle:
            _snd = sndWallBreakJungle
            break
        case Area.Oasis:
            _snd = sndOasisExplosionSmall
            break
    }
	
    snd_play_pitchvol(_snd, 0.2, 0.4)
}
