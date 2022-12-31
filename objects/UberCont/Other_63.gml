if async_load[? "id"] == update_message {
    if async_load[? "status"] {
        url_open("https://toncho.itch.io/nuclear-throne-mobile")
    }
}

if async_load[? "id"] != namereq exit

result = async_load[? "result"]

result = string_replace_all(result, "<br>", "")
result = string_replace_all(result, "&", "")
result = string_replace_all(result, "+", " ")
result = string_replace_all(result, "?", "")
result = string_replace_all(result, "\\", "")

if string_length(result) <= 1 {
    namereq = get_string_async("Too short.#Enter your nickname", "Seeker" + scrAddZero(random(999), 2))
    exit
}

if string_length(result) >= 15 {
    namereq = get_string_async("Too long, 15 is the limit.#Enter your nickname", "Seeker" + scrAddZero(random(999), 2))
    exit
}

save_set_val("etc", "name", result)