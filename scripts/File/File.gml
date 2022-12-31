function File(path, openType = "r") constructor {
    self.path = path
    self.file = -1

    static rstring = function() {
        return file_text_read_string(self.file)
    }

    static wstring = function(data) {
        file_text_write_string(self.file, data)
        return self
    }

    static rreal = function() {
        return file_text_read_real(self.file)
    }

    static wreal = function(data) {
        file_text_write_real(self.file, data)
        return self
    }

    static wln = function(data) {
        file_text_write_real(self.file, data)
        return self
    }

    static rln = function() {
        return file_text_readln(self.file)
    }

    static eof = function() {
        return file_text_eof(self.file)
    }

    static close = function() {
        file_text_close(self.file)
    }

    static open = function(mode = "r") {
        var f = -1
        show_debug_message("opening file for " + mode)
        switch mode {
            case "w":
                f = file_text_open_write(self.path) break
            case "r":
                f = file_text_open_read(self.path) break
        }

        if self.file != -1 {
            self.close()
        }

        self.file = f

        return self
    }

    self.open(openType)
}

/*
var file = new File("test.txt", "w").write_string("Hello World!").close()

var file = new File("test.txt", "r")

while !file.eof() {
	show_debug_message(file.rstring())
	file.rln()
}

file.close()*/