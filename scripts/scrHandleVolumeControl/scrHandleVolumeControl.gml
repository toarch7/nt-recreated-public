function scrHandleVolumeControl(type, val) {
    if type == "volumeButtonPressed" {
        if val == "down" {
            with ButtonActive {
                if volume_control_command == 0 volume_control_command = 1
            }
        } else {
            with ButtonSwap {
                if volume_control_command == 0 volume_control_command = 1
            }
        }
    }
    // Handle release and "unhold"
    else if type == "volumeButtonReleased" {
        if val == "down" {
            with ButtonActive {
                if volume_control_command != 0 volume_control_command = -1
            }
        } else {
            with ButtonSwap {
                if volume_control_command != 0 volume_control_command = -1
            }
        }
    }
}