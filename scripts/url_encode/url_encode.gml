function url_encode(url_string){
	gml_pragma("global", "global._url_encode_ready = false;");
	var l_inbuf, l_outbuf, l_allowed, l_hex, l_ind;
	if (global._url_encode_ready) {
	    l_inbuf = global._url_encode_in;
	    l_outbuf = global._url_encode_out;
	    l_allowed = global._url_encode_allowed;
	    l_hex = global._url_encode_hex;
	} else { // first-time setup
	    global._url_encode_ready = true;
	    l_inbuf = buffer_create(1024, buffer_grow, 1);
	    global._url_encode_in = l_inbuf;
	    l_outbuf = buffer_create(1024, buffer_grow, 1);
	    global._url_encode_out = l_outbuf;
	    // establish which characters we do NOT need to encode:
	    l_allowed = array_create(256);
	    for (l_ind = ord("A"); l_ind <= ord("Z"); l_ind++) l_allowed[l_ind] = true;
	    for (l_ind = ord("a"); l_ind <= ord("z"); l_ind++) l_allowed[l_ind] = true;
	    for (l_ind = ord("0"); l_ind <= ord("9"); l_ind++) l_allowed[l_ind] = true;
	    l_allowed[ord("-")] = true;
	    l_allowed[ord("_")] = true;
	    l_allowed[ord(".")] = true;
	    l_allowed[ord("!")] = true;
	    l_allowed[ord("~")] = true;
	    l_allowed[ord("*")] = true;
	    l_allowed[ord("'")] = true;
	    l_allowed[ord("(")] = true;
	    l_allowed[ord(")")] = true;
	    global._url_encode_allowed = l_allowed;
	    // pre-generate two-byte hex char sequences:
	    l_hex = array_create(256);
	    for (l_ind = 0; l_ind < 256; l_ind++) {
	        var l_hv, l_hd = l_ind >> 4;
	        if (l_hd >= 10) {
	            l_hv = ord("A") + l_hd - 10;
	        } else l_hv = ord("0") + l_hd;
	        // second char (lower nibble):
	        l_hd = l_ind & $F;
	        if (l_hd >= 10) {
	            l_hv |= (ord("A") + l_hd - 10) << 8;
	        } else l_hv |= (ord("0") + l_hd) << 8;
	        l_hex[l_ind] = l_hv;
	    }
	    global._url_encode_hex = l_hex;
	}
	// write down and measure the input string:
	buffer_seek(l_inbuf, buffer_seek_start, 0);
	buffer_write(l_inbuf, buffer_text, url_string);
	var l_len = buffer_tell(l_inbuf);
	// read bytes one-by-one, deciding for each:
	buffer_seek(l_inbuf, buffer_seek_start, 0);
	buffer_seek(l_outbuf, buffer_seek_start, 0);
	repeat (l_len) {
	    var l_byte = buffer_read(l_inbuf, buffer_u8);
	    if (l_allowed[l_byte]) {
	        buffer_write(l_outbuf, buffer_u8, l_byte);
	    } else { // if it needs to be encoded, write %<two hex digits>
	        buffer_write(l_outbuf, buffer_u8, ord("%"));
	        buffer_write(l_outbuf, buffer_u16, l_hex[l_byte]);
	    }
	}
	// finally, rewind and read the string:
	buffer_write(l_outbuf, buffer_u8, 0);
	buffer_seek(l_outbuf, buffer_seek_start, 0);
	return buffer_read(l_outbuf, buffer_string);
}

function url_encode_header(data) {
	
	var str = "",
		keys = struct_keys(data)
	
	for(var i = 0; i < array_length(keys); i ++) {
		var key = keys[i],
			val = data[$ key]
		
		str += key + ": " + string(val) + "\r\n"//url_encode(string(val)) + "\r\n"
	}
	
	return str
}

function url_encode_query(data) {
	var str = "",
		keys = struct_keys(data)
	
	for(var i = 0; i < array_length(keys); i ++) {
		var key = keys[i],
			val = data[$ key]
		
		if i
			str += "&"
		
		str += key + "=" + string(val)
	}
	
	return str
}