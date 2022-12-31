#macro URL_DAILY_WEBHOOK "DISCORD_WEBHOOK_URL_HERE"
#macro URL_WEEKLY_WEBHOOK "DISCORD_WEBHOOK_URL_HERE"

function scrSendDailyData() {
    if !UberCont.daily_run or is_undefined(UberCont.update_info) or UberCont.continued_run {
        exit
    }

    with Player
    if is_me {
        var d = struct_secure_load(game_directory + "dailyruns.dat")

        if is_undefined(d) {
            d = {
                daily: {},
                weekly: {},

                kills: [0, 0]
            }
        }

        if is_undefined(d[$ "kills"]) {
            d.kills = [0, 0]
        }

        var skillsarr = []
        var l = GameCont.skills
        var runs = 0
        var avg = 0

        for (var i = 0; i < ds_list_size(l); i++) {
            var skill = l[| i]

            if skill != 25 {
                array_push(skillsarr, skill)
            }
        }

        var list = UberCont.weekly_run ? d.weekly : d.daily
        var _d = list[$ string(global.seed)]

        if is_undefined(_d) or(!is_undefined(_d) && _d.kills < GameCont.kills) {
            if UberCont.weekly_run {
                if !is_undefined(_d) {
                    d.kills[1] += max(0, GameCont.kills - _d.kills)
                } else d.kills[1] += GameCont.kills
            } else d.kills[0] += GameCont.kills

            list[$ string(global.seed)] = {
                race: race,
                skin: bskin,
                ultra: GameCont.ultra,

                skills: skillsarr,
                patienceskill: GameCont.patienceskill,

                wep: wep,
                bwep: bwep,
                crown: GameCont.crown,

                day: UberCont.date_day,
                month: UberCont.date_month,
                timestamp: date_current_datetime(),

                area: GameCont.area,
                subarea: GameCont.subarea,
                loop: GameCont.loops,

                killed_by: sprite_exists(last_hit) ? sprite_get_name(last_hit) : mskNone,
                kills: GameCont.kills
            }

            runs = array_length(struct_keys(list))
            avg = d.kills[UberCont.weekly_run] / runs

            struct_secure_save(game_directory + "dailyruns.dat", d)
            struct_secure_save("dailyruns.dat", d)
        }

        var map = ds_map_create();
        map[? "Content-type"] = "application/json";
        var date = scrAddZero(UberCont.date_day, 1) + "." + scrAddZero(UberCont.date_month, 1) + "." + string(UberCont.date_year)
        var time = scrAddZero(GameCont.minutes, 1) + ":" + scrAddZero(GameCont.seconds, 1)

        var name = save_get_val("etc", "name", "unnamed")
        name = string_replace_all(name, "?", "_")
        name = string_replace_all(name, "&", "_")
        name = string_replace_all(name, "@", "")
        name = string_replace_all(name, "\n", "")
        name = string_replace_all(name, "#", "")

        if instance_exists(GameCont) && ((GameCont.hard > 3 && UberCont.weekly_run) or!UberCont.weekly_run) {
            scrRaces()
            scrCrowns()
            scrSkills()
            scrUltras()

            var mut_list = ""

            scrDiscordIcons()

            for (var i = 0; i < ds_list_size(GameCont.skills); i++) {
                mut_list += muticon[GameCont.skills[| i]] + " "
            }

            if ds_list_size(GameCont.skills) {
                mut_list = "\n**Muts**:\n" + mut_list
            }

            if GameCont.ultra {
                mut_list += ulticon[GameCont.race, GameCont.ultra]
            }

            var week = 0

            if UberCont.weekly_run {
                week = scrReal(UberCont.weekly_data[? "week"])
                date = "Week #" + string(week) + " " + date
            }

            var char_icon = chricon[GameCont.race, GameCont.bskin + 1]
            var crownicon = cwnicon[GameCont.crown]

            random_set_seed(global.seed)

            var secwep = ", " + string_lower_camel(wep_name[bwep])

            if !bwep {
                secwep = ""
            }

            var footerstring = "(v" + string(GAME_BUILD) + ") Entry #" + string(runs) + ", player score: " + string(avg)

            if avg <= 0 {
                footerstring = "(no score improvement)"
            }

            var result = {
                embeds: [{
                    title: string(char_icon) + " " + string_copy(name, 1, 15),
                    description: " **" + area_get_name(GameCont.area, GameCont.subarea, GameCont.loops) + (GameCont.win ? " (Win)" : "") + "<:none:763720063140233226> <:none:763720063140233226> <:none:763720063140233226> <:Kills:763751370901159979> " + string(GameCont.kills) + "**\n\n**Weapons**:\n" + string_lower_camel(wep_name[wep]) + secwep + mut_list + "\n**Crown**: " + crownicon + "\n**Time**: " + time,
                    color: string(make_color_hsv(irandom(255), 200, 200)),
                    footer: {
                        text: footerstring
                    }
                }],

                username: string(date)
            };

            if os_type != os_android {
                var _platform = "??"

                if os_type == os_windows {
                    _platform = "Windows"
                } else if os_type == os_linux {
                    _platform = "Linux"
                }

                result.embeds[0].title += ", " + string(_platform)
            }

            if UberCont.opt_gamepad {
                result.embeds[0].title += " 🎮"
            } else if UberCont.opt_keyboard {
                result.embeds[0].title += " ⌨"
            }

            var hook = URL_DAILY_WEBHOOK
            if UberCont.weekly_run {
                hook = URL_WEEKLY_WEBHOOK
            }

            scrHttpRequest(hook, "POST", map, json_stringify(result))
        }

        ds_map_destroy(map)
    }

    if !UberCont.weekly_run {
        save_set_val("etc", "seed", UberCont.daily_seed)
    }
}