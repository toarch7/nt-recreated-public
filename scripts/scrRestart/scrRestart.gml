function scrRestart() {




}

function scrUnpause() {
    with UberCont {
        instance_activate_all()
        surface_free(pauseimg)
        sprite_delete(pausespr)
        pausespr = -1
        paused = 0
    }

    KeyCont.press_fire[global.index] = 0

    if instance_exists(AttackButton) {
        with AttackButton {
            event_perform(ev_create, 0)
            pause = 5
        }
    } else if instance_exists(JoystickAttack) {
        with JoystickAttack {
            event_perform(ev_create, 0)
            pause = 5
        }
    }

    with MobileUI {
        if self[$ "do_thing"] != undefined {
            if do_thing {
                do_thing = -1
            }
        }
    }

    audio_resume_all()
}