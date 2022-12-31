function scr_can_hit(obj = other) {
    if obj.object_index == Player {
        return obj.inframes <= 0
    }

    return 1
}