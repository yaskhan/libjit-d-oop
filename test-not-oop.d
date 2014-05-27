module main;

import std.stdio;
import cjit;
//import c.jit_f, c.jit_alias, c.jit_const;

version(Windows) {
	pragma(lib, "libjit.lib");
} else {
	pragma(lib, "libjit.a");
}

int main(string[] dargs)
{
	jit_context_t context;
	jit_type_t params[3];
	jit_type_t signature;
	jit_function_t function_;
	jit_value_t x, y, z;
	jit_value_t temp1, temp2;
	jit_int arg1, arg2, arg3;
	void *args[3];
	jit_int result;

	/* Create a context to hold the JIT's primary state */
	context = cjit.context.create();

	/* Lock the context while we build and compile the function */
	cjit.context.build_start(context);

	/* Build the function signature */
	params[0] = cast(_jit_type*) jit_type_int;
	params[1] = cast(_jit_type*) jit_type_int;
	params[2] = cast(_jit_type*) jit_type_int;
	signature = cjit.type.create_signature(jit_abi_cdecl, jit_type_int, params.ptr, 3, 1);

	/* Create the function object */
	function_ = cjit.functions.create(context, signature);
	cjit.type.free(signature);

	/* Construct the function body */
	x = value.get.param(function_, 0);
	y = value.get.param(function_, 1);
	z = value.get.param(function_, 2);

	temp1 = instruction.mul(function_, x, y);
	temp2 = instruction.add(function_, temp1, z);
	instruction.Return(function_, temp2);

	/* Compile the function */
	functions.compile(function_);

	/* Unlock the context */
	cjit.context.build_end(context);

	/* Execute the function and print the result */
	arg1 = 3; arg2 = 5; arg3 = 2;
	args[0] = &arg1;
	args[1] = &arg2;
	args[2] = &arg3;
	functions.apply(function_, args.ptr, &result);

	writeln("mul_add(3, 5, 2) = ", result);

	/* Clean up */
	cjit.context.destroy(context);

	return 0;
}

