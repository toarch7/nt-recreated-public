draw_set_halign(fa_center)
draw_set_valign(fa_center)

if instance_exists(SpiralCont) {
    with SkillText {
        if !disappear or disappear % 2 == 0 draw_text_nt(x, y, "@d" + loc(txt))
    }
}

draw_set_halign(fa_left)
draw_set_valign(fa_top)