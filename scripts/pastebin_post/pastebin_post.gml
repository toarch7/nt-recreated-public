/// @description pastebin_post(name,text)
/// @param name
/// @param text
function pastebin_post(argument0, argument1) {

    api_dev_key = ""
    api_paste_private = "1"
    api_paste_name = argument0
    api_paste_expire_date = "N"
    api_paste_format = "gml"
    api_paste_code = argument1

    return scrHttpPost("https://pastebin.com/api/api_post.php", "api_option=paste&api_paste_private=" + api_paste_private + "&api_paste_name=" + api_paste_name + "&api_paste_expire_date=" + api_paste_expire_date + "&api_paste_format=" + api_paste_format + "&api_dev_key=" + api_dev_key + "&api_paste_code=" + api_paste_code)



}