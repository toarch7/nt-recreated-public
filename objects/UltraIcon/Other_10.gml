/// @description Select

var _race = race, _num = num

scr_ultra_set(_race, _num, scr_ultra_get(_race, _num) + 1)
snd_play(GameCont.underwater ? sndOasisShoot : scrRaceGetUltraSkillSound(_race, _num))

if (!scrNeedMorePlayerUltras()) GameCont.ultrapoints --

if _race == Race.Venuz || _race == Race.Cuz {
    with (GameCont) {
		can_advance_stage = false
		gocrib = true
	}
    room_restart()
}

var _name = loc("Races", race, "Ultra", num, "Name", scrRaceGetUltraSkillName(race, num))

scrLevelUpScreenSubmit(_name)