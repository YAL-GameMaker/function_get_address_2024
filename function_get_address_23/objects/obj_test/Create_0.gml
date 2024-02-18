//function_get_address_init();
var sdm = function_get_address(show_debug_message);
trace(sdm);
dll_test_call_func(sdm, "hello!");
dll_test_store_script_execute(function_get_address(script_execute));
show_debug_message(dll_test_call_script(scr_test));