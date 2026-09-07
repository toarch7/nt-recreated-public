function struct_clone(_struct, _keep_undefineds = true) {
    var names = variable_struct_get_names(_struct)
	
    var struct = {}

    for (var i = 0; i < array_length(names); i++) {
        var name = names[i],
            val = _struct[$ name]
		
        if !_keep_undefineds && is_undefined(val)
			continue
		
        struct[$ name] = val
    }

    return struct
}

function foreach(_data, _func, _type = undefined) {
    if is_array(_data) {
        for (var __iterator = 0; __iterator < array_length(_data); __iterator++) {
            _func(_data[__iterator], __iterator, _data)
        }

        return _data;
    }

    if is_struct(_data) {
        var _names = variable_struct_get_names(_data)
        var _key = _names[0]

        for (var __iterator = 0; __iterator < array_length(_names); __iterator++) {
            _key = _names[__iterator]
            _func(_data[$ _key], _key, _data)
        }

        return _data;
    }

    switch _type {
        case "list":
            for (var __iterator = 0; __iterator < array_length(_data); __iterator++) {
                _func(_data[__iterator], __iterator, _data)
            }
            return _data;

        case "map":
            var _key = ds_map_find_first(_data);

            while !is_undefined(_data[? _key]) {
                _func(_data[? _key], _key, _data);
                _key = ds_map_find_next(_data, _key);
            }
            return _data;
    }

    return undefined
}

function struct_merge_instance(struct, instance) {
    if is_undefined(struct) or is_undefined(instance)
    return undefined

    var keys = variable_struct_get_names(struct)

    for (var i = 0; i < array_length(keys); i++) {
        var key = keys[i];
        instance[$ key] = struct[$ key]
    }
}

function struct_secure_save(path, struct) {
    var data = base64_encode(json_stringify(struct))

    var buff = buffer_create(1, buffer_grow, 1)

    buffer_write(buff, buffer_string, data)

    var buff2 = buffer_compress(buff, 0, buffer_get_size(buff))

    buffer_save(buff2, path)

    buffer_delete(buff)
    buffer_delete(buff2)
}

function struct_secure_load(path) {
    if !file_exists(path) return undefined

    try {
        var buff = buffer_load(path)
        var buff2 = buffer_decompress(buff)

        var data = base64_decode(buffer_read(buff2, buffer_string))

        buffer_delete(buff)
        buffer_delete(buff2)

        return json_parse(data)
    }
	catch (e) {
        print("Failed to load " + path, e.message)
    }

    return undefined
}

function array_join(arr, s = "_") {
    var r = "",
        l = array_length(arr)

        for (var i = 0; i < l; i++) {
            r += string(arr[i])

            if i + 1 < l {
                r += s
            }
        }

    return r
}

function method_execute(meth, args = undefined) {
	/* Generator:
		let str = "";

		for(let i = 1; i < 30; i ++) {
			str += `case ${i}:\n\treturn m(`
			
			for(let a = 1; a < i; a ++) {
				str += `argument[${a}]`;
				
				if (a + 1 < i)
					str += ", ";
			}
			
			str += ")\n";
		}
		
		console.log(str);
	*/
	
	if meth == undefined
		exit
	
	var m = method(id, meth)
	
	#region lol
	
	switch argument_count {
		case 2:
			return m(argument[1])
		case 3:
			return m(argument[1], argument[2])
		case 4:
			return m(argument[1], argument[2], argument[3])
		case 5:
			return m(argument[1], argument[2], argument[3], argument[4])
		case 6:
			return m(argument[1], argument[2], argument[3], argument[4], argument[5])
		case 7:
			return m(argument[1], argument[2], argument[3], argument[4], argument[5], argument[6])
		case 8:
			return m(argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7])
		case 9:
			return m(argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8])
		case 10:
			return m(argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9])
		case 11:
			return m(argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10])
		case 12:
			return m(argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11])
		case 13:
			return m(argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12])
		case 14:
			return m(argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13])
		case 15:
			return m(argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14])
		case 16:
			return m(argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15])
		case 17:
			return m(argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15], argument[16])
		case 18:
			return m(argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15], argument[16], argument[17])
		case 19:
			return m(argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15], argument[16], argument[17], argument[18])
		case 20:
			return m(argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15], argument[16], argument[17], argument[18], argument[19])
		case 21:
			return m(argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15], argument[16], argument[17], argument[18], argument[19], argument[20])
		case 22:
			return m(argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15], argument[16], argument[17], argument[18], argument[19], argument[20], argument[21])
		case 23:
			return m(argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15], argument[16], argument[17], argument[18], argument[19], argument[20], argument[21], argument[22])
		case 24:
			return m(argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15], argument[16], argument[17], argument[18], argument[19], argument[20], argument[21], argument[22], argument[23])
		case 25:
			return m(argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15], argument[16], argument[17], argument[18], argument[19], argument[20], argument[21], argument[22], argument[23], argument[24])
		case 26:
			return m(argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15], argument[16], argument[17], argument[18], argument[19], argument[20], argument[21], argument[22], argument[23], argument[24], argument[25])
		case 27:
			return m(argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15], argument[16], argument[17], argument[18], argument[19], argument[20], argument[21], argument[22], argument[23], argument[24], argument[25], argument[26])
		case 28:
			return m(argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15], argument[16], argument[17], argument[18], argument[19], argument[20], argument[21], argument[22], argument[23], argument[24], argument[25], argument[26], argument[27])
		case 29:
			return m(argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15], argument[16], argument[17], argument[18], argument[19], argument[20], argument[21], argument[22], argument[23], argument[24], argument[25], argument[26], argument[27], argument[28])
	}
	
	#endregion
	
	return m()
}

function array_create_number_range(_min, _max) {
	if (_min > _max) {
		var _t = _max
		_max = _min
		_min = _t
	}
	
	var _index = 0,
		_count = _max - _min + 1,
		_result = array_create(_count, 0)
	
	repeat _count {
		_result[_index ++] = _min ++
	}
	
	return _result
}

function file_write(path, str) {
	var _file = file_text_open_write(path)
    file_text_write_string(_file, str)
    file_text_close(_file)
}

function file_read(_path) {
	var _buffer = buffer_load(_path),
		_contents = buffer_read(_buffer, buffer_string)
	
	buffer_delete(_buffer)
	
	return _contents
}

function array_delete_val(_array, _value) {
	var _index = array_get_index(_array, _value)
	if (_index >= 0) array_delete(_array, _index, 1)
	return _index
}
