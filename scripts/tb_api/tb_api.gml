#macro URL_TBAPI "https://raw.githubusercontent.com/toarch7/torcherdev/main/"

// Makes a http request to retrieve needed info
// about daily/weekly preset
//
// example usage:
// tb_api("daily") -> "https://raw.githubusercontent.com/toarch7/torcherdev/main/dailydata.json"
//

function tb_api(type) {
    return scrHttpGet(URL_TBAPI + type + "data.json")
}