if mouse_x > x and mouse_x < x + 24 and mouse_y > y and mouse_y < y + 24 and selected = 0 {
    selected = 1
    instance_create(view_xview + view_width / 2 + 8, view_yview + 40, MusVolSlider)
    instance_create(view_xview + view_width / 2 + 8, view_yview + 48, SfxVolSlider)
    instance_create(view_xview + view_width / 2 + 8, view_yview + 56, AmbVolSlider)
    instance_create(view_xview + view_width / 2 + 10 + string_width(string_hash_to_newline("OFF")), view_yview + 80, FullScreenToggle)
    instance_create(view_xview + view_width / 2 + 10 + string_width(string_hash_to_newline("OFF")), view_yview + 88, ScaleUpDown)
    instance_create(view_xview + view_width / 2 + 10 + string_width(string_hash_to_newline("OFF")), view_yview + 96, FitScreenToggle)
    instance_create(view_xview + view_width / 2 + 10 + string_width(string_hash_to_newline("OFF")), view_yview + 136, GamePadToggle)
    instance_create(view_xview + view_width / 2 + 10 + string_width(string_hash_to_newline("100%")), view_yview + 144, AutoAimUpDown)
    instance_create(view_xview + view_width / 2 + 10 + string_width(string_hash_to_newline("100%")), view_yview + 168, ShakeUpDown)
    instance_create(view_xview + view_width / 2 + 10 + string_width(string_hash_to_newline("OFF")), view_yview + 176, MouseCPToggle)
} else if StatsSelect.selected = 1 or CreditsSelect.selected = 1 {
    selected = 0
}

if selected = 0 {
    with option
    instance_destroy()
}