
if file_exists("gamestate.dat")
	file_delete("gamestate.dat")

scr_camera_set_position(0, 0)

snd_stop_all()

UberCont.showtutorial = 0