if lockstep_stop
	exit

var c = c_gray

if selected
	c = c_white

draw_sprite_ext(sprite_index, num, x, y + 48 - Menu.widescreen, 1, 1, 0, c, 1)

if !UberCont.cgot[num] && !UberCont.weekly_run {
    sprite_index = sprCharSelectLocked
    //draw_sprite_ext(sprCharSelectLocked,num,x,y+48 - Menu.widescreen, 1, 1, 0, c_gray, 1)
    can = 0
}
else can = 1

if UberCont.cgot[num] && !UberCont.ctot_dead[num] && num != 0 {
    draw_sprite(sprNew, - 1, x - 5, y + 40 - Menu.widescreen)
}