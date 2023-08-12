if instance_number(object_index) > 1 {
	instance_destroy()
	
	exit
}

index = -1

x = save_get_val("controls", object_get_name(object_index) + "_x", x)
y = save_get_val("controls", object_get_name(object_index) + "_y", y)