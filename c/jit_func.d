module c.jit_func;


import core.stdc.stdio;
import c.jit_alias;
import c.jit_const;

extern (C):
alias void  function(jit_type_t signature, void *result, void **args, void *user_data)jit_closure_func;


/* Converted to D from C:\libjit\include\jit\jit-walk.h by htod */
//:module jit-walk;


/*
 * Get the frame address for a frame which is "n" levels up the stack.
 * A level value of zero indicates the current frame.
 */

extern (C):
void * _jit_get_frame_address(void *start, uint n);






/*
 * Get the frame address for the current frame.  May be more efficient
 * than using "jit_get_frame_address(0)".
 *
 * Note: some gcc vestions have broken __builtin_frame_address() so use
 * _JIT_ARCH_GET_CURRENT_FRAME() if available. 
 */










/*
 * Get the next frame up the stack from a specified frame.
 * Returns NULL if it isn't possible to retrieve the next frame.
 */

void * _jit_get_next_frame_address(void *frame);






/*
 * Get the return address for a specific frame.
 */

void * _jit_get_return_address(void *frame, void *frame0, void *return0);


/*
 * Get the return address for the current frame.  May be more efficient
 * than using "jit_get_return_address(0)".
 */




/*
 * Determine if the stack frame just above "frame" contains a
 * particular crawl mark.
 */

int  jit_frame_contains_crawl_mark(void *frame, jit_crawl_mark_t *mark);


/* Converted to D from C:\libjit\include\jit\jit.h by htod */

/* Converted to D from C:\libjit\include\jit\jit-apply.h by htod */
//:module jit-apply;





/*
 * Prototype for closure functions.
 */




/*
 * External function declarations.
 */



void  jit_apply(jit_type_t signature, void *func, void **args, uint num_fixed_args, void *return_value);


void  jit_apply_raw(jit_type_t signature, void *func, void *args, void *return_value);

int  jit_raw_supported(jit_type_t signature);



void * jit_closure_create(jit_context_t context, jit_type_t signature, jit_closure_func func, void *user_data);


jit_nint  jit_closure_va_get_nint(jit_closure_va_list_t va);

jit_nuint  jit_closure_va_get_nuint(jit_closure_va_list_t va);

jit_long  jit_closure_va_get_long(jit_closure_va_list_t va);

jit_ulong  jit_closure_va_get_ulong(jit_closure_va_list_t va);

jit_float32  jit_closure_va_get_float32(jit_closure_va_list_t va);

jit_float64  jit_closure_va_get_float64(jit_closure_va_list_t va);

jit_nfloat  jit_closure_va_get_nfloat(jit_closure_va_list_t va);

void * jit_closure_va_get_ptr(jit_closure_va_list_t va);

void  jit_closure_va_get_struct(jit_closure_va_list_t va, void *buf, jit_type_t type);






/* Converted to D from C:\libjit\include\jit\jit-arch.h by htod */
//:module jit-arch;





/*
 * If defined _JIT_ARCH_GET_CURRENT_FRAME() macro assigns the current frame
 * pointer to the supplied argument that has to be a void pointer.
 */









/* Converted to D from C:\libjit\include\jit\jit-arch-arm.h by htod */
//:module jit-arch-arm;





/*
 * If defined _JIT_ARCH_GET_CURRENT_FRAME() macro assigns the current frame
 * pointer to the supplied argument that has to be a void pointer.
 */







/* Converted to D from C:\libjit\include\jit\jit-arch-generic.h by htod */
//:module jit-arch-generic;





/*
 * If defined _JIT_ARCH_GET_CURRENT_FRAME() macro assigns the current frame
 * pointer to the supplied argument that has to be a void pointer.
 */


/*
 * If defined _JIT_ARCH_GET_NEXT_FRAME() assigns the frame address following
 * the frame supplied as second arg to the value supplied as first argument.
 */


/*
 * If defined _JIT_ARCH_GET_RETURN_ADDRESS() assigns the return address of
 * the frame supplied as second arg to the value supplied as first argument.
 */


/*
 * If defined _JIT_ARCH_GET_CURRENT_RETURN() assigns the return address of
 * the current to the supplied argument.
 */



/* Converted to D from C:\libjit\include\jit\jit-arch-x86.h by htod */
//:module jit-arch-x86;





/*
 * If defined _JIT_ARCH_GET_CURRENT_FRAME() macro assigns the current frame
 * pointer to the supplied argument that has to be a void pointer.
 */









/* Converted to D from C:\libjit\include\jit\jit-arch-x86-64.h by htod */
//:module jit-arch-x86-64;





/*
 * The frame header structure for X86_64
 */


/*
 * If defined _JIT_ARCH_GET_CURRENT_FRAME() macro assigns the current frame
 * pointer to the supplied argument that has to be a void pointer.
 */








/*
 * If defined _JIT_ARCH_GET_NEXT_FRAME() assigns the frame address following
 * the frame supplied as second arg to the value supplied as first argument.
 */


/*
 * If defined _JIT_ARCH_GET_RETURN_ADDRESS() assigns the return address of
 * the frame supplied as second arg to the value supplied as first argument.
 */


/*
 * If defined _JIT_ARCH_GET_CURRENT_RETURN() assigns the return address of
 * the current to the supplied argument.
 */



/* Converted to D from C:\libjit\include\jit\jit-block.h by htod */
//:module jit-block;



jit_function_t  jit_block_get_function(jit_block_t block);

jit_context_t  jit_block_get_context(jit_block_t block);

jit_label_t  jit_block_get_label(jit_block_t block);


jit_label_t  jit_block_get_next_label(jit_block_t block, jit_label_t label);


jit_block_t  jit_block_next(jit_function_t func, jit_block_t previous);


jit_block_t  jit_block_previous(jit_function_t func, jit_block_t previous);


jit_block_t  jit_block_from_label(jit_function_t func, jit_label_t label);


int  jit_block_set_meta(jit_block_t block, int type, void *data, jit_meta_free_func free_data);

void * jit_block_get_meta(jit_block_t block, int type);

void  jit_block_free_meta(jit_block_t block, int type);

int  jit_block_is_reachable(jit_block_t block);

int  jit_block_ends_in_dead(jit_block_t block);

int  jit_block_current_is_dead(jit_function_t func);






/* Converted to D from C:\libjit\include\jit\jit-common.h by htod */
//:module jit-common;




/*
 * Opaque structure that represents a context.
 */



/* Converted to D from C:\libjit\include\jit\jit-context.h by htod */
//:module jit-context;


jit_context_t  jit_context_create();

void  jit_context_destroy(jit_context_t context);


void  jit_context_build_start(jit_context_t context);

void  jit_context_build_end(jit_context_t context);




void  jit_context_set_on_demand_driver(jit_context_t context, jit_on_demand_driver_func driver);




void  jit_context_set_memory_manager(jit_context_t context, jit_memory_manager_t manager);




int  jit_context_set_meta(jit_context_t context, int type, void *data, jit_meta_free_func free_data);


int  jit_context_set_meta_numeric(jit_context_t context, int type, jit_nuint data);

void * jit_context_get_meta(jit_context_t context, int type);


jit_nuint  jit_context_get_meta_numeric(jit_context_t context, int type);

void  jit_context_free_meta(jit_context_t context, int type);







/* Converted to D from C:\libjit\include\jit\jit-debugger.h by htod */
//:module jit-debugger;


int  jit_debugging_possible();


jit_debugger_t  jit_debugger_create(jit_context_t context);

void  jit_debugger_destroy(jit_debugger_t dbg);


jit_context_t  jit_debugger_get_context(jit_debugger_t dbg);

jit_debugger_t  jit_debugger_from_context(jit_context_t context);


jit_debugger_thread_id_t  jit_debugger_get_self(jit_debugger_t dbg);


jit_debugger_thread_id_t  jit_debugger_get_thread(jit_debugger_t dbg, void *native_thread);



int  jit_debugger_get_native_thread(jit_debugger_t dbg, jit_debugger_thread_id_t thread, void *native_thread);


void  jit_debugger_set_breakable(jit_debugger_t dbg, void *native_thread, int flag);



void  jit_debugger_attach_self(jit_debugger_t dbg, int stop_immediately);

void  jit_debugger_detach_self(jit_debugger_t dbg);




int  jit_debugger_wait_event(jit_debugger_t dbg, jit_debugger_event_t *event, jit_int timeout);



jit_debugger_breakpoint_id_t  jit_debugger_add_breakpoint(jit_debugger_t dbg, jit_debugger_breakpoint_info_t info);


void  jit_debugger_remove_breakpoint(jit_debugger_t dbg, jit_debugger_breakpoint_id_t id);

void  jit_debugger_remove_all_breakpoints(jit_debugger_t dbg);



int  jit_debugger_is_alive(jit_debugger_t dbg, jit_debugger_thread_id_t thread);


int  jit_debugger_is_running(jit_debugger_t dbg, jit_debugger_thread_id_t thread);


void  jit_debugger_run(jit_debugger_t dbg, jit_debugger_thread_id_t thread);


void  jit_debugger_step(jit_debugger_t dbg, jit_debugger_thread_id_t thread);


void  jit_debugger_next(jit_debugger_t dbg, jit_debugger_thread_id_t thread);


void  jit_debugger_finish(jit_debugger_t dbg, jit_debugger_thread_id_t thread);


void  jit_debugger_break(jit_debugger_t dbg);


void  jit_debugger_quit(jit_debugger_t dbg);



jit_debugger_hook_func  jit_debugger_set_hook(jit_context_t context, jit_debugger_hook_func hook);






/* Converted to D from C:\libjit\include\jit\jit-defs.h by htod */
//:module jit-defs;

/* Converted to D from C:\libjit\include\jit\jit-dump.h by htod */
//:module jit-dump;


void  jit_dump_type(FILE *stream, jit_type_t type);



void  jit_dump_value(FILE *stream, jit_function_t func, jit_value_t value, char *prefix);


void  jit_dump_insn(FILE *stream, jit_function_t func, jit_insn_t insn);


void  jit_dump_function(FILE *stream, jit_function_t func, char *name);






/* Converted to D from C:\libjit\include\jit\jit-dynamic.h by htod */
//:module jit-dynamic;












/*
 * Dynamic library routines.
 */


jit_dynlib_handle_t  jit_dynlib_open(char *name);

void  jit_dynlib_close(jit_dynlib_handle_t handle);


void * jit_dynlib_get_symbol(jit_dynlib_handle_t handle, char *symbol);

char * jit_dynlib_get_suffix();

void  jit_dynlib_set_debug(int flag);


char * jit_mangle_global_function(char *name, jit_type_t signature, int form);



char * jit_mangle_member_function(char *class_name, char *name, jit_type_t signature, int form, int flags);






/* Converted to D from C:\libjit\include\jit\jit-elf.h by htod */
//:module jit-elf;


/*
 * Flags for "jit_readelf_open".
 */



/*
 * External function declarations.
 */


int  jit_readelf_open(jit_readelf_t *readelf, char *filename, int flags);

void  jit_readelf_close(jit_readelf_t readelf);

char * jit_readelf_get_name(jit_readelf_t readelf);


void * jit_readelf_get_symbol(jit_readelf_t readelf, char *name);


void * jit_readelf_get_section(jit_readelf_t readelf, char *name, jit_nuint *size);


void * jit_readelf_get_section_by_type(jit_readelf_t readelf, jit_int type, jit_nuint *size);


void * jit_readelf_map_vaddr(jit_readelf_t readelf, jit_nuint vaddr);

uint  jit_readelf_num_needed(jit_readelf_t readelf);


char * jit_readelf_get_needed(jit_readelf_t readelf, uint index);


void  jit_readelf_add_to_context(jit_readelf_t readelf, jit_context_t context);


int  jit_readelf_resolve_all(jit_context_t context, int print_failures);



int  jit_readelf_register_symbol(jit_context_t context, char *name, void *value, int after);


jit_writeelf_t  jit_writeelf_create(char *library_name);

void  jit_writeelf_destroy(jit_writeelf_t writeelf);


int  jit_writeelf_write(jit_writeelf_t writeelf, char *filename);



int  jit_writeelf_add_function(jit_writeelf_t writeelf, jit_function_t func, char *name);


int  jit_writeelf_add_needed(jit_writeelf_t writeelf, char *library_name);



int  jit_writeelf_write_section(jit_writeelf_t writeelf, char *name, jit_int type, void *buf, uint len, int discardable);






/* Converted to D from C:\libjit\include\jit\jit-except.h by htod */
//:module jit-except;












/*
 * Builtin exception type codes, and result values for intrinsic functions.
 */













/*
 * Exception handling function for builtin exceptions.
 */



/*
 * External function declarations.
 */

void * jit_exception_get_last();

void * jit_exception_get_last_and_clear();

void  jit_exception_set_last(void *object);

void  jit_exception_clear_last();

void  jit_exception_throw(void *object);

void  jit_exception_builtin(int exception_type);

jit_exception_func  jit_exception_set_handler(jit_exception_func handler);

jit_exception_func  jit_exception_get_handler();

jit_stack_trace_t  jit_exception_get_stack_trace();

uint  jit_stack_trace_get_size(jit_stack_trace_t trace);



jit_function_t  jit_stack_trace_get_function(jit_context_t context, jit_stack_trace_t trace, uint posn);

void * jit_stack_trace_get_pc(jit_stack_trace_t trace, uint posn);



uint  jit_stack_trace_get_offset(jit_context_t context, jit_stack_trace_t trace, uint posn);

void  jit_stack_trace_free(jit_stack_trace_t trace);






/* Converted to D from C:\libjit\include\jit\jit-function.h by htod */
//:module jit-function;














jit_function_t  jit_function_create(jit_context_t context, jit_type_t signature);



jit_function_t  jit_function_create_nested(jit_context_t context, jit_type_t signature, jit_function_t parent);

void  jit_function_abandon(jit_function_t func);

jit_context_t  jit_function_get_context(jit_function_t func);

jit_type_t  jit_function_get_signature(jit_function_t func);



int  jit_function_set_meta(jit_function_t func, int type, void *data, jit_meta_free_func free_data, int build_only);

void * jit_function_get_meta(jit_function_t func, int type);

void  jit_function_free_meta(jit_function_t func, int type);


jit_function_t  jit_function_next(jit_context_t context, jit_function_t prev);


jit_function_t  jit_function_previous(jit_context_t context, jit_function_t prev);

jit_block_t  jit_function_get_entry(jit_function_t func);

jit_block_t  jit_function_get_current(jit_function_t func);

jit_function_t  jit_function_get_nested_parent(jit_function_t func);

int  jit_function_compile(jit_function_t func);

int  jit_function_is_compiled(jit_function_t func);

void  jit_function_set_recompilable(jit_function_t func);

void  jit_function_clear_recompilable(jit_function_t func);

int  jit_function_is_recompilable(jit_function_t func);

int  jit_function_compile_entry(jit_function_t func, void **entry_point);

void  jit_function_setup_entry(jit_function_t func, void *entry_point);

void * jit_function_to_closure(jit_function_t func);


jit_function_t  jit_function_from_closure(jit_context_t context, void *closure);


jit_function_t  jit_function_from_pc(jit_context_t context, void *pc, void **handler);

void * jit_function_to_vtable_pointer(jit_function_t func);


jit_function_t  jit_function_from_vtable_pointer(jit_context_t context, void *vtable_pointer);


void  jit_function_set_on_demand_compiler(jit_function_t func, jit_on_demand_func on_demand);

jit_on_demand_func  jit_function_get_on_demand_compiler(jit_function_t func);


int  jit_function_apply(jit_function_t func, void **args, void *return_area);


int  jit_function_apply_vararg(jit_function_t func, jit_type_t signature, void **args, void *return_area);


void  jit_function_set_optimization_level(jit_function_t func, uint level);


uint  jit_function_get_optimization_level(jit_function_t func);

uint  jit_function_get_max_optimization_level();

jit_label_t  jit_function_reserve_label(jit_function_t func);

int  jit_function_labels_equal(jit_function_t func, jit_label_t label, jit_label_t label2);






/* Converted to D from C:\libjit\include\jit\jit-init.h by htod */
//:module jit-init;













void  jit_init();


int  jit_uses_interpreter();


int  jit_supports_threads();


int  jit_supports_virtual_memory();


int  jit_supports_closures();


uint  jit_get_closure_size();

uint  jit_get_closure_alignment();

uint  jit_get_trampoline_size();

uint  jit_get_trampoline_alignment();






/* Converted to D from C:\libjit\include\jit\jit-insn.h by htod */
//:module jit-insn;












/*
 * Descriptor for an intrinsic function.
 */






/*
 * Flags for "jit_insn_call" and friends.
 */





int  jit_insn_get_opcode(jit_insn_t insn);

jit_value_t  jit_insn_get_dest(jit_insn_t insn);

jit_value_t  jit_insn_get_value1(jit_insn_t insn);

jit_value_t  jit_insn_get_value2(jit_insn_t insn);

jit_label_t  jit_insn_get_label(jit_insn_t insn);

jit_function_t  jit_insn_get_function(jit_insn_t insn);

void * jit_insn_get_native(jit_insn_t insn);

char * jit_insn_get_name(jit_insn_t insn);

jit_type_t  jit_insn_get_signature(jit_insn_t insn);

int  jit_insn_dest_is_value(jit_insn_t insn);


int  jit_insn_label(jit_function_t func, jit_label_t *label);

int  jit_insn_new_block(jit_function_t func);

jit_value_t  jit_insn_load(jit_function_t func, jit_value_t value);

jit_value_t  jit_insn_dup(jit_function_t func, jit_value_t value);


jit_value_t  jit_insn_load_small(jit_function_t func, jit_value_t value);


int  jit_insn_store(jit_function_t func, jit_value_t dest, jit_value_t value);



jit_value_t  jit_insn_load_relative(jit_function_t func, jit_value_t value, jit_nint offset, jit_type_t type);



int  jit_insn_store_relative(jit_function_t func, jit_value_t dest, jit_nint offset, jit_value_t value);


jit_value_t  jit_insn_add_relative(jit_function_t func, jit_value_t value, jit_nint offset);



jit_value_t  jit_insn_load_elem(jit_function_t func, jit_value_t base_addr, jit_value_t index, jit_type_t elem_type);



jit_value_t  jit_insn_load_elem_address(jit_function_t func, jit_value_t base_addr, jit_value_t index, jit_type_t elem_type);



int  jit_insn_store_elem(jit_function_t func, jit_value_t base_addr, jit_value_t index, jit_value_t value);

int  jit_insn_check_null(jit_function_t func, jit_value_t value);



jit_value_t  jit_insn_add(jit_function_t func, jit_value_t value1, jit_value_t value2);


jit_value_t  jit_insn_add_ovf(jit_function_t func, jit_value_t value1, jit_value_t value2);


jit_value_t  jit_insn_sub(jit_function_t func, jit_value_t value1, jit_value_t value2);


jit_value_t  jit_insn_sub_ovf(jit_function_t func, jit_value_t value1, jit_value_t value2);


jit_value_t  jit_insn_mul(jit_function_t func, jit_value_t value1, jit_value_t value2);


jit_value_t  jit_insn_mul_ovf(jit_function_t func, jit_value_t value1, jit_value_t value2);


jit_value_t  jit_insn_div(jit_function_t func, jit_value_t value1, jit_value_t value2);


jit_value_t  jit_insn_rem(jit_function_t func, jit_value_t value1, jit_value_t value2);


jit_value_t  jit_insn_rem_ieee(jit_function_t func, jit_value_t value1, jit_value_t value2);


jit_value_t  jit_insn_neg(jit_function_t func, jit_value_t value1);


jit_value_t  jit_insn_and(jit_function_t func, jit_value_t value1, jit_value_t value2);


jit_value_t  jit_insn_or(jit_function_t func, jit_value_t value1, jit_value_t value2);


jit_value_t  jit_insn_xor(jit_function_t func, jit_value_t value1, jit_value_t value2);


jit_value_t  jit_insn_not(jit_function_t func, jit_value_t value1);


jit_value_t  jit_insn_shl(jit_function_t func, jit_value_t value1, jit_value_t value2);


jit_value_t  jit_insn_shr(jit_function_t func, jit_value_t value1, jit_value_t value2);


jit_value_t  jit_insn_ushr(jit_function_t func, jit_value_t value1, jit_value_t value2);


jit_value_t  jit_insn_sshr(jit_function_t func, jit_value_t value1, jit_value_t value2);


jit_value_t  jit_insn_eq(jit_function_t func, jit_value_t value1, jit_value_t value2);


jit_value_t  jit_insn_ne(jit_function_t func, jit_value_t value1, jit_value_t value2);


jit_value_t  jit_insn_lt(jit_function_t func, jit_value_t value1, jit_value_t value2);


jit_value_t  jit_insn_le(jit_function_t func, jit_value_t value1, jit_value_t value2);


jit_value_t  jit_insn_gt(jit_function_t func, jit_value_t value1, jit_value_t value2);


jit_value_t  jit_insn_ge(jit_function_t func, jit_value_t value1, jit_value_t value2);


jit_value_t  jit_insn_cmpl(jit_function_t func, jit_value_t value1, jit_value_t value2);


jit_value_t  jit_insn_cmpg(jit_function_t func, jit_value_t value1, jit_value_t value2);


jit_value_t  jit_insn_to_bool(jit_function_t func, jit_value_t value1);


jit_value_t  jit_insn_to_not_bool(jit_function_t func, jit_value_t value1);


jit_value_t  jit_insn_acos(jit_function_t func, jit_value_t value1);


jit_value_t  jit_insn_asin(jit_function_t func, jit_value_t value1);


jit_value_t  jit_insn_atan(jit_function_t func, jit_value_t value1);


jit_value_t  jit_insn_atan2(jit_function_t func, jit_value_t value1, jit_value_t value2);


jit_value_t  jit_insn_ceil(jit_function_t func, jit_value_t value1);


jit_value_t  jit_insn_cos(jit_function_t func, jit_value_t value1);


jit_value_t  jit_insn_cosh(jit_function_t func, jit_value_t value1);


jit_value_t  jit_insn_exp(jit_function_t func, jit_value_t value1);


jit_value_t  jit_insn_floor(jit_function_t func, jit_value_t value1);


jit_value_t  jit_insn_log(jit_function_t func, jit_value_t value1);


jit_value_t  jit_insn_log10(jit_function_t func, jit_value_t value1);


jit_value_t  jit_insn_pow(jit_function_t func, jit_value_t value1, jit_value_t value2);


jit_value_t  jit_insn_rint(jit_function_t func, jit_value_t value1);


jit_value_t  jit_insn_round(jit_function_t func, jit_value_t value1);


jit_value_t  jit_insn_sin(jit_function_t func, jit_value_t value1);


jit_value_t  jit_insn_sinh(jit_function_t func, jit_value_t value1);


jit_value_t  jit_insn_sqrt(jit_function_t func, jit_value_t value1);


jit_value_t  jit_insn_tan(jit_function_t func, jit_value_t value1);


jit_value_t  jit_insn_tanh(jit_function_t func, jit_value_t value1);


jit_value_t  jit_insn_trunc(jit_function_t func, jit_value_t value1);


jit_value_t  jit_insn_is_nan(jit_function_t func, jit_value_t value1);


jit_value_t  jit_insn_is_finite(jit_function_t func, jit_value_t value1);


jit_value_t  jit_insn_is_inf(jit_function_t func, jit_value_t value1);


jit_value_t  jit_insn_abs(jit_function_t func, jit_value_t value1);


jit_value_t  jit_insn_min(jit_function_t func, jit_value_t value1, jit_value_t value2);


jit_value_t  jit_insn_max(jit_function_t func, jit_value_t value1, jit_value_t value2);


jit_value_t  jit_insn_sign(jit_function_t func, jit_value_t value1);


int  jit_insn_branch(jit_function_t func, jit_label_t *label);


int  jit_insn_branch_if(jit_function_t func, jit_value_t value, jit_label_t *label);


int  jit_insn_branch_if_not(jit_function_t func, jit_value_t value, jit_label_t *label);



int  jit_insn_jump_table(jit_function_t func, jit_value_t value, jit_label_t *labels, uint num_labels);


jit_value_t  jit_insn_address_of(jit_function_t func, jit_value_t value1);


jit_value_t  jit_insn_address_of_label(jit_function_t func, jit_label_t *label);



jit_value_t  jit_insn_convert(jit_function_t func, jit_value_t value, jit_type_t type, int overflow_check);





jit_value_t  jit_insn_call(jit_function_t func, char *name, jit_function_t jit_func, jit_type_t signature, jit_value_t *args, uint num_args, int flags);



jit_value_t  jit_insn_call_indirect(jit_function_t func, jit_value_t value, jit_type_t signature, jit_value_t *args, uint num_args, int flags);



jit_value_t  jit_insn_call_indirect_vtable(jit_function_t func, jit_value_t value, jit_type_t signature, jit_value_t *args, uint num_args, int flags);




jit_value_t  jit_insn_call_native(jit_function_t func, char *name, void *native_func, jit_type_t signature, jit_value_t *args, uint num_args, int flags);




jit_value_t  jit_insn_call_intrinsic(jit_function_t func, char *name, void *intrinsic_func, jit_intrinsic_descr_t *descriptor, jit_value_t arg1, jit_value_t arg2);


int  jit_insn_incoming_reg(jit_function_t func, jit_value_t value, int reg);


int  jit_insn_incoming_frame_posn(jit_function_t func, jit_value_t value, jit_nint frame_offset);


int  jit_insn_outgoing_reg(jit_function_t func, jit_value_t value, int reg);


int  jit_insn_outgoing_frame_posn(jit_function_t func, jit_value_t value, jit_nint frame_offset);


int  jit_insn_return_reg(jit_function_t func, jit_value_t value, int reg);


int  jit_insn_setup_for_nested(jit_function_t func, int nested_level, int reg);

int  jit_insn_flush_struct(jit_function_t func, jit_value_t value);


jit_value_t  jit_insn_import(jit_function_t func, jit_value_t value);

int  jit_insn_push(jit_function_t func, jit_value_t value);


int  jit_insn_push_ptr(jit_function_t func, jit_value_t value, jit_type_t type);


int  jit_insn_set_param(jit_function_t func, jit_value_t value, jit_nint offset);



int  jit_insn_set_param_ptr(jit_function_t func, jit_value_t value, jit_type_t type, jit_nint offset);

int  jit_insn_push_return_area_ptr(jit_function_t func);

int  jit_insn_pop_stack(jit_function_t func, jit_nint num_items);


int  jit_insn_defer_pop_stack(jit_function_t func, jit_nint num_items);


int  jit_insn_flush_defer_pop(jit_function_t func, jit_nint num_items);

int  jit_insn_return(jit_function_t func, jit_value_t value);


int  jit_insn_return_ptr(jit_function_t func, jit_value_t value, jit_type_t type);

int  jit_insn_default_return(jit_function_t func);

int  jit_insn_throw(jit_function_t func, jit_value_t value);

jit_value_t  jit_insn_get_call_stack(jit_function_t func);


jit_value_t  jit_insn_thrown_exception(jit_function_t func);

int  jit_insn_uses_catcher(jit_function_t func);

jit_value_t  jit_insn_start_catcher(jit_function_t func);



int  jit_insn_branch_if_pc_not_in_range(jit_function_t func, jit_label_t start_label, jit_label_t end_label, jit_label_t *label);

int  jit_insn_rethrow_unhandled(jit_function_t func);


int  jit_insn_start_finally(jit_function_t func, jit_label_t *finally_label);

int  jit_insn_return_from_finally(jit_function_t func);


int  jit_insn_call_finally(jit_function_t func, jit_label_t *finally_label);


jit_value_t  jit_insn_start_filter(jit_function_t func, jit_label_t *label, jit_type_t type);


int  jit_insn_return_from_filter(jit_function_t func, jit_value_t value);



jit_value_t  jit_insn_call_filter(jit_function_t func, jit_label_t *label, jit_value_t value, jit_type_t type);




int  jit_insn_memcpy(jit_function_t func, jit_value_t dest, jit_value_t src, jit_value_t size);



int  jit_insn_memmove(jit_function_t func, jit_value_t dest, jit_value_t src, jit_value_t size);



int  jit_insn_memset(jit_function_t func, jit_value_t dest, jit_value_t value, jit_value_t size);


jit_value_t  jit_insn_alloca(jit_function_t func, jit_value_t size);




int  jit_insn_move_blocks_to_end(jit_function_t func, jit_label_t from_label, jit_label_t to_label);



int  jit_insn_move_blocks_to_start(jit_function_t func, jit_label_t from_label, jit_label_t to_label);



int  jit_insn_mark_offset(jit_function_t func, jit_int offset);


int  jit_insn_mark_breakpoint(jit_function_t func, jit_nint data1, jit_nint data2);


int  jit_insn_mark_breakpoint_variable(jit_function_t func, jit_value_t data1, jit_value_t data2);


void  jit_insn_iter_init(jit_insn_iter_t *iter, jit_block_t block);


void  jit_insn_iter_init_last(jit_insn_iter_t *iter, jit_block_t block);

jit_insn_t  jit_insn_iter_next(jit_insn_iter_t *iter);

jit_insn_t  jit_insn_iter_previous(jit_insn_iter_t *iter);






/* Converted to D from C:\libjit\include\jit\jit-intrinsic.h by htod */
//:module jit-intrinsic;












/*
 * Perform operations on signed 32-bit integers.
 */


jit_int  jit_int_add(jit_int value1, jit_int value2);

jit_int  jit_int_sub(jit_int value1, jit_int value2);

jit_int  jit_int_mul(jit_int value1, jit_int value2);


jit_int  jit_int_div(jit_int *result, jit_int value1, jit_int value2);


jit_int  jit_int_rem(jit_int *result, jit_int value1, jit_int value2);


jit_int  jit_int_add_ovf(jit_int *result, jit_int value1, jit_int value2);


jit_int  jit_int_sub_ovf(jit_int *result, jit_int value1, jit_int value2);


jit_int  jit_int_mul_ovf(jit_int *result, jit_int value1, jit_int value2);

jit_int  jit_int_neg(jit_int value1);

jit_int  jit_int_and(jit_int value1, jit_int value2);

jit_int  jit_int_or(jit_int value1, jit_int value2);

jit_int  jit_int_xor(jit_int value1, jit_int value2);

jit_int  jit_int_not(jit_int value1);

jit_int  jit_int_shl(jit_int value1, jit_uint value2);

jit_int  jit_int_shr(jit_int value1, jit_uint value2);

jit_int  jit_int_eq(jit_int value1, jit_int value2);

jit_int  jit_int_ne(jit_int value1, jit_int value2);

jit_int  jit_int_lt(jit_int value1, jit_int value2);

jit_int  jit_int_le(jit_int value1, jit_int value2);

jit_int  jit_int_gt(jit_int value1, jit_int value2);

jit_int  jit_int_ge(jit_int value1, jit_int value2);

jit_int  jit_int_cmp(jit_int value1, jit_int value2);

jit_int  jit_int_abs(jit_int value1);

jit_int  jit_int_min(jit_int value1, jit_int value2);

jit_int  jit_int_max(jit_int value1, jit_int value2);

jit_int  jit_int_sign(jit_int value1);

/*
 * Perform operations on unsigned 32-bit integers.
 */

jit_uint  jit_uint_add(jit_uint value1, jit_uint value2);

jit_uint  jit_uint_sub(jit_uint value1, jit_uint value2);

jit_uint  jit_uint_mul(jit_uint value1, jit_uint value2);


jit_int  jit_uint_div(jit_uint *result, jit_uint value1, jit_uint value2);


jit_int  jit_uint_rem(jit_uint *result, jit_uint value1, jit_uint value2);


jit_int  jit_uint_add_ovf(jit_uint *result, jit_uint value1, jit_uint value2);


jit_int  jit_uint_sub_ovf(jit_uint *result, jit_uint value1, jit_uint value2);


jit_int  jit_uint_mul_ovf(jit_uint *result, jit_uint value1, jit_uint value2);

jit_uint  jit_uint_neg(jit_uint value1);

jit_uint  jit_uint_and(jit_uint value1, jit_uint value2);

jit_uint  jit_uint_or(jit_uint value1, jit_uint value2);

jit_uint  jit_uint_xor(jit_uint value1, jit_uint value2);

jit_uint  jit_uint_not(jit_uint value1);

jit_uint  jit_uint_shl(jit_uint value1, jit_uint value2);

jit_uint  jit_uint_shr(jit_uint value1, jit_uint value2);

jit_int  jit_uint_eq(jit_uint value1, jit_uint value2);

jit_int  jit_uint_ne(jit_uint value1, jit_uint value2);

jit_int  jit_uint_lt(jit_uint value1, jit_uint value2);

jit_int  jit_uint_le(jit_uint value1, jit_uint value2);

jit_int  jit_uint_gt(jit_uint value1, jit_uint value2);

jit_int  jit_uint_ge(jit_uint value1, jit_uint value2);

jit_int  jit_uint_cmp(jit_uint value1, jit_uint value2);

jit_uint  jit_uint_min(jit_uint value1, jit_uint value2);

jit_uint  jit_uint_max(jit_uint value1, jit_uint value2);

/*
 * Perform operations on signed 64-bit integers.
 */

jit_long  jit_long_add(jit_long value1, jit_long value2);

jit_long  jit_long_sub(jit_long value1, jit_long value2);

jit_long  jit_long_mul(jit_long value1, jit_long value2);


jit_int  jit_long_div(jit_long *result, jit_long value1, jit_long value2);


jit_int  jit_long_rem(jit_long *result, jit_long value1, jit_long value2);


jit_int  jit_long_add_ovf(jit_long *result, jit_long value1, jit_long value2);


jit_int  jit_long_sub_ovf(jit_long *result, jit_long value1, jit_long value2);


jit_int  jit_long_mul_ovf(jit_long *result, jit_long value1, jit_long value2);

jit_long  jit_long_neg(jit_long value1);

jit_long  jit_long_and(jit_long value1, jit_long value2);

jit_long  jit_long_or(jit_long value1, jit_long value2);

jit_long  jit_long_xor(jit_long value1, jit_long value2);

jit_long  jit_long_not(jit_long value1);

jit_long  jit_long_shl(jit_long value1, jit_uint value2);

jit_long  jit_long_shr(jit_long value1, jit_uint value2);

jit_int  jit_long_eq(jit_long value1, jit_long value2);

jit_int  jit_long_ne(jit_long value1, jit_long value2);

jit_int  jit_long_lt(jit_long value1, jit_long value2);

jit_int  jit_long_le(jit_long value1, jit_long value2);

jit_int  jit_long_gt(jit_long value1, jit_long value2);

jit_int  jit_long_ge(jit_long value1, jit_long value2);

jit_int  jit_long_cmp(jit_long value1, jit_long value2);

jit_long  jit_long_abs(jit_long value1);

jit_long  jit_long_min(jit_long value1, jit_long value2);

jit_long  jit_long_max(jit_long value1, jit_long value2);

jit_int  jit_long_sign(jit_long value1);

/*
 * Perform operations on unsigned 64-bit integers.
 */

jit_ulong  jit_ulong_add(jit_ulong value1, jit_ulong value2);

jit_ulong  jit_ulong_sub(jit_ulong value1, jit_ulong value2);

jit_ulong  jit_ulong_mul(jit_ulong value1, jit_ulong value2);


jit_int  jit_ulong_div(jit_ulong *result, jit_ulong value1, jit_ulong value2);


jit_int  jit_ulong_rem(jit_ulong *result, jit_ulong value1, jit_ulong value2);


jit_int  jit_ulong_add_ovf(jit_ulong *result, jit_ulong value1, jit_ulong value2);


jit_int  jit_ulong_sub_ovf(jit_ulong *result, jit_ulong value1, jit_ulong value2);


jit_int  jit_ulong_mul_ovf(jit_ulong *result, jit_ulong value1, jit_ulong value2);

jit_ulong  jit_ulong_neg(jit_ulong value1);

jit_ulong  jit_ulong_and(jit_ulong value1, jit_ulong value2);

jit_ulong  jit_ulong_or(jit_ulong value1, jit_ulong value2);

jit_ulong  jit_ulong_xor(jit_ulong value1, jit_ulong value2);

jit_ulong  jit_ulong_not(jit_ulong value1);

jit_ulong  jit_ulong_shl(jit_ulong value1, jit_uint value2);

jit_ulong  jit_ulong_shr(jit_ulong value1, jit_uint value2);

jit_int  jit_ulong_eq(jit_ulong value1, jit_ulong value2);

jit_int  jit_ulong_ne(jit_ulong value1, jit_ulong value2);

jit_int  jit_ulong_lt(jit_ulong value1, jit_ulong value2);

jit_int  jit_ulong_le(jit_ulong value1, jit_ulong value2);

jit_int  jit_ulong_gt(jit_ulong value1, jit_ulong value2);

jit_int  jit_ulong_ge(jit_ulong value1, jit_ulong value2);

jit_int  jit_ulong_cmp(jit_ulong value1, jit_ulong value2);

jit_ulong  jit_ulong_min(jit_ulong value1, jit_ulong value2);

jit_ulong  jit_ulong_max(jit_ulong value1, jit_ulong value2);

/*
 * Perform operations on 32-bit floating-point values.
 */


jit_float32  jit_float32_add(jit_float32 value1, jit_float32 value2);


jit_float32  jit_float32_sub(jit_float32 value1, jit_float32 value2);


jit_float32  jit_float32_mul(jit_float32 value1, jit_float32 value2);


jit_float32  jit_float32_div(jit_float32 value1, jit_float32 value2);


jit_float32  jit_float32_rem(jit_float32 value1, jit_float32 value2);


jit_float32  jit_float32_ieee_rem(jit_float32 value1, jit_float32 value2);

jit_float32  jit_float32_neg(jit_float32 value1);

jit_int  jit_float32_eq(jit_float32 value1, jit_float32 value2);

jit_int  jit_float32_ne(jit_float32 value1, jit_float32 value2);

jit_int  jit_float32_lt(jit_float32 value1, jit_float32 value2);

jit_int  jit_float32_le(jit_float32 value1, jit_float32 value2);

jit_int  jit_float32_gt(jit_float32 value1, jit_float32 value2);

jit_int  jit_float32_ge(jit_float32 value1, jit_float32 value2);

jit_int  jit_float32_cmpl(jit_float32 value1, jit_float32 value2);

jit_int  jit_float32_cmpg(jit_float32 value1, jit_float32 value2);

jit_float32  jit_float32_acos(jit_float32 value1);

jit_float32  jit_float32_asin(jit_float32 value1);

jit_float32  jit_float32_atan(jit_float32 value1);


jit_float32  jit_float32_atan2(jit_float32 value1, jit_float32 value2);

jit_float32  jit_float32_ceil(jit_float32 value1);

jit_float32  jit_float32_cos(jit_float32 value1);

jit_float32  jit_float32_cosh(jit_float32 value1);

jit_float32  jit_float32_exp(jit_float32 value1);

jit_float32  jit_float32_floor(jit_float32 value1);

jit_float32  jit_float32_log(jit_float32 value1);

jit_float32  jit_float32_log10(jit_float32 value1);


jit_float32  jit_float32_pow(jit_float32 value1, jit_float32 value2);

jit_float32  jit_float32_rint(jit_float32 value1);

jit_float32  jit_float32_round(jit_float32 value1);

jit_float32  jit_float32_sin(jit_float32 value1);

jit_float32  jit_float32_sinh(jit_float32 value1);

jit_float32  jit_float32_sqrt(jit_float32 value1);

jit_float32  jit_float32_tan(jit_float32 value1);

jit_float32  jit_float32_tanh(jit_float32 value1);

jit_float32  jit_float32_trunc(jit_float32 value1);

jit_int  jit_float32_is_finite(jit_float32 value);

jit_int  jit_float32_is_nan(jit_float32 value);

jit_int  jit_float32_is_inf(jit_float32 value);

jit_float32  jit_float32_abs(jit_float32 value1);


jit_float32  jit_float32_min(jit_float32 value1, jit_float32 value2);


jit_float32  jit_float32_max(jit_float32 value1, jit_float32 value2);

jit_int  jit_float32_sign(jit_float32 value1);

/*
 * Perform operations on 64-bit floating-point values.
 */


jit_float64  jit_float64_add(jit_float64 value1, jit_float64 value2);


jit_float64  jit_float64_sub(jit_float64 value1, jit_float64 value2);


jit_float64  jit_float64_mul(jit_float64 value1, jit_float64 value2);


jit_float64  jit_float64_div(jit_float64 value1, jit_float64 value2);


jit_float64  jit_float64_rem(jit_float64 value1, jit_float64 value2);


jit_float64  jit_float64_ieee_rem(jit_float64 value1, jit_float64 value2);

jit_float64  jit_float64_neg(jit_float64 value1);

jit_int  jit_float64_eq(jit_float64 value1, jit_float64 value2);

jit_int  jit_float64_ne(jit_float64 value1, jit_float64 value2);

jit_int  jit_float64_lt(jit_float64 value1, jit_float64 value2);

jit_int  jit_float64_le(jit_float64 value1, jit_float64 value2);

jit_int  jit_float64_gt(jit_float64 value1, jit_float64 value2);

jit_int  jit_float64_ge(jit_float64 value1, jit_float64 value2);

jit_int  jit_float64_cmpl(jit_float64 value1, jit_float64 value2);

jit_int  jit_float64_cmpg(jit_float64 value1, jit_float64 value2);

jit_float64  jit_float64_acos(jit_float64 value1);

jit_float64  jit_float64_asin(jit_float64 value1);

jit_float64  jit_float64_atan(jit_float64 value1);


jit_float64  jit_float64_atan2(jit_float64 value1, jit_float64 value2);

jit_float64  jit_float64_ceil(jit_float64 value1);

jit_float64  jit_float64_cos(jit_float64 value1);

jit_float64  jit_float64_cosh(jit_float64 value1);

jit_float64  jit_float64_exp(jit_float64 value1);

jit_float64  jit_float64_floor(jit_float64 value1);

jit_float64  jit_float64_log(jit_float64 value1);

jit_float64  jit_float64_log10(jit_float64 value1);


jit_float64  jit_float64_pow(jit_float64 value1, jit_float64 value2);

jit_float64  jit_float64_rint(jit_float64 value1);

jit_float64  jit_float64_round(jit_float64 value1);

jit_float64  jit_float64_sin(jit_float64 value1);

jit_float64  jit_float64_sinh(jit_float64 value1);

jit_float64  jit_float64_sqrt(jit_float64 value1);

jit_float64  jit_float64_tan(jit_float64 value1);

jit_float64  jit_float64_tanh(jit_float64 value1);

jit_float64  jit_float64_trunc(jit_float64 value1);

jit_int  jit_float64_is_finite(jit_float64 value);

jit_int  jit_float64_is_nan(jit_float64 value);

jit_int  jit_float64_is_inf(jit_float64 value);

jit_float64  jit_float64_abs(jit_float64 value1);


jit_float64  jit_float64_min(jit_float64 value1, jit_float64 value2);


jit_float64  jit_float64_max(jit_float64 value1, jit_float64 value2);

jit_int  jit_float64_sign(jit_float64 value1);

/*
 * Perform operations on native floating-point values.
 */

jit_nfloat  jit_nfloat_add(jit_nfloat value1, jit_nfloat value2);

jit_nfloat  jit_nfloat_sub(jit_nfloat value1, jit_nfloat value2);

jit_nfloat  jit_nfloat_mul(jit_nfloat value1, jit_nfloat value2);

jit_nfloat  jit_nfloat_div(jit_nfloat value1, jit_nfloat value2);

jit_nfloat  jit_nfloat_rem(jit_nfloat value1, jit_nfloat value2);


jit_nfloat  jit_nfloat_ieee_rem(jit_nfloat value1, jit_nfloat value2);

jit_nfloat  jit_nfloat_neg(jit_nfloat value1);

jit_int  jit_nfloat_eq(jit_nfloat value1, jit_nfloat value2);

jit_int  jit_nfloat_ne(jit_nfloat value1, jit_nfloat value2);

jit_int  jit_nfloat_lt(jit_nfloat value1, jit_nfloat value2);

jit_int  jit_nfloat_le(jit_nfloat value1, jit_nfloat value2);

jit_int  jit_nfloat_gt(jit_nfloat value1, jit_nfloat value2);

jit_int  jit_nfloat_ge(jit_nfloat value1, jit_nfloat value2);

jit_int  jit_nfloat_cmpl(jit_nfloat value1, jit_nfloat value2);

jit_int  jit_nfloat_cmpg(jit_nfloat value1, jit_nfloat value2);

jit_nfloat  jit_nfloat_acos(jit_nfloat value1);

jit_nfloat  jit_nfloat_asin(jit_nfloat value1);

jit_nfloat  jit_nfloat_atan(jit_nfloat value1);

jit_nfloat  jit_nfloat_atan2(jit_nfloat value1, jit_nfloat value2);

jit_nfloat  jit_nfloat_ceil(jit_nfloat value1);

jit_nfloat  jit_nfloat_cos(jit_nfloat value1);

jit_nfloat  jit_nfloat_cosh(jit_nfloat value1);

jit_nfloat  jit_nfloat_exp(jit_nfloat value1);

jit_nfloat  jit_nfloat_floor(jit_nfloat value1);

jit_nfloat  jit_nfloat_log(jit_nfloat value1);

jit_nfloat  jit_nfloat_log10(jit_nfloat value1);

jit_nfloat  jit_nfloat_pow(jit_nfloat value1, jit_nfloat value2);

jit_nfloat  jit_nfloat_rint(jit_nfloat value1);

jit_nfloat  jit_nfloat_round(jit_nfloat value1);

jit_nfloat  jit_nfloat_sin(jit_nfloat value1);

jit_nfloat  jit_nfloat_sinh(jit_nfloat value1);

jit_nfloat  jit_nfloat_sqrt(jit_nfloat value1);

jit_nfloat  jit_nfloat_tan(jit_nfloat value1);

jit_nfloat  jit_nfloat_tanh(jit_nfloat value1);

jit_nfloat  jit_nfloat_trunc(jit_nfloat value1);

jit_int  jit_nfloat_is_finite(jit_nfloat value);

jit_int  jit_nfloat_is_nan(jit_nfloat value);

jit_int  jit_nfloat_is_inf(jit_nfloat value);

jit_nfloat  jit_nfloat_abs(jit_nfloat value1);

jit_nfloat  jit_nfloat_min(jit_nfloat value1, jit_nfloat value2);

jit_nfloat  jit_nfloat_max(jit_nfloat value1, jit_nfloat value2);

jit_int  jit_nfloat_sign(jit_nfloat value1);

/*
 * Convert between integer types.
 */

jit_int  jit_int_to_sbyte(jit_int value);

jit_int  jit_int_to_ubyte(jit_int value);

jit_int  jit_int_to_short(jit_int value);

jit_int  jit_int_to_ushort(jit_int value);

jit_int  jit_int_to_int(jit_int value);

jit_uint  jit_int_to_uint(jit_int value);

jit_long  jit_int_to_long(jit_int value);

jit_ulong  jit_int_to_ulong(jit_int value);

jit_int  jit_uint_to_int(jit_uint value);

jit_uint  jit_uint_to_uint(jit_uint value);

jit_long  jit_uint_to_long(jit_uint value);

jit_ulong  jit_uint_to_ulong(jit_uint value);

jit_int  jit_long_to_int(jit_long value);

jit_uint  jit_long_to_uint(jit_long value);

jit_long  jit_long_to_long(jit_long value);

jit_ulong  jit_long_to_ulong(jit_long value);

jit_int  jit_ulong_to_int(jit_ulong value);

jit_uint  jit_ulong_to_uint(jit_ulong value);

jit_long  jit_ulong_to_long(jit_ulong value);

jit_ulong  jit_ulong_to_ulong(jit_ulong value);

/*
 * Convert between integer types with overflow detection.
 */

jit_int  jit_int_to_sbyte_ovf(jit_int *result, jit_int value);

jit_int  jit_int_to_ubyte_ovf(jit_int *result, jit_int value);

jit_int  jit_int_to_short_ovf(jit_int *result, jit_int value);

jit_int  jit_int_to_ushort_ovf(jit_int *result, jit_int value);

jit_int  jit_int_to_int_ovf(jit_int *result, jit_int value);

jit_int  jit_int_to_uint_ovf(jit_uint *result, jit_int value);

jit_int  jit_int_to_long_ovf(jit_long *result, jit_int value);

jit_int  jit_int_to_ulong_ovf(jit_ulong *result, jit_int value);

jit_int  jit_uint_to_int_ovf(jit_int *result, jit_uint value);

jit_int  jit_uint_to_uint_ovf(jit_uint *result, jit_uint value);

jit_int  jit_uint_to_long_ovf(jit_long *result, jit_uint value);

jit_int  jit_uint_to_ulong_ovf(jit_ulong *result, jit_uint value);

jit_int  jit_long_to_int_ovf(jit_int *result, jit_long value);

jit_int  jit_long_to_uint_ovf(jit_uint *result, jit_long value);

jit_int  jit_long_to_long_ovf(jit_long *result, jit_long value);

jit_int  jit_long_to_ulong_ovf(jit_ulong *result, jit_long value);

jit_int  jit_ulong_to_int_ovf(jit_int *result, jit_ulong value);

jit_int  jit_ulong_to_uint_ovf(jit_uint *result, jit_ulong value);

jit_int  jit_ulong_to_long_ovf(jit_long *result, jit_ulong value);

jit_int  jit_ulong_to_ulong_ovf(jit_ulong *result, jit_ulong value);

/*
 * Convert a 32-bit floating-point value into various integer types.
 */

jit_int  jit_float32_to_int(jit_float32 value);

jit_uint  jit_float32_to_uint(jit_float32 value);

jit_long  jit_float32_to_long(jit_float32 value);

jit_ulong  jit_float32_to_ulong(jit_float32 value);

/*
 * Convert a 32-bit floating-point value into various integer types,
 * with overflow detection.
 */

jit_int  jit_float32_to_int_ovf(jit_int *result, jit_float32 value);

jit_int  jit_float32_to_uint_ovf(jit_uint *result, jit_float32 value);

jit_int  jit_float32_to_long_ovf(jit_long *result, jit_float32 value);


jit_int  jit_float32_to_ulong_ovf(jit_ulong *result, jit_float32 value);

/*
 * Convert a 64-bit floating-point value into various integer types.
 */

jit_int  jit_float64_to_int(jit_float64 value);

jit_uint  jit_float64_to_uint(jit_float64 value);

jit_long  jit_float64_to_long(jit_float64 value);

jit_ulong  jit_float64_to_ulong(jit_float64 value);

/*
 * Convert a 64-bit floating-point value into various integer types,
 * with overflow detection.
 */

jit_int  jit_float64_to_int_ovf(jit_int *result, jit_float64 value);

jit_int  jit_float64_to_uint_ovf(jit_uint *result, jit_float64 value);

jit_int  jit_float64_to_long_ovf(jit_long *result, jit_float64 value);


jit_int  jit_float64_to_ulong_ovf(jit_ulong *result, jit_float64 value);

/*
 * Convert a native floating-point value into various integer types.
 */

jit_int  jit_nfloat_to_int(jit_nfloat value);

jit_uint  jit_nfloat_to_uint(jit_nfloat value);

jit_long  jit_nfloat_to_long(jit_nfloat value);

jit_ulong  jit_nfloat_to_ulong(jit_nfloat value);

/*
 * Convert a native floating-point value into various integer types,
 * with overflow detection.
 */

jit_int  jit_nfloat_to_int_ovf(jit_int *result, jit_nfloat value);

jit_int  jit_nfloat_to_uint_ovf(jit_uint *result, jit_nfloat value);

jit_int  jit_nfloat_to_long_ovf(jit_long *result, jit_nfloat value);


jit_int  jit_nfloat_to_ulong_ovf(jit_ulong *result, jit_nfloat value);

/*
 * Convert integer types into floating-point values.
 */

jit_float32  jit_int_to_float32(jit_int value);

jit_float64  jit_int_to_float64(jit_int value);

jit_nfloat  jit_int_to_nfloat(jit_int value);

jit_float32  jit_uint_to_float32(jit_uint value);

jit_float64  jit_uint_to_float64(jit_uint value);

jit_nfloat  jit_uint_to_nfloat(jit_uint value);

jit_float32  jit_long_to_float32(jit_long value);

jit_float64  jit_long_to_float64(jit_long value);

jit_nfloat  jit_long_to_nfloat(jit_long value);

jit_float32  jit_ulong_to_float32(jit_ulong value);

jit_float64  jit_ulong_to_float64(jit_ulong value);

jit_nfloat  jit_ulong_to_nfloat(jit_ulong value);

/*
 * Convert between floating-point types.
 */

jit_float64  jit_float32_to_float64(jit_float32 value);

jit_nfloat  jit_float32_to_nfloat(jit_float32 value);

jit_float32  jit_float64_to_float32(jit_float64 value);

jit_nfloat  jit_float64_to_nfloat(jit_float64 value);

jit_float32  jit_nfloat_to_float32(jit_nfloat value);

jit_float64  jit_nfloat_to_float64(jit_nfloat value);






/* Converted to D from C:\libjit\include\jit\jit-memory.h by htod */
//:module jit-memory;



/* Converted to D from C:\libjit\include\jit\jit-meta.h by htod */
//:module jit-meta;



int  jit_meta_set(jit_meta_t *list, int type, void *data,...);

void * jit_meta_get(jit_meta_t list, int type);

void  jit_meta_free(jit_meta_t *list, int type);

void  jit_meta_destroy(jit_meta_t *list);






/* Converted to D from C:\libjit\include\jit\jit-objmodel.h by htod */
//:module jit-objmodel;












/*
 * Operations on object models.
 */

void  jitom_destroy_model(jit_objmodel_t model);


jitom_class_t  jitom_get_class_by_name(jit_objmodel_t model, char *name);

/*
 * Operations on object model classes.
 */


char * jitom_class_get_name(jit_objmodel_t model, jitom_class_t klass);


int  jitom_class_get_modifiers(jit_objmodel_t model, jitom_class_t klass);


jit_type_t  jitom_class_get_type(jit_objmodel_t model, jitom_class_t klass);


jit_type_t  jitom_class_get_value_type(jit_objmodel_t model, jitom_class_t klass);


jitom_class_t  jitom_class_get_primary_super(jit_objmodel_t model, jitom_class_t klass);


jitom_class_t * jitom_class_get_all_supers(jit_objmodel_t model, jitom_class_t klass, uint *num);


jitom_class_t * jitom_class_get_interfaces(jit_objmodel_t model, jitom_class_t klass, uint *num);


jitom_field_t * jitom_class_get_fields(jit_objmodel_t model, jitom_class_t klass, uint *num);


jitom_method_t * jitom_class_get_methods(jit_objmodel_t model, jitom_class_t klass, uint *num);




jit_value_t  jitom_class_new(jit_objmodel_t model, jitom_class_t klass, jitom_method_t ctor, jit_function_t func, jit_value_t *args, uint num_args, int flags);




jit_value_t  jitom_class_new_value(jit_objmodel_t model, jitom_class_t klass, jitom_method_t ctor, jit_function_t func, jit_value_t *args, uint num_args, int flags);



int  jitom_class_delete(jit_objmodel_t model, jitom_class_t klass, jit_value_t obj_value);



int  jitom_class_add_ref(jit_objmodel_t model, jitom_class_t klass, jit_value_t obj_value);

/*
 * Operations on object model fields.
 */



char * jitom_field_get_name(jit_objmodel_t model, jitom_class_t klass, jitom_field_t field);



jit_type_t  jitom_field_get_type(jit_objmodel_t model, jitom_class_t klass, jitom_field_t field);



int  jitom_field_get_modifiers(jit_objmodel_t model, jitom_class_t klass, jitom_field_t field);



jit_value_t  jitom_field_load(jit_objmodel_t model, jitom_class_t klass, jitom_field_t field, jit_function_t func, jit_value_t obj_value);



jit_value_t  jitom_field_load_address(jit_objmodel_t model, jitom_class_t klass, jitom_field_t field, jit_function_t func, jit_value_t obj_value);



int  jitom_field_store(jit_objmodel_t model, jitom_class_t klass, jitom_field_t field, jit_function_t func, jit_value_t obj_value, jit_value_t value);

/*
 * Operations on object model methods.
 */



char * jitom_method_get_name(jit_objmodel_t model, jitom_class_t klass, jitom_method_t method);



jit_type_t  jitom_method_get_type(jit_objmodel_t model, jitom_class_t klass, jitom_method_t method);



int  jitom_method_get_modifiers(jit_objmodel_t model, jitom_class_t klass, jitom_method_t method);




jit_value_t  jitom_method_invoke(jit_objmodel_t model, jitom_class_t klass, jitom_method_t method, jit_function_t func, jit_value_t *args, uint num_args, int flags);




jit_value_t  jitom_method_invoke_virtual(jit_objmodel_t model, jitom_class_t klass, jitom_method_t method, jit_function_t func, jit_value_t *args, uint num_args, int flags);

/*
 * Manipulate types that represent objects and inline values.
 */



jit_type_t  jitom_type_tag_as_class(jit_type_t type, jit_objmodel_t model, jitom_class_t klass, int incref);



jit_type_t  jitom_type_tag_as_value(jit_type_t type, jit_objmodel_t model, jitom_class_t klass, int incref);

int  jitom_type_is_class(jit_type_t type);

int  jitom_type_is_value(jit_type_t type);

jit_objmodel_t  jitom_type_get_model(jit_type_t type);

jitom_class_t  jitom_type_get_class(jit_type_t type);






/* Converted to D from C:\libjit\include\jit\jit-objmodel-private.h by htod */
//:module jit-objmodel-private;












/*
 * Internal structure of an object model handler.
 */


	/*
	 * Size of this structure, for versioning.
	 */


	/*
	 * Reserved fields that can be used by the handler to store its state.
	 */





	/*
	 * Operations on object models.
	 */



	/*
	 * Operations on object model classes.
 	 */


	/*
	 * Operations on object model fields.
	 */


	/*
	 * Operations on object model methods.
	 */



/* Converted to D from C:\libjit\include\jit\jit-opcode.h by htod */
//:module jit-opcode;
/* Automatically generated from ../../jit/jit-opcodes.ops - DO NOT EDIT */


/* Converted to D from C:\libjit\include\jit\jit-opcode-compat.h by htod */
//:module jit-opcode-compat;



/* Converted to D from C:\libjit\include\jit\jit-plus.h by htod */
//:module jit-plus;





/* Converted to D from C:\libjit\include\jit\jit-type.h by htod */
//:module jit-type;




/*
 * External function declarations.
 */

jit_type_t  jit_type_copy(jit_type_t type);

void  jit_type_free(jit_type_t type);


jit_type_t  jit_type_create_struct(jit_type_t *fields, uint num_fields, int incref);


jit_type_t  jit_type_create_union(jit_type_t *fields, uint num_fields, int incref);



jit_type_t  jit_type_create_signature(jit_abi_t abi, jit_type_t return_type, jit_type_t *params, uint num_params, int incref);

jit_type_t  jit_type_create_pointer(jit_type_t type, int incref);



jit_type_t  jit_type_create_tagged(jit_type_t type, int kind, void *data, jit_meta_free_func free_func, int incref);


int  jit_type_set_names(jit_type_t type, char **names, uint num_names);


void  jit_type_set_size_and_alignment(jit_type_t type, jit_nint size, jit_nint alignment);


void  jit_type_set_offset(jit_type_t type, uint field_index, jit_nuint offset);

int  jit_type_get_kind(jit_type_t type);

jit_nuint  jit_type_get_size(jit_type_t type);

jit_nuint  jit_type_get_alignment(jit_type_t type);

uint  jit_type_num_fields(jit_type_t type);


jit_type_t  jit_type_get_field(jit_type_t type, uint field_index);


jit_nuint  jit_type_get_offset(jit_type_t type, uint field_index);

char * jit_type_get_name(jit_type_t type, uint index);


uint  jit_type_find_name(jit_type_t type, char *name);

uint  jit_type_num_params(jit_type_t type);

jit_type_t  jit_type_get_return(jit_type_t type);


jit_type_t  jit_type_get_param(jit_type_t type, uint param_index);

jit_abi_t  jit_type_get_abi(jit_type_t type);

jit_type_t  jit_type_get_ref(jit_type_t type);

jit_type_t  jit_type_get_tagged_type(jit_type_t type);


void  jit_type_set_tagged_type(jit_type_t type, jit_type_t underlying, int incref);

int  jit_type_get_tagged_kind(jit_type_t type);

void * jit_type_get_tagged_data(jit_type_t type);


void  jit_type_set_tagged_data(jit_type_t type, void *data, jit_meta_free_func free_func);

int  jit_type_is_primitive(jit_type_t type);

int  jit_type_is_struct(jit_type_t type);

int  jit_type_is_union(jit_type_t type);

int  jit_type_is_signature(jit_type_t type);

int  jit_type_is_pointer(jit_type_t type);

int  jit_type_is_tagged(jit_type_t type);

jit_nuint  jit_type_best_alignment();

jit_type_t  jit_type_normalize(jit_type_t type);

jit_type_t  jit_type_remove_tags(jit_type_t type);

jit_type_t  jit_type_promote_int(jit_type_t type);

int  jit_type_return_via_pointer(jit_type_t type);

int  jit_type_has_tag(jit_type_t type, int kind);






/* Converted to D from C:\libjit\include\jit\jit-unwind.h by htod */
//:module jit-unwind;



int  jit_unwind_init(jit_unwind_context_t *unwind, jit_context_t context);

void  jit_unwind_free(jit_unwind_context_t *unwind);


int  jit_unwind_next(jit_unwind_context_t *unwind);

int  jit_unwind_next_pc(jit_unwind_context_t *unwind);

void * jit_unwind_get_pc(jit_unwind_context_t *unwind);


int  jit_unwind_jump(jit_unwind_context_t *unwind, void *pc);


jit_function_t  jit_unwind_get_function(jit_unwind_context_t *unwind);

uint  jit_unwind_get_offset(jit_unwind_context_t *unwind);






/* Converted to D from C:\libjit\include\jit\jit-util.h by htod */
//:module jit-util;






/*
 * Memory allocation routines.
 */

void * jit_malloc(uint size);

void * jit_calloc(uint num, uint size);

void * jit_realloc(void *ptr, uint size);

void  jit_free(void *ptr);




/*
 * Memory set/copy/compare routines.
 */

void * jit_memset(void *dest, int ch, uint len);

void * jit_memcpy(void *dest, void *src, uint len);

void * jit_memmove(void *dest, void *src, uint len);

int  jit_memcmp(void *s1, void *s2, uint len);

void * jit_memchr(void *str, int ch, uint len);

/*
 * String routines.
 */

uint  jit_strlen(char *str);

char * jit_strcpy(char *dest, char *src);

char * jit_strcat(char *dest, char *src);

char * jit_strncpy(char *dest, char *src, uint len);

char * jit_strdup(char *str);

char * jit_strndup(char *str, uint len);

int  jit_strcmp(char *str1, char *str2);


int  jit_strncmp(char *str1, char *str2, uint len);

int  jit_stricmp(char *str1, char *str2);


int  jit_strnicmp(char *str1, char *str2, uint len);

char * jit_strchr(char *str, int ch);

char * jit_strrchr(char *str, int ch);

int  jit_sprintf(char *str, char *format,...);


int  jit_snprintf(char *str, uint len, char *format,...);






/* Converted to D from C:\libjit\include\jit\jit-value.h by htod */
//:module jit-value;



/*
 * Full struction that can hold a constant of any type.
 */


/*
 * External function declarations.
 */

jit_value_t  jit_value_create(jit_function_t func, jit_type_t type);


jit_value_t  jit_value_create_nint_constant(jit_function_t func, jit_type_t type, jit_nint const_value);


jit_value_t  jit_value_create_long_constant(jit_function_t func, jit_type_t type, jit_long const_value);



jit_value_t  jit_value_create_float32_constant(jit_function_t func, jit_type_t type, jit_float32 const_value);



jit_value_t  jit_value_create_float64_constant(jit_function_t func, jit_type_t type, jit_float64 const_value);



jit_value_t  jit_value_create_nfloat_constant(jit_function_t func, jit_type_t type, jit_nfloat const_value);


jit_value_t  jit_value_create_constant(jit_function_t func, jit_constant_t *const_value);


jit_value_t  jit_value_get_param(jit_function_t func, uint param);

jit_value_t  jit_value_get_struct_pointer(jit_function_t func);

int  jit_value_is_temporary(jit_value_t value);

int  jit_value_is_local(jit_value_t value);

int  jit_value_is_constant(jit_value_t value);

int  jit_value_is_parameter(jit_value_t value);

void  jit_value_ref(jit_function_t func, jit_value_t value);

void  jit_value_set_volatile(jit_value_t value);

int  jit_value_is_volatile(jit_value_t value);

void  jit_value_set_addressable(jit_value_t value);

int  jit_value_is_addressable(jit_value_t value);

jit_type_t  jit_value_get_type(jit_value_t value);

jit_function_t  jit_value_get_function(jit_value_t value);

jit_block_t  jit_value_get_block(jit_value_t value);

jit_context_t  jit_value_get_context(jit_value_t value);

jit_constant_t  jit_value_get_constant(jit_value_t value);

jit_nint  jit_value_get_nint_constant(jit_value_t value);

jit_long  jit_value_get_long_constant(jit_value_t value);

jit_float32  jit_value_get_float32_constant(jit_value_t value);

jit_float64  jit_value_get_float64_constant(jit_value_t value);

jit_nfloat  jit_value_get_nfloat_constant(jit_value_t value);

int  jit_value_is_true(jit_value_t value);



int  jit_constant_convert(jit_constant_t *result, jit_constant_t *value, jit_type_t type, int overflow_check);






/* Converted to D from C:\libjit\include\jit\jit-vmem.h by htod */
//:module jit-vmem;






void  jit_vmem_init();


jit_uint  jit_vmem_page_size();

jit_nuint  jit_vmem_round_up(jit_nuint value);

jit_nuint  jit_vmem_round_down(jit_nuint value);


void * jit_vmem_reserve(jit_uint size);

void * jit_vmem_reserve_committed(jit_uint size, jit_prot_t prot);

int  jit_vmem_release(void *addr, jit_uint size);


int  jit_vmem_commit(void *addr, jit_uint size, jit_prot_t prot);

int  jit_vmem_decommit(void *addr, jit_uint size);


int  jit_vmem_protect(void *addr, jit_uint size, jit_prot_t prot);






