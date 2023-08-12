#define native_cursor_prepare_buffer
/// (size:int)->buffer~
var _size = argument0;
gml_pragma("global", "global.__native_cursor_buffer = undefined");
var _buf = global.__native_cursor_buffer;
if (_buf == undefined) {
    _buf = buffer_create(_size, buffer_grow, 1);
    global.__native_cursor_buffer = _buf;
} else if (buffer_get_size(_buf) < _size) {
    buffer_resize(_buf, _size);
}
buffer_seek(_buf, buffer_seek_start, 0);
return _buf;

#define native_cursor_preinit
//#init native_cursor_preinit
global.ptr_t_native_cursor = ["native_cursor"];
global.g_native_cursor_buf = buffer_create(16, buffer_grow, 1);
global.g_native_cursor_dir = filename_dir(parameter_string(0));

var i = 0;
global.g_native_cursor_dirs = array_create(0);
global.g_native_cursor_dirs[i++] = global.g_native_cursor_dir;
global.g_native_cursor_dirs[i++] = working_directory;
global.g_native_cursor_dirs[i++] = game_save_id;
global.g_native_cursor_dirn = i;
while (--i >= 0) {
    var s = global.g_native_cursor_dirs[i];
    switch (string_ord_at(s, string_length(s))) {
        case 47: case 92: break;
        default: global.g_native_cursor_dirs[i] = s + "/";
    }
}

var _info = os_get_info();
var _swap_br = !ds_map_exists(_info, "video_adapter_0_name");
ds_map_destroy(_info);
native_cursor_preinit_raw(window_handle(), _swap_br);

#define native_cursor_create_from_file
/// (path)->
return native_cursor_create_from_full_path(native_cursor_resolve_full_path(argument0));

#define native_cursor_add_from_file
/// (cursor, path)->
native_cursor_add_from_full_path(argument0, native_cursor_resolve_full_path(argument1));

#define native_cursor_create_from_sprite
/// (sprite, ?frame, ?fps)
var _sprite = argument[0];
var _frame = argument_count > 1 ? argument[1] : undefined;
var _fps = argument_count > 2 ? argument[2] : undefined;
return native_cursor_create_from_sprite_ext(_sprite, _frame, 1, 1, c_white, 1, _fps);

#define native_cursor_create_from_sprite_ext
/// (sprite, frame, xscale, yscale, color, alpha, ?fps)->
var _sprite = argument[0], _frame = argument[1], _xscale = argument[2], _yscale = argument[3], _color = argument[4], _alpha = argument[5];
var _fps = argument_count > 6 ? argument[6] : undefined;
var _cursor = native_cursor_create_empty();
if (_fps == undefined) {
    // GMS >= 2.0:
    if (sprite_get_speed_type(_sprite) != 0) {
        _fps = game_get_speed(gamespeed_fps) * sprite_get_speed(_sprite);
    } else {
        _fps = sprite_get_speed(_sprite);
    }
    /*/
    _fps = room_speed;
    //*/
}
native_cursor_set_framerate(_cursor, _fps);
native_cursor_add_from_sprite_ext(_cursor, _sprite, _frame, _xscale, _yscale, _color, _alpha);
return _cursor;

#define native_cursor_add_from_sprite_ext
/// (cursor, sprite, frame, xscale, yscale, color, alpha)
var _cursor = argument0, _sprite = argument1, _frame = argument2, _xscale = argument3, _yscale = argument4, _color = argument5, _alpha = argument6;
var _width = sprite_get_width(_sprite);
var _height = sprite_get_height(_sprite);
var _surf = surface_create(ceil(_width * _xscale), ceil(_height * _yscale));
var _xoffset = sprite_get_xoffset(_sprite) * _xscale;
var _yoffset = sprite_get_yoffset(_sprite) * _yscale;
var _start, _end;
if (_frame == undefined) {
    _start = 0;
    _end = sprite_get_number(_sprite) - 1;
} else {
    _start = _frame;
    _end = _frame;
}
for (var i = _start; i <= _end; i++) {
    surface_set_target(_surf);
    draw_clear_alpha(c_black, 0);
    // GMS >= 2.0:
    gpu_set_blendmode_ext(bm_one, bm_zero);
    /*/
    draw_set_blend_mode_ext(bm_one, bm_zero);
    //*/
    draw_sprite_ext(_sprite, i, _xoffset, _yoffset, _xscale, _yscale, 0, _color, _alpha);
    // GMS >= 2.0:
    gpu_set_blendmode(bm_normal);
    /*/
    draw_set_blend_mode(bm_normal);
    //*/
    surface_reset_target();
    
    native_cursor_add_from_surface(_cursor, _surf, _xoffset, _yoffset);
}
surface_free(_surf);

#define native_cursor_create_from_surface
/// (surface, hotspot_x, hotspot_y, ?fps)->
var _surf = argument[0], _hx = argument[1], _hy = argument[2];
var _fps = argument_count > 3 ? argument[3] : 30;
var _width = surface_get_width(_surf);
var _height = surface_get_height(_surf);
var _size = _width * _height * 4;
var _pixels = global.g_native_cursor_buf;
if (buffer_get_size(_pixels) < _size) buffer_resize(_pixels, _size);
buffer_get_surface(_pixels, _surf, 0);
return native_cursor_create_from_buffer(_pixels, _width, _height, _hx, _hy, _fps);

#define native_cursor_add_from_surface
/// (cursor, surface, hotspot_x, hotspot_y)
var _cursor = argument0, _surf = argument1, _hx = argument2, _hy = argument3;
var _width = surface_get_width(_surf);
var _height = surface_get_height(_surf);
var _size = _width * _height * 4;
var _pixels = global.g_native_cursor_buf;
if (buffer_get_size(_pixels) < _size) buffer_resize(_pixels, _size);
buffer_get_surface(_pixels, _surf, 0);
native_cursor_add_from_buffer(_cursor, _pixels, _width, _height,  _hx, _hy);

#define native_cursor_resolve_full_path
/// (path)->
var _path = argument0;
var n = global.g_native_cursor_dirn;
for (var i = 0; i < n; i++) {
    var _cp = global.g_native_cursor_dirs[i] + _path;
    if (native_cursor_check_full_path(_cp)) return _cp;
}
return _path;
