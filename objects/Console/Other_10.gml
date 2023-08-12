if !UberCont.opt_console exit

if global.console_active {
    snd_play(sndClick)

    if os_type == os_android {
        scrShowVirtualKeyboard()
    }
}
else {
    snd_play(sndClickBack)

    if os_type == os_android {
        keyboard_virtual_hide()
    }
}