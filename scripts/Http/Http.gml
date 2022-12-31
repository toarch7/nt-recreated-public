function scrHttpGet(url) {
    return (UberCont.opt_online) ? http_get(url) : -1
}

function scrHttpPost(url, data) {
    return (UberCont.opt_online) ? http_post_string(url, data) : -1
}

function scrHttpRequest(url, _method, header_map, body) {
    return (UberCont.opt_online) ? http_request(url, _method, header_map, body) : -1
}