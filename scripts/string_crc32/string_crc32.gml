function string_crc32(_string) {
	static _buffer = buffer_create(64, buffer_grow, 1)
	buffer_seek(_buffer, buffer_seek_start, 0)
	buffer_write(_buffer, buffer_string, string(_string))
	return buffer_crc32(_buffer, 0, buffer_tell(_buffer))
}