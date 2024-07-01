# function_get_address (2024 edition)

**Supported versions:** GameMaker Studio 2.3.x, GameMaker 2022+

For older GameMaker versions, check out
[the 2019 edition](https://github.com/YAL-GameMaker/function_get_address).

## What is this
This is an example of how to get pointers to GameMaker's built-in functions
and pass them to native extensions.

This enables you to call built-in functions (or user-defined ones!)
from native code, which can be used to create faster and more convenient extensions -
see [Apollo](https://github.com/YAL-GameMaker/Apollo) for an example.

## How this works
`ptr(method(undefined, a_built_in_function))` gives you a pointer to a method-struct,
which, among other things, contains a pointer to the function itself.

There is currently no way to get a function pointer from these using `YYRunnerInterface`,
but we can figure out the offset ourselves by comparing layout of two method structs
pointing at the same built-in function.

<details><summary>Further explanation</summary>

The "method" type inherits from the general "struct" type
(which is why you can do `method.v = 1`)
and has a handful of pointers, including the following:
- A pointer to a VM script struct.  
  Not much is known about these.
- A pointer to a built-in function.
  These are structured like  
  `void fun(RValue& result, CInstance* self, CInstance* other, int argCount, RValue* argArray)`
- A pointer to a YYC script if we're using YYC.
  These are structured like  
  `RValue& scr(CInstance* self, CInstance* other, RValue& result, int argCount, RValue** argArray)`  
  You can see these in your generated `.gml.cpp` files.

The three appear next to each other in all GameMaker versions that support structs.

And thus, if we have two method-structs for the same built-in function,
we can look for the "null, same pointer, null" pattern inside
to figure out where the built-in function field is, and compare it against a non-function method struct (which will have the middle pointer as null) to be sure.

With the offset calculated, grabbing a function pointer
is a matter of adding the offset to a method-struct address and reading the address from there.
Nice and fast.

</details>

## How to use it
- Import the extension
- Сall `function_get_address` and alike to get pointers to built-in functions.  
  The function will return `pointer_null` if the DLL is missing or the provided function is invalid.

For example,
```gml
var _game_end = function_get_address(game_end);
show_debug_message(_game_end);
my_native_extension_function(_game_end); // should have argument set as string/pointer type
```

For use in your own extensions, you can either bundle the `function_get_address` extension with yours (it's 4KB!),
or borrow the initializer code.

## function_get_address_demo
This small example DLL shows how to call built-in functions,
as well as calling user-defined scripts.

## Limitations
`YYRunnerInterface` is currently (June 2024) only implemented on desktop and console platforms,
which means that using this on mobile requires additional legwork
even though the core trick remains functional.

HTML5 target does not need this because you can pass functions to JS extensions as-is (e.g. `ext_func(show_debug_message)`) - just remember that the first two arguments are `self, other`.

## Meta

**Author:** [YellowAfterlife](https://github.com/YellowAfterlife)  
**License:** MIT
