function directory_destroy_recursive(path) {
    if directory_exists(path) {
        var f = file_find_first(path + "/*", fa_directory)

        while f != "" {
            directory_destroy_recursive(path + "/" + f)
            f = file_find_next()
        }

        file_find_close()

        var f = file_find_first(path + "/*", 0)

        while f != "" {
            if directory_exists(path + "/" + f) {
                directory_destroy_recursive(path + "/" + f)
            } else file_delete(path + "/" + f)

            f = file_find_next()
        }

        file_find_close()

        directory_destroy(path)
    }
}