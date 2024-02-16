#define function_get_address_init
/// ()->bool
var _f1 = method(undefined, is_bool);
var _f2 = method(undefined, is_bool);
return function_get_address_init_raw(ptr(_f1), ptr(_f2));

#define function_get_address
/// (func)->ptr
var _size = argument0;
gml_pragma("global", "global.__function_get_address_buffer = undefined");
var _buf = global.__function_get_address_buffer;
if (_buf == undefined) {
    _buf = buffer_create(_size, buffer_grow, 8);
    global.__function_get_address_buffer = _buf;
} else if (buffer_get_size(_buf) < _size) {
    buffer_resize(_buf, _size);
}
var _method = method(undefined, argument0);
function_get_address_raw(ptr(_method), buffer_get_address(_buf));
return ptr(buffer_peek(_buf, 0, buffer_u64));