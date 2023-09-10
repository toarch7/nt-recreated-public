if !instance_exists(Player) {
    global.hardmode = 0
    scrLoadLoadout()

    SetVolumeControl(false)
}
else if os_type == os_android {
    SetVolumeControl(opt_volumecontrol)
}
