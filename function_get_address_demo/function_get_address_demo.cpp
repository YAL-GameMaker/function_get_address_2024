/// @author YellowAfterlife

#include "stdafx.h"
#include "YYRunnerInterface.h"
#include "YYRValue.h"

#define YYFuncArgs RValue& result, CInstance* self, CInstance* other, int argc, RValue* arg
typedef void(*YYFunc) (YYFuncArgs);


static YYRunnerInterface g_YYRunnerInterface{};
YYRunnerInterface* g_pYYRunnerInterface;
__declspec(dllexport) void YYExtensionInitialise(const struct YYRunnerInterface* _struct, size_t _size) {
	if (_size < sizeof(YYRunnerInterface)) {
		memcpy(&g_YYRunnerInterface, _struct, _size);
	} else {
		memcpy(&g_YYRunnerInterface, _struct, sizeof(YYRunnerInterface));
	}
	g_pYYRunnerInterface = &g_YYRunnerInterface;
}

/// (func_to_call, arg)
dllm void dll_test_call_func(YYFuncArgs) {
	auto func = (YYFunc)arg[0].ptr;
	func(result, self, other, 1, &arg[1]);
}

YYFunc script_execute = nullptr;
/// (script_execute)
dllm void dll_test_store_script_execute(YYFuncArgs) {
	script_execute = (YYFunc)arg[0].ptr;
}

/// (script)
dllm void dll_test_call_script(YYFuncArgs) {
	RValue scrArgs[] = { {}, {}, {} };
	scrArgs[0].val = arg[0].asReal();
	scrArgs[1].val = 1;
	scrArgs[2].val = 2;
	script_execute(result, self, other, std::size(scrArgs), scrArgs);
}