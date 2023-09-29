function unix_timestamp(datetime = date_current_datetime()) {
	var epoch = date_create_datetime(1970, 1, 1, 0, 0, 0)
	return floor(date_second_span(epoch, datetime))
}