# function_get_address (2024 edition)

**Supported versions:** GameMaker Studio 2.3.x, GameMaker 2022+

For older GameMaker versions, check out
[the 2019 edition](https://github.com/YAL-GameMaker/function_get_address).

## What is this
This is an example of how to get pointers to GameMaker's built-in functions
and pass them to native extensions.

## How this works
`ptr(method(undefined, a_built_in_function))` gives you a pointer to a method-struct,
which, among other things, contains a pointer to the function itself.

There is currently no way to get a function pointer from these using `YYRunnerInterface`,
but we can figure out the offset ourselves by comparing layout of two method structs
pointing at the same built-in function.

## How to use it
- Import the extension
- Call `function_get_address_init()`
- You can now call
  `function_get_address` (e.g. `function_get_address(show_debug_message)`)
  and alike to get pointers to built-in functions.

For use in your own extensions, you can either bundle the `function_get_address` extension with yours (it's 4KB!),
or borrow the initializer code.

## function_get_address_demo
This small example DLL shows how to call built-in functions,
as well as calling user-defined scripts.

## Limitations
`YYRunnerInterface` is currently (Feb 2024) only implemented on desktop platforms,
which means that using this on mobile/consoles requires additional legwork
even though the core trick remains functional.

## Meta

**Author:** [YellowAfterlife](https://github.com/YellowAfterlife)  
**License:** MIT