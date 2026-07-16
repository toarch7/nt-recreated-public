function buffer_peek_u32be(_buffer, _offset) {
	var _result = buffer_peek(_buffer, _offset, buffer_u32)
	
	return real(((_result & 0x000000ff) << 24)
			 | ((_result & 0x0000ff00) << 8)
			 | ((_result & 0x00ff0000) >> 8)
			 | ((_result & 0xff000000) >> 24))
}
