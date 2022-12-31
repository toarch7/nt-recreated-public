with all {
    if object_index != UberCont && object_index != Console {
        persistent = 0
        instance_destroy(id, 0)
    }
}

UberCont.showtutorial = 1
snd_stop_all()

UberCont.showtutorial = 0