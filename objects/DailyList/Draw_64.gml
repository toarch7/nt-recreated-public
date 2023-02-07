var keys = viewtype == "weekly" ? weeklykeys : dailykeys
var typehistory = history[$ viewtype]
var yy = 48
var len = array_length(keys)
var kills = history.kills[viewtype == "weekly"]

var perpage = 6
var maxpages = ceil(len / perpage)

if instance_exists(Menu) {
    if alpha < 0.5 alpha += 0.1

    draw_set_color(c_black)
    draw_set_alpha(alpha)
    draw_rectangle(0, 0, view_width, view_height, 0)
    draw_set_alpha(1)
    draw_set_color(c_white)
}
else {
    draw_set_halign(fa_center)
    draw_text_nt(view_width / 2, 12, loc(string_upper(viewtype))) //loc_sfmt("@wYOUR % RUN ENTIRES", loc(string_upper(viewtype))))
    draw_set_halign(fa_left)
}

draw_set_halign(fa_left)
draw_set_valign(fa_center)

if !array_length(keys) {
    draw_set_halign(fa_center)
    draw_set_valign(fa_center)
    draw_text_nt(view_width / 2, view_height / 2, loc("@wNOTHING TO SHOW... YET"))
    draw_set_halign(fa_left)
    draw_set_valign(fa_top)

    exit
}

var avg = kills / len
draw_text_nt(38, 14, loc("@dAVERAGE SCORE") + ":#" + string(avg))

draw_set_color(c_white)

draw_set_valign(fa_top)

draw_set_halign(fa_center)

draw_text_nt(view_width / 2, view_height - 18, string(page + 1) + "/" + string(maxpages))

draw_set_halign(fa_left)

var touchr = 0,
    touchl = 0

if maxpages > 1 {
    var mx = device_mouse_x_to_gui(0)
    var my = device_mouse_y_to_gui(0)

    draw_sprite_ext(sprDailyListArrow, 0, view_width / 2 - 96, view_height - 16, 1, 1, 0, c_white, 1)
    draw_sprite_ext(sprDailyListArrow, 1, view_width / 2 + 96, view_height - 16, 1, 1, 0, c_white, 1)

    if mouse_check_button_pressed(mb_left) {
        if point_in_circle(mx, my, view_width / 2 - 96, view_height - 16, 16) {
            snd_play(sndClick)
            touchl = 1
        }
		else if point_in_circle(mx, my, view_width / 2 + 96, view_height - 16, 16) {
            snd_play(sndClick)
            touchr = 1
        }
    }

    if touchr or gamepad_button_check_pressed(0, gp_padr) or keyboard_check_pressed(vk_right) {
        page++snd_play(sndClick)

        if page >= maxpages {
            page = 0
        }
    } else if touchl or gamepad_button_check_pressed(0, gp_padl) or keyboard_check_pressed(vk_left) {
        page--snd_play(sndClick)

        if page < 0 {
            page = maxpages - 1

            if page < 0 {
                page = 0
            }
        }
    }
}

var pg = page * perpage
var maxpg = pg + perpage

if maxpg > len {
    maxpg = len
}

for (var i = pg; i < maxpg; i++) {
    var run_id = keys[i]
    var run = typehistory[$ run_id]
    var str = month_name_short(run.month) + ". " + scrAddZero(run.day, 1) + " " + area_get_name(run.area, run.subarea, run.loop)

    draw_sprite(sprDailySplat, 3, view_width / 2, yy + 3)

    draw_text_nt(27, yy + 2 - 6 * (array_length(run.skills) > 0), str)

    if run.killed_by != mskNone && is_string(run.killed_by) {
        var spr = asset_get_index(run.killed_by)
        if !sprite_exists(spr) spr = mskNone

        if spr == sprNothing2Idle {
            spr = sprKilledByThrone2
        } else if spr == sprNothingMiddle {
            spr = sprKilledByThrone
        }

        draw_sprite_ext(spr, frame, view_width - 96, yy + 3, 0.7, 0.7, 0, c_white, 1)
    }

    draw_sprite(sprKillsIcon, 0, view_width - 72, yy + 3)
    draw_text_nt(view_width - 56, yy, string(run.kills))

    if run.bwep {
        draw_sprite(wep_sprt[run.bwep], 0, view_width / 2 + 10 + 4, yy + 4)
        draw_sprite(wep_sprt[run.wep], 0, view_width / 2 + 10 - 4, yy - 2)

        draw_sprite_ext(sprLoadoutCrown, run.crown, view_width / 2 - 4, yy, 0.5, 0.5, 0, c_white, 1)
    } else {
        draw_sprite_ext(sprLoadoutCrown, run.crown, view_width / 2 - 4, yy + 3, 0.5, 0.5, 0, c_white, 1)
        draw_sprite(wep_sprt[run.wep], 0, view_width / 2 + 10, yy + 3)
    }

    draw_sprite(run.skin ? sprPlayerMapIconSkin : sprPlayerMapIcon, run.race, 14, yy + 4)

    var skills = run.skills
    var len = array_length(skills)
    var px = 0

    if run.ultra {
        draw_sprite_ext(sprUltraIconHUD, ultr_indx[run.race, run.ultra], 30, yy + 10, 0.5, 0.5, 0, c_white, 1)
        px++
    }

    for (var j = 0; j < len; j++) {
        var skill = skills[j]

        draw_sprite_ext(sprSkillIconHUD, skill, 30 + px * 8, yy + 10, 0.5, 0.5, 0, c_white, 1)

        if skill == run.patienceskill {
            draw_sprite_ext(sprPatienceIconHUD, 0, 30 + px * 8, yy + 10, 0.5, 0.5, 0, c_white, 1)
        }

        px++
    }

    yy += 30

    if yy >= view_height - 32 {
        break
    }
}

frame += 0.4