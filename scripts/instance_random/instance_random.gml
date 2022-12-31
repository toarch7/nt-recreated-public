function instance_random(obj) {
    return instance_find(obj, irandom(instance_number(obj) - 1))
}