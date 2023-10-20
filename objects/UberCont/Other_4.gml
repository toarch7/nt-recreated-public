if !instance_exists(Player) {
    global.hardmode = 0
    scrLoadLoadout()

    SetVolumeControl(false)
}
else if os_type == os_android {
    SetVolumeControl(opt_volumecontrol)
}

scrOptionsUpdate()

if daily_run {
	if weekly_run && weekly_grill {
		opt_griller = true
	}
	else if daily_grill
		opt_griller = true
}