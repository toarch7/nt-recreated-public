
if file_exists("gamestate.dat")
	file_delete("gamestate.dat")

camera_set_pos(0, 0)

snd_stop_all()

UberCont.showtutorial = 0