/// @author YellowAfterlife

#include "stdafx.h"
static int CScriptRefOffset;
static int findCScriptRefOffset(void* _f1, void* _f2) {
	auto f1 = (void**)_f1;
	auto f2 = (void**)_f2;
	void** fx[] = { f1, f2 };
	for (auto i = 10u; i < 24; i++) {
		auto step = 0u;
		for (; step < 2; step++) {
			auto fi = fx[step];

			// should be NULL, <addr>, NULL
			if (fi[i - 1] != nullptr) break;
			if (fi[i] == nullptr) break;
			if (fi[i + 1] != nullptr) break;
		}
		if (step < 2u) continue;

		// destination address must match:
		auto dest = f1[i];
		if (dest != f2[i]) continue;

		return (int)(sizeof(void*) * i);
	}
	return -1;
}
static void init() {
	CScriptRefOffset = -1;
}
dllx double function_get_address_init_raw(void* _f1, void* _f2) {
	CScriptRefOffset = findCScriptRefOffset(_f1, _f2);
	return CScriptRefOffset >= 0;
}
dllx void function_get_address_raw(void* _method, int64_t* _out) {
	if (CScriptRefOffset < 0) {
		*_out = 0;
	} else {
		auto _func_at = (uint8_t*)_method + CScriptRefOffset;
		auto _func = *(void**)_func_at;
		*_out = (int64_t)_func;
	}
}

BOOL APIENTRY DllMain(HMODULE hModule, DWORD  ul_reason_for_call, LPVOID lpReserved) {
	if (ul_reason_for_call == DLL_PROCESS_ATTACH) init();
	return TRUE;
}
