if async_load[? "id"] == ipprompt && async_load[? "result"] != "" {
    global.ip = async_load[? "result"]

    if string_lower(global.ip) == "localhost" {
        global.ip = "127.0.0.1"
    }

    save_set_val("coop", "lastip", global.ip)
}