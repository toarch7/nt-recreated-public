draw_sprite(sprite_index, - 1, x, y)
draw_set_color(c_gray)
draw_rectangle(x, y + 1, x + UberCont.opt_volume * 100, y + 6, 0)

if mouse_check_button(mb_left) and mouse_x > x - 2 and mouse_x < x + 100 and mouse_y > y and mouse_y < y + 8 {
    UberCont.opt_volume = round((mouse_x - x) / 5) * 5 / 100
    with MusCont {
        sound_global_volume(max(0, sqrt(UberCont.opt_volume)))
        sound_volume(song, sqrt(UberCont.opt_musvol))
        sound_volume(amb, sqrt(UberCont.opt_ambvol))
    }
}

if mouse_check_button_pressed(mb_left) and mouse_x > x + 103 and mouse_x < x + 113 and mouse_y > y and mouse_y < y + 8 {
    if UberCont.opt_volume > 0 UberCont.opt_volume -= 0.05 with MusCont {
        sound_global_volume(max(0, sqrt(UberCont.opt_volume)))
        sound_volume(song, sqrt(UberCont.opt_musvol))
        sound_volume(amb, sqrt(UberCont.opt_ambvol))
    }
}
if mouse_check_button_pressed(mb_left) and mouse_x > x + 113 and mouse_x < x + 123 and mouse_y > y and mouse_y < y + 8 {
    if UberCont.opt_volume < 1 UberCont.opt_volume += 0.05 with MusCont {
        sound_global_volume(max(0, sqrt(UberCont.opt_volume)))
        sound_volume(song, sqrt(UberCont.opt_musvol))
        sound_volume(amb, sqrt(UberCont.opt_ambvol))
    }
}