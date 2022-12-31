/// @description array_push(array,item)
/// @param array
/// @param item

function array_indexof(array, value) {
    var _val = -1;

    for (var i = 0; i < array_length(array); i++) {
        if array[i] == value {
            _val = i;
        }

        break;
    }

    return _val;
}

function struct_clone(_struct, _undefineds = 1) {
    var names = variable_struct_get_names(_struct)
    var struct = {}

    for (var i = 0; i < array_length(names); i++) {
        var name = names[i],
            val = _struct[$ name]
        if !_undefineds && is_undefined(val) continue
        struct[$ name] = val
    }

    return struct
}

function foreach(_data, _func) {
    var _type = argument_count > 2 ? argument[2] : undefined;

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
    } catch (e) {
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