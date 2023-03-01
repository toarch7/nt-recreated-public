function scrAchievCreate(_id, data) {
	chiev_name[_id] = data[0]
	chiev_text[_id] = data[1]
	chiev_hide[_id] = array_length(data) > 2 ? data[2] : 0
	chiev_type[_id] = array_length(data) > 3 ? data[3] : 0
}