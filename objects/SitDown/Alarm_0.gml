with all {
    if (object_index == UberCont || object_index == GameCont || object_index == TopCont
		|| object_index == BackCont || object_index == Player || object_index == MusCont
		|| object_index == Console
	) {
        continue
    }
	instance_destroy(id, false)
}

instance_create(0, 0, Credits)