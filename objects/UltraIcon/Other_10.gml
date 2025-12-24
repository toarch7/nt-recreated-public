/// @description Select

var _race = race, _num = num

scr_ultra_set(_race, _num, scr_ultra_get(_race, _num) + 1)
snd_play(GameCont.underwater ? sndOasisShoot : scrRaceGetUltraSkillSound(_race, _num))

if (!scrNeedMorePlayerUltras()) GameCont.ultrapoints --

if _race == Race.Venuz || _race == Race.Cuz {
    GameCont.gocrib = true
    room_restart()
}

scrLevelUpScreenSubmit(scrRaceGetUltraSkillName(race, num))