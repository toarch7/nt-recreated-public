function scrDefineGamepadBindings() {
    var names = variable_struct_get_names(gpad)

    for (var i = 0; i < array_length(names); i++) {
        var name = names[i]

        var v = save_get_val("gamepadkey", name, variable_struct_get(gpad, name))

        variable_struct_set(gpad, name, v)
    }
}