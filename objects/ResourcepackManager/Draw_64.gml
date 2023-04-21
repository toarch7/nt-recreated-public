var count = self.count - unlisted

if loading {
    draw_set_halign(fa_center)

    var t = loc("FETCHING RESOURCEPACKS")
    var f = get_timer() / 500000
    var _y = 4

    if loading == 2 {
        t = loc("COPYING FILES")
    } else if loading == 3 {
        var _if = itemsinfo[$ selected]
        t = loc("DOWNLOADING") + "\n" + string_upper(_if[2]) + "\n\n\n\n" + status
        _y = 8
    }

    draw_text_shadow(view_width / 2, view_height / 2 - _y, t)

    var w = round(string_width(t) / 2)

    draw_set_color(c_white)
    draw_text_shadow(view_width / 2 + sin(f) * w, view_height / 2 + 4, ".")

    draw_set_halign(fa_left)

    exit
}

if error != "" {

    draw_set_halign(fa_center)

    draw_set_color(c_dkgray)

    if error == "INSTALLED SUCCESSFULLY!" {
        draw_set_color(make_color_rgb(68, 198, 22))
    }

    draw_text_shadow(view_width / 2, view_height / 2, loc(string_upper(error)))

    draw_set_color(c_white)

    draw_set_halign(fa_left)

    if mouse_check_button_pressed(mb_left) {
        snd_play(sndMenuClick)
        instance_destroy()
    }

    exit
}

draw_set_halign(fa_left)
draw_set_valign(fa_top)

var z = 1

if mode != 4 {
    var _p = page * RPBrowserPerpage
    var l = min(_p + RPBrowserPerpage, array_length(items)),
        n = 0

    var maxpage = floor((count - 1) / RPBrowserPerpage)

    var a = "MOST RATED"

    if sort == "updated" {
        a = "NEW AND UPDATED"
    } else if sort == "stars V" {
        a = "LEAST RATED"
    } else if sort == "updated V" {
        a = "LEAST UPDATED"
    }

    var _y = 36,
        can = 1

    if browsing {
        draw_set_halign(fa_center)
        draw_text(view_width / 2, 14, "(" + loc(a) + ")")
        draw_set_halign(fa_left)

        if _p >= l && array_length(items) < count {
            print("Browsing start ", [_p, p])
            self.browse() exit
        }
    }

    for (var i = _p; i < l; i++) {
        var _if = itemsinfo[$ items[i][2]]

        items[i, 7] = i

        // show_debug_message([_if, items])

        if browsing && _if == undefined {
            print("Attempting to load", items[i, 2] + "...")
            loadresourcepack(items[i])
            appear[n] = 0 can = 0
            continue
        }

        if _if[5] != -1 {
            draw_set_color(c_black)
            draw_set_alpha(0.33)

            if point_in_rectangle(mouse_x, mouse_y, 0, _y - 2, appear[n], _y + 32) {
                draw_set_alpha(0.66)

                if selected != items[i, 2] {
                    snd_play(sndMenuSelect)
                    selected = items[i, 2]
                }

                if (!global.pc_build && mouse_check_button_released(mb_left)) or mouse_check_button_pressed(mb_left) {
                    snd_play(sndMenuClick)
                    mode = 4

                    exit
                }
            } else if selected == items[i, 2] selected = ""

            draw_rectangle(0, _y - 2, appear[n], _y + 32, 0)
            draw_set_color(c_white)
            draw_set_alpha(1)

            if _if[5] != -2 {
                draw_set_font(fntM1)

                draw_text_nt(28, _y + 4, _if[0] + "@w")

                UberCont.font = fontSmall
                draw_text_nt(28, _y + 14, _if[8] + "@w")
                UberCont.font = fntM1

                if _if[9] != undefined {
                    draw_text_shadow(28, _y + 24, (browsing ? ("$" + string(_if[4]) + " ") : "") + string(_if[9]))
                } else draw_text_shadow(28, _y + 24, "(local)")

                if browsing {
                    var v = version[$ _if[2]]

                    if v != undefined {
                        draw_set_halign(fa_right)

                        if v != _if[11] {
                            draw_set_color(make_color_rgb(68, 198, 22))
                            draw_text_shadow(view_width - 8, _y + 24, loc("UPDATE!"))
                        } else {
                            draw_set_color(c_silver)
                            draw_text_shadow(view_width - 8, _y + 24, loc("DOWNLOADED"))
                        }

                        draw_set_color(c_white)
                        draw_set_halign(fa_left)
                    }
                }

                var s = sprite_exists(_if[6]) ? _if[6] : -1

                if s != -1 && sprite_get_width(s) > 1 {
                    draw_sprite_ext(s, 0, 0, _y + 4, 24 / sprite_get_width(s), 24 / sprite_get_height(s), 0, c_white, 1)
                } else {
                    draw_sprite_ext(sprSaving, get_timer() / 33333 * 0.4, 12, _y + 16, 0.75, 0.75, 0, c_white, 1)
                }
            } else {
                draw_set_font(fontSmall)
                draw_set_color(c_gray)
                draw_text_shadow(28, _y + 16, _if[2])

                draw_set_halign(fa_right)
                draw_text_shadow(view_width - 8, _y + 16, loc("(MALFORMED)"))
                draw_set_halign(fa_left)

                var r = self[$ "_retry_" + _if[2]]

                if r < 30 or r == undefined {
                    if r == undefined r = 0

                    if r == 0 print("Trying to load " + _if[2] + " again...")

                    r++

                    if r >= 30 {
                        itemsinfo[$ _if[2]] = undefined
                        self.loadresourcepack(items[i])

                        r = 0
                    }

                    self[$ "_retry_" + _if[2]] = r
                }

                draw_set_color(c_white)

                var s = sprite_exists(_if[6]) ? _if[6] : -1

                if s != -1 && sprite_get_width(s) > 1 {
                    draw_sprite_ext(s, 0, 0, _y + 4, 24 / sprite_get_width(s), 24 / sprite_get_height(s), 0, c_white, 1)
                } else {
                    draw_sprite_ext(sprSaving, get_timer() / 33333 * 0.4, 12, _y + 16, 0.75, 0.75, 0, c_white, 1)
                }
            }

            if !browsing && !_if[5] {
                draw_set_blend_mode(bm_subtract)
                draw_rectangle_color(0, _y - 2, appear[n], _y + 32, c_white, c_white, c_gray, c_gray, 0)
                draw_set_blend_mode(bm_normal)

                draw_set_halign(fa_center)
                draw_text_shadow(view_width / 2, _y + 6, loc("DISABLED"))
                draw_set_halign(fa_left)
            }

            _y += 36

            if appear[n] < view_width {
                appear[n] += view_width / 10
            }
        } else can = 0

        n++
    }

    if count > 0 {
        draw_sprite_ext(sprDailyListArrow, 1, view_width / 2 - 48, view_height - 14, 1, 1, 90, (can && page > 0) ? c_white : c_dkgray, 1)
        draw_sprite_ext(sprDailyListArrow, 1, view_width / 2 + 48, view_height - 14, 1, 1, 270, can ? c_white : c_dkgray, 1)
    }

    draw_set_font(fntM1)

    draw_set_valign(fa_center)
    draw_set_halign(fa_right)

    if browsing {
        draw_text(view_width - 20, view_height - 12, loc("SORT") + ":")

        var img = 0

        if sort == "updated"
        img = 1
        else if sort == "stars V"
        img = 2
        else if sort == "updated V"
        img = 3

        draw_sprite(sprResourcepackBrowserSort, img, view_width - 4, view_height - 14)
    }

    if count > 0 {
        draw_set_halign(fa_center)
        draw_text(view_width / 2, view_height - 12, string(page + 1) + "/" + string(maxpage + 1))
        draw_set_halign(fa_left)
    }

    draw_set_valign(fa_top)

    if mouse_check_button_pressed(mb_left) && can {
        var p = page

        if point_in_circle(mouse_x, mouse_y, view_width / 2 - 48, view_height - 12, 12) && page > 0 && count > 0 {
            page--

            snd_play(sndMenuClick)

            if page < 0 {
                page = maxpage - 1
            }
        } else if point_in_circle(mouse_x, mouse_y, view_width / 2 + 48, view_height - 16, 12) && count > 0 {
            page++

            snd_play(sndMenuClick)

            if page > maxpage {
                page = 0
            }
        } else if browsing && point_in_circle(mouse_x, mouse_y, view_width - 24, view_height - 16, 16) {
            var s = sort

            if sort == "stars" {
                sort = "updated"
            } else if sort == "updated" {
                sort = "stars V"
            } else if sort == "stars V" {
                sort = "updated V"
            } else sort = "stars"

            if sort != s {
                items = []
                page = 0

                snd_play(sndClickBack)

                self.browse()
            }
        }

        if p != page {
            appear = array_create(array_length(appear), 0)
        }
    }
}

if mode == 4 {
    var _if = itemsinfo[$ selected]

    if _if != undefined {
        draw_set_color(c_black)
        draw_set_alpha(0.33)

        draw_rectangle(0, 34, view_width, 66, 0)

        draw_rectangle(0, 68, view_width, view_height, 0)

        draw_set_color(c_white)
        draw_set_alpha(1)

        var s = sprite_exists(_if[6]) ? _if[6] : -1

        if s != -1 && sprite_get_width(s) > 1 {
            draw_sprite_ext(s, 0, 2, 36, 24 / sprite_get_width(s), 24 / sprite_get_height(s), 0, c_white, 1)
        } else {
            draw_sprite_ext(sprSaving, get_timer() / 33333 * 0.4, 12, 52, 0.75, 0.75, 0, c_white, 1)
        }

        draw_set_font(fontSmall)

        var height = string_height("Aa")

        draw_set_color(c_black)
        draw_text_ext(5, 73, _if[1], height, view_width - 4)
        draw_text_ext(4, 73, _if[1], height, view_width - 4)

        draw_set_color(c_white)
        draw_text_ext(4, 72, _if[1], height, view_width - 4)

        draw_set_font(fntM1)
        draw_text_nt(38, 42, _if[0] + "@w")

        draw_set_color(c_white)
        draw_set_font(fontSmall)

        if _if[9] != undefined {
            draw_text_shadow(38, 52, (browsing ? ("$" + string(_if[4]) + " ") : "") + string(_if[9]))
        } else draw_text_shadow(38, 52, "local")

        var m = _if[3] != undefined

        // github
        draw_sprite_ext(sprResourcepackBrowserActions, 1, view_width - 32, 48, 1, 1, 0, m ? c_blue : c_dkgray, 1)

        if m && point_in_circle(mouse_x, mouse_y, view_width - 32, 48, 16) {
            if self[$ "action_hover"] != 1 {
                self[$ "action_hover"] = 1
                snd_play(sndMenuSelect)
            }

            if mouse_check_button_pressed(mb_left) {
                snd_play(sndMenuClick)
                show_debug_message(_if[3])
                url_open(_if[3])
            }
        } else if self[$ "action_hover"] == 1 {
            self[$ "action_hover"] = -1
        }

        if browsing {
            // download
            draw_sprite_ext(sprResourcepackBrowserActions, 0, view_width - 64, 48, 1, 1, 0, (!_if[5] ? c_dkgray : c_lime), 1)

            if _if[5] && point_in_circle(mouse_x, mouse_y, view_width - 64, 48, 16) {
                if self[$ "action_hover"] != 2 {
                    self[$ "action_hover"] = 2
                    snd_play(sndMenuSelect)
                }

                if mouse_check_button_pressed(mb_left) {
                    snd_play(sndMenuClick)

                    loading = 3
                    download = http_get_file("https://github.com/" + _if[2] + "/archive/refs/heads/master.zip", game_directory + "_download/" + string(get_timer()) + ".zip")

                    alarm[0] = 900
                }
            } else if self[$ "action_hover"] == 2 {
                self[$ "action_hover"] = -1
            }
        } else {
            // delete
            /*if !is_undefined(_if[3]) {
				draw_sprite_ext(sprResourcepackBrowserActions, 2, view_width - 64, 48, 1, 1, 0, c_red, 1)
				
				if point_in_circle(mouse_x, mouse_y, view_width - 64, 48, 16) {
					if self[$ "action_hover"] != 2 {
						self[$ "action_hover"] = 2
						snd_play(sndMenuSelect)
					}
					
					if mouse_check_button_pressed(mb_left) && _if[12] != "" {
						message = show_question_async("Delete " + _if[0] + "?")
						snd_play(sndMenuClick)
					}
				}
				else if self[$ "action_hover"] == 2 {
					self[$ "action_hover"] = -1
				}
			}*/

            if 1 { // is_undefined(_if[3]) {
                var xx = 64

                // toggle
                draw_sprite_ext(sprResourcepackBrowserActions, 3 + _if[5], view_width - xx, 48, 1, 1, 0, _if[5] ? c_white : c_gray, 1)

                if point_in_circle(mouse_x, mouse_y, view_width - xx, 48, 16) {
                    if self[$ "action_hover"] != 3 {
                        self[$ "action_hover"] = 3
                        snd_play(sndMenuSelect)
                    }

                    if mouse_check_button_pressed(mb_left) {
                        snd_play(sndMenuClick)

                        if file_exists(_if[12] + "disable.d") {
                            file_delete(_if[12] + "disable.d")
                            _if[5] = 1

                            itemsinfo[$ selected] = _if

                            restart = 1
                        } else {
                            var f = file_text_open_write(_if[12] + "disable.d")
                            file_text_write_string(f, "")
                            file_text_close(f)
                            _if[5] = 0

                            itemsinfo[$ selected] = _if

                            restart = 1
                        }
                    }
                } else if self[$ "action_hover"] == 3 {
                    self[$ "action_hover"] = -1
                }
            }
        }

        draw_set_font(fntM1)

        var screenshots = _if[11]

        if !array_length(screenshots) {
            for (var i = 1; i <= 3; i++) {
                if browsing {
                    var s = sprite_add("https://raw.githubusercontent.com/" + _if[2] + "/master/screenshot" + string(i) + ".png", 1, 0, 0, 0, 0)
                } else var s = sprite_add(_if[12] + "screenshot" + string(i) + ".png", 1, 0, 0, 0, 0)

                array_push(_if[@11], s)
                array_push(icons, s)
            }
        } else for (var i = 0; i < array_length(screenshots); i++) {
            var s = screenshots[i]
            var w = floor(view_width * 0.3)
            var h = floor(view_height * 0.3)
            var p = view_width / 3

            if sprite_get_width(s) > 1 && sprite_get_height(s) > 1 {
                draw_sprite_ext(s, 0, i * p + 8, view_height - h - 40, w / sprite_get_width(s), h / sprite_get_height(s), 0, c_white, 1)
            } else {
                draw_set_color(c_black)
                draw_set_alpha(0.33)
                draw_rectangle(i * p + 8, view_height - h - 40, i * p + 8 + w, view_height - h - 40 + h, 0)
                draw_set_alpha(1)
                draw_set_color(c_white)
            }
        }
    }
}