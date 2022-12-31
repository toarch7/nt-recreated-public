function instance_create(x, y, object) {
    return instance_create_depth(x, y, object_get_depth(object), object);
}