//function_get_address_init();
var sdm = function_get_address(show_debug_message);
var scx = function_get_address(script_execute);
trace(sdm);
dll_test_call_func(sdm, "hello!");
dll_test_store_script_execute(scx);
show_debug_message(dll_test_call_script(scr_test));

dllcs_test_call_func(sdm);
dllcs_test_store_script_execute(scx);
show_debug_message("scr_test: {0}", dllcs_test_call_script(scr_test));