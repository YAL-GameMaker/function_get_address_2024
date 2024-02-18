#define function_get_address
/// (func)->ptr
gml_pragma("global", "global.__function_get_address_buffer = undefined");
var _buf = global.__function_get_address_buffer;
if (_buf == undefined) {
    _buf = buffer_create(8, buffer_grow, 8);
    global.__function_get_address_buffer = _buf;
    var _f1 = method(undefined, is_bool);
    var _f2 = method(undefined, is_bool);
    function_get_address_init_raw(ptr(_f1), ptr(_f2));
}
var _method = method(undefined, argument0);
function_get_address_raw(ptr(_method), buffer_get_address(_buf));
return ptr(buffer_peek(_buf, 0, buffer_u64));