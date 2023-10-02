function directory_read(mask, attr = 0) {
	var f = file_find_first(mask, attr),
		list = []
	
    while f != "" {
        array_push(list, f)
        f = file_find_next()
    }
	
    file_find_close()
	
	return list
}