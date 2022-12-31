with other {
    if !UberCont.cgot[12] {
        UberCont.cgot[12] = 1
        show_unlock_popup("ROGUE UNLOCKED#FOR DEFEATING THE NUCLEAR THRONE")
        with instance_create(0, 0, UnlockScreen) {
            race = 12;
            skin = 0
        }
        save_set_val("cgot", "12", 1)
        scrSave()
    }
}