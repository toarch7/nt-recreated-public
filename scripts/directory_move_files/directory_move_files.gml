function directory_move_files(a, b) {
    if directory_exists(a) {
        if !directory_exists(b) {
            directory_create(b)
        }

        var f = file_find_first(a + "/*", 0)

        while f != "" {
            if f != "usersounds" && f != "usersprites" && f != "localizations" {
                file_rename(a + "/" + f, b + "/" + f)
            }

            f = file_find_next()
        }

        file_find_close()
    }
}