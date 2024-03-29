// stdafx.h : include file for standard system include files,
// or project specific include files that are used frequently, but
// are changed infrequently
//

#pragma once

#pragma region configuration

//#define _trace // requires user32.lib;Kernel32.lib

#ifdef TINY // common things to implement
//#define tiny_memset
//#define tiny_memcpy
//#define tiny_malloc // malloc, realloc, free
//#define tiny_new // new, new[], delete, delete[] - requires tiny_malloc
//#define tiny_init_cleanup // static init, cleanup, atexit
//#define tiny_dtoui3
#endif

#pragma endregion

#ifdef _WINDOWS
	#include "targetver.h"
	
	#define WIN32_LEAN_AND_MEAN // Exclude rarely-used stuff from Windows headers
	#include <windows.h>
#endif

#if ((defined(_MSVC_LANG) && _MSVC_LANG >= 201703L) || __cplusplus >= 201703L)
#define tiny_cpp17
#endif

#if defined(WIN32)
#define dllx extern "C" __declspec(dllexport)
#elif defined(GNUC)
#define dllx extern "C" __attribute__ ((visibility("default"))) 
#else
#define dllx extern "C"
#endif

void tiny_init();
void tiny_cleanup();

#ifdef _trace
static constexpr char trace_prefix[] = "[function_get_address] ";
#ifdef TINY
void trace(const char* format, ...);
#else
#define trace(...) { printf("%s", trace_prefix); printf(__VA_ARGS__); printf("\n"); fflush(stdout); }
#endif
#endif

#pragma region typed memory helpers
template<typename T> T* malloc_arr(size_t count) {
	return (T*)malloc(sizeof(T) * count);
}
template<typename T> T* realloc_arr(T* arr, size_t count) {
	return (T*)realloc(arr, sizeof(T) * count);
}
template<typename T> T* memcpy_arr(T* dst, const T* src, size_t count) {
	return (T*)memcpy(dst, src, sizeof(T) * count);
}
#pragma endregion

#include "gml_ext.h"

// TODO: reference additional headers your program requires here
