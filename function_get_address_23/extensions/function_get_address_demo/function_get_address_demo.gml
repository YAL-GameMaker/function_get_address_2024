/*#define function_get_address_demo_prepare_buffer
/// (size:int)->buffer~
#args _size
gml_pragma("global", "global.__function_get_address_demo_buffer = undefined");
var _buf = global.__function_get_address_demo_buffer;
if (_buf == undefined) {
    _buf = buffer_create(_size, buffer_grow, 1);
    global.__function_get_address_demo_buffer = _buf;
} else if (buffer_get_size(_buf) < _size) {
    buffer_resize(_buf, _size);
}
buffer_seek(_buf, buffer_seek_start, 0);
return _buf;*/