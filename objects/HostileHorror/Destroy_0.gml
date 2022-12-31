instance_create(x, y, PortalClear)
raddrop += 25
event_inherited()
if !hp && !UberCont.cgot[11] {
    scrAchievement(8)
    UberCont.cgot[11] = 1

    with instance_create(x, y, UnlockScreen) {
        race = 11;
        skin = 0
    }
    show_unlock_popup("@wHORROR UNLOCKED@s#HORROR DEFEATED")

    /*
    with instance_create(0, 0, UnlockPopup) {
        txt = "@wHORROR UNLOCKED"
        txt2 = "@sHORROR DEFEATED"
    }
    
    */
}

/* */
/*  */