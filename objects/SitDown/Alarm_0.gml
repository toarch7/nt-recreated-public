with UberCont {
    if !UberCont.cgot[12] {
        UberCont.cgot[12] = 1
        show_unlock_popup("ROGUE UNLOCKED#FOR DEFEATING THE NUCLEAR THRONE")
        with instance_create(0, 0, UnlockScreen) {
            race = 12;
            skin = 0
        }
        save_set_val("cgot", "12", 1)
    }

    scrUnlock()
    scrSave()
}

with all {
    if object_index != UberCont && object_index != GameCont && object_index != TopCont && object_index != BackCont && object_index != Player && object_index != MusCont && object_index != Console {
        instance_destroy(id, 0)
    }
}

instance_create(0, 0, Credits)