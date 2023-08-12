function generate_uid(len = 10) {
    var str = ""

    repeat len {
        str += chr(choose(irandom_range(97, 122), irandom_range(65, 90), irandom_range(48, 57)))
    }

    return str
}