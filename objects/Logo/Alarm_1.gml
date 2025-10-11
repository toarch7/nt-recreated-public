/// @description Create main menu buttons

var _step_size = 24,
	_button_index = 0,
	_button_x = floor(view_xview_center),
	_button_y = floor(view_yview_center - _step_size * 2)

for (var i = 0; i <= 4; ++i) {
    with instance_create(_button_x, _button_y, MainMenuButton) {
        image_index = i
		
		if _button_index == 1 {
			available = MultiplayerConfig
		}
    }
	
	_button_y += _step_size
    _button_index ++
}

instance_create(0, 0, ButtonDiscord)
instance_create(0, 0, ButtonAchievements)

instance_destroy()