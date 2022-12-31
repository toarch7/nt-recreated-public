function object_get_depth(objID) {
    if objID >= 0 && objID < array_length(ObjectDepth) {
        return ObjectDepth[objID]
    }

    return 0
}