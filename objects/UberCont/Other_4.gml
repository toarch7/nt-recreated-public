if !instance_exists(Player) {
    global.hardmode = 0
    scrLoadLoadout()

    SetVolumeControl(0)
}
else if os_type == os_android {
    SetVolumeControl(opt_volumecontrol)
}
