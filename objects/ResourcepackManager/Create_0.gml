searching = 0

page = 0
selected = ""

#macro RPBrowserPerpage 5

req = -1
download = -1

status = ""

headermap = ds_map_create()
headermap[? "Content-type"] = "application/json"

count = 0
unlisted = 0

mode = 0 // 0 - list, 1 - browsing, 2 - importing, 3 - local view, 4 - browser view

error = ""

items = []

appear = array_create(RPBrowserPerpage, 0)

loading = 0

itemsinfo = {}

sort = "stars" // stars, updated, stars-asc, updated-asc

restart = 0

version = {}

for (var i = 0; i < array_length(Resourcepacks); i++) {
    var r = Resourcepacks[i]

    version[$ r[$ "id"]] = r.info[$ "update"]
}

sub = {}
icons = []

list = function() {
    for (var i = 0; i < array_length(Resourcepacks); i++) {
        var r = Resourcepacks[i]
        var ind = r[$ "id"]

        if r.info[$ "repo"] != undefined {
            ind = r.info[$ "repo"]
        }

        var item = [
        r.name,
        r.description,
        ind, // id or repo
        r.info[$ "url"], - 1, // stargazers
        r.active,
        r.icon,
        r.active, // loaded
        r.descriptionShort,
        r.info[$ "owner"],
        r.info[$ "updated"],
            [],
            r.path]


        itemsinfo[$ ind] = item
        array_push(items, item)

        show_debug_message("Indentifier: " + ind + ": " + string(item))
    }

    count = array_length(Resourcepacks)
}

browsing = 0

browse = function() {
    browsing = 1

    if !directory_exists("./request") directory_create("./request")

    var f = "ntm%20resourcepack"
    var p = floor(page / 6) + 1

    print("Browsing packs. Page:", p)

    var o = "desc"
    var sort = self.sort

    if sort == "stars V" {
        sort = "stars"
        o = "asc"
    } else if sort == "updated V" {
        sort = "updated"
        o = "asc"
    }

    var url = "https://api.github.com/search/repositories?q=" + f + "&per_page=30&page=" + string(p) + "&sort=" + sort + "&order=" + o

    loading = 1

    appear = array_create(RPBrowserPerpage, 0)

    mode = 1

    req = http_get_file(url, "_temp")
}

import = function() {}

loadresourcepack = function(item) {
    var _if = itemsinfo[$ item[2]]

    if !is_undefined(_if) exit

    var r = http_get("https://raw.githubusercontent.com/" + item[2] + "/master/meta.json")

    var s = sprite_add("https://raw.githubusercontent.com/" + item[2] + "/master/icon.png", 1, 0, 0, 0, 0)
    array_push(icons, s)

    item[@6] = s

    sub[$ r] = item

    itemsinfo[$ item[2]] = item
}

install = function(path, _if) {
    if !zip_unzip(path, game_directory + "_install") {
        return -1
    }

    var f = file_find_first(game_directory + "_install/*", fa_directory)
    file_find_close()

    if f == ""
    return -2

    var p = game_directory + "_install/" + f + "/"
    var l = ["usersprites", "usersounds", "localizations"]

    // extract folders if they're zipped
    for (var i = 0; i < array_length(l); i++) {
        var n = p + l[i]

        if file_exists(n + ".zip") {
            if !zip_unzip(n + ".zip", p) return -3

            file_delete(n + ".zip")
        }
    }

    if is_undefined(_if) {
        try {
            _if = json_parse(file_read(p + "meta.json"))
        } catch (e) {
            print_error(e.longMessage, 1)
            return -4
        }
    } else {
        var _f = file_text_open_write(p + "githubdata.json")

        print(_if[2], _if[3], _if[9], _if[10])

        var d = {
            repo: _if[2],
            url: _if[3],
            owner: _if[9],
            updated: _if[10]
        }

        file_text_write_string(_f, string_replace_all(json_stringify(d), "\/", "/"))

        file_text_close(_f)
    }


    // move next to other resourcepacks
    var r = game_directory + "resourcepacks/" + f

    if directory_exists(r) directory_destroy_recursive(r)

    directory_create(r)

    r += "/"

    directory_move_files(game_directory + "_install/" + f, game_directory + "resourcepacks/" + f)

    directory_move_files(p + "usersounds", r + "usersounds")
    directory_move_files(p + "usersprites", r + "usersprites")
    directory_move_files(p + "localizations", r + "localizations")

    directory_destroy_recursive("./_install/" + f)

    return 1
}

message = -1