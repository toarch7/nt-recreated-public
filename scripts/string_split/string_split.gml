function string_split_list(str, delimiter) {
	ds_list_clear(global.string_split_list)
	
	var result = global.string_split_list
	var max_pos = string_length(str)
	var add_str = ""
	var pos = 1

	while pos <= max_pos {
	    if string_lower(string_char_at(str, pos)) == string_lower(delimiter) or delimiter == "" {
	        ds_list_add(result, add_str)
	        add_str = ""
	    } else add_str += string_char_at(str, pos)
    
	    pos ++
	}

	ds_list_add(result, add_str)
	
	return result
}