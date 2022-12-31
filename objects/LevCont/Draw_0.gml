//draw_background(bakMut,view_xview,view_yview)
scrDrawSpiral()

draw_set_halign(fa_center)
draw_set_valign(fa_top)


if GameCont.crownpoints <= 0 {
    if GameCont.skillpoints <= 1 or(!GameCont.skillpoints && GameCont.ultrapoints) {
        txt = " @gMUTATION"
    } else {
        txt = " @gMUTATIONS"
    }

    txt2 = "SELECT "

    if GameCont.race == 8 {
        if GameCont.skillpoints <= 1 {
            txt = " @gUPDATE"
        } else txt = " @gUPDATES@s#DON'T TURN OFF THE ROBOT"

        txt2 = "INSTALL "
    }
} else {
    txt = "CHOOSE WISELY"
    txt2 = ""
}

if splat {
    draw_sprite(sprSkillSplat, 0, view_width / 2, view_height - 31)
}

spr = sprTextLevel
count = string(GameCont.skillpoints)

if instance_exists(CrownIcon) {
    spr = sprTextCrown
    count = ""
} else if instance_exists(UltraIcon) {
    spr = sprTextUltra
    count = loc("@gULTRA")
}

var img = appear > view_height * 0.7 ? 0 : 2

draw_sprite_ext(spr, img, view_xview + view_width / 2 + 1, view_yview + 49 + appear, 1, 1, 0, c_black, 1)
draw_sprite(spr, img, view_xview + view_width / 2, view_yview + 48 + appear)

draw_text_nt(view_xview + view_width / 2 + 1, view_yview + 75 - appear, "@s" + loc_sfmt(txt2 + "%" + txt, count))

appear = lerp(appear, 0, 0.75)