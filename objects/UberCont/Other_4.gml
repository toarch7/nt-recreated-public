if !instance_exists(Player) {
    global.hardmode = 0
    scrLoadLoadout()

    SetVolumeControl(false)
}
else if os_type == os_android {
    SetVolumeControl(opt_volumecontrol)
}

scrOptionsUpdate()

if daily_run && !want_menu {
	
	opt_griller = weekly_run ? weekly_grill : daily_grill
	
}