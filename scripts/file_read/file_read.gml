function file_read(path) {
    var str = ""

    var _f = file_text_open_read(path)

    while !file_text_eof(_f) {
        str += file_text_read_string(_f)
        file_text_readln(_f)
    }

    file_text_close(_f)

    return str
}