if sub[$ async_load[? "id"]] != undefined {
    var r = sub[$ async_load[? "id"]]

    r[5] = -2 // mark as malformed (yes)

    try {
        var d = json_parse(async_load[? "result"])

        if is_struct(d) {
            // name (no shaky)
            r[0] = string_replace_all(string_copy((d[$ "name"] ?? r[0]), 1, 32), "@q", "")

            // full decription
            r[1] = d[$ "description"] ?? r[1]

            // breif description (no shaky or newlines)
            r[8] = string_replace_all( // remove @q
            string_copy( // maximum length - 64
            string_replace_all( // remove newlines
            (d[$ "descriptionShort"] ?? r[1]), "\n", " "), 1, 64), "@q", "")

            r[5] = 1 // mark as loaded
        }
    } catch (e) {
        print("RPBrowser failed to load meta.json of", r[2], "-", e.message)
        show_debug_message(json_encode(async_load))
    }

    itemsinfo[$ r[2]] = r

    snd_play(sndCrownAppear)

    delete sub[$ async_load[? "id"]]
}

if async_load[? "id"] == req {
    if async_load[? "status"] == 0 {
        var f = file_text_open_read("_temp")
        var d = file_text_read_string(f)
        file_text_close(f)

        var ul = UberCont.rp_unlisted

        if ul == -1 {
            error = "WASN'T ABLE TO FETCH EXTRA INFO"
            exit
        }

        var m = 0

        try {
            var d = json_parse(d)

            if is_undefined(d[$ "items"]) {
                m = string_count("rate limit", d[$ "message"]) > 0
            }

            count = d[$ "total_count"] ?? 0

            for (var i = 0; i < array_length(d.items); i++) {
                var item = d.items[i]

                if ds_list_find_index(ul, item.full_name) != -1 or ds_list_find_index(ul, item.owner.login) != -1 {
                    unlisted++
                    continue
                }

                array_push(items, [
                item.name,
                item.description,
                item.full_name,
                item.html_url,
                item.stargazers_count, - 1,
                sprCharSelect, - 1,
                item.description,
                item.owner.login,
                item.updated_at, [], ""])
            }
        } catch (e) {
            print("RPBrowser parse failed: " + e.message)

            error = "FETCH FAILED!"

            if m != 0 {
                error = "YOU'VE BEEN RATE LIMITED.\nTRY AGAIN LATER"
            }
        }

        loading = 0
    }
}

if async_load[? "id"] == download {
    if async_load[? "status"] > 0 {
        if async_load[? "contentLength"] > 0 {
            status = scrAddZero(round(async_load[? "sizeDownloaded"] / async_load[? "contentLength"] * 100), 1) + "%"
        } else status = string(async_load[? "sizeDownloaded"] / 1000) + " KB"

        alarm[0] = max(300, alarm[0])

        with BackButton
        instance_destroy()
    } else {
        status = "INSTALLING"

        var s = self.install(async_load[? "result"], itemsinfo[$ selected])

        if !s {
            error = "INSTALL FAILED.#"

            if s == -1 error += "DOWNLOAD FAILURE"
            else if s == -2 error += "EXTRACTION OR DOWNLOAD FAILURE"
            else if s == -3 error += "SOME INNER ARCHIVES ARE MALFORMED"
            else if s == -4 error += "META JSON STRUCTURE IS MALFORMED"
        } else error = "INSTALLED SUCCESSFULLY!"

        file_delete(async_load[? "result"])
        directory_destroy_recursive(game_directory + "downloads")

        if !instance_exists(BackButton) instance_create(0, 0, BackButton)

        alarm[0] = -1

        loading = 0

        restart = 1
    }
}