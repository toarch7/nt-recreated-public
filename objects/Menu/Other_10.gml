if !weekly {
    var instances = playerinstances
    var keys = struct_keys(instances)

    for (var i = 0; i < array_length(keys); i++) {
        var inst = variable_struct_get(instances, keys[i])

        with CharSelect
        if num != 0 && num == inst.race {
            event_perform(ev_mouse, ev_left_press)

            break
        }
    }
}