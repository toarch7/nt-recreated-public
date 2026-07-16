function directory_destroy_recursive(_path) {
	//
    var _find = file_find_first(_path + "/*", fa_directory)
    while (_find != "") {
        directory_destroy_recursive(_path + "/" + _find)
        _find = file_find_next()
    }
    file_find_close()
	
	//
    var _find = file_find_first(_path + "/*", 0)
	
    while (_find != "") {
        if (file_exists(_path + "/" + _find)) {
			file_delete(_path + "/" + _find)
		}
		else {
            directory_destroy_recursive(_path + "/" + _find)
        }
        _find = file_find_next()
    }
    file_find_close()
	
	//
    directory_destroy(_path)
}