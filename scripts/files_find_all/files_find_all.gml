function files_find_all(path) {
	var list = [],
		find = file_find_first(path, 0)
	
	while find != "" {
		array_push(list, find)
		find = file_find_next()
	}
	
	file_find_close()
	
	return list
}