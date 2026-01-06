/// @description Savegame data corrupt - restart
if (file_exists("m_gamestate.dat")) file_delete("m_gamestate.dat")

file_rename(savegame_file, "m_gamestate.dat")

instance_activate_all()
instance_destroy(all, false)
room_restart()