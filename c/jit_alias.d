module c.jit_alias;
import c.jit_func, c.jit_const;

extern (C):

struct jit_closure_va_list;
struct _jit_context       ;
struct _jit_function      ;
struct _jit_block         ;
struct _jit_insn          ;
struct _jit_value         ;
struct _jit_type          ;
struct jit_stack_trace    ;
struct jit_debugger       ;
struct jit_readelf        ;
struct jit_writeelf       ;
struct jit_memory_manager ;
struct _jit_meta          ;
struct jitom_class        ;
struct jitom_field        ;
struct jitom_method       ;

alias void  function(jit_type_t signature, void *result, void **args, void *user_data)jit_closure_func;

/*
 * Opaque type for accessing vararg parameters on closures.
 */

alias jit_closure_va_list *jit_closure_va_list_t;



alias _jit_context *jit_context_t;

/*
 * Opaque structure that represents a function.
 */

alias _jit_function *jit_function_t;

/*
 * Opaque structure that represents a block.
 */

alias _jit_block *jit_block_t;

/*
 * Opaque structure that represents an instruction.
 */

alias _jit_insn *jit_insn_t;

/*
 * Opaque structure that represents a value.
 */

alias _jit_value *jit_value_t;

/*
 * Opaque structure that represents a type descriptor.
 */

alias _jit_type *jit_type_t;

/*
 * Opaque type that represents an exception stack trace.
 */

alias jit_stack_trace *jit_stack_trace_t;

/*
 * Block label identifier.
 */

alias jit_nuint jit_label_t;

/*
 * Value that represents an undefined label.
 */


/*
 * Value that represents an undefined offset.
 */


/*
 * Function that is used to free user-supplied metadata.
 */

alias void  function(void *data)jit_meta_free_func;

/*
 * Function that is used to compile a function on demand.
 * Returns zero if the compilation process failed for some reason.
 */

alias int  function(jit_function_t func)jit_on_demand_func;

/*
 * Function that is used to control on demand compilation.
 * Typically, it should take care of the context locking and unlocking,
 * calling function's on demand compiler, and final compilation.
 */

alias void * function(jit_function_t func)jit_on_demand_driver_func;


alias jit_debugger *jit_debugger_t;

alias jit_nint jit_debugger_thread_id_t;

alias jit_nint jit_debugger_breakpoint_id_t;

alias void  function(jit_function_t func, jit_nint data1, jit_nint data2)jit_debugger_hook_func;


alias char jit_sbyte;

alias ubyte jit_ubyte;

alias short jit_short;

alias ushort jit_ushort;

alias int jit_int;

alias uint jit_uint;

alias int jit_nint;

alias uint jit_nuint;





alias long jit_long;

alias ulong jit_ulong;


alias float jit_float32;

alias double jit_float64;

alias double jit_nfloat;

alias void *jit_ptr;



alias void *jit_dynlib_handle_t;


/*
 * Opaque types that represent a loaded ELF binary in read or write mode.
 */


alias jit_readelf *jit_readelf_t;

alias jit_writeelf *jit_writeelf_t;



alias void * function(int exception_type)jit_exception_func;






/* TODO: the proper place for this is jit-def.h and it's going to depend on the platform. */


alias uint jit_size_t;


alias void *jit_memory_context_t;

alias void *jit_function_info_t;


alias jit_memory_manager *jit_memory_manager_t;


alias _jit_meta *jit_meta_t;




/*
 * Opaque types that describe object model elements.
 */


alias jit_objmodel *jit_objmodel_t;

alias jitom_class *jitom_class_t;

alias jitom_field *jitom_field_t;

alias jitom_method *jitom_method_t;





alias JIT_OPCODE_DEST_INT JIT_OPCODE_DEST_PTR;

alias JIT_OPCODE_SRC1_INT JIT_OPCODE_SRC1_PTR;

alias JIT_OPCODE_SRC2_INT JIT_OPCODE_SRC2_PTR;



/*
 * Pre-defined type descriptors.
 */


extern jit_type_t jit_type_void;

extern jit_type_t jit_type_sbyte;

extern jit_type_t jit_type_ubyte;

extern jit_type_t jit_type_short;

extern jit_type_t jit_type_ushort;

extern jit_type_t jit_type_int;

extern jit_type_t jit_type_uint;

extern jit_type_t jit_type_nint;

extern jit_type_t jit_type_nuint;

extern jit_type_t jit_type_long;

extern jit_type_t jit_type_ulong;

extern jit_type_t jit_type_float32;

extern jit_type_t jit_type_float64;

extern jit_type_t jit_type_nfloat;

extern jit_type_t jit_type_void_ptr;

/*
 * Type descriptors for the system "char", "int", "long", etc types.
 * These are defined to one of the above values.
 */

extern jit_type_t jit_type_sys_bool;

extern jit_type_t jit_type_sys_char;

extern jit_type_t jit_type_sys_schar;

extern jit_type_t jit_type_sys_uchar;

extern jit_type_t jit_type_sys_short;

extern jit_type_t jit_type_sys_ushort;

extern jit_type_t jit_type_sys_int;

extern jit_type_t jit_type_sys_uint;

extern jit_type_t jit_type_sys_long;

extern jit_type_t jit_type_sys_ulong;

extern jit_type_t jit_type_sys_longlong;

extern jit_type_t jit_type_sys_ulonglong;

extern jit_type_t jit_type_sys_float;

extern jit_type_t jit_type_sys_double;

extern jit_type_t jit_type_sys_long_double;





/*
 * Some obsolete opcodes that have been removed because they are duplicates
 * of other opcodes.
 */


alias JIT_OP_FEQ JIT_OP_FEQ_INV;

alias JIT_OP_FNE JIT_OP_FNE_INV;

alias JIT_OP_DEQ JIT_OP_DEQ_INV;

alias JIT_OP_DNE JIT_OP_DNE_INV;

alias JIT_OP_NFEQ JIT_OP_NFEQ_INV;

alias JIT_OP_NFNE JIT_OP_NFNE_INV;

alias JIT_OP_BR_FEQ JIT_OP_BR_FEQ_INV;

alias JIT_OP_BR_FNE JIT_OP_BR_FNE_INV;

alias JIT_OP_BR_DEQ JIT_OP_BR_DEQ_INV;

alias JIT_OP_BR_DNE JIT_OP_BR_DNE_INV;

alias JIT_OP_BR_NFEQ JIT_OP_BR_NFEQ_INV;

alias JIT_OP_BR_NFNE JIT_OP_BR_NFNE_INV;


/*
 * Declare a stack crawl mark variable.  The address of this variable
 * can be passed to "jit_frame_contains_crawl_mark" to determine
 * if a frame contains the mark.
 */

struct _N1
{
    void *mark;
}
alias _N1 jit_crawl_mark_t;




struct _jit_arch_frame
{
    _jit_arch_frame_t *next_frame;
    void *return_address;
}
alias _jit_arch_frame _jit_arch_frame_t;




struct jit_debugger_event
{
    int type;
    jit_debugger_thread_id_t thread;
    jit_function_t function_;
    jit_nint data1;
    jit_nint data2;
    jit_debugger_breakpoint_id_t id;
    jit_stack_trace_t trace;
}
alias jit_debugger_event jit_debugger_event_t;




struct jit_debugger_breakpoint_info
{
    int flags;
    jit_debugger_thread_id_t thread;
    jit_function_t function_;
    jit_nint data1;
    jit_nint data2;
}
alias jit_debugger_breakpoint_info *jit_debugger_breakpoint_info_t;





struct _N11
{
    jit_type_t return_type;
    jit_type_t ptr_result_type;
    jit_type_t arg1_type;
    jit_type_t arg2_type;
}

alias _N11 jit_intrinsic_descr_t;

/*
 * Structure for iterating over the instructions in a block.
 * This should be treated as opaque.
 */






struct _N22
{
    jit_block_t block;
    int posn;
}
alias _N22 jit_insn_iter_t;





struct jit_objmodel
{
    uint size;
    void *reserved0;
    void *reserved1;
    void *reserved2;
    void *reserved3;
    void  function(jit_objmodel_t model)destroy_model;
    jitom_class_t  function(jit_objmodel_t model, char *name)get_class_by_name;
    char * function(jit_objmodel_t model, jitom_class_t klass)class_get_name;
    int  function(jit_objmodel_t model, jitom_class_t klass)class_get_modifiers;
    jit_type_t  function(jit_objmodel_t model, jitom_class_t klass)class_get_type;
    jit_type_t  function(jit_objmodel_t model, jitom_class_t klass)class_get_value_type;
    jitom_class_t  function(jit_objmodel_t model, jitom_class_t klass)class_get_primary_super;
    jitom_class_t * function(jit_objmodel_t model, jitom_class_t klass, uint *num)class_get_all_supers;
    jitom_class_t * function(jit_objmodel_t model, jitom_class_t klass, uint *num)class_get_interfaces;
    jitom_field_t * function(jit_objmodel_t model, jitom_class_t klass, uint *num)class_get_fields;
    jitom_method_t * function(jit_objmodel_t model, jitom_class_t klass, uint *num)class_get_methods;
    jit_value_t  function(jit_objmodel_t model, jitom_class_t klass, jitom_method_t ctor, jit_function_t func, jit_value_t *args, uint num_args, int flags)class_new;
    jit_value_t  function(jit_objmodel_t model, jitom_class_t klass, jitom_method_t ctor, jit_function_t func, jit_value_t *args, uint num_args, int flags)class_new_value;
    int  function(jit_objmodel_t model, jitom_class_t klass, jit_value_t obj_value)class_delete;
    int  function(jit_objmodel_t model, jitom_class_t klass, jit_value_t obj_value)class_add_ref;
    char * function(jit_objmodel_t model, jitom_class_t klass, jitom_field_t field)field_get_name;
    jit_type_t  function(jit_objmodel_t model, jitom_class_t klass, jitom_field_t field)field_get_type;
    int  function(jit_objmodel_t model, jitom_class_t klass, jitom_field_t field)field_get_modifiers;
    jit_value_t  function(jit_objmodel_t model, jitom_class_t klass, jitom_field_t field, jit_function_t func, jit_value_t obj_value)field_load;
    jit_value_t  function(jit_objmodel_t model, jitom_class_t klass, jitom_field_t field, jit_function_t func, jit_value_t obj_value)field_load_address;
    int  function(jit_objmodel_t model, jitom_class_t klass, jitom_field_t field, jit_function_t func, jit_value_t obj_value, jit_value_t value)field_store;
    char * function(jit_objmodel_t model, jitom_class_t klass, jitom_method_t method)method_get_name;
    jit_type_t  function(jit_objmodel_t model, jitom_class_t klass, jitom_method_t method)method_get_type;
    int  function(jit_objmodel_t model, jitom_class_t klass, jitom_method_t method)method_get_modifiers;
    jit_value_t  function(jit_objmodel_t model, jitom_class_t klass, jitom_method_t method, jit_function_t func, jit_value_t *args, uint num_args, int flags)method_invoke;
    jit_value_t  function(jit_objmodel_t model, jitom_class_t klass, jitom_method_t method, jit_function_t func, jit_value_t *args, uint num_args, int flags)method_invoke_virtual;
}


struct _N12
{
    void *frame;
    void *cache;
    jit_context_t context;
}

alias _N12 jit_unwind_context_t;



union _N2
{
    void *ptr_value;
    jit_int int_value;
    jit_uint uint_value;
    jit_nint nint_value;
    jit_nuint nuint_value;
    jit_long long_value;
    jit_ulong ulong_value;
    jit_float32 float32_value;
    jit_float64 float64_value;
    jit_nfloat nfloat_value;
}


struct _N111
{
    jit_type_t type;
    _N2 un;
}

alias _N111 jit_constant_t;












