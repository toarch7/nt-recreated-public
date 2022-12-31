if !UberCont.opt_console exit

if global.console_active {
    snd_play(sndClick)

    if os_type == os_android {
        keyboard_virtual_show(kbv_type_default, kbv_returnkey_default,
        kbv_autocapitalize_none, kbv_returnkey_google)
    }
} else {
    snd_play(sndClickBack)

    if os_type == os_android {
        keyboard_virtual_hide()
    }
}