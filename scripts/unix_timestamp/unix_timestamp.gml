function unix_timestamp(datetime = date_current_datetime()) {
	var epoch = date_create_datetime(1970, 1, 1, 0, 0, 0)
	return floor(date_second_span(epoch, datetime))
}

function unix_to_datatime(seconds) {
	return date_create_datetime(1970, 1, 1, 0, 0, seconds)	
}

function date_ddmmYY_string(date) {
	return scrAddZero(date_get_day(date), 1) + "/" + scrAddZero(date_get_month(date), 1) + "/" + string(date_get_year(date))
}