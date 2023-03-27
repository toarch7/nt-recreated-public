function scrRunStart() {
    random_set_seed(global.seed)
	
    GameCont.crown = Menu.loadout_crown
	
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
    var players = UberCont.playerinstances
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
                    UberCont.ctot_days[race]++
                }

                if global.hardmode {
                    UberCont.ctot_hard[race]++
                }

                UberCont.ctot_runs[race]++
            }

            wep = pinst.cwep

            ammo[wep_type[wep]] += typ_ammo[wep_type[wep]] * 3

            if bwep {
                ammo[wep_type[bwep]] += typ_ammo[wep_type[bwep]] * 3
            }
        }
    }
}

// playerinstances are used to store starting loadout of a physical player
function PlayerInstance(index = 0, race = 1, skin = 0) constructor {
    self.index = index
    self.race = race
    self.skin = skin
    self.cwep = 1
    self.hp = 1
	
	self.randchar = 0
	
    static write = function(buff) {
        buffer_write(buff, buffer_u8, self.index)
        buffer_write(buff, buffer_u8, self.race)
        buffer_write(buff, buffer_u8, self.skin)
        buffer_write(buff, buffer_u16, self.cwep)
        return buff
    }

    static read = function(buff) {
        self.race = buffer_read(buff, buffer_u8)
        self.skin = buffer_read(buff, buffer_u8)
        self.cwep = buffer_read(buff, buffer_u16)
    }
}

function playerinstance_remove(index) {
    UberCont.playerinstances[$ string(index)] = undefined
    UberCont.playerinstances = struct_clone(UberCont.playerinstances, 0)

    show_debug_message("Removed playerinstace. list: " + string(UberCont.playerinstances))
}