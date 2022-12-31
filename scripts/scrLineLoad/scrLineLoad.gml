function scrLineLoad(argument0) {
    if file_text_eof(txt) = false {
        file_text_readln(txt)
        tmptxt = file_text_read_string(txt)
        if is_real(tmptxt) variable_instance_set(id, string(argument0), string(tmptxt))
    }



}