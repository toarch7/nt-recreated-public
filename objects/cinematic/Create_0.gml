x = 10016
y = 10016 - 245

scrLetterbox(false, 0)

with (TopCont) drawcontrols = 0

alarm[0] = 110

view_xview = x - view_width / 2
view_yview = y - view_height / 2

camera_set_view_pos(view_camera, view_xview, view_yview)

with GameCont {
    area = area_hq
    subarea = scrAreaGetMaxSubarea(area)
}

with Player {
    visible = false
    mask_index = mskNone

    x = other.x
    y = other.y
}

done = 0

file_delete(savegame_file)