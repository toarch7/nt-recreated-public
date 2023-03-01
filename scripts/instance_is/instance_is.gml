function instance_is(inst, obj) {
	return instance_exists(inst) && (inst.object_index == obj or object_is_ancestor(inst.object_index, obj))
}