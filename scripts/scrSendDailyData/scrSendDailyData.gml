function scrSendDailyData() {
    if (!scrGameIsEventRun() || is_undefined(UberCont.update_info) || (UberCont.public && scr_debug_cheats_enabled())) exit
	
	if (scrGameIsDailyRun()) UberCont.can_daily = false
	
    with (Player) if (scr_player_is_local(index)) {
		var _race = race,
			_bskin = bskin
        
		#region write run to history
		var d = struct_secure_load(game_directory + "dailyruns.dat")

        if is_undefined(d) {
            d = {
                daily: {},
                weekly: {},

                kills: [0, 0]
            }
        }

        if (is_undefined(d[$ "kills"])) d.kills = [0, 0]
        
        var skillsarr = []
        var l = GameCont.skills
        var runs = 0
        var avg = 0

        for (var i = 0; i < ds_list_size(l); i++) {
            var skill = l[| i]

            if skill != mut_patience {
                array_push(skillsarr, skill)
            }
        }

        var list = UberCont.weekly_run ? d.weekly : d.daily
		
        var _d = list[$ string(global.seed)]

        if is_undefined(_d) or (!is_undefined(_d) && _d.kills < GameCont.kills) {
            if scrGameIsWeeklyRun() {
                if !is_undefined(_d) {
                    d.kills[1] += max(0, GameCont.kills - _d.kills)
                }
				else {
					d.kills[1] += GameCont.kills
				}
			}
			else d.kills[0] += GameCont.kills
			
			var _deathcause_sprite = scrDeathCauseGetSprite(GameCont.deathcause),
				_deathcause_sprite_name = undefined
			
			if (sprite_exists(_deathcause_sprite)) {
				_deathcause_sprite_name = sprite_get_name(_deathcause_sprite)
			}

            list[$ string(global.seed)] = {
                race: race,
                skin: bskin,
                ultra_got: GameCont.ultra_got,
                ultra_hud: GameCont.ultra_hud,
				ultra: 0,

                skills: skillsarr,
                patienceskill: GameCont.patienceskill,

                wep: wep,
                bwep: bwep,
				extra_weps: extra_weps,
                crown: GameCont.crown,

                day: current_day,
                month: current_month,
                year: current_year,
                timestamp: date_current_datetime(),

                area: GameCont.area,
                subarea: GameCont.subarea,
                loop: GameCont.loops,
                killed_by: _deathcause_sprite_name,
				deathcause: GameCont.deathcause,
                kills: GameCont.kills
            }

            runs = array_length(struct_keys(list))
            avg = d.kills[UberCont.weekly_run] / runs

            struct_secure_save(game_directory + "dailyruns.dat", d)
            struct_secure_save("dailyruns.dat", d)
        }
		
		#endregion

        var map = ds_map_create();
        map[? "Content-type"] = "application/json";
        var date = string_pad_zeroes(current_day, 1) + "." + string_pad_zeroes(current_month, 1) + "." + string(current_year)
        var time = string_pad_zeroes(GameCont.minutes, 1) + ":" + string_pad_zeroes(GameCont.seconds, 1)

        var name = save_get_value("etc", "name", "unnamed")
        name = string_replace_all(name, "?", "_")
        name = string_replace_all(name, "&", "_")
        name = string_replace_all(name, "@", "")
        name = string_replace_all(name, "\n", "")
        name = string_replace_all(name, "#", "")

        if instance_exists(GameCont) && (GM_build_type == "run" || (GameCont.hard > 3 && scrGameIsWeeklyRun()) || !UberCont.weekly_run) {
            scrRaces()
            scrCrowns()
            scrSkills()
            scrUltras()

            var mut_list = "", runId = base_convert(global.seed, 10, 16)

            scrWebhookEmoteIDs()

            for (var i = 0; i < ds_list_size(GameCont.skills); i++) {
                mut_list += muticon[GameCont.skills[| i]] + " "
            }

            if ds_list_size(GameCont.skills) {
                mut_list = "\n**Muts**:\n" + mut_list
            }
			
			var _icons = ulticon
			with (GameCont) {
	            var _ultras = ultra_got[_race],
					_count = array_length(_ultras)
					
				for(var i = 1; i < _count; ++i) {
					if (_ultras[i]) mut_list += _icons[_race, i]
		        }
			}
			
            var week = 0

            if UberCont.weekly_run {
                week = scrReal(UberCont.weekly_data[? "week"])
                date = "Week #" + string(week) + " " + date
            }

            var _char_icon = chricon[_race, _bskin + 1]
            var _crown_icon = cwnicon[GameCont.crown]

            random_set_seed(global.seed)

            var _footer = "(v" + string(GAME_BUILD) + ") " + save_get_value("general", "uid", "-1") + ";" + runId

            if avg <= 0 && scrGameIsWeeklyRun() {
                _footer = "(no score improvement)"
            }
			
			var _area = scrAreaGetMapName(GameCont.area, GameCont.subarea, GameCont.loops),
				
				_gap = "<:none:763720063140233226> <:none:763720063140233226> <:none:763720063140233226> <:Kills:763751370901159979>",
				
				var _weapon_list = scrPlayerGetWeapons(id),
					_weapon_count = array_length(_weapon_list),
					_weapons = "\n\n**Weapons**:\n",
					_crown = "\n**Crown**: " + _crown_icon,
					_time = "\n**Time**: " + time,
			
			if (_weapon_count) {
				var _weapon_name = scr_weapon_get_name(array_first(_weapon_list))
				_weapons += string_lower_camel(_weapon_name, true)
				
				for(var i = 1; i < _weapon_count; ++i) {
					if (scr_weapon_is_valid(_weapon_list[i])) {
						var _weapon_name = scr_weapon_get_name(_weapon_list[i])
						_weapons += ", " + string_lower_camel(_weapon_name, true)
					}
				}
			}
			else _weapons += "**\*none\***"
			
            var result = {
                embeds: [{
                    title: string(_char_icon) + " " + string_copy(name, 1, 15),
                    description: " **" + _area + (GameCont.win ? " (Win)" : "") + _gap + " " + string(GameCont.kills) + "**" + _weapons + mut_list + _crown + _time,
                    color: UberCont.opt_healthcol,
                    footer: {
                        text: _footer
                    }
                }],

                username: string(date)
            };

            if os_type != os_android {
                var _platform = "??"

                if os_type == os_windows {
                    _platform = "Windows"
                }
				else if os_type == os_linux {
                    _platform = "Linux"
                }
				else if os_type == os_ios {
					_platform = "iOS"
				}

                result.embeds[0].title += ", " + string(_platform)
            }

            if UberCont.opt_gamepad {
                result.embeds[0].title += " 🎮"
            }
			else if UberCont.opt_keyboard {
                result.embeds[0].title += " ⌨"
            }

            var hook = URL_DAILY_WEBHOOK
			
            if UberCont.weekly_run
                hook = URL_WEEKLY_WEBHOOK
			
			#region save local entry
			
			var _skills = []
			
			for(var i = 0; i < GameCont.skills; i ++) {
				array_push(_skills, GameCont.skills[| i])
			}
			
			var my_entry = {
				char: _race,
				skin: _bskin,
				area: GameCont.area,
				subarea: GameCont.subarea,
				loops: GameCont.loops,
				wep: wep,
				bwep: bwep,
				win: GameCont.win,
				kills: GameCont.kills,
				ultra_got: GameCont.ultra_got,
				ultra: 0,
				skills: _skills,
				crown: GameCont.crown,
				version: UberCont.version,
				uid: scrSavedatascrGetUID()
			}
			
			my_entry.runId = runId
			
			struct_secure_save("local_" + (UberCont.weekly_run ? "weekly" : "daily") + "_entry.dat", my_entry)
			
			#endregion

            scrHttpRequest(hook, "POST", map, json_stringify(result))
        }

        ds_map_destroy(map)
    }

    if (!scrGameIsWeeklyRun()) save_set_value("etc", "seed", UberCont.daily_seed)
}