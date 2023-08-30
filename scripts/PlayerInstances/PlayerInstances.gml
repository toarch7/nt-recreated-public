globalvar playerinstances, playerinstance;

playerinstances = {}
playerinstance = undefined

function scrRunStart() {
    random_set_seed(global.seed)
	
    GameCont.crown = Menu.loadout_crown
	
	if instance_exists(CoopController) {
		global.index = CoopController.index
	}
	
    scrSpawnPlayers(global.index)
	
    global.crownpick = GameCont.crown
	
    with Player {
        snd_cnfm = asset_get_index("sndMutant" + string(race) + "Cnfm")
		
        if race == 13 {
            snd_cnfm = sndBigDogSpin
        }
		
        crown = GameCont.crown
		
        snd_play(snd_cnfm)
    }
	
    if UberCont.daily_run && !UberCont.weekly_run {
        save_set_val("etc", "seed", UberCont.daily_seed)
    }
	
    room_restart()
}

function scrSpawnPlayers(myIndex = global.index) {
    var players = playerinstances
    var names = struct_keys(players)

    for (var i = 0; i < array_length(names); i++) {
        var name = names[i],
            pinst = players[$ name]

        if is_undefined(pinst) continue

        if pinst.race == 0 or pinst.randchar {
            do {
                pinst.race = 1 + irandom(14)

                if pinst.race == 13 {
                    pinst.race += choose(-1, 1)
                }
            } until UberCont.cgot[pinst.race]
			
			pinst.randchar = 1

            if !instance_exists(CoopController) {
                if !UberCont.daily_run {
                    pinst.cwep = save_get_val("cswep", string(pinst.race), 0) ? UberCont.cwep[pinst.race] : UberCont.race_swep[pinst.race]
                }
				else if !UberCont.weekly_run {
                    pinst.cwep = race_swep[pinst.race]
                }
            }

            if !UberCont.daily_run {
                with Menu {
					loadout_crown = save_get_val("ccrown", string(pinst.race), 1)
				}
				
				GameCont.crown = save_get_val("ccrown", string(pinst.race), 1)
            }
        }

        if pinst.race == 14 && !instance_exists(CoopController) && !UberCont.weekly_run && !UberCont.cgot[14] {
            pinst.race = 4
        }

        if pinst[$ "cwep"] == 255 {
            pinst.race = 15
        }

        with scrSpawnPlayer(pinst.index, pinst.race, pinst.skin) {
            is_me = 0

            if pinst.index == myIndex {
                GameCont.race = race
                is_me = 1

                if UberCont.daily_run && !UberCont.weekly_run {
                    UberCont.ctot_days[race] ++
                }

                if global.hardmode {
                    UberCont.ctot_hard[race] ++
                }

                UberCont.ctot_runs[race] ++
            }

            wep = pinst.cwep

            ammo[wep_type[wep]] += typ_ammo[wep_type[wep]] * 3

            if bwep {
                ammo[wep_type[bwep]] += typ_ammo[wep_type[bwep]] * 3
            }
        }
    }
}

function PlayerInstance(_index = 0) constructor {
    index = _index
	uid = -1
	
	name = "Player"
	color = -1
	
    race = 0
    skin = 0
	
    cwep = 1
    hp = 0
	cprefs = 0
	randchar = 0
	
	static update_prefs = function() {
		var cprefs = 0
		
		with UberCont {
			for(var i = 0; i < array_length(cpref_list); i ++) {
				if self[$ "cpref_" + cpref_list[i]]
					cprefs |= (1 << (i + 1))
			}
		}
		
		name = scrGetUsername()
		color = global.player_color
		
		if self.cprefs != cprefs
			KeyCont.activeforever[index] = false
		
		self.cprefs = cprefs
		
		if instance_exists(CoopController) {
			// share
		}
	}
	
	static pref = function(name) {
		var list = UberCont.cpref_list,
			index = array_indexof(list, name)
		
		if index == -1
			return false
		
		return bit_check(self.cprefs, 1 << (index + 1))
	}
	
    static write = function(buff) {
        buffer_write(buff, buffer_u8, index)
		
        buffer_write(buff, buffer_u8, race)
        buffer_write(buff, buffer_u8, skin)
        buffer_write(buff, buffer_u16, cwep)
		
        buffer_write(buff, buffer_u32, color)
        buffer_write(buff, buffer_u32, cprefs)
		
        buffer_write(buff, buffer_string, name)
		
        return buff
    }

    static read = function(buff) {
		
        race = buffer_read(buff, buffer_u8)
        skin = buffer_read(buff, buffer_u8)
        cwep = buffer_read(buff, buffer_u16)
		
        color = buffer_read(buff, buffer_u32)
        cprefs = buffer_read(buff, buffer_u32)
		
        name = buffer_read(buff, buffer_string)
    }
	
	playerinstances[$ index] = self
}

function playerinstance_reset(index = global.index) {
	var old = playerinstance_get(index),
		old_index = -1
	
	if old != undefined
		old_index = old.index
	
	var player = new PlayerInstance(index)
	
	if old != undefined && old_index == index
		player.update_prefs()
	
	return player
}

function playerinstance_remove(index) {
    playerinstances[$ string(index)] = undefined
    playerinstances = struct_clone(playerinstances, 0)

    show_debug_message("Removed playerinstace. list: " + string(playerinstances))
}