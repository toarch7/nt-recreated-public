if !is_undefined(async_options[$ string(async_load[? "id"])]) {
    var o = async_options[$ string(async_load[? "id"])]
    o[2](async_load, o, o[3])
}