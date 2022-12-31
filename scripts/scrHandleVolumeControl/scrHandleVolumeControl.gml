function scrHandleVolumeControl(type, val) {
    if type == "volumeButtonPressed" {
        if val == "down" {
            with ButtonActive {
                if do_thing == 0 do_thing = 1
            }
        } else {
            with ButtonSwap {
                if do_thing == 0 do_thing = 1
            }
        }
    }
    // Handle release and "unhold"
    else if type == "volumeButtonReleased" {
        if val == "down" {
            with ButtonActive {
                if do_thing != 0 do_thing = -1
            }
        } else {
            with ButtonSwap {
                if do_thing != 0 do_thing = -1
            }
        }
    }
}