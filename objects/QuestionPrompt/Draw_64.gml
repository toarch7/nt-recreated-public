var mx = device_mouse_x_to_gui(0),
	my = device_mouse_y_to_gui(0),
	w = gui_w, h = gui_h

var press = mouse_ui_clicked()

if choice_made {
	mx = -1000
	my = -1000
	
	press = false
}

scrDrawAlignCenter()

if appear < 3
	draw_text_nt(w / 2, h / 2 + appear - 12, loc(text))

var any = false,
	l = array_length(options)

if appear < 2 {
	var step = w / l,
		
		px = w / 2 - step,
		py = h / 2 - appear + 6
	
	for(var i = 0; i < l; i ++) {
		var opt = options[i],
			str = loc(opt),
			_w = string_width(str) / 2 + 6,
			_h = string_height(str) / 2 + 4
		
		var pointed = pointed_item == opt
		
		if !choice_made {
			draw_set_color(c_uigray)
			
			if pointed
				draw_set_color(c_white)
		}
		else draw_set_color(c_uidark)
		
		draw_text_nt(px, py - pointed, loc(opt))
		
		if point_in_rectangle(mx, my, px - _w, py - _h, px + _w, py + _h) {
			if pointed_item != opt
				pointed_item = opt
			
			if press
				on_result()
			
			any = true
		}
		
		px += step
	}
}

if is_gamepad() {
	var h = input_ui_horizontal_pressed()

	if h != 0 {
		pointed_item += h
	
		if pointed_item < 0
			pointed_item = l - 1
		else if pointed_item >= l
			pointed_item = 0
	
		snd_play(sndHover)
	}
}
if !any
	pointed_item = -1


scrDrawAlignDefault()

if appear
	appear --