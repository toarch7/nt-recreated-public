with UberCont {
	scrRaceUnlock(Race.Rogue)
    scrUnlocksArea()
    scrSave()
}

with all {
    if object_index != UberCont && object_index != GameCont && object_index != TopCont && object_index != BackCont && object_index != Player && object_index != MusCont && object_index != Console {
        instance_destroy(id, 0)
    }
}

instance_create(0, 0, Credits)