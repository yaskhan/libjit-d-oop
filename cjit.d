module cjit;


//import c.jit_alias;
import c.jit_const;
import c.jit_f;

alias sprintf                           = jit_sprintf                                ;
alias snprintf                          = jit_snprintf                               ;

/** Working with basic blocks in the JIT */
interface block {
	alias get_function                  =    jit_block_get_function                  ; ///Get the function that a particular <var>block</var> belongs to. 
	alias get_context                   =    jit_block_get_context                   ; ///Get the context that a particular <var>block</var> belongs to. 
	alias get_label                     =    jit_block_get_label                     ; ///Get the label associated with a block. 
	alias get_next_label                =    jit_block_get_next_label                ; ///Get the next label associated with a block. 
	alias next                          =    jit_block_next                          ; ///Iterate over the blocks in a function, in order of their creation. The <var>previous</var> argument should be NULL on the first call. This function will return NULL if there are no further blocks to iterate. 
	alias previous                      =    jit_block_previous                      ; ///Iterate over the blocks in a function, in reverse order of their creation. The <var>previous</var> argument should be NULL on the first call. This function will return NULL if there are no further blocks to iterate. 
	alias from_label                    =    jit_block_from_label                    ; ///Get the block that corresponds to a particular <var>label</var>. Returns NULL if there is no block associated with the label. 
	alias set_meta                      =    jit_block_set_meta                      ; ///Tag a block with some metadata.  Returns zero if out of memory. If the <var>type</var> already has some metadata associated with it, then the previous value will be freed.  Metadata may be used to store dependency graphs, branch prediction information, or any other information that is useful to optimizers or code generators. </p> <p>Metadata type values of 10000 or greater are reserved for internal use. 
	alias get_meta                      =    jit_block_get_meta                      ;
	alias free_meta                     =    jit_block_free_meta                     ; ///Free metadata of a specific type on a block.  Does nothing if the <var>type</var> does not have any metadata associated with it. 
	alias is_reachable                  =    jit_block_is_reachable                  ; ///Determine if a block is reachable from some other point in its function.  Unreachable blocks can be discarded in their entirety.  If the JIT is uncertain as to whether a block is reachable, or it does not wish to perform expensive flow analysis to find out, then it will err on the side of caution and assume that it is reachable. 
	alias ends_in_dead                  =    jit_block_ends_in_dead                  ; ///Determine if a block ends in a &quot;dead&quot; marker.  That is, control will not fall out through the end of the block. 
	alias current_is_dead               =    jit_block_current_is_dead               ; ///Determine if the current point in the function is dead.  That is, there are no existing branches or fall-throughs to this point. This differs slightly from <code>jit_block_ends_in_dead</code> in that this can skip past zero-length blocks that may not appear to be dead to find the dead block at the head of a chain of empty blocks. 
}

/** 
Stack walking

stack interface allow the caller to walk up the native execution stack, inspecting frames and return addresses
*/
interface stack {
	/**
	 * Get the frame address for a frame which is "n" levels up the stack.
	 * A level value of zero indicates the current frame.
	 */
	alias get_frame_address  = _jit_get_frame_address;

	/**
	 * Get the next frame up the stack from a specified frame.
	 * Returns NULL if it isn't possible to retrieve the next frame.
	 */
	alias get_next_frame_address = _jit_get_next_frame_address;

	/**
	 * Get the return address for a specific frame.
	 */
	alias get_return_address = _jit_get_return_address;


	alias  frame_contains_crawl_mark        = jit_frame_contains_crawl_mark              ; ///Determine if the stack frame that resides just above <var>frame</var> contains a local variable whose address is <var>mark</var>.  The <var>mark</var> parameter should be the address of a local variable that is declared with <code>jit_declare_crawl_mark(<var>name</var>)</code>. </p> <p>Crawl marks are used internally by libjit to determine where control passes between JIT&rsquo;ed and ordinary code during an exception throw. They can also be used to mark frames that have special security conditions associated with them. 
}
/**
* The libjit library provides an interface to the traditional system malloc routines. 
* All heap allocation in libjit goes through these functions. 
* If you need to perform some other kind of memory allocation, 
* you can replace these functions with your own versions.
*/
interface memory {
	alias alloc                         = jit_malloc                                 ;
	alias calloc                        = jit_calloc                                 ; ///Allocate <code><var>num</var> * <var>size</var></code> bytes of memory from the heap and clear them to zero. 
	alias realloc                       = jit_realloc                                ; ///Re-allocate the memory at <var>ptr</var> to be <var>size</var> bytes in size. The memory block at <var>ptr</var> must have been allocated by a previous call to <code>jit_malloc</code>, <code>jit_calloc</code>, or <code>jit_realloc</code>. 
	alias free                          = jit_free                                   ; ///Free the memory at <var>ptr</var>.  It is safe to pass a NULL pointer. 
	alias set                           = jit_memset                                 ; ///Set the <var>len</var> bytes at <var>dest</var> to the value <var>ch</var>. Returns <var>dest</var>. 
	alias copy                          = jit_memcpy                                 ; ///Copy the <var>len</var> bytes at <var>src</var> to <var>dest</var>.  Returns <var>dest</var>.  The behavior is undefined if the blocks overlap (use <var>jit_memmove</var> instead for that case). 
	alias move                          = jit_memmove                                ; ///Copy the <var>len</var> bytes at <var>src</var> to <var>dest</var> and handle overlapping blocks correctly.  Returns <var>dest</var>. 
	alias cmp                           = jit_memcmp                                 ; ///Compare <var>len</var> bytes at <var>s1</var> and <var>s2</var>, returning a negative, zero, or positive result depending upon their relationship.  It is system-specific as to whether this function uses signed or unsigned byte comparisons. 
	alias chr                           = jit_memchr                                 ; ///Search the <var>len</var> bytes at <var>str</var> for the first instance of the value <var>ch</var>.  Returns the location of <var>ch</var> if it was found, or NULL if it was not found. 
}

/**
* The following functions are provided to manipulate NULL-terminated strings. 
* It is highly recommended that you use these functions in preference to system functions, 
* because the corresponding system functions are extremely non-portable.
*/
interface string_ {
	alias len                            = jit_strlen                                 ; ///Returns the length of <var>str</var>. 
	alias copy                           = jit_strcpy                                 ; ///Copy the string at <var>src</var> to <var>dest</var>.  Returns <var>dest</var>. 
	alias cat                            = jit_strcat                                 ; ///Copy the string at <var>src</var> to the end of the string at <var>dest</var>. Returns <var>dest</var>. 
	alias ncpy                           = jit_strncpy                                ; ///Copy at most <var>len</var> characters from the string at <var>src</var> to <var>dest</var>.  Returns <var>dest</var>. 
	alias dup                            = jit_strdup                                 ; ///Allocate a block of memory using <code>jit_malloc</code> and copy <var>str</var> into it.  Returns NULL if <var>str</var> is NULL or there is insufficient memory to perform the <code>jit_malloc</code> operation. 
	alias ndup                           = jit_strndup                                ; ///Allocate a block of memory using <code>jit_malloc</code> and copy at most <var>len</var> characters of <var>str</var> into it.  The copied string is then NULL-terminated.  Returns NULL if <var>str</var> is NULL or there is insufficient memory to perform the <code>jit_malloc</code> operation. 
	alias cmp                            = jit_strcmp                                 ; ///Compare the two strings <var>str1</var> and <var>str2</var>, returning a negative, zero, or positive value depending upon their relationship. 
	alias ncmp                           = jit_strncmp                                ; ///Compare the two strings <var>str1</var> and <var>str2</var>, returning a negative, zero, or positive value depending upon their relationship. At most <var>len</var> characters are compared. 
	alias icmp                           = jit_stricmp                                ; ///Compare the two strings <var>str1</var> and <var>str2</var>, returning a negative, zero, or positive value depending upon their relationship. Instances of the English letters A to Z are converted into their lower case counterparts before comparison. </p> <p>Note: this function is guaranteed to use English case comparison rules, no matter what the current locale is set to, making it suitable for comparing token tags and simple programming language identifiers. </p> <p>Locale-sensitive string comparison is complicated and usually specific to the front end language or its supporting runtime library.  We deliberately chose not to handle this in <code>libjit</code>. 
	alias nicmp                          = jit_strnicmp                               ; ///Compare the two strings <var>str1</var> and <var>str2</var>, returning a negative, zero, or positive value depending upon their relationship. At most <var>len</var> characters are compared.  Instances of the English letters A to Z are converted into their lower case counterparts before comparison. 
	alias chr                            = jit_strchr                                 ; ///Search <var>str</var> for the first occurrence of <var>ch</var>.  Returns the address where <var>ch</var> was found, or NULL if not found. 
	alias rchr                           = jit_strrchr                                ; ///Search <var>str</var> for the first occurrence of <var>ch</var>, starting at the end of the string.  Returns the address where <var>ch</var> was found, or NULL if not found. 
}

/**
* Function application and closures
* 
* Sometimes all you have for a function is a pointer to it and a dynamic 
* description of its arguments. Calling such a function can be extremely 
* difficult in standard C. The routines in this section, particularly jit_apply, 
* provide a convenient interface for doing this. 
* 
* At other times, you may wish to wrap up one of your own dynamic functions in such 
* a way that it appears to be a regular C function. This is performed with jit_closure_create.
*/
interface closure {
	alias create                        =    jit_closure_create                      ; ///Create a closure from a function signature, a closure handling function, and a user data value.  Returns NULL if out of memory, or if closures are not supported.  The <var>func</var> argument should have the following prototype: </p> <table><tr><td>&nbsp;</td><td><code>void func(jit_type_t signature, void *result, void **args, void *user_data); <code></td></tr></table>  <p>If the closure signature includes variable arguments, then <code>args</code> will contain pointers to the fixed arguments, followed by a <code>jit_closure_va_list_t</code> value for accessing the remainder of the arguments. </p> <p>The memory for the closure will be reclaimed when the <var>context</var> is destroyed. 
	alias get_nint                      =    jit_closure_va_get_nint                 ; ///Get the next value of a specific type from a closure&rsquo;s variable arguments.
	alias get_nuint                     =    jit_closure_va_get_nuint                ; ///Get the next value of a specific type from a closure&rsquo;s variable arguments.
	alias get_long                      =    jit_closure_va_get_long                 ; ///Get the next value of a specific type from a closure&rsquo;s variable arguments.
	alias get_ulong                     =    jit_closure_va_get_ulong                ; ///Get the next value of a specific type from a closure&rsquo;s variable arguments.
	alias get_float32                   =    jit_closure_va_get_float32              ; ///Get the next value of a specific type from a closure&rsquo;s variable arguments.
	alias get_float64                   =    jit_closure_va_get_float64              ; ///Get the next value of a specific type from a closure&rsquo;s variable arguments.
	alias get_nfloat                    =    jit_closure_va_get_nfloat               ; ///Get the next value of a specific type from a closure&rsquo;s variable arguments.
	alias get_ptr                       =    jit_closure_va_get_ptr                  ; ///Get the next value of a specific type from a closure&rsquo;s variable arguments.
	alias get_struct                    =    jit_closure_va_get_struct               ; ///Get a structure or union value of a specific <var>type</var> from a closure&rsquo;s variable arguments, and copy it into <var>buf</var>. 
	
	alias supports                      =    jit_supports_closures                   ; ///Determine if this platform has support for closures. 
	alias get_size                      =    jit_get_closure_size                    ;
	alias get_alignment                 =    jit_get_closure_alignment               ;
}

/** The following functions are available to create, manage, and ultimately destroy JIT contexts */
interface context {
	alias create                        =    jit_context_create                      ; ///Create a new context block for the JIT.  Returns NULL if out of memory. 
	alias destroy                       =    jit_context_destroy                     ; ///Destroy a JIT context block and everything that is associated with it. It is very important that no threads within the program are currently running compiled code when this function is called. 
	alias build_start                   =    jit_context_build_start                 ; ///This routine should be called before you start building a function to be JIT&rsquo;ed.  It acquires a lock on the context to prevent other threads from accessing the build process, since only one thread can be performing build operations at any one time. 
	alias build_end                     =    jit_context_build_end                   ; ///This routine should be called once you have finished building and compiling a function and are ready to resume normal execution. This routine will release the build lock, allowing other threads that are waiting on the builder to proceed. 
	alias set_on_demand_driver          =    jit_context_set_on_demand_driver        ; ///Specify the C function to be called to drive on-demand compilation. </p> <p>When on-demand compilation is requested the default driver provided by <code>libjit</code> takes the following actions: </p> <ol> <li> The context is locked by calling <code>jit_context_build_start</code>.  </li><li> If the function has already been compiled, <code>libjit</code> unlocks the context and returns immediately.  This can happen because of race conditions between threads: some other thread may have beaten us to the on-demand compiler.  </li><li> The user&rsquo;s on-demand compiler is called.  It is responsible for building the instructions in the function&rsquo;s body.  It should return one of the result codes <code>JIT_RESULT_OK</code>, <code>JIT_RESULT_COMPILE_ERROR</code>, or <code>JIT_RESULT_OUT_OF_MEMORY</code>.  </li><li> If the user&rsquo;s on-demand function hasn&rsquo;t already done so, <code>libjit</code> will call <code>jit_function_compile</code> to compile the function.  </li><li> The context is unlocked by calling <code>jit_context_build_end</code> and <code>libjit</code> jumps to the newly-compiled entry point.  If an error occurs, a built-in exception of type <code>JIT_RESULT_COMPILE_ERROR</code> or <code>JIT_RESULT_OUT_OF_MEMORY</code> will be thrown.  </li><li> The entry point of the compiled function is returned from the driver. </li></ol>  <p>You may need to provide your own driver if some additional actions are required. </p> </dd></dl>  <dl> <dt>jit_context_set_memory_manager <dd><p>Specify the memory manager plug-in. 
	alias set_memory_manager            =    jit_context_set_memory_manager          ;
	alias set_meta                      =    jit_context_set_meta                    ; ///Tag a context with some metadata.  Returns zero if out of memory. </p> <p>Metadata may be used to store dependency graphs, branch prediction information, or any other information that is useful to optimizers or code generators.  It can also be used by higher level user code to store information about the context that is specific to the virtual machine or language. </p> <p>If the <var>type</var> already has some metadata associated with it, then the previous value will be freed. 
	alias set_meta_numeric              =    jit_context_set_meta_numeric            ; ///Tag a context with numeric metadata.  Returns zero if out of memory. This function is more convenient for accessing the context&rsquo;s special option values: </p>  <dd> </dd> <dt> <code>JIT_OPTION_CACHE_LIMIT</code></dt> <dd><p>A numeric option that indicates the maximum size in bytes of the function cache.  If set to zero (the default), the function cache is unlimited in size. </p>  </dd> <dt> <code>JIT_OPTION_CACHE_PAGE_SIZE</code></dt> <dd><p>A numeric option that indicates the size in bytes of a single page in the function cache.  Memory is allocated for the cache in chunks of this size.  If set to zero, the cache page size is set to an internally-determined default (usually 128k).  The cache page size also determines the maximum size of a single compiled function. </p>  </dd> <dt> <code>JIT_OPTION_PRE_COMPILE</code></dt> <dd><p>A numeric option that indicates that this context is being used for pre-compilation if it is set to a non-zero value.  Code within pre-compiled contexts cannot be executed directly.  Instead, they can be written out to disk in ELF format to be reloaded at some future time. </p>  </dd> <dt> <code>JIT_OPTION_DONT_FOLD</code></dt> <dd><p>A numeric option that disables constant folding when it is set to a non-zero value.  This is useful for debugging, as it forces <code>libjit</code> to always execute constant expressions at run time, instead of at compile time. </p>  </dd> <dt> <code>JIT_OPTION_POSITION_INDEPENDENT</code></dt> <dd><p>A numeric option that forces generation of position-independent code (PIC) if it is set to a non-zero value. This may be mainly useful for pre-compiled contexts. </p></dd> </dl>  <p>Metadata type values of 10000 or greater are reserved for internal use. 
	alias get_meta                      =    jit_context_get_meta                    ; ///Get the metadata associated with a particular tag.  Returns NULL if <var>type</var> does not have any metadata associated with it. 
	alias get_meta_numeric              =    jit_context_get_meta_numeric            ; ///Get the metadata associated with a particular tag.  Returns zero if <var>type</var> does not have any metadata associated with it. This version is more convenient for the pre-defined numeric option values. 
	alias free_meta                     =    jit_context_free_meta                   ; ///Free metadata of a specific type on a context.  Does nothing if the <var>type</var> does not have any metadata associated with it. 
}

/** Handling exceptions */
interface exception {
	alias get_last                      =    jit_exception_get_last                  ; ///Get the last exception object that occurred on this thread, or NULL if there is no exception object on this thread.  As far as <code>libjit</code> is concerned, an exception is just a pointer.  The precise meaning of the data at the pointer is determined by the front end. 
	alias get_last_and_clear            =    jit_exception_get_last_and_clear        ; ///Get the last exception object that occurred on this thread and also clear the exception state to NULL.  This combines the effect of both <code>jit_exception_get_last</code> and <code>jit_exception_clear_last</code>. 
	alias set_last                      =    jit_exception_set_last                  ; ///Set the last exception object that occurred on this thread, so that it can be retrieved by a later call to <code>jit_exception_get_last</code>. This is normally used by <code>jit_function_apply</code> to save the exception object before returning to regular code. 
	alias clear_last                    =    jit_exception_clear_last                ; ///Clear the last exception object that occurred on this thread. This is equivalent to calling <code>jit_exception_set_last</code> with a parameter of NULL. 
	alias Throw                         =    jit_exception_throw                     ; ///Throw an exception object within the current thread.  As far as <code>libjit</code> is concerned, the exception object is just a pointer. The precise meaning of the data at the pointer is determined by the front end. </p> <p>Note: as an exception object works its way back up the stack, it may be temporarily stored in memory that is not normally visible to a garbage collector.  The front-end is responsible for taking steps to &quot;pin&quot; the object so that it is uncollectable until explicitly copied back into a location that is visible to the collector once more. 
	alias builtin                       =    jit_exception_builtin                   ; ///This function is called to report a builtin exception. The JIT will automatically embed calls to this function wherever a builtin exception needs to be reported. </p> <p>When a builtin exception occurs, the current thread&rsquo;s exception handler is called to construct an appropriate object, which is then thrown. </p> <p>If there is no exception handler set, or the handler returns NULL, then <code>libjit</code> will print an error message to stderr and cause the program to exit with a status of 1.  You normally don&rsquo;t want this behavior and you should override it if possible. </p> <p>The following builtin exception types are currently supported: </p> <dd> </dd> <dt> <code>JIT_RESULT_OK</code></dt> <dd><p>The operation was performed successfully (value is 1). </p>  </dd> <dt> <code>JIT_RESULT_OVERFLOW</code></dt> <dd><p>The operation resulted in an overflow exception (value is 0). </p>  </dd> <dt> <code>JIT_RESULT_ARITHMETIC</code></dt> <dd><p>The operation resulted in an arithmetic exception.  i.e. an attempt was made to divide the minimum integer value by -1 (value is -1). </p>  </dd> <dt> <code>JIT_RESULT_DIVISION_BY_ZERO</code></dt> <dd><p>The operation resulted in a division by zero exception (value is -2). </p>  </dd> <dt> <code>JIT_RESULT_COMPILE_ERROR</code></dt> <dd><p>An error occurred when attempting to dynamically compile a function (value is -3). </p>  </dd> <dt> <code>JIT_RESULT_OUT_OF_MEMORY</code></dt> <dd><p>The system ran out of memory while performing an operation (value is -4). </p>  </dd> <dt> <code>JIT_RESULT_NULL_REFERENCE</code></dt> <dd><p>An attempt was made to dereference a NULL pointer (value is -5). </p>  </dd> <dt> <code>JIT_RESULT_NULL_FUNCTION</code></dt> <dd><p>An attempt was made to call a function with a NULL function pointer (value is -6). </p>  </dd> <dt> <code>JIT_RESULT_CALLED_NESTED</code></dt> <dd><p>An attempt was made to call a nested function from a non-nested context (value is -7). </p>  </dd> <dt> <code>JIT_RESULT_OUT_OF_BOUNDS</code></dt> <dd><p>The operation resulted in an out of bounds array access (value is -8). </p>  </dd> <dt> <code>JIT_RESULT_UNDEFINED_LABEL</code></dt> <dd><p>A branch operation used a label that was not defined anywhere in the function (value is -9). </p></dd> </dl> </dd></dl>  <dl> <dt>jit_exception_set_handler <dd><p>Set the builtin exception handler for the current thread. Returns the previous exception handler. 
	alias set_handler                   =    jit_exception_set_handler               ;
	alias get_handler                   =    jit_exception_get_handler               ; ///Get the builtin exception handler for the current thread. 
	alias get_stack_trace               =    jit_exception_get_stack_trace           ; ///Create an object that represents the current call stack. This is normally used to indicate the location of an exception. Returns NULL if a stack trace is not available, or there is insufficient memory to create it. 
	
	interface stackTrace {           
		alias get_size                  =    jit_stack_trace_get_size                ; ///Get the size of a stack trace. 
		alias get_function              =    jit_stack_trace_get_function            ; ///Get the function that is at position <var>posn</var> within a stack trace. Position 0 is the function that created the stack trace.  If this returns NULL, then it indicates that there is a native callout at <var>posn</var> within the stack trace. 
		alias get_pc                    =    jit_stack_trace_get_pc                  ; ///Get the program counter that corresponds to position <var>posn</var> within a stack trace.  This is the point within the function where execution had reached at the time of the trace. 
		alias get_offset                =    jit_stack_trace_get_offset              ; ///Get the bytecode offset that is recorded for position <var>posn</var> within a stack trace.  This will be <code>JIT_NO_OFFSET</code> if there is no bytecode offset associated with <var>posn</var>. 
		alias free                      =    jit_stack_trace_free                    ; ///Free the memory associated with a stack trace. 
	}
}


/** Building and compiling functions with the JIT */
interface functions {
	alias create                        =    jit_function_create                     ; ///Create a new function block and associate it with a JIT context. Returns NULL if out of memory. </p> <p>A function persists for the lifetime of its containing context. It initially starts life in the &quot;building&quot; state, where the user constructs instructions that represents the function body. Once the build process is complete, the user calls <code>jit_function_compile</code> to convert it into its executable form. </p> <p>It is recommended that you call <code>jit_context_build_start</code> before calling <code>jit_function_create</code>, and then call <code>jit_context_build_end</code> after you have called <code>jit_function_compile</code>.  This will protect the JIT&rsquo;s internal data structures within a multi-threaded environment. 
	alias create_nested                 =    jit_function_create_nested              ; ///Create a new function block and associate it with a JIT context. In addition, this function is nested inside the specified <var>parent</var> function and is able to access its parent&rsquo;s (and grandparent&rsquo;s) local variables. </p> <p>The front end is responsible for ensuring that the nested function can never be called by anyone except its parent and sibling functions. The front end is also responsible for ensuring that the nested function is compiled before its parent. 
	alias abandon                       =    jit_function_abandon                    ; ///Abandon this function during the build process.  This should be called when you detect a fatal error that prevents the function from being properly built.  The <var>func</var> object is completely destroyed and detached from its owning context.  The function is left alone if it was already compiled. 
	alias get_context                   =    jit_function_get_context                ; ///Get the context associated with a function. 
	alias get_signature                 =    jit_function_get_signature              ; ///Get the signature associated with a function. 
	alias set_meta                      =    jit_function_set_meta                   ; ///Tag a function with some metadata.  Returns zero if out of memory. </p> <p>Metadata may be used to store dependency graphs, branch prediction information, or any other information that is useful to optimizers or code generators.  It can also be used by higher level user code to store information about the function that is specific to the virtual machine or language. </p> <p>If the <var>type</var> already has some metadata associated with it, then the previous value will be freed. </p> <p>If <var>build_only</var> is non-zero, then the metadata will be freed when the function is compiled with <code>jit_function_compile</code>. Otherwise the metadata will persist until the JIT context is destroyed, or <code>jit_function_free_meta</code> is called for the specified <var>type</var>. </p> <p>Metadata type values of 10000 or greater are reserved for internal use. 
	alias get_meta                      =    jit_function_get_meta                   ;
	alias free_meta                     =    jit_function_free_meta                  ; ///Free metadata of a specific type on a function.  Does nothing if the <var>type</var> does not have any metadata associated with it. 
	alias next                          =    jit_function_next                       ; ///Iterate over the defined functions in creation order.  The <var>prev</var> argument should be NULL on the first call.  Returns NULL at the end. 
	alias previous                      =    jit_function_previous                   ; ///Iterate over the defined functions in reverse creation order. 
	alias get_entry                     =    jit_function_get_entry                  ; ///Get the entry block for a function.  This is always the first block created by <code>jit_function_create</code>. 
	alias get_current                   =    jit_function_get_current                ; ///Get the current block for a function.  New blocks are created by certain <code>jit_insn_xxx</code> calls. 
	alias get_nested_parent             =    jit_function_get_nested_parent          ; ///Get the nested parent for a function, or NULL if <var>func</var> does not have a nested parent. 
	alias compile                       =    jit_function_compile                    ;
	alias is_compiled                   =    jit_function_is_compiled                ; ///Determine if a function has already been compiled. 
	alias set_recompilable              =    jit_function_set_recompilable           ; ///Mark this function as a candidate for recompilation.  That is, it is possible that we may call <code>jit_function_compile</code> more than once, to re-optimize an existing function. </p> <p>It is very important that this be called before the first time that you call <code>jit_function_compile</code>.  Functions that are recompilable are invoked in a slightly different way to non-recompilable functions. If you don&rsquo;t set this flag, then existing invocations of the function may continue to be sent to the original compiled version, not the new version. 
	alias clear_recompilable            =    jit_function_clear_recompilable         ; ///Clear the recompilable flag on this function.  Normally you would use this once you have decided that the function has been optimized enough, and that you no longer intend to call <code>jit_function_compile</code> again. </p> <p>Future uses of the function with <code>jit_insn_call</code> will output a direct call to the function, which is more efficient than calling its recompilable version.  Pre-existing calls to the function may still use redirection stubs, and will remain so until the pre-existing functions are themselves recompiled. 
	alias is_recompilable               =    jit_function_is_recompilable            ; ///Determine if this function is recompilable. 
	alias compile_entry                 =    jit_function_compile_entry              ;
	alias setup_entry                   =    jit_function_setup_entry                ;
	alias to_closure                    =    jit_function_to_closure                 ; ///Convert a compiled function into a closure that can called directly from C.  Returns NULL if out of memory, or if closures are not supported on this platform. </p> <p>If the function has not been compiled yet, then this will return a pointer to a redirector that will arrange for the function to be compiled on-demand when it is called. </p> <p>Creating a closure for a nested function is not recommended as C does not have any way to call such closures directly. 
	alias from_closure                  =    jit_function_from_closure               ; ///Convert a closure back into a function.  Returns NULL if the closure does not correspond to a function in the specified context. 
	alias from_pc                       =    jit_function_from_pc                    ; ///Get the function that contains the specified program counter location. Also return the address of the <code>catch</code> handler for the same location. Returns NULL if the program counter does not correspond to a function under the control of <var>context</var>. 
	alias to_vtable_pointer             =    jit_function_to_vtable_pointer          ; ///Return a pointer that is suitable for referring to this function from a vtable.  Such pointers should only be used with the <code>jit_insn_call_vtable</code> instruction. </p> <p>Using <code>jit_insn_call_vtable</code> is generally more efficient than <code>jit_insn_call_indirect</code> for calling virtual methods. </p> <p>The vtable pointer might be the same as the closure, but this isn&rsquo;t guaranteed.  Closures can be used with <code>jit_insn_call_indirect</code>. 
	alias from_vtable_pointer           =    jit_function_from_vtable_pointer        ; ///Convert a vtable_pointer back into a function.  Returns NULL if the vtable_pointer does not correspond to a function in the specified context. 
	alias set_on_demand_compiler        =    jit_function_set_on_demand_compiler     ; ///Specify the C function to be called when <var>func</var> needs to be compiled on-demand.  This should be set just after the function is created, before any build or compile processes begin. </p> <p>You won&rsquo;t need an on-demand compiler if you always build and compile your functions before you call them.  But if you can call a function before it is built, then you must supply an on-demand compiler. </p> <p>When on-demand compilation is requested, <code>libjit</code> takes the following actions: </p> <ol> <li> The context is locked by calling <code>jit_context_build_start</code>.  </li><li> If the function has already been compiled, <code>libjit</code> unlocks the context and returns immediately.  This can happen because of race conditions between threads: some other thread may have beaten us to the on-demand compiler.  </li><li> The user&rsquo;s on-demand compiler is called.  It is responsible for building the instructions in the function&rsquo;s body.  It should return one of the result codes <code>JIT_RESULT_OK</code>, <code>JIT_RESULT_COMPILE_ERROR</code>, or <code>JIT_RESULT_OUT_OF_MEMORY</code>.  </li><li> If the user&rsquo;s on-demand function hasn&rsquo;t already done so, <code>libjit</code> will call <code>jit_function_compile</code> to compile the function.  </li><li> The context is unlocked by calling <code>jit_context_build_end</code> and <code>libjit</code> jumps to the newly-compiled entry point.  If an error occurs, a built-in exception of type <code>JIT_RESULT_COMPILE_ERROR</code> or <code>JIT_RESULT_OUT_OF_MEMORY</code> will be thrown. </li></ol>  <p>Normally you will need some kind of context information to tell you which higher-level construct is being compiled.  You can use the metadata facility to add this context information to the function just after you create it with <code>jit_function_create</code>. 
	alias get_on_demand_compiler        =    jit_function_get_on_demand_compiler     ; ///Returns function&rsquo;s on-demand compiler. 
	alias apply                         =    jit_function_apply                      ; ///Call the function <var>func</var> with the supplied arguments.  Each element in <var>args</var> is a pointer to one of the arguments, and <var>return_area</var> points to a buffer to receive the return value.  Returns zero if an exception occurred. </p> <p>This is the primary means for executing a function from ordinary C code without creating a closure first with <code>jit_function_to_closure</code>. Closures may not be supported on all platforms, but function application is guaranteed to be supported everywhere. </p> <p>Function applications acts as an exception blocker.  If any exceptions occur during the execution of <var>func</var>, they won&rsquo;t travel up the stack any further than this point.  This prevents ordinary C code from being accidentally presented with a situation that it cannot handle. This blocking protection is not present when a function is invoked via its closure. 
	alias apply_vararg                  =    jit_function_apply_vararg               ; ///Call the function <var>func</var> with the supplied arguments.  There may be more arguments than are specified in the function&rsquo;s original signature, in which case the additional values are passed as variable arguments. This function is otherwise identical to <code>jit_function_apply</code>. 
	alias set_optimization_level        =    jit_function_set_optimization_level     ; ///Set the optimization level for <var>func</var>.  Increasing values indicate that the <code>libjit</code> dynamic compiler should expend more effort to generate better code for this function.  Usually you would increase this value just before forcing <var>func</var> to recompile. </p> <p>When the optimization level reaches the value returned by <code>jit_function_get_max_optimization_level()</code>, there is usually little point in continuing to recompile the function because <code>libjit</code> may not be able to do any better. </p> <p>The front end is usually responsible for choosing candidates for function inlining.  If it has identified more such candidates, then it may still want to recompile <var>func</var> again even once it has reached the maximum optimization level. 
	alias get_optimization_level        =    jit_function_get_optimization_level     ; ///Get the current optimization level for <var>func</var>. 
	alias get_max_optimization_level    =    jit_function_get_max_optimization_level ; ///Get the maximum optimization level that is supported by <code>libjit</code>. 
	alias reserve_label                 =    jit_function_reserve_label              ; ///Allocate a new label for later use within the function <var>func</var>.  Most instructions that require a label could perform label allocation themselves. A separate label allocation could be useful to fill a jump table with identical entries. 
	alias labels_equal                  =    jit_function_labels_equal               ; ///Check if labels <var>label</var> and <var>label2</var> defined within the function <var>func</var> are equal that is belong to the same basic block.  Labels that are not associated with any block are never considered equal. 
}
	
interface init {
	alias init                          =    jit_init                                ; ///This is normally the first function that you call when using <code>libjit</code>.  It initializes the library and prepares for JIT operations. </p> <p>The <code>jit_context_create</code> function also calls this, so you can avoid using <code>jit_init</code> if <code>jit_context_create</code> is the first JIT function that you use. </p> <p>It is safe to initialize the JIT multiple times.  Subsequent initializations are quietly ignored. 
	alias uses_interpreter              =    jit_uses_interpreter                    ; ///Determine if the JIT uses a fall-back interpreter to execute code rather than generating and executing native code.  This can be called prior to <code>jit_init</code>. 
	alias supports_threads              =    jit_supports_threads                    ; ///Determine if the JIT supports threads. 
	alias supports_virtual_memory       =    jit_supports_virtual_memory             ; ///Determine if the JIT supports virtual memory. 
	alias get_trampoline_size           =    jit_get_trampoline_size                 ;
	alias get_trampoline_alignment      =    jit_get_trampoline_alignment            ;
}

/**	Working with instructions in the JIT */
interface instruction {
	alias get_opcode                    =    jit_insn_get_opcode                     ; ///Get the opcode that is associated with an instruction.
	alias get_dest                      =    jit_insn_get_dest                       ; ///Get the destination value that is associated with an instruction. Returns NULL if the instruction does not have a destination.
	alias get_value1                    =    jit_insn_get_value1                     ; ///Get the first argument value that is associated with an instruction. Returns NULL if the instruction does not have a first argument value.
	alias get_value2                    =    jit_insn_get_value2                     ; ///Get the second argument value that is associated with an instruction. Returns NULL if the instruction does not have a second argument value.
	alias get_label                     =    jit_insn_get_label                      ; ///Get the label for a branch target from an instruction. Returns NULL if the instruction does not have a branch target.
	alias get_function                  =    jit_insn_get_function                   ; ///Get the function for a call instruction.  Returns NULL if the instruction does not refer to a called function.
	alias get_native                    =    jit_insn_get_native                     ; ///Get the function pointer for a native call instruction. Returns NULL if the instruction does not refer to a native function call.
	alias get_name                      =    jit_insn_get_name                       ; ///Get the diagnostic name for a function call.  Returns NULL if the instruction does not have a diagnostic name.
	alias get_signature                 =    jit_insn_get_signature                  ; ///Get the signature for a function call instruction.  Returns NULL if the instruction is not a function call.
	alias dest_is_value                 =    jit_insn_dest_is_value                  ; ///Returns a non-zero value if the destination for <var>insn</var> is actually a source value.  This can happen with instructions such as <code>jit_insn_store_relative</code> where the instruction needs three source operands, and the real destination is a side-effect on one of the sources.
	alias label                         =    jit_insn_label                          ; ///Start a new basic block within the function <var>func</var> and give it the specified <var>label</var>.  If the call is made when a new block was just created by any previous call then that block is reused, no new block is created.  Returns zero if out of memory. </p> <p>If the contents of <var>label</var> are <code>jit_label_undefined</code>, then this function will allocate a new label for this block.  Otherwise it will reuse the specified label from a previous branch instruction.
	alias new_block                     =    jit_insn_new_block                      ; ///Start a new basic block, without giving it an explicit label.
	alias load                          =    jit_insn_load                           ; ///Load the contents of <var>value</var> into a new temporary, essentially duplicating the value.  Constants are not duplicated.
	alias dup                           =    jit_insn_dup                            ; ///This is the same as <code>jit_insn_load</code>, but the name may better reflect how it is used in some front ends.
	alias load_small                    =    jit_insn_load_small                     ; ///If <var>value</var> is of type <code>sbyte</code>, <code>byte</code>, <code>short</code>, <code>ushort</code>, a structure, or a union, then make a copy of it and return the temporary copy.  Otherwise return <var>value</var> as-is. </p> <p>This is useful where you want to use <var>value</var> directly without duplicating it first.  However, certain types usually cannot be operated on directly without first copying them elsewhere. This function will do that whenever necessary.
	alias store                         =    jit_insn_store                          ; ///Store the contents of <var>value</var> at the location referred to by <var>dest</var>.  The <var>dest</var> should be a <code>jit_value_t</code> representing a local variable or temporary.  Use <code>jit_insn_store_relative</code> to store to a location referred to by a pointer.
	alias load_relative                 =    jit_insn_load_relative                  ; ///Load a value of the specified <var>type</var> from the effective address <code>(<var>value</var> + <var>offset</var>)</code>, where <var>value</var> is a pointer.
	alias store_relative                =    jit_insn_store_relative                 ; ///Store <var>value</var> at the effective address <code>(<var>dest</var> + <var>offset</var>)</code>, where <var>dest</var> is a pointer.
	alias add_relative                  =    jit_insn_add_relative                   ; ///Add the constant <var>offset</var> to the specified pointer <var>value</var>. This is functionally identical to calling <code>jit_insn_add</code>, but the JIT can optimize the code better if it knows that the addition is being used to perform a relative adjustment on a pointer. In particular, multiple relative adjustments on the same pointer can be collapsed into a single adjustment.
	alias load_elem                     =    jit_insn_load_elem                      ; ///Load an element of type <var>elem_type</var> from position <var>index</var> within the array starting at <var>base_addr</var>.  The effective address of the array element is <code><var>base_addr</var> + <var>index</var> * sizeof(<var>elem_type</var>)</code>.
	alias load_elem_address             =    jit_insn_load_elem_address              ; ///Load the effective address of an element of type <var>elem_type</var> at position <var>index</var> within the array starting at <var>base_addr</var>. Essentially, this computes the expression <code><var>base_addr</var> + <var>index</var> * sizeof(<var>elem_type</var>)</code>, but may be more efficient than performing the steps with <code>jit_insn_mul</code> and <code>jit_insn_add</code>.
	alias store_elem                    =    jit_insn_store_elem                     ; ///Store <var>value</var> at position <var>index</var> of the array starting at <var>base_addr</var>.  The effective address of the storage location is <code><var>base_addr</var> + <var>index</var> * sizeof(jit_value_get_type(<var>value</var>))</code>.
	alias check_null                    =    jit_insn_check_null                     ; ///Check <var>value</var> to see if it is NULL.  If it is, then throw the built-in <code>JIT_RESULT_NULL_REFERENCE</code> exception.
	alias add                           =    jit_insn_add                            ; ///Add two values together and return the result in a new temporary value.
	alias add_ovf                       =    jit_insn_add_ovf                        ; ///Add two values together and return the result in a new temporary value. Throw an exception if overflow occurs.
	alias sub                           =    jit_insn_sub                            ; ///Subtract two values and return the result in a new temporary value.
	alias sub_ovf                       =    jit_insn_sub_ovf                        ; ///Subtract two values and return the result in a new temporary value. Throw an exception if overflow occurs.
	alias mul                           =    jit_insn_mul                            ; ///Multiply two values and return the result in a new temporary value.
	alias mul_ovf                       =    jit_insn_mul_ovf                        ; ///Multiply two values and return the result in a new temporary value. Throw an exception if overflow occurs.
	alias div                           =    jit_insn_div                            ; ///Divide two values and return the quotient in a new temporary value. Throws an exception on division by zero or arithmetic error (an arithmetic error is one where the minimum possible signed integer value is divided by -1).
	alias rem                           =    jit_insn_rem                            ; ///Divide two values and return the remainder in a new temporary value. Throws an exception on division by zero or arithmetic error (an arithmetic error is one where the minimum possible signed integer value is divided by -1).
	alias rem_ieee                      =    jit_insn_rem_ieee                       ; ///Divide two values and return the remainder in a new temporary value. Throws an exception on division by zero or arithmetic error (an arithmetic error is one where the minimum possible signed integer value is divided by -1).  This function is identical to <code>jit_insn_rem</code>, except that it uses IEEE rules for computing the remainder of floating-point values.
	alias neg                           =    jit_insn_neg                            ; ///Negate a value and return the result in a new temporary value.
	alias and                           =    jit_insn_and                            ; ///Bitwise AND two values and return the result in a new temporary value.
	alias or                            =    jit_insn_or                             ; ///Bitwise OR two values and return the result in a new temporary value.
	alias xor                           =    jit_insn_xor                            ; ///Bitwise XOR two values and return the result in a new temporary value.
	alias not                           =    jit_insn_not                            ; ///Bitwise NOT a value and return the result in a new temporary value.
	alias shl                           =    jit_insn_shl                            ; ///Perform a bitwise left shift on two values and return the result in a new temporary value.
	alias shr                           =    jit_insn_shr                            ; ///Perform a bitwise right shift on two values and return the result in a new temporary value.  This performs a signed shift on signed operators, and an unsigned shift on unsigned operands.
	alias ushr                          =    jit_insn_ushr                           ; ///Perform a bitwise right shift on two values and return the result in a new temporary value.  This performs an unsigned shift on both signed and unsigned operands.
	alias sshr                          =    jit_insn_sshr                           ; ///Perform a bitwise right shift on two values and return the result in a new temporary value.  This performs an signed shift on both signed and unsigned operands.
	alias eq                            =    jit_insn_eq                             ; ///Compare two values for equality and return the result in a new temporary value.
	alias ne                            =    jit_insn_ne                             ; ///Compare two values for inequality and return the result in a new temporary value.
	alias lt                            =    jit_insn_lt                             ; ///Compare two values for less than and return the result in a new temporary value.
	alias le                            =    jit_insn_le                             ; ///Compare two values for less than or equal and return the result in a new temporary value.
	alias gt                            =    jit_insn_gt                             ; ///Compare two values for greater than and return the result in a new temporary value.
	alias ge                            =    jit_insn_ge                             ; ///Compare two values for greater than or equal and return the result in a new temporary value.
	alias cmpl                          =    jit_insn_cmpl                           ; ///Compare two values, and return a -1, 0, or 1 result.  If either value is &quot;not a number&quot;, then -1 is returned.
	alias cmpg                          =    jit_insn_cmpg                           ; ///Compare two values, and return a -1, 0, or 1 result.  If either value is &quot;not a number&quot;, then 1 is returned.
	alias to_bool                       =    jit_insn_to_bool                        ; ///Convert a value into a boolean 0 or 1 result of type <code>jit_type_int</code>.
	alias to_not_bool                   =    jit_insn_to_not_bool                    ; ///Convert a value into a boolean 1 or 0 result of type <code>jit_type_int</code> (i.e. the inverse of <code>jit_insn_to_bool</code>).
	alias acos                          =    jit_insn_acos                           ; ///Apply a mathematical function to floating-point arguments.
	alias asin                          =    jit_insn_asin                           ;
	alias atan                          =    jit_insn_atan                           ;
	alias atan2                         =    jit_insn_atan2                          ;
	alias ceil                          =    jit_insn_ceil                           ; ///Round <var>value1</var> up towads positive infinity.
	alias cos                           =    jit_insn_cos                            ;
	alias cosh                          =    jit_insn_cosh                           ;
	alias exp                           =    jit_insn_exp                            ;
	alias floor                         =    jit_insn_floor                          ; ///Round <var>value1</var> down towards negative infinity.
	alias log                           =    jit_insn_log                            ;
	alias log10                         =    jit_insn_log10                          ;
	alias pow                           =    jit_insn_pow                            ;
	alias rint                          =    jit_insn_rint                           ; ///Round <var>value1</var> to the nearest integer. Half-way cases are rounded to the even number.
	alias round                         =    jit_insn_round                          ; ///Round <var>value1</var> to the nearest integer. Half-way cases are rounded away from zero.
	alias sin                           =    jit_insn_sin                            ;
	alias sinh                          =    jit_insn_sinh                           ;
	alias sqrt                          =    jit_insn_sqrt                           ;
	alias tan                           =    jit_insn_tan                            ;
	alias tanh                          =    jit_insn_tanh                           ;
	alias trunc                         =    jit_insn_trunc                          ; ///Round <var>value1</var> towards zero.
	alias is_nan                        =    jit_insn_is_nan                         ; ///Test a floating point value for not a number, finite, or infinity.
	alias is_finite                     =    jit_insn_is_finite                      ;
	alias is_inf                        =    jit_insn_is_inf                         ;
	alias abs                           =    jit_insn_abs                            ; ///Calculate the absolute value, minimum, maximum, or sign of the specified values.
	alias min                           =    jit_insn_min                            ;
	alias max                           =    jit_insn_max                            ;
	alias sign                          =    jit_insn_sign                           ;
	alias branch                        =    jit_insn_branch                         ; ///Terminate the current block by branching unconditionally to a specific label.  Returns zero if out of memory.
	alias branch_if                     =    jit_insn_branch_if                      ; ///Terminate the current block by branching to a specific label if the specified value is non-zero.  Returns zero if out of memory. </p> <p>If <var>value</var> refers to a conditional expression that was created by <code>jit_insn_eq</code>, <code>jit_insn_ne</code>, etc, then the conditional expression will be replaced by an appropriate conditional branch instruction.
	alias branch_if_not                 =    jit_insn_branch_if_not                  ; ///Terminate the current block by branching to a specific label if the specified value is zero.  Returns zero if out of memory. </p> <p>If <var>value</var> refers to a conditional expression that was created by <code>jit_insn_eq</code>, <code>jit_insn_ne</code>, etc, then the conditional expression will be followed by an appropriate conditional branch instruction, instead of a value load.
	alias jump_table                    =    jit_insn_jump_table                     ; ///Branch to a label from the <var>labels</var> table. The <var>value</var> is the index of the label. It is allowed to have identical labels in the table. If an entry in the table has <code>jit_label_undefined</code> value then it is replaced with a newly allocated label.
	alias address_of                    =    jit_insn_address_of                     ; ///Get the address of a value into a new temporary.
	alias address_of_label              =    jit_insn_address_of_label               ; ///Get the address of <var>label</var> into a new temporary.  This is typically used for exception handling, to track where in a function an exception was actually thrown.
	alias convert                       =    jit_insn_convert                        ; ///Convert the contents of a value into a new type, with optional overflow checking.
	alias call                          =    jit_insn_call                           ; ///Call the function <var>jit_func</var>, which may or may not be translated yet. The <var>name</var> is for diagnostic purposes only, and can be NULL. </p> <p>If <var>signature</var> is NULL, then the actual signature of <var>jit_func</var> is used in its place.  This is the usual case.  However, if the function takes a variable number of arguments, then you may need to construct an explicit signature for the non-fixed argument values. </p> <p>The <var>flags</var> parameter specifies additional information about the type of call to perform: <code>JIT_CALL_NOTHROW</code></dt> <dd><p>The function never throws exceptions.  <code>JIT_CALL_NORETURN</code></dt> <dd><p>The function will never return directly to its caller.  It may however return to the caller indirectly by throwing an exception that the caller catches. <code>JIT_CALL_TAIL</code></dt> <dd><p>Apply tail call optimizations, as the result of this function call will be immediately returned from the containing function. Tail calls are only appropriate when the signature of the called function matches the callee, and none of the parameters point to local variables. </p></dd> </dl>  <p>If <var>jit_func</var> has already been compiled, then <code>jit_insn_call</code> may be able to intuit some of the above flags for itself.  Otherwise it is up to the caller to determine when the flags may be appropriate.
	alias call_indirect                 =    jit_insn_call_indirect                  ; ///Call a function via an indirect pointer.
	alias call_indirect_vtable          =    jit_insn_call_indirect_vtable           ; ///Call a function via an indirect pointer.  This version differs from <code>jit_insn_call_indirect</code> in that we assume that <var>value</var> contains a pointer that resulted from calling <code>jit_function_to_vtable_pointer</code>.  Indirect vtable pointer calls may be more efficient on some platforms than regular indirect calls.
	alias call_native                   =    jit_insn_call_native                    ; ///Output an instruction that calls an external native function. The <var>name</var> is for diagnostic purposes only, and can be NULL.
	alias call_intrinsic                =    jit_insn_call_intrinsic                 ; ///Output an instruction that calls an intrinsic function.  The descriptor contains the following fields: <code>return_type</code></dt> <dd><p>The type of value that is returned from the intrinsic. </p> </dd> <dt> <code>ptr_result_type</code></dt> <dd><p>This should be NULL for an ordinary intrinsic, or the result type if the intrinsic reports exceptions. </p> </dd> <dt> <code>arg1_type</code></dt> <dd><p>The type of the first argument. </p> </dd> <dt> <code>arg2_type</code></dt> <dd><p>The type of the second argument, or NULL for a unary intrinsic. </p></dd> </dl>  <p>If all of the arguments are constant, then <code>jit_insn_call_intrinsic</code> will call the intrinsic directly to calculate the constant result. If the constant computation will result in an exception, then code is output to cause the exception at runtime. </p> <p>The <var>name</var> is for diagnostic purposes only, and can be NULL.
	alias incoming_reg                  =    jit_insn_incoming_reg                   ; ///Output an instruction that notes that the contents of <var>value</var> can be found in the register <var>reg</var> at this point in the code. </p> <p>You normally wouldn&rsquo;t call this yourself - it is used internally by the CPU back ends to set up the function&rsquo;s entry frame and the values of registers on return from a subroutine call.
	alias incoming_frame_posn           =    jit_insn_incoming_frame_posn            ; ///Output an instruction that notes that the contents of <var>value</var> can be found in the stack frame at <var>frame_offset</var> at this point in the code. </p> <p>You normally wouldn&rsquo;t call this yourself - it is used internally by the CPU back ends to set up the function&rsquo;s entry frame.
	alias outgoing_reg                  =    jit_insn_outgoing_reg                   ; ///Output an instruction that copies the contents of <var>value</var> into the register <var>reg</var> at this point in the code.  This is typically used just before making an outgoing subroutine call. </p> <p>You normally wouldn&rsquo;t call this yourself - it is used internally by the CPU back ends to set up the registers for a subroutine call.
	alias outgoing_frame_posn           =    jit_insn_outgoing_frame_posn            ; ///Output an instruction that notes that the contents of <var>value</var> should be stored in the stack frame at <var>frame_offset</var> at this point in the code. </p> <p>You normally wouldn&rsquo;t call this yourself - it is used internally by the CPU back ends to set up an outgoing frame for tail calls.
	alias return_reg                    =    jit_insn_return_reg                     ; ///Output an instruction that notes that the contents of <var>value</var> can be found in the register <var>reg</var> at this point in the code. This is similar to <code>jit_insn_incoming_reg</code>, except that it refers to return values, not parameter values. </p> <p>You normally wouldn&rsquo;t call this yourself - it is used internally by the CPU back ends to handle returns from subroutine calls.
	alias setup_for_nested              =    jit_insn_setup_for_nested               ; ///Output an instruction to set up for a nested function call. The <var>nested_level</var> value will be -1 to call a child, zero to call a sibling of <var>func</var>, 1 to call a sibling of the parent, 2 to call a sibling of the grandparent, etc.  If <var>reg</var> is not -1, then it indicates the register to receive the parent frame information. If <var>reg</var> is -1, then the frame information will be pushed on the stack. </p> <p>You normally wouldn&rsquo;t call this yourself - it is used internally by the CPU back ends to set up the parameters for a nested subroutine call.
	alias flush_struct                  =    jit_insn_flush_struct                   ; ///Flush a small structure return value out of registers and back into the local variable frame.  You normally wouldn&rsquo;t call this yourself - it is used internally by the CPU back ends to handle structure returns from functions.
	alias Import                        =    jit_insn_import                         ; ///Import <var>value</var> from an outer nested scope into <var>func</var>.  Returns the effective address of the value for local access via a pointer. Returns NULL if out of memory or the value is not accessible via a parent, grandparent, or other ancestor of <var>func</var>.
	alias push                          =    jit_insn_push                           ; ///Push a value onto the function call stack, in preparation for a call. You normally wouldn&rsquo;t call this yourself - it is used internally by the CPU back ends to set up the stack for a subroutine call.
	alias push_ptr                      =    jit_insn_push_ptr                       ; ///Push <code>*<var>value</var></code> onto the function call stack, in preparation for a call. This is normally used for returning <code>struct</code> and <code>union</code> values where you have the effective address of the structure, rather than the structure&rsquo;s contents, in <var>value</var>. </p> <p>You normally wouldn&rsquo;t call this yourself - it is used internally by the CPU back ends to set up the stack for a subroutine call.
	alias set_param                     =    jit_insn_set_param                      ; ///Set the parameter slot at <var>offset</var> in the outgoing parameter area to <var>value</var>.  This may be used instead of <code>jit_insn_push</code> if it is more efficient to store directly to the stack than to push. The outgoing parameter area is allocated within the frame when the function is first entered. </p> <p>You normally wouldn&rsquo;t call this yourself - it is used internally by the CPU back ends to set up the stack for a subroutine call.
	alias set_param_ptr                 =    jit_insn_set_param_ptr                  ; ///Same as <code>jit_insn_set_param_ptr</code>, except that the parameter is at <code>*<var>value</var></code>.
	alias push_return_area_ptr          =    jit_insn_push_return_area_ptr           ; ///Push the interpreter&rsquo;s return area pointer onto the stack. You normally wouldn&rsquo;t call this yourself - it is used internally by the CPU back ends to set up the stack for a subroutine call.
	alias pop_stack                     =    jit_insn_pop_stack                      ; ///Pop <var>num_items</var> items from the function call stack.  You normally wouldn&rsquo;t call this yourself - it is used by CPU back ends to clean up the stack after calling a subroutine.  The size of an item is specific to the back end (it could be bytes, words, or some other measurement).
	alias defer_pop_stack               =    jit_insn_defer_pop_stack                ; ///This is similar to <code>jit_insn_pop_stack</code>, except that it tries to defer the pop as long as possible.  Multiple subroutine calls may result in parameters collecting up on the stack, and only being popped at the next branch or label instruction.  You normally wouldn&rsquo;t call this yourself - it is used by CPU back ends.
	alias flush_defer_pop               =    jit_insn_flush_defer_pop                ; ///Flush any deferred items that were scheduled for popping by <code>jit_insn_defer_pop_stack</code> if there are <var>num_items</var> or more items scheduled.  You normally wouldn&rsquo;t call this yourself - it is used by CPU back ends to clean up the stack just prior to a subroutine call when too many items have collected up. Calling <code>jit_insn_flush_defer_pop(func, 0)</code> will flush all deferred items.
	alias Return                        =    jit_insn_return                         ; ///Output an instruction to return <var>value</var> as the function&rsquo;s result. If <var>value</var> is NULL, then the function is assumed to return <code>void</code>.  If the function returns a structure, this will copy the value into the memory at the structure return address.
	alias return_ptr                    =    jit_insn_return_ptr                     ; ///Output an instruction to return <code>*<var>value</var></code> as the function&rsquo;s result. This is normally used for returning <code>struct</code> and <code>union</code> values where you have the effective address of the structure, rather than the structure&rsquo;s contents, in <var>value</var>.
	alias default_return                =    jit_insn_default_return                 ; ///Add an instruction to return a default value if control reaches this point. This is typically used at the end of a function to ensure that all paths return to the caller.  Returns zero if out of memory, 1 if a default return was added, and 2 if a default return was not needed. </p> <p>Note: if this returns 1, but the function signature does not return <code>void</code>, then it indicates that a higher-level language error has occurred and the function should be abandoned.
	alias Throw                         =    jit_insn_throw                          ; ///Throw a pointer <var>value</var> as an exception object.  This can also be used to &quot;rethrow&quot; an object from a catch handler that is not interested in handling the exception.
	alias get_call_stack                =    jit_insn_get_call_stack                 ; ///Get an object that represents the current position in the code, and all of the functions that are currently on the call stack. This is equivalent to calling <code>jit_exception_get_stack_trace</code>, and is normally used just prior to <code>jit_insn_throw</code> to record the location of the exception that is being thrown.
	alias thrown_exception              =    jit_insn_thrown_exception               ; ///Get the value that holds the most recent thrown exception.  This is typically used in <code>catch</code> clauses.
	alias uses_catcher                  =    jit_insn_uses_catcher                   ; ///Notify the function building process that <var>func</var> contains some form of <code>catch</code> clause for catching exceptions.  This must be called before any instruction that is covered by a <code>try</code>, ideally at the start of the function output process.
	alias start_catcher                 =    jit_insn_start_catcher                  ; ///Start the catcher block for <var>func</var>.  There should be exactly one catcher block for any function that involves a <code>try</code>.  All exceptions that are thrown within the function will cause control to jump to this point.  Returns a value that holds the exception that was thrown.
	alias branch_if_pc_not_in_range     =    jit_insn_branch_if_pc_not_in_range      ; ///Branch to <var>label</var> if the program counter where an exception occurred does not fall between <var>start_label</var> and <var>end_label</var>.
	alias rethrow_unhandled             =    jit_insn_rethrow_unhandled              ; ///Rethrow the current exception because it cannot be handled by any of the <code>catch</code> blocks in the current function. </p> <p>Note: this is intended for use within catcher blocks.  It should not be used to rethrow exceptions in response to programmer requests (e.g. <code>throw;</code> in C#).  The <code>jit_insn_throw</code> function should be used for that purpose.
	alias start_finally                 =    jit_insn_start_finally                  ; ///Start a <code>finally</code> clause.
	alias return_from_finally           =    jit_insn_return_from_finally            ; ///Return from the <code>finally</code> clause to where it was called from. This is usually the last instruction in a <code>finally</code> clause.
	alias call_finally                  =    jit_insn_call_finally                   ; ///Call a <code>finally</code> clause.
	alias start_filter                  =    jit_insn_start_filter                   ; ///Define the start of a filter.  Filters are embedded subroutines within functions that are used to filter exceptions in <code>catch</code> blocks. </p> <p>A filter subroutine takes a single argument (usually a pointer) and returns a single result (usually a boolean).  The filter has complete access to the local variables of the function, and can use any of them in the filtering process. </p> <p>This function returns a temporary value of the specified <var>type</var>, indicating the parameter that is supplied to the filter.
	alias return_from_filter            =    jit_insn_return_from_filter             ; ///Return from a filter subroutine with the specified <code>value</code> as its result.
	alias call_filter                   =    jit_insn_call_filter                    ; ///Call the filter subroutine at <var>label</var>, passing it <var>value</var> as its argument.  This function returns a value of the specified <var>type</var>, indicating the filter&rsquo;s result.
	alias memcpy                        =    jit_insn_memcpy                         ; ///Copy the <var>size</var> bytes of memory at <var>src</var> to <var>dest</var>. It is assumed that the source and destination do not overlap.
	alias memmove                       =    jit_insn_memmove                        ; ///Copy the <var>size</var> bytes of memory at <var>src</var> to <var>dest</var>. This is save to use if the source and destination overlap.
	alias memset                        =    jit_insn_memset                         ; ///Set the <var>size</var> bytes at <var>dest</var> to <var>value</var>.
	alias alloca                        =    jit_insn_alloca                         ; ///Allocate <var>size</var> bytes of memory from the stack.
	alias move_blocks_to_end            =    jit_insn_move_blocks_to_end             ; ///Move all of the blocks between <var>from_label</var> (inclusive) and <var>to_label</var> (exclusive) to the end of the current function. This is typically used to move the expression in a <code>while</code> loop to the end of the body, where it can be executed more efficiently.
	alias move_blocks_to_start          =    jit_insn_move_blocks_to_start           ; ///Move all of the blocks between <var>from_label</var> (inclusive) and <var>to_label</var> (exclusive) to the start of the current function. This is typically used to move initialization code to the head of the function.
	alias mark_offset                   =    jit_insn_mark_offset                    ; ///Mark the current position in <var>func</var> as corresponding to the specified bytecode <var>offset</var>.  This value will be returned by <code>jit_stack_trace_get_offset</code>, and is useful for associating code positions with source line numbers.
	alias mark_breakpoint               =    jit_insn_mark_breakpoint                ; ///Mark the current position in <var>func</var> as corresponding to a breakpoint location.  When a break occurs, the debugging routines are passed <var>func</var>, <var>data1</var>, and <var>data2</var> as arguments.  By convention, <var>data1</var> is the type of breakpoint (source line, function entry, function exit, etc).   <p>There are two ways for a front end to receive notification about breakpoints. The bulk of this chapter describes the <code>jit_debugger_t</code> interface, which handles most of the ugly details.  In addition, a low-level &quot;debug hook mechanism&quot; is provided for front ends that wish more control over the process.  The debug hook mechanism is described below, under the <code>jit_debugger_set_hook</code> function. </p> <p>This debugger implementation requires a threading system to work successfully.  At least two threads are required, in addition to those of the program being debugged: </p> <ol> <li> Event thread which calls <code>jit_debugger_wait_event</code> to receive notifications of breakpoints and other interesting events.  </li><li> User interface thread which calls functions like <code>jit_debugger_run</code>, <code>jit_debugger_step</code>, etc, to control the debug process. </li></ol>  <p>These two threads should be set to &quot;unbreakable&quot; with a call to <code>jit_debugger_set_breakable</code>.  This prevents them from accidentally stopping at a breakpoint, which would cause a system deadlock. Other housekeeping threads, such as a finalization thread, should also be set to &quot;unbreakable&quot; for the same reason. </p> <p>Events have the following members: </p> <dt> <code>type</code></dt> <dd><p>The type of event (see the next table for details). </p> </dd> <dt> <code>thread</code></dt> <dd><p>The thread that the event occurred on. </p> </dd> <dt> <code>function</code></dt> <dd><p>The function that the breakpoint occurred within. </p> </dd> <dt> <code>data1</code></dt> <dt> <code>data2</code></dt> <dd><p>The data values at the breakpoint.  These values are inserted into the function&rsquo;s code with <code>jit_insn_mark_breakpoint</code>. </p> </dd> <dt> <code>id</code></dt> <dd><p>The identifier for the breakpoint. </p> </dd> <dt> <code>trace</code></dt> <dd><p>The stack trace corresponding to the location where the breakpoint occurred.  This value is automatically freed upon the next call to <code>jit_debugger_wait_event</code>.  If you wish to preserve the value, then you must call <code>jit_stack_trace_copy</code>. </p></dd> </dl>  <p>The following event types are currently supported: </p> <dt> <code>JIT_DEBUGGER_TYPE_QUIT</code></dt> <dd><p>A thread called <code>jit_debugger_quit</code>, indicating that it wanted the event thread to terminate. </p> </dd> <dt> <code>JIT_DEBUGGER_TYPE_HARD_BREAKPOINT</code></dt> <dd><p>A thread stopped at a hard breakpoint.  That is, a breakpoint defined by a call to <code>jit_debugger_add_breakpoint</code>. </p> </dd> <dt> <code>JIT_DEBUGGER_TYPE_SOFT_BREAKPOINT</code></dt> <dd><p>A thread stopped at a breakpoint that wasn&rsquo;t explicitly defined by a call to <code>jit_debugger_add_breakpoint</code>.  This typicaly results from a call to a &quot;step&quot; function like <code>jit_debugger_step</code>, where execution stopped at the next line but there isn&rsquo;t an explicit breakpoint on that line. </p> </dd> <dt> <code>JIT_DEBUGGER_TYPE_USER_BREAKPOINT</code></dt> <dd><p>A thread stopped because of a call to <code>jit_debugger_break</code>. </p> </dd> <dt> <code>JIT_DEBUGGER_TYPE_ATTACH_THREAD</code></dt> <dd><p>A thread called <code>jit_debugger_attach_self</code>.  The <code>data1</code> field of the event is set to the value of <code>stop_immediately</code> for the call. </p> </dd> <dt> <code>JIT_DEBUGGER_TYPE_DETACH_THREAD</code></dt> <dd><p>A thread called <code>jit_debugger_detach_self</code>. </p></dd> </dl>
	alias mark_breakpoint_variable      =    jit_insn_mark_breakpoint_variable       ; ///This function is similar to <code>jit_insn_mark_breakpoint</code> except that values in <var>data1</var> and <var>data2</var> can be computed at runtime. You can use this function for example to get address of local variable. 
	alias iter_init                     =    jit_insn_iter_init                      ; ///Initialize an iterator to point to the first instruction in <var>block</var>.
	alias iter_init_last                =    jit_insn_iter_init_last                 ; ///Initialize an iterator to point to the last instruction in <var>block</var>.
	alias iter_next                     =    jit_insn_iter_next                      ; ///Get the next instruction in an iterator&rsquo;s block.  Returns NULL when there are no further instructions in the block.
	alias iter_previous                 =    jit_insn_iter_previous                  ; ///Get the previous instruction in an iterator&rsquo;s block.  Returns NULL when there are no further instructions in the block.
}

/** 
 * Intrinsics are functions that are provided to ease code generation on platforms that may not be able to perform all operations
 * natively. 
 * 
 * For example, on a CPU without a floating-point unit, the back end code generator will output a call to an intrinsic function when a
 * floating-point operation is performed. CPU’s with a floating-point unit would use a native instruction instead. 
 * 
 * Some platforms may already have appropriate intrinsics (e.g. the ARM floating-point emulation routines). The back end code generator
 * may choose to use either the system-supplied intrinsics or the ones supplied by this library. We supply all of them in our library
 * just in case a particular platform lacks an appropriate intrinsic. 
 * 
 * Some intrinsics have no equivalent in existing system libraries; particularly those that deal with overflow checking. 
 * 
 * Functions that perform overflow checking or which divide integer operands return a built-in exception code to indicate the type of 
 * exception to be thrown (the caller is responsible for throwing the actual exception). See section Handling exceptions, for a list of
 * built-in exception codes.
 */
interface intrinsic {
	interface Int {
		alias add                           =    jit_int_add                             ; ///Perform an arithmetic operation on signed 32-bit integers.
		alias sub                           =    jit_int_sub                             ;
		alias mul                           =    jit_int_mul                             ;
		alias div                           =    jit_int_div                             ;
		alias rem                           =    jit_int_rem                             ;
		alias add_ovf                       =    jit_int_add_ovf                         ; ///Perform an arithmetic operation on two signed 32-bit integers, with overflow checking.  Returns <code>JIT_RESULT_OK</code> or <code>JIT_RESULT_OVERFLOW</code>. 
		alias sub_ovf                       =    jit_int_sub_ovf                         ;
		alias mul_ovf                       =    jit_int_mul_ovf                         ;
		alias neg                           =    jit_int_neg                             ;
		alias and                           =    jit_int_and                             ;
		alias or                            =    jit_int_or                              ;
		alias xor                           =    jit_int_xor                             ;
		alias not                           =    jit_int_not                             ;
		alias shl                           =    jit_int_shl                             ;
		alias shr                           =    jit_int_shr                             ; ///Perform an arithmetic operation on signed 32-bit integers. 
		alias eq                            =    jit_int_eq                              ; ///Compare two signed 32-bit integers, returning 0 or 1 based on their relationship. 
		alias ne                            =    jit_int_ne                              ;
		alias lt                            =    jit_int_lt                              ;
		alias le                            =    jit_int_le                              ;
		alias gt                            =    jit_int_gt                              ;
		alias ge                            =    jit_int_ge                              ;
		alias cmp                           =    jit_int_cmp                             ; ///Compare two signed 32-bit integers and return -1, 0, or 1 based on their relationship. 
		alias abs                           =    jit_int_abs                             ;
		alias min                           =    jit_int_min                             ; ///Calculate the absolute value, minimum, maximum, or sign for signed 32-bit integer values. 
		alias max                           =    jit_int_max                             ;
		alias sign                          =    jit_int_sign                            ;
		
		alias to_sbyte                      =    jit_int_to_sbyte                        ; ///Convert between integer types.
		alias to_ubyte                      =    jit_int_to_ubyte                        ;
		alias to_short                      =    jit_int_to_short                        ;
		alias to_ushort                     =    jit_int_to_ushort                       ;
		alias to_int                        =    jit_int_to_int                          ;
		alias to_uint                       =    jit_int_to_uint                         ;
		alias to_long                       =    jit_int_to_long                         ;
		alias to_ulong                      =    jit_int_to_ulong                        ;
		alias to_f32                        =    jit_int_to_float32                      ; ///Convert an integer into 32-bit floating-point value.
		alias to_f64                        =    jit_int_to_float64                      ; ///Convert an integer into 64-bit floating-point value.
		alias to_nf                         =    jit_int_to_nfloat                       ; ///Convert an integer into native floating-point value.
		
		/** Convert types with overflow detection. */
		interface ovf {  
			alias to_int                =    jit_int_to_int_ovf                      ;
			alias to_long               =    jit_int_to_long_ovf                     ;
			alias to_sbyte              =    jit_int_to_sbyte_ovf                    ; ///Convert between integer types with overflow detection. 
			alias to_short              =    jit_int_to_short_ovf                    ;
			alias to_ubyte              =    jit_int_to_ubyte_ovf                    ;
			alias to_uint               =    jit_int_to_uint_ovf                     ;
			alias to_ulong              =    jit_int_to_ulong_ovf                    ;
			alias to_ushort             =    jit_int_to_ushort_ovf                   ;
		}
	}

	interface Uint {
		alias add                           =    jit_uint_add                            ; ///Perform an arithmetic operation on unsigned 32-bit integers. 
		alias sub                           =    jit_uint_sub                            ;
		alias mul                           =    jit_uint_mul                            ;
		alias div                           =    jit_uint_div                            ;
		alias rem                           =    jit_uint_rem                            ;
		alias add_ovf                       =    jit_uint_add_ovf                        ; ///Perform an arithmetic operation on two unsigned 32-bit integers, with overflow checking.  Returns <code>JIT_RESULT_OK</code> or <code>JIT_RESULT_OVERFLOW</code>. 
		alias sub_ovf                       =    jit_uint_sub_ovf                        ;
		alias mul_ovf                       =    jit_uint_mul_ovf                        ;
		alias neg                           =    jit_uint_neg                            ;
		alias and                           =    jit_uint_and                            ;
		alias or                            =    jit_uint_or                             ;
		alias xor                           =    jit_uint_xor                            ;
		alias not                           =    jit_uint_not                            ;
		alias shl                           =    jit_uint_shl                            ;
		alias shr                           =    jit_uint_shr                            ;
		alias eq                            =    jit_uint_eq                             ; ///Compare two unsigned 32-bit integers, returning 0 or 1 based on their relationship. 
		alias ne                            =    jit_uint_ne                             ;
		alias lt                            =    jit_uint_lt                             ;
		alias le                            =    jit_uint_le                             ;
		alias gt                            =    jit_uint_gt                             ;
		alias ge                            =    jit_uint_ge                             ;
		alias cmp                           =    jit_uint_cmp                            ; ///Compare two unsigned 32-bit integers and return -1, 0, or 1 based on their relationship. 
		alias min                           =    jit_uint_min                            ; ///Calculate the minimum or maximum for unsigned 32-bit integer values. 
		alias max                           =    jit_uint_max                            ;
		
		alias to_f32                        =    jit_uint_to_float32                     ;
		alias to_f64                        =    jit_uint_to_float64                     ;
		alias to_int                        =    jit_uint_to_int                         ;
		alias to_long                       =    jit_uint_to_long                        ;
		alias to_nf                         =    jit_uint_to_nfloat                      ;
		alias to_uint                       =    jit_uint_to_uint                        ;
		alias to_ulong                      =    jit_uint_to_ulong                       ;
		
		/** Convert types with overflow detection. */
		interface ovf {
			alias to_int               =    jit_uint_to_int_ovf                     ;
			alias to_long              =    jit_uint_to_long_ovf                    ;
			alias to_uint              =    jit_uint_to_uint_ovf                    ;
			alias to_ulong             =    jit_uint_to_ulong_ovf                   ;
		}
	}

	interface Long {
		alias add                           =    jit_long_add                            ; ///Perform an arithmetic operation on signed 64-bit integers. 
		alias sub                           =    jit_long_sub                            ;
		alias mul                           =    jit_long_mul                            ;
		alias div                           =    jit_long_div                            ;
		alias rem                           =    jit_long_rem                            ;
		alias add_ovf                       =    jit_long_add_ovf                        ; ///Perform an arithmetic operation on two signed 64-bit integers, with overflow checking.  Returns <code>JIT_RESULT_OK</code> or <code>JIT_RESULT_OVERFLOW</code>. 
		alias sub_ovf                       =    jit_long_sub_ovf                        ;
		alias mul_ovf                       =    jit_long_mul_ovf                        ;
		alias neg                           =    jit_long_neg                            ;
		alias and                           =    jit_long_and                            ;
		alias or                            =    jit_long_or                             ;
		alias xor                           =    jit_long_xor                            ;
		alias not                           =    jit_long_not                            ;
		alias shl                           =    jit_long_shl                            ;
		alias shr                           =    jit_long_shr                            ;
		alias eq                            =    jit_long_eq                             ; ///Compare two signed 64-bit integers, returning 0 or 1 based on their relationship. 
		alias ne                            =    jit_long_ne                             ;
		alias lt                            =    jit_long_lt                             ;
		alias le                            =    jit_long_le                             ;
		alias gt                            =    jit_long_gt                             ;
		alias ge                            =    jit_long_ge                             ;
		alias cmp                           =    jit_long_cmp                            ; ///Compare two signed 64-bit integers and return -1, 0, or 1 based on their relationship. 
		alias abs                           =    jit_long_abs                            ;
		alias min                           =    jit_long_min                            ; ///Calculate the absolute value, minimum, maximum, or sign for signed 64-bit integer values. 
		alias max                           =    jit_long_max                            ;
		alias sign                          =    jit_long_sign                           ;
		
		alias to_f32                        =    jit_long_to_float32                     ;
		alias to_f64                        =    jit_long_to_float64                     ;
		alias to_int                        =    jit_long_to_int                         ;
		alias to_long                       =    jit_long_to_long                        ;
		alias to_nf                         =    jit_long_to_nfloat                      ;
		alias to_uint                       =    jit_long_to_uint                        ;
		alias to_ulong                      =    jit_long_to_ulong                       ;
		
		/** Convert types with overflow detection. */
		interface ovf {   
			alias to_int               =    jit_long_to_int_ovf                     ;
			alias to_long              =    jit_long_to_long_ovf                    ;
			alias to_uint              =    jit_long_to_uint_ovf                    ;
			alias to_ulong             =    jit_long_to_ulong_ovf                   ;
		}
	}

	interface Ulong {
		alias add                           =    jit_ulong_add                           ; ///Perform an arithmetic operation on unsigned 64-bit integers.
		alias sub                           =    jit_ulong_sub                           ;
		alias mul                           =    jit_ulong_mul                           ;
		alias div                           =    jit_ulong_div                           ;
		alias rem                           =    jit_ulong_rem                           ;
		alias add_ovf                       =    jit_ulong_add_ovf                       ; ///Perform an arithmetic operation on two unsigned 64-bit integers, with overflow checking.  Returns <code>JIT_RESULT_OK</code> or <code>JIT_RESULT_OVERFLOW</code>. 
		alias sub_ovf                       =    jit_ulong_sub_ovf                       ;
		alias mul_ovf                       =    jit_ulong_mul_ovf                       ;
		alias neg                           =    jit_ulong_neg                           ;
		alias and                           =    jit_ulong_and                           ;
		alias or                            =    jit_ulong_or                            ;
		alias xor                           =    jit_ulong_xor                           ;
		alias not                           =    jit_ulong_not                           ;
		alias shl                           =    jit_ulong_shl                           ;
		alias shr                           =    jit_ulong_shr                           ; ///Perform an arithmetic operation on unsigned 64-bit integers. 
		alias eq                            =    jit_ulong_eq                            ; ///Compare two unsigned 64-bit integers, returning 0 or 1 based on their relationship. 
		alias ne                            =    jit_ulong_ne                            ;
		alias lt                            =    jit_ulong_lt                            ;
		alias le                            =    jit_ulong_le                            ;
		alias gt                            =    jit_ulong_gt                            ;
		alias ge                            =    jit_ulong_ge                            ;
		alias cmp                           =    jit_ulong_cmp                           ; ///Compare two unsigned 64-bit integers and return -1, 0, or 1 based on their relationship. 
		alias min                           =    jit_ulong_min                           ; ///Calculate the minimum or maximum for unsigned 64-bit integer values. 
		alias max                           =    jit_ulong_max                           ;
		
		alias to_f32                        =    jit_ulong_to_float32                    ; ///Convert an integer into 32-bit floating-point value. 
		alias to_f64                        =    jit_ulong_to_float64                    ; ///Convert an integer into 64-bit floating-point value. 
		alias to_int                        =    jit_ulong_to_int                        ;
		alias to_long                       =    jit_ulong_to_long                       ;
		alias to_nf                         =    jit_ulong_to_nfloat                     ; ///Convert an integer into native floating-point value. 
		alias to_uint                       =    jit_ulong_to_uint                       ;
		alias to_ulong                      =    jit_ulong_to_ulong                      ; ///Convert between integer types. 
		
		/** Convert types with overflow detection. */
		interface ovf { 
			alias to_int              =    jit_ulong_to_int_ovf                    ;
			alias to_long             =    jit_ulong_to_long_ovf                   ;
			alias to_uint             =    jit_ulong_to_uint_ovf                   ;
			alias to_ulong            =    jit_ulong_to_ulong_ovf                  ;
		}
	}

	interface Float32 {
		alias add                           =    jit_float32_add                         ; ///Perform an arithmetic operation on 32-bit floating-point values. 
		alias sub                           =    jit_float32_sub                         ;
		alias mul                           =    jit_float32_mul                         ;
		alias div                           =    jit_float32_div                         ;
		alias rem                           =    jit_float32_rem                         ;
		alias ieee_rem                      =    jit_float32_ieee_rem                    ;
		alias neg                           =    jit_float32_neg                         ;
		alias eq                            =    jit_float32_eq                          ; ///Compare two 32-bit floating-point values, returning 0 or 1 based on their relationship. 
		alias ne                            =    jit_float32_ne                          ;
		alias lt                            =    jit_float32_lt                          ;
		alias le                            =    jit_float32_le                          ;
		alias gt                            =    jit_float32_gt                          ;
		alias ge                            =    jit_float32_ge                          ;
		alias cmpl                          =    jit_float32_cmpl                        ; ///Compare two 32-bit floating-point values and return -1, 0, or 1 based on their relationship.  If either value is &quot;not a number&quot;, then -1 is returned. 
		alias cmpg                          =    jit_float32_cmpg                        ; ///Compare two 32-bit floating-point values and return -1, 0, or 1 based on their relationship.  If either value is &quot;not a number&quot;, then 1 is returned. 
		alias acos                          =    jit_float32_acos                        ; ///Apply a mathematical function to one or two 32-bit floating-point values.
		alias asin                          =    jit_float32_asin                        ;
		alias atan                          =    jit_float32_atan                        ;
		alias atan2                         =    jit_float32_atan2                       ;
		alias ceil                          =    jit_float32_ceil                        ; ///Round <var>value1</var> up towards positive infinity. 
		alias cos                           =    jit_float32_cos                         ;
		alias cosh                          =    jit_float32_cosh                        ;
		alias exp                           =    jit_float32_exp                         ;
		alias floor                         =    jit_float32_floor                       ; ///Round <var>value1</var> down towards negative infinity. 
		alias log                           =    jit_float32_log                         ;
		alias log10                         =    jit_float32_log10                       ;
		alias pow                           =    jit_float32_pow                         ;
		alias rint                          =    jit_float32_rint                        ; ///Round <var>value1</var> to the nearest integer.  Half-way cases are rounded to an even number. 
		alias round                         =    jit_float32_round                       ; ///Round <var>value1</var> to the nearest integer.  Half-way cases are rounded away from zero. 
		alias sin                           =    jit_float32_sin                         ;
		alias sinh                          =    jit_float32_sinh                        ;
		alias sqrt                          =    jit_float32_sqrt                        ;
		alias tan                           =    jit_float32_tan                         ;
		alias tanh                          =    jit_float32_tanh                        ; ///Apply a mathematical function to one or two 32-bit floating-point values. 
		alias trunc                         =    jit_float32_trunc                       ; ///Round <var>value1</var> towards zero. 
		alias is_finite                     =    jit_float32_is_finite                   ; ///Determine if a 32-bit floating point value is finite, returning non-zero if it is, or zero if it is not.  If the value is &quot;not a number&quot;, this function returns zero. 
		alias is_nan                        =    jit_float32_is_nan                      ; ///Determine if a 32-bit floating point value is &quot;not a number&quot;, returning non-zero if it is, or zero if it is not. 
		alias is_inf                        =    jit_float32_is_inf                      ; ///Determine if a 32-bit floating point value is infinite or not. Returns -1 for negative infinity, 1 for positive infinity, and 0 for everything else. </p> <p>Note: this function is preferable to the system <code>isinf</code> intrinsic because some systems have a broken <code>isinf</code> function that returns 1 for both positive and negative infinity. 
		alias abs                           =    jit_float32_abs                         ; ///Calculate the absolute value, minimum, maximum, or sign for 32-bit floating point values. 
		alias min                           =    jit_float32_min                         ;
		alias max                           =    jit_float32_max                         ;
		alias sign                          =    jit_float32_sign                        ;
		
		alias to_f64                        =    jit_float32_to_float64                  ; ///Convert between floating-point types.
		alias to_int                        =    jit_float32_to_int                      ; ///Convert a 32-bit floating-point value into an integer. 
		alias to_long                       =    jit_float32_to_long                     ;
		alias to_nf                         =    jit_float32_to_nfloat                   ;
		alias to_uint                       =    jit_float32_to_uint                     ;
		alias to_ulong                      =    jit_float32_to_ulong                    ;
		
		/** Convert types with overflow detection. */
		interface ovf {   
			alias to_int                =    jit_float32_to_int_ovf                  ; ///Convert a 32-bit floating-point value into an integer, with overflow detection.  Returns <code>JIT_RESULT_OK</code> if the conversion was successful or <code>JIT_RESULT_OVERFLOW</code> if an overflow occurred. 
			alias to_long               =    jit_float32_to_long_ovf                 ;
			alias to_uint               =    jit_float32_to_uint_ovf                 ;
			alias to_ulong              =    jit_float32_to_ulong_ovf                ;
		}
	}

	interface Float64 {
		alias add                           =    jit_float64_add                         ; ///Perform an arithmetic operation on 64-bit floating-point values. 
		alias sub                           =    jit_float64_sub                         ;
		alias mul                           =    jit_float64_mul                         ;
		alias div                           =    jit_float64_div                         ;
		alias rem                           =    jit_float64_rem                         ;
		alias ieee_rem                      =    jit_float64_ieee_rem                    ;
		alias neg                           =    jit_float64_neg                         ;
		alias eq                            =    jit_float64_eq                          ; ///Compare two 64-bit floating-point values, returning 0 or 1 based on their relationship.
		alias ne                            =    jit_float64_ne                          ;
		alias lt                            =    jit_float64_lt                          ;
		alias le                            =    jit_float64_le                          ;
		alias gt                            =    jit_float64_gt                          ;
		alias ge                            =    jit_float64_ge                          ; ///Compare two 64-bit floating-point values, returning 0 or 1 based on their relationship. 
		alias cmpl                          =    jit_float64_cmpl                        ; ///Compare two 64-bit floating-point values and return -1, 0, or 1 based on their relationship.  If either value is &quot;not a number&quot;, then -1 is returned. 
		alias cmpg                          =    jit_float64_cmpg                        ; ///Compare two 64-bit floating-point values and return -1, 0, or 1 based on their relationship.  If either value is &quot;not a number&quot;, then 1 is returned. 
		alias acos                          =    jit_float64_acos                        ; ///Apply a mathematical function to one or two 64-bit floating-point values.
		alias asin                          =    jit_float64_asin                        ;
		alias atan                          =    jit_float64_atan                        ;
		alias atan2                         =    jit_float64_atan2                       ;
		alias ceil                          =    jit_float64_ceil                        ;
		alias cos                           =    jit_float64_cos                         ;
		alias cosh                          =    jit_float64_cosh                        ;
		alias exp                           =    jit_float64_exp                         ;
		alias floor                         =    jit_float64_floor                       ;
		alias log                           =    jit_float64_log                         ;
		alias log10                         =    jit_float64_log10                       ;
		alias pow                           =    jit_float64_pow                         ;
		alias rint                          =    jit_float64_rint                        ;
		alias round                         =    jit_float64_round                       ;
		alias sin                           =    jit_float64_sin                         ;
		alias sinh                          =    jit_float64_sinh                        ;
		alias sqrt                          =    jit_float64_sqrt                        ;
		alias tan                           =    jit_float64_tan                         ;
		alias tanh                          =    jit_float64_tanh                        ; ///Apply a mathematical function to one or two 64-bit floating-point values. 
		alias trunc                         =    jit_float64_trunc                       ;
		alias is_finite                     =    jit_float64_is_finite                   ; ///Determine if a 64-bit floating point value is finite, returning non-zero if it is, or zero if it is not.  If the value is &quot;not a number&quot;, this function returns zero. 
		alias is_nan                        =    jit_float64_is_nan                      ; ///Determine if a 64-bit floating point value is &quot;not a number&quot;, returning non-zero if it is, or zero if it is not. 
		alias is_inf                        =    jit_float64_is_inf                      ; ///Determine if a 64-bit floating point value is infinite or not. Returns -1 for negative infinity, 1 for positive infinity, and 0 for everything else. </p> <p>Note: this function is preferable to the system <code>isinf</code> intrinsic because some systems have a broken <code>isinf</code> function that returns 1 for both positive and negative infinity. 
		alias abs                           =    jit_float64_abs                         ; ///Calculate the absolute value, minimum, maximum, or sign for 64-bit floating point values. 
		alias min                           =    jit_float64_min                         ;
		alias max                           =    jit_float64_max                         ;
		alias sign                          =    jit_float64_sign                        ;
		
		alias to_f32                        =    jit_float64_to_float32                  ;
		alias to_int                        =    jit_float64_to_int                      ; ///Convert a 64-bit floating-point value into an integer. 
		alias to_long                       =    jit_float64_to_long                     ;
		alias to_nf                         =    jit_float64_to_nfloat                   ;
		alias to_uint                       =    jit_float64_to_uint                     ;
		alias to_ulong                      =    jit_float64_to_ulong                    ;

		/** Convert types with overflow detection. */
		interface ovf { 
			alias to_int                =    jit_float64_to_int_ovf                  ; ///Convert a 64-bit floating-point value into an integer, with overflow detection.  Returns <code>JIT_RESULT_OK</code> if the conversion was successful or <code>JIT_RESULT_OVERFLOW</code> if an overflow occurred. 
			alias to_long               =    jit_float64_to_long_ovf                 ;
			alias to_uint               =    jit_float64_to_uint_ovf                 ;
			alias to_ulong              =    jit_float64_to_ulong_ovf                ;
		}
	}

	/** Native floating-point values */
	interface Nfloat {
		alias add                           =    jit_nfloat_add                          ; ///Perform an arithmetic operation on native floating-point values. 
		alias sub                           =    jit_nfloat_sub                          ;
		alias mul                           =    jit_nfloat_mul                          ;
		alias div                           =    jit_nfloat_div                          ;
		alias rem                           =    jit_nfloat_rem                          ;
		alias ieee_rem                      =    jit_nfloat_ieee_rem                     ;
		alias neg                           =    jit_nfloat_neg                          ;
		alias eq                            =    jit_nfloat_eq                           ; ///Compare two native floating-point values, returning 0 or 1 based on their relationship. 
		alias ne                            =    jit_nfloat_ne                           ;
		alias lt                            =    jit_nfloat_lt                           ;
		alias le                            =    jit_nfloat_le                           ;
		alias gt                            =    jit_nfloat_gt                           ;
		alias ge                            =    jit_nfloat_ge                           ;
		alias cmpl                          =    jit_nfloat_cmpl                         ; ///Compare two native floating-point values and return -1, 0, or 1 based on their relationship.  If either value is &quot;not a number&quot;, then -1 is returned. 
		alias cmpg                          =    jit_nfloat_cmpg                         ; ///Compare two native floating-point values and return -1, 0, or 1 based on their relationship.  If either value is &quot;not a number&quot;, then 1 is returned. 
		alias acos                          =    jit_nfloat_acos                         ; ///Apply a mathematical function to one or two native floating-point values.
		alias asin                          =    jit_nfloat_asin                         ;
		alias atan                          =    jit_nfloat_atan                         ;
		alias atan2                         =    jit_nfloat_atan2                        ;
		alias ceil                          =    jit_nfloat_ceil                         ;
		alias cos                           =    jit_nfloat_cos                          ;
		alias cosh                          =    jit_nfloat_cosh                         ;
		alias exp                           =    jit_nfloat_exp                          ;
		alias floor                         =    jit_nfloat_floor                        ;
		alias log                           =    jit_nfloat_log                          ;
		alias log10                         =    jit_nfloat_log10                        ;
		alias pow                           =    jit_nfloat_pow                          ;
		alias rint                          =    jit_nfloat_rint                         ;
		alias round                         =    jit_nfloat_round                        ;
		alias sin                           =    jit_nfloat_sin                          ;
		alias sinh                          =    jit_nfloat_sinh                         ;
		alias sqrt                          =    jit_nfloat_sqrt                         ;
		alias tan                           =    jit_nfloat_tan                          ;
		alias tanh                          =    jit_nfloat_tanh                         ; ///Apply a mathematical function to one or two native floating-point values. 
		alias trunc                         =    jit_nfloat_trunc                        ;
		alias is_finite                     =    jit_nfloat_is_finite                    ; ///Determine if a native floating point value is finite, returning non-zero if it is, or zero if it is not.  If the value is &quot;not a number&quot;, this function returns zero. 
		alias is_nan                        =    jit_nfloat_is_nan                       ; ///Determine if a native floating point value is &quot;not a number&quot;, returning non-zero if it is, or zero if it is not. 
		alias is_inf                        =    jit_nfloat_is_inf                       ; ///Determine if a native floating point value is infinite or not. Returns -1 for negative infinity, 1 for positive infinity, and 0 for everything else. </p> <p>Note: this function is preferable to the system <code>isinf</code> intrinsic because some systems have a broken <code>isinf</code> function that returns 1 for both positive and negative infinity. 
		alias abs                           =    jit_nfloat_abs                          ; ///Calculate the absolute value, minimum, maximum, or sign for native floating point values. 
		alias min                           =    jit_nfloat_min                          ;
		alias max                           =    jit_nfloat_max                          ;
		alias sign                          =    jit_nfloat_sign                         ;
		
		alias to_f32                        =    jit_nfloat_to_float32                   ;
		alias to_f64                        =    jit_nfloat_to_float64                   ; ///Convert between floating-point types. 
		alias to_int                        =    jit_nfloat_to_int                       ; ///Convert a native floating-point value into an integer. 
		alias to_long                       =    jit_nfloat_to_long                      ;
		alias to_uint                       =    jit_nfloat_to_uint                      ;
		alias to_ulong                      =    jit_nfloat_to_ulong                     ;
		
		/** Convert types with overflow detection. */
		interface ovf {  
			alias to_int                 =    jit_nfloat_to_int_ovf                   ; ///Convert a native floating-point value into an integer, with overflow detection.  Returns <code>JIT_RESULT_OK</code> if the conversion was successful or <code>JIT_RESULT_OVERFLOW</code> if an overflow occurred. 
			alias to_long                =    jit_nfloat_to_long_ovf                  ;
			alias to_uint                =    jit_nfloat_to_uint_ovf                  ;
			alias to_ulong               =    jit_nfloat_to_ulong_ovf                 ;
		}
	}

}

/** 
* Many of the structures in the libjit library can have user-supplied metadata associated with them. 
* Metadata may be used to store dependency graphs, branch prediction information, 
* or any other information that is useful to optimizers or code generators. 
* 
* Metadata can also be used by higher level user code to store information about the structures that 
* is specific to the user’s virtual machine or language. 
* 
* The library structures have special-purpose metadata routines associated with them 
* (e.g. jit_function_set_meta, jit_block_get_meta). However, sometimes you may wish to create your 
* own metadata lists and attach them to your own structures.
*/
interface meta {
	alias set                           = jit_meta_set                               ; ///Set a metadata value on a list.  If the <var>type</var> is already present in the list, then its previous value will be freed.  The <var>free_func</var> is called when the metadata value is freed with <code>jit_meta_free</code> or <code>jit_meta_destroy</code>.  Returns zero if out of memory. </p> <p>If <var>pool_owner</var> is not NULL, then the metadata value will persist until the specified function is finished building.  Normally you would set this to NULL. </p> <p>Metadata type values of 10000 or greater are reserved for internal use. They should never be used by external user code. 
	alias get                           = jit_meta_get                               ; ///Get the value associated with <var>type</var> in the specified <var>list</var>. Returns NULL if <var>type</var> is not present. 
	alias free                          = jit_meta_free                              ; ///Free the metadata value in the <var>list</var> that has the specified <var>type</var>.  Does nothing if the <var>type</var> is not present. 
	alias destroy                       = jit_meta_destroy                           ; ///Destroy all of the metadata values in the specified <var>list</var>. 
}

/**
The @code{libjit} library does not implement a particular object model
of its own, so that it is generic across bytecode formats and front end
languages.  However, it does provide support for plugging object models
into the JIT process, and for transparently proxying to external libraries
that may use a foreign object model.

There may be more than one object model active in the system at any
one time.  For example, a JVM implementation might have a primary
object model for its own use, and a secondary object model for
calling methods in an imported Objective C library.

The functions in this section support pluggable object models.  There is
no requirement that you use them: you can ignore them and use the rest
of @code{libjit} directly if you wish.

To create a new object model, you would include the file
@code{<jit/jit-objmodel-private.h>} and create an instance of
the @code{struct jit_objmodel} type.  This instance should be
populated with pointers to your object model's handler routines.
You then use functions from the list below to access the
object model.

Some standard object models are distributed with @code{libjit}
for invoking methods in external C++, Objective C, GCJ, and JNI
based libraries.
*/
interface objModel {
	/** Operations on object model classes. */
	interface Class {
		alias get_by_name               = jitom_get_class_by_name                    ;
		alias add_ref                   = jitom_class_add_ref                        ;
		alias Delete                    = jitom_class_delete                         ;
		alias get_all_supers            = jitom_class_get_all_supers                 ;
		alias get_fields                = jitom_class_get_fields                     ;
		alias get_interfaces            = jitom_class_get_interfaces                 ;
		alias get_methods               = jitom_class_get_methods                    ;
		alias get_modifiers             = jitom_class_get_modifiers                  ;
		alias get_name                  = jitom_class_get_name                       ;
		alias get_primary_super         = jitom_class_get_primary_super              ;
		alias get_type                  = jitom_class_get_type                       ;
		alias get_value_type            = jitom_class_get_value_type                 ;
		alias New                       = jitom_class_new                            ;
		alias new_value                 = jitom_class_new_value                      ;
    }

	
	alias destroy                       = jitom_destroy_model                        ;
    
	/** Operations on object model fields. */
	interface field {
		alias get_modifiers             = jitom_field_get_modifiers                  ;
		alias get_name                  = jitom_field_get_name                       ;
		alias get_type                  = jitom_field_get_type                       ;
		alias load                      = jitom_field_load                           ;
		alias load_address              = jitom_field_load_address                   ;
		alias store                     = jitom_field_store                          ;
    }
    
	/** Operations on object model methods. */
	interface method {
		alias get_modifiers             = jitom_method_get_modifiers                 ;
		alias get_name                  = jitom_method_get_name                      ;
		alias get_type                  = jitom_method_get_type                      ;
		alias invoke                    = jitom_method_invoke                        ;
		alias invoke_virtual            = jitom_method_invoke_virtual                ;
    }
	
	/*** Manipulate types that represent objects and inline values. */
	interface type {
		alias get_class                 = jitom_type_get_class                       ;
		alias get_model                 = jitom_type_get_model                       ;
		alias is_class                  = jitom_type_is_class                        ;
		alias is_value                  = jitom_type_is_value                        ;
		alias tag_as_class              = jitom_type_tag_as_class                    ;
		alias tag_as_value              = jitom_type_tag_as_value                    ;
	}
}

/** create and manipulate objects that represent native system types. 
For example, jit_type_int represents the signed 32-bit integer type. */
interface type {
	alias copy                          = jit_type_copy                              ; ///Make a copy of the type descriptor <var>type</var> by increasing its reference count.
	alias free                          = jit_type_free                              ; ///Free a type descriptor by decreasing its reference count. This function is safe to use on pre-defined types, which are never actually freed.
	alias create_struct                 = jit_type_create_struct                     ; ///Create a type descriptor for a structure.  Returns NULL if out of memory. If there are no fields, then the size of the structure will be zero. It is necessary to add a padding field if the language does not allow zero-sized structures.  The reference counts on the field types are incremented if <var>incref</var> is non-zero. </p> <p>The <code>libjit</code> library does not provide any special support for implementing structure inheritance, where one structure extends the definition of another.  The effect of inheritance can be achieved by always allocating the first field of a structure to be an instance of the inherited structure.  Multiple inheritance can be supported by allocating several special fields at the front of an inheriting structure. </p> <p>Similarly, no special support is provided for vtables.  The program is responsible for allocating an appropriate slot in a structure to contain the vtable pointer, and dereferencing it wherever necessary. The vtable will itself be a structure, containing signature types for each of the method slots. </p> <p>The choice not to provide special support for inheritance and vtables in <code>libjit</code> was deliberate.  The layout of objects and vtables is highly specific to the language and virtual machine being emulated, and no single scheme can hope to capture all possibilities.
	alias create_union                  = jit_type_create_union                      ; ///Create a type descriptor for a union.  Returns NULL if out of memory. If there are no fields, then the size of the union will be zero. It is necessary to add a padding field if the language does not allow zero-sized unions.  The reference counts on the field types are incremented if <var>incref</var> is non-zero.
	alias create_signature              = jit_type_create_signature                  ; ///Create a type descriptor for a function signature.  Returns NULL if out of memory.  The reference counts on the component types are incremented if <var>incref</var> is non-zero. </p> <p>When used as a structure or union field, function signatures are laid out like pointers.  That is, they represent a pointer to a function that has the specified parameters and return type. </p>  <p>The <var>abi</var> parameter specifies the Application Binary Interface (ABI) that the function uses.  It may be one of the following values: </p> </dd>  <code>jit_abi_cdecl</code></dt> <dd><p>Use the native C ABI definitions of the underlying platform. </p>  </dd>  <code>jit_abi_vararg</code></dt> <dd><p>Use the native C ABI definitions of the underlying platform, and allow for an optional list of variable argument parameters. </p> </dd>  <code>jit_abi_stdcall</code></dt> <dd><p>Use the Win32 STDCALL ABI definitions, whereby the callee pops its arguments rather than the caller.  If the platform does not support this type of ABI, then <code>jit_abi_stdcall</code> will be identical to <code>jit_abi_cdecl</code>. </p></dd>  <code>jit_abi_fastcall</code></dt> <dd><p>Use the Win32 FASTCALL ABI definitions, whereby the callee pops its arguments rather than the caller, and the first two word arguments are passed in ECX and EDX.  If the platform does not support this type of ABI, then <code>jit_abi_fastcall</code> will be identical to <code>jit_abi_cdecl</code>. </p></dd> </dl> </dd></dl>
	alias create_pointer                = jit_type_create_pointer                    ; ///Create a type descriptor for a pointer to another type.  Returns NULL if out of memory.  The reference count on <var>type</var> is incremented if <var>incref</var> is non-zero.
	alias create_tagged                 = jit_type_create_tagged                     ; ///Tag a type with some additional user data.  Tagging is typically used by higher-level programs to embed extra information about a type that <code>libjit</code> itself does not support. </p> <p>As an example, a language might have a 16-bit Unicode character type and a 16-bit unsigned integer type that are distinct types, even though they share the same fundamental representation (<code>jit_ushort</code>). Tagging allows the program to distinguish these two types, when it is necessary to do so, without affecting <code>libjit</code>&rsquo;s ability to compile the code efficiently. </p> <p>The <var>kind</var> is a small positive integer value that the program can use to distinguish multiple tag types.  The <var>data</var> pointer is the actual data that you wish to store.  And <var>free_func</var> is a function that is used to free <var>data</var> when the type is freed with <code>jit_type_free</code>. </p> <p>If you need to store more than one piece of information, you can tag a type multiple times.  The order in which multiple tags are applied is irrelevant to <code>libjit</code>, although it may be relevant to the higher-level program. </p> <p>Tag kinds of 10000 or greater are reserved for <code>libjit</code> itself. The following special tag kinds are currently provided in the base implementation: </p></dd>  <code>JIT_TYPETAG_NAME</code></dt> <dd><p>The <var>data</var> pointer is a <code>char *</code> string indicating a friendly name to display for the type. </p></dd>  <code>JIT_TYPETAG_STRUCT_NAME</code></dt>  <code>JIT_TYPETAG_UNION_NAME</code></dt>  <code>JIT_TYPETAG_ENUM_NAME</code></dt> <dd><p>The <var>data</var> pointer is a <code>char *</code> string indicating a friendly name to display for a <code>struct</code>, <code>union</code>, or <code>enum</code> type. This is for languages like C that have separate naming scopes for typedef&rsquo;s and structures. </p> </dd>  <code>JIT_TYPETAG_CONST</code></dt> <dd><p>The underlying value is assumed to have <code>const</code> semantics. The <code>libjit</code> library doesn&rsquo;t enforce such semantics: it is up to the front-end to only use constant values in appopriate contexts. </p></dd>  <code>JIT_TYPETAG_VOLATILE</code></dt> <dd><p>The underlying value is assumed to be volatile.  The <code>libjit</code> library will automatically call <code>jit_value_set_volatile</code> when a value is constructed using this type. </p> </dd>  <code>JIT_TYPETAG_REFERENCE</code></dt> <dd><p>The underlying value is a pointer, but it is assumed to refer to a pass-by-reference parameter. </p>  </dd>  <code>JIT_TYPETAG_OUTPUT</code></dt> <dd><p>This is similar to <code>JIT_TYPETAG_REFERENCE</code>, except that the underlying parameter is assumed to be output-only. </p> </dd>  <code>JIT_TYPETAG_RESTRICT</code></dt> <dd><p>The underlying type is marked as <code>restrict</code>.  Normally ignored. </p></dd>  <code>JIT_TYPETAG_SYS_BOOL</code></dt>  <code>JIT_TYPETAG_SYS_CHAR</code></dt>  <code>JIT_TYPETAG_SYS_SCHAR</code></dt>  <code>JIT_TYPETAG_SYS_UCHAR</code></dt>  <code>JIT_TYPETAG_SYS_SHORT</code></dt>  <code>JIT_TYPETAG_SYS_USHORT</code></dt>  <code>JIT_TYPETAG_SYS_INT</code></dt>  <code>JIT_TYPETAG_SYS_UINT</code></dt>  <code>JIT_TYPETAG_SYS_LONG</code></dt>  <code>JIT_TYPETAG_SYS_ULONG</code></dt>  <code>JIT_TYPETAG_SYS_LONGLONG</code></dt>  <code>JIT_TYPETAG_SYS_ULONGLONG</code></dt>  <code>JIT_TYPETAG_SYS_FLOAT</code></dt>  <code>JIT_TYPETAG_SYS_DOUBLE</code></dt>  <code>JIT_TYPETAG_SYS_LONGDOUBLE</code></dt> <dd><p>Used to mark types that we know for a fact correspond to the system C types of the corresponding names.  This is primarily used to distinguish system types like <code>int</code> and <code>long</code> types on 32-bit platforms when it is necessary to do so.  The <code>jit_type_sys_xxx</code> values are all tagged in this manner. </p></dd> </dl> </dd></dl>  
	alias set_names                     = jit_type_set_names                         ; ///Set the field or parameter names for <var>type</var>.  Returns zero if there is insufficient memory to set the names. </p> <p>Normally fields are accessed via their index.  Field names are a convenience for front ends that prefer to use names to indices.
	alias set_size_and_alignment        = jit_type_set_size_and_alignment            ; ///Set the size and alignment information for a structure or union type.  Use this for performing explicit type layout.  Normally the size is computed automatically.  Ignored if not a structure or union type.  Setting either value to -1 will cause that value to be computed automatically.
	alias set_offset                    = jit_type_set_offset                        ; ///Set the offset of a specific structure field.  Use this for performing explicit type layout.  Normally the offset is computed automatically.  Ignored if not a structure type, or the field index is out of range.
	alias get_kind                      = jit_type_get_kind                          ; ///Get a value that indicates the kind of <var>type</var>.  This allows callers to quickly classify a type to determine how it should be handled further. </p><dd> </dd>  <code>JIT_TYPE_INVALID</code></dt> <dd><p>The value of the <var>type</var> parameter is NULL. </p>  </dd>  <code>JIT_TYPE_VOID</code></dt> <dd><p>The type is <code>jit_type_void</code>. </p>  </dd>  <code>JIT_TYPE_SBYTE</code></dt> <dd><p>The type is <code>jit_type_sbyte</code>. </p>  </dd>  <code>JIT_TYPE_UBYTE</code></dt> <dd><p>The type is <code>jit_type_ubyte</code>. </p>  </dd>  <code>JIT_TYPE_SHORT</code></dt> <dd><p>The type is <code>jit_type_short</code>. </p>  </dd>  <code>JIT_TYPE_USHORT</code></dt> <dd><p>The type is <code>jit_type_ushort</code>. </p>  </dd>  <code>JIT_TYPE_INT</code></dt> <dd><p>The type is <code>jit_type_int</code>. </p>  </dd>  <code>JIT_TYPE_UINT</code></dt> <dd><p>The type is <code>jit_type_uint</code>. </p>  </dd>  <code>JIT_TYPE_NINT</code></dt> <dd><p>The type is <code>jit_type_nint</code>. </p>  </dd>  <code>JIT_TYPE_NUINT</code></dt> <dd><p>The type is <code>jit_type_nuint</code>. </p>  </dd>  <code>JIT_TYPE_LONG</code></dt> <dd><p>The type is <code>jit_type_long</code>. </p>  </dd>  <code>JIT_TYPE_ULONG</code></dt> <dd><p>The type is <code>jit_type_ulong</code>. </p>  </dd>  <code>JIT_TYPE_FLOAT32</code></dt> <dd><p>The type is <code>jit_type_float32</code>. </p>  </dd>  <code>JIT_TYPE_FLOAT64</code></dt> <dd><p>The type is <code>jit_type_float64</code>. </p>  </dd>  <code>JIT_TYPE_NFLOAT</code></dt> <dd><p>The type is <code>jit_type_nfloat</code>. </p>  </dd>  <code>JIT_TYPE_STRUCT</code></dt> <dd><p>The type is the result of calling <code>jit_type_create_struct</code>. </p>  </dd>  <code>JIT_TYPE_UNION</code></dt> <dd><p>The type is the result of calling <code>jit_type_create_union</code>. </p>  </dd>  <code>JIT_TYPE_SIGNATURE</code></dt> <dd><p>The type is the result of calling <code>jit_type_create_signature</code>. </p>  </dd>  <code>JIT_TYPE_PTR</code></dt> <dd><p>The type is the result of calling <code>jit_type_create_pointer</code>. </p></dd> </dl>   <p>If this function returns <code>JIT_TYPE_FIRST_TAGGED</code> or higher, then the type is tagged and its tag kind is the return value minus <code>JIT_TYPE_FIRST_TAGGED</code>.  That is, the following two expressions will be identical if <var>type</var> is tagged: </p> <code>jit_type_get_tagged_kind(type) jit_type_get_kind(type) - JIT_TYPE_FIRST_TAGGED </code> </dd></dl>  
	alias get_size                      = jit_type_get_size                          ; ///Get the size of a type in bytes.
	alias get_alignment                 = jit_type_get_alignment                     ; ///Get the alignment of a type.  An alignment value of 2 indicates that the type should be aligned on a two-byte boundary, for example.
	alias num_fields                    = jit_type_num_fields                        ; ///Get the number of fields in a structure or union type.
	alias get_field                     = jit_type_get_field                         ; ///Get the type of a specific field within a structure or union. Returns NULL if not a structure or union, or the index is out of range.
	alias get_offset                    = jit_type_get_offset                        ; ///Get the offset of a specific field within a structure. Returns zero if not a structure, or the index is out of range, so this is safe to use on non-structure types.
	alias get_name                      = jit_type_get_name                          ; ///Get the name of a structure, union, or signature field/parameter. Returns NULL if not a structure, union, or signature, the index is out of range, or there is no name associated with the component.
	alias find_name                     = jit_type_find_name                         ; ///Find the field/parameter index for a particular name.  Returns <code>JIT_INVALID_NAME</code> if the name was not present.
	alias num_params                    = jit_type_num_params                        ; ///Get the number of parameters in a signature type.
	alias get_return                    = jit_type_get_return                        ; ///Get the return type from a signature type.  Returns NULL if not a signature type.
	alias get_param                     = jit_type_get_param                         ; ///Get a specific parameter from a signature type.  Returns NULL if not a signature type or the index is out of range.
	alias get_abi                       = jit_type_get_abi                           ; ///Get the ABI code from a signature type.  Returns <code>jit_abi_cdecl</code> if not a signature type.
	alias get_ref                       = jit_type_get_ref                           ; ///Get the type that is referred to by a pointer type.  Returns NULL if not a pointer type.
	alias get_tagged_type               = jit_type_get_tagged_type                   ; ///Get the kind of tag that is applied to a tagged type.  Returns -1 if not a tagged type.
	alias set_tagged_type               = jit_type_set_tagged_type                   ; ///Set the type that underlies a tagged type.  Ignored if <var>type</var> is not a tagged type.  If <var>type</var> already has an underlying type, then the original is freed. </p> <p>This function is typically used to flesh out the body of a forward-declared type.  The tag is used as a placeholder until the definition can be located.
	alias get_tagged_kind               = jit_type_get_tagged_kind                   ;
	alias get_tagged_data               = jit_type_get_tagged_data                   ; ///Get the user data is associated with a tagged type.  Returns NULL if not a tagged type.
	alias set_tagged_data               = jit_type_set_tagged_data                   ; ///Set the user data is associated with a tagged type.  The original data, if any, is freed.
	alias is_primitive                  = jit_type_is_primitive                      ; ///Determine if a type is primitive.
	alias is_struct                     = jit_type_is_struct                         ; ///Determine if a type is a structure.
	alias is_union                      = jit_type_is_union                          ; ///Determine if a type is a union.
	alias is_signature                  = jit_type_is_signature                      ; ///Determine if a type is a function signature.
	alias is_pointer                    = jit_type_is_pointer                        ; ///Determine if a type is a pointer.
	alias is_tagged                     = jit_type_is_tagged                         ; ///Determine if a type is a tagged type.
	alias best_alignment                = jit_type_best_alignment                    ; ///Get the best alignment value for this platform.
	alias normalize                     = jit_type_normalize                         ; ///Normalize a type to its basic numeric form.  e.g. &quot;jit_type_nint&quot; is turned into &quot;jit_type_int&quot; or &quot;jit_type_long&quot;, depending upon the underlying platform.  Pointers are normalized like &quot;jit_type_nint&quot;. If the type does not have a normalized form, it is left unchanged. </p> <p>Normalization is typically used prior to applying a binary numeric instruction, to make it easier to determine the common type. It will also remove tags from the specified type.
	alias remove_tags                   = jit_type_remove_tags                       ; ///Remove tags from a type, and return the underlying type. This is different from normalization, which will also collapses native types to their basic numeric counterparts.
	alias promote_int                   = jit_type_promote_int                       ; ///If <var>type</var> is <code>jit_type_sbyte</code> or <code>jit_type_short</code>, then return <code>jit_type_int</code>.  If <var>type</var> is <code>jit_type_ubyte</code> or <code>jit_type_ushort</code>, then return <code>jit_type_uint</code>.  Otherwise return <var>type</var> as-is.
	alias return_via_pointer            = jit_type_return_via_pointer                ; ///Determine if a type should be returned via a pointer if it appears as the return type in a signature.
	alias has_tag                       = jit_type_has_tag                           ; ///Determine if <var>type</var> has a specific kind of tag.  This will resolve multiple levels of tagging.
}

/**
* Values form the backbone of the storage system in libjit. 
* Every value in the system, be it a constant, a local variable, or
* a temporary result, is represented by an object of type jit_value_t.
* The JIT then allocates registers or memory locations to the
* values as appropriate. 
*/
interface value {
	interface create {
		alias create                    =  jit_value_create                          ; ///Create a new value in the context of a function&rsquo;s current block. The value initially starts off as a block-specific temporary. It will be converted into a function-wide local variable if it is ever referenced from a different block.  Returns NULL if out of memory. </p> <p>Note: It isn&rsquo;t possible to refer to global variables directly using values.  If you need to access a global variable, then load its address into a temporary and use <code>jit_insn_load_relative</code> or <code>jit_insn_store_relative</code> to manipulate it.  It simplifies the JIT if it can assume that all values are local.
		alias constant                  =  jit_value_create_constant                 ; ///Create a new constant from a generic constant structure in the specified function.  Returns NULL if out of memory or if the type in <var>const_value</var> is not suitable for a constant.
		alias float32_constant          =  jit_value_create_float32_constant         ; ///Create a new 32-bit floating-point constant in the specified function.  Returns NULL if out of memory.
		alias float64_constant          =  jit_value_create_float64_constant         ; ///Create a new 64-bit floating-point constant in the specified function.  Returns NULL if out of memory.
		alias long_constant             =  jit_value_create_long_constant            ; ///Create a new 64-bit integer constant in the specified function.  This can also be used to create constants of type <code>jit_type_ulong</code>.  Returns NULL if out of memory.
		alias nfloat_constant           =  jit_value_create_nfloat_constant          ; ///Create a new native floating-point constant in the specified function.  Returns NULL if out of memory.
		alias nint_constant             =  jit_value_create_nint_constant            ; ///Create a new native integer constant in the specified function. Returns NULL if out of memory. </p> <p>The <var>type</var> parameter indicates the actual type of the constant, if it happens to be something other than <code>jit_type_nint</code>. For example, the following will create an unsigned byte constant: </p> <code>value = jit_value_create_nint_constant(context, jit_type_ubyte, 128); </code>  <p>This function can be used to create constants of type <code>jit_type_sbyte</code>, <code>jit_type_ubyte</code>, <code>jit_type_short</code>, <code>jit_type_ushort</code>, <code>jit_type_int</code>, <code>jit_type_uint</code>, <code>jit_type_nint</code>, <code>jit_type_nuint</code>, and all pointer types.
	}

	interface get {
		alias block                     =  jit_value_get_block                       ; ///Get the block which owns a particular <var>value</var>.
		alias constant                  =  jit_value_get_constant                    ; ///Get the constant value within a particular <var>value</var>.  The returned structure&rsquo;s <code>type</code> field will be <code>jit_type_void</code> if <code>value</code> is not a constant.
		alias context                   =  jit_value_get_context                     ; ///Get the context which owns a particular <var>value</var>.
		alias float32_constant          =  jit_value_get_float32_constant            ; ///Get the constant value within a particular <var>value</var>, assuming that its type is compatible with <code>jit_type_float32</code>.
		alias float64_constant          =  jit_value_get_float64_constant            ; ///Get the constant value within a particular <var>value</var>, assuming that its type is compatible with <code>jit_type_float64</code>.
		alias Function                  =  jit_value_get_function                    ; ///Get the function which owns a particular <var>value</var>.
		alias long_constant             =  jit_value_get_long_constant               ; ///Get the constant value within a particular <var>value</var>, assuming that its type is compatible with <code>jit_type_long</code>.
		alias nfloat_constant           =  jit_value_get_nfloat_constant             ; ///Get the constant value within a particular <var>value</var>, assuming that its type is compatible with <code>jit_type_nfloat</code>.
		alias nint_constant             =  jit_value_get_nint_constant               ; ///Get the constant value within a particular <var>value</var>, assuming that its type is compatible with <code>jit_type_nint</code>.
		alias param                     =  jit_value_get_param                       ; ///Get the value that corresponds to a specified function parameter. Returns NULL if out of memory.
		alias struct_pointer            =  jit_value_get_struct_pointer              ; ///Get the value that contains the structure return pointer for a function.  If the function does not have a structure return pointer (i.e. structures are returned in registers), then this returns NULL.
		alias type                      =  jit_value_get_type                        ; ///Get the type that is associated with a value.
	}

	interface Is {
		alias addressable               =  jit_value_is_addressable                  ; ///Determine if a value is addressable.
		alias constant                  =  jit_value_is_constant                     ; ///Determine if a value is a constant.
		alias local                     =  jit_value_is_local                        ; ///Determine if a value is local.  i.e. its scope extends over multiple blocks within its function.
		alias parameter                 =  jit_value_is_parameter                    ; ///Determine if a value is a function parameter.
		alias temporary                 =  jit_value_is_temporary                    ; ///Determine if a value is temporary.  i.e. its scope extends over a single block within its function.
		alias True                      =  jit_value_is_true                         ; ///Determine if <var>value</var> is constant and non-zero.
		alias Volatile                  =  jit_value_is_volatile                     ; ///Determine if a value is volatile.
	}		  
	
	alias Ref                           =  jit_value_ref                             ; ///Create a reference to the specified <var>value</var> from the current block in <var>func</var>.  This will convert a temporary value into a local value if <var>value</var> is being referenced from a different block than its original. </p> <p>It is not necessary that <var>func</var> be the same function as the one where the value was originally created.  It may be a nested function, referring to a local variable in its parent function.
	alias constant_convert              =  jit_constant_convert                      ; ///Convert a the constant <var>value</var> into a new <var>type</var>, and return its value in <var>result</var>.  Returns zero if the conversion is not possible, usually due to overflow.
	
	interface set {	
		alias addressable               =  jit_value_set_addressable                 ; ///Set a flag on a value to indicate that it is addressable. This should be used when you want to take the address of a value (e.g. <code>&amp;variable</code> in C).  The value is guaranteed to not be stored in a register across a function call. If you refer to a value from a nested function (<code>jit_value_ref</code>), then the value will be automatically marked as addressable.
		alias Volatile                  =  jit_value_set_volatile                    ; ///Set a flag on a value to indicate that it is volatile.  The contents of the value must always be reloaded from memory, never from a cached register copy.
	}
}


/**
* Manipulating ELF binaries
* 
* The libjit library contains routines that permit pre-compiling JIT’ed functions into an on-disk representation. 
* This representation can be loaded at some future time, to avoid the overhead of compiling the functions at runtime. 
* 
* We use the ELF format for this purpose, which is a common binary format used by modern operating systems and compilers. 
* 
* It isn’t necessary for your operating system to be based on ELF natively. 
* We use our own routines to read and write ELF binaries. We chose ELF because it has all of the features that we require, 
* and reusing an existing format was better than inventing a completely new one
*/
interface readElf {
	alias open                          =    jit_readelf_open                        ; ///Open the specified <var>filename</var> and load the ELF binary that is contained within it.  Returns one of the following result codes: </p> <dd> </dd> <dt> <code>JIT_READELF_OK</code></dt> <dd><p>The ELF binary was opened successfully. </p>  </dd> <dt> <code>JIT_READELF_CANNOT_OPEN</code></dt> <dd><p>Could not open the file at the filesystem level (reason in <code>errno</code>). </p>  </dd> <dt> <code>JIT_READELF_NOT_ELF</code></dt> <dd><p>The file was opened, but it is not an ELF binary. </p>  </dd> <dt> <code>JIT_READELF_WRONG_ARCH</code></dt> <dd><p>The file is an ELF binary, but it does not pertain to the architecture of this machine. </p>  </dd> <dt> <code>JIT_READELF_BAD_FORMAT</code></dt> <dd><p>The file is an ELF binary, but the format is corrupted in some fashion. </p>  </dd> <dt> <code>JIT_READELF_MEMORY</code></dt> <dd><p>There is insufficient memory to open the ELF binary. </p></dd> </dl>  <p>The following flags may be supplied to alter the manner in which the ELF binary is loaded: </p> <dd> </dd> <dt> <code>JIT_READELF_FLAG_FORCE</code></dt> <dd><p>Force <code>jit_readelf_open</code> to open the ELF binary, even if the architecture does not match this machine.  Useful for debugging. </p>  </dd> <dt> <code>JIT_READELF_FLAG_DEBUG</code></dt> <dd><p>Print additional debug information to stdout. </p></dd> </dl> </dd></dl>  <dl> <dt>jit_readelf_close <dd><p>Close an ELF reader, reclaiming all of the memory that was used. 
	alias close                         =    jit_readelf_close                       ;
	alias get_name                      =    jit_readelf_get_name                    ; ///Get the library name that is embedded inside an ELF binary. ELF binaries can refer to each other using this name. 
	alias get_symbol                    =    jit_readelf_get_symbol                  ; ///Look up the symbol called <var>name</var> in the ELF binary represented by <var>readelf</var>.  Returns NULL if the symbol is not present. </p> <p>External references from this ELF binary to others are not resolved until the ELF binary is loaded into a JIT context using <code>jit_readelf_add_to_context</code> and <code>jit_readelf_resolve_all</code>. You should not call functions within this ELF binary until after you have fully resolved it. 
	alias get_section                   =    jit_readelf_get_section                 ; ///Get the address and size of a particular section from an ELF binary. Returns NULL if the section is not present in the ELF binary. </p> <p>The virtual machine may have stored auxillary information in the section when the binary was first generated.  This function allows the virtual machine to retrieve its auxillary information. </p> <p>Examples of such information may be version numbers, timestamps, checksums, and other identifying information for the bytecode that was previously compiled by the virtual machine.  The virtual machine can use this to determine if the ELF binary is up to date and relevant to its needs. </p> <p>It is recommended that virtual machines prefix their special sections with a unique string (e.g. <code>.foovm</code>) to prevent clashes with system-defined section names.  The prefix <code>.libjit</code> is reserved for use by <code>libjit</code> itself. 
	alias get_section_by_type           =    jit_readelf_get_section_by_type         ; ///Get a particular section using its raw ELF section type (i.e. one of the <code>SHT_*</code> constants in <code>jit-elf-defs.h</code>).  This is mostly for internal use, but some virtual machines may find it useful for debugging purposes. 
	alias map_vaddr                     =    jit_readelf_map_vaddr                   ; ///Map a virtual address to an actual address in a loaded ELF binary. Returns NULL if <var>vaddr</var> could not be mapped. 
	alias num_needed                    =    jit_readelf_num_needed                  ; ///Get the number of dependent libraries that are needed by this ELF binary.  The virtual machine will normally need to arrange to load these libraries with <code>jit_readelf_open</code> as well, so that all of the necessary symbols can be resolved. 
	alias get_needed                    =    jit_readelf_get_needed                  ; ///Get the name of the dependent library at position <var>index</var> within the needed libraries list of this ELF binary.  Returns NULL if the <var>index</var> is invalid. 
	alias add_to_context                =    jit_readelf_add_to_context              ; ///Add this ELF binary to a JIT context, so that its contents can be used when executing JIT-managed code.  The binary will be closed automatically if the context is destroyed and <code>jit_readelf_close</code> has not been called explicitly yet. </p> <p>The functions in the ELF binary cannot be used until you also call <code>jit_readelf_resolve_all</code> to resolve cross-library symbol references. The reason why adding and resolution are separate steps is to allow for resolving circular dependencies between ELF binaries. 
	alias resolve_all                   =    jit_readelf_resolve_all                 ; ///Resolve all of the cross-library symbol references in ELF binaries that have been added to <var>context</var> but which were not resolved in the previous call to this function.  If <var>print_failures</var> is non-zero, then diagnostic messages will be written to stdout for any symbol resolutions that fail. </p> <p>Returns zero on failure, or non-zero if all symbols were successfully resolved.  If there are no ELF binaries awaiting resolution, then this function will return a non-zero result. 
	alias register_symbol               =    jit_readelf_register_symbol             ; ///Register <var>value</var> with <var>name</var> on the specified <var>context</var>. Whenever symbols are resolved with <code>jit_readelf_resolve_all</code>, and the symbol <var>name</var> is encountered, <var>value</var> will be substituted.  Returns zero if out of memory or there is something wrong with the parameters. </p> <p>If <var>after</var> is non-zero, then <var>name</var> will be resolved after all other ELF libraries; otherwise it will be resolved before the ELF libraries. </p> <p>This function is used to register intrinsic symbols that are specific to the front end virtual machine.  References to intrinsics within <code>libjit</code> itself are resolved automatically. 
}

/**
* Manipulating ELF binaries
* 
* The libjit library contains routines that permit pre-compiling JIT’ed functions into an on-disk representation. 
* This representation can be loaded at some future time, to avoid the overhead of compiling the functions at runtime. 
* 
* We use the ELF format for this purpose, which is a common binary format used by modern operating systems and compilers. 
* 
* It isn’t necessary for your operating system to be based on ELF natively. 
* We use our own routines to read and write ELF binaries. We chose ELF because it has all of the features that we require, 
* and reusing an existing format was better than inventing a completely new one
*/
interface writeElf {
	alias create                        =    jit_writeelf_create                     ;
	alias destroy                       =    jit_writeelf_destroy                    ;
	alias write                         =    jit_writeelf_write                      ;
	alias add_function                  =    jit_writeelf_add_function               ;
	alias add_needed                    =    jit_writeelf_add_needed                 ;
	alias write_section                 =    jit_writeelf_write_section              ;
}


/*** Diagnostic routines */
interface dump {
	alias type                          =    jit_dump_type                           ; ///Dump the name of a type to a stdio stream. 
	alias value                         =    jit_dump_value                          ; ///Dump the name of a value to a stdio stream.  If <var>prefix</var> is not NULL, then it indicates a type prefix to add to the value name. If <var>prefix</var> is NULL, then this function intuits the type prefix. 
	alias insn                          =    jit_dump_insn                           ; ///Dump the contents of an instruction to a stdio stream. 
	alias Function                      =    jit_dump_function                       ; ///Dump the three-address instructions within a function to a stream. The <var>name</var> is attached to the output as a friendly label, but has no other significance. </p> <p>If the function has not been compiled yet, then this will dump the three address instructions from the build process.  Otherwise it will disassemble and dump the compiled native code. 
}

/**
* Dynamic libraries
* 
* The following routines are supplied to help load and inspect dynamic libraries. 
* They should be used in place of the traditional dlopen, dlclose, and dlsym functions, 
* which are not portable across operating systems.
*/
interface dynamicLib {
	alias open                          =    jit_dynlib_open                         ;
	alias close                         =    jit_dynlib_close                        ; ///Close a dynamic library. 
	alias get_symbol                    =    jit_dynlib_get_symbol                   ; ///Retrieve the symbol <var>symbol</var> from the specified dynamic library. Returns NULL if the symbol could not be found.  This will try both non-prefixed and underscore-prefixed forms of <var>symbol</var> on platforms where it makes sense to do so, so there is no need for the caller to perform prefixing. 
	alias get_suffix                    =    jit_dynlib_get_suffix                   ; ///Get the preferred dynamic library suffix for this platform. Usually something like <code>so</code>, <code>dll</code>, or <code>dylib</code>. 
	alias set_debug                     =    jit_dynlib_set_debug                    ; ///Enable or disable additional debug messages to stderr.  Debugging is disabled by default.  Normally the dynamic library routines will silently report errors via NULL return values, leaving reporting up to the caller. However, it can be useful to turn on additional diagnostics when tracking down problems with dynamic loading. 
}

interface mangle {
	alias global_function               =    jit_mangle_global_function              ; ///Mangle the name of a global C++ function using the specified <var>form</var>. Returns NULL if out of memory, or if the form is not supported. 
	alias member_function               =    jit_mangle_member_function              ; ///Mangle the name of a C++ member function using the specified <var>form</var>. Returns NULL if out of memory, or if the form is not supported. The following flags may be specified to modify the mangling rules: </p>  <dd> </dd> <dt> <code>JIT_MANGLE_PUBLIC</code></dt> <dd><p>The method has <code>public</code> access within its containing class. </p>  </dd> <dt> <code>JIT_MANGLE_PROTECTED</code></dt> <dd><p>The method has <code>protected</code> access within its containing class. </p>  </dd> <dt> <code>JIT_MANGLE_PRIVATE</code></dt> <dd><p>The method has <code>private</code> access within its containing class. </p>  </dd> <dt> <code>JIT_MANGLE_STATIC</code></dt> <dd><p>The method is <code>static</code>. </p>  </dd> <dt> <code>JIT_MANGLE_VIRTUAL</code></dt> <dd><p>The method is a virtual instance method.  If neither <code>JIT_MANGLE_STATIC</code> nor <code>JIT_MANGLE_VIRTUAL</code> are supplied, then the method is assumed to be a non-virtual instance method. </p>  </dd> <dt> <code>JIT_MANGLE_CONST</code></dt> <dd><p>The method is an instance method with the <code>const</code> qualifier. </p>  </dd> <dt> <code>JIT_MANGLE_EXPLICIT_THIS</code></dt> <dd><p>The <var>signature</var> includes an extra pointer parameter at the start that indicates the type of the <code>this</code> pointer.  This parameter won&rsquo;t be included in the final mangled name. </p>  </dd> <dt> <code>JIT_MANGLE_IS_CTOR</code></dt> <dd><p>The method is a constructor.  The <var>name</var> parameter will be ignored. </p>  </dd> <dt> <code>JIT_MANGLE_IS_DTOR</code></dt> <dd><p>The method is a destructor.  The <var>name</var> parameter will be ignored. </p>  </dd> <dt> <code>JIT_MANGLE_BASE</code></dt> <dd><p>Fetch the &quot;base&quot; constructor or destructor entry point, rather than the &quot;complete&quot; entry point. </p></dd> </dl>  <p>The <var>class_name</var> may include namespace and nested parent qualifiers by separating them with <code>::</code> or <code>.</code>.  Class names that involve template parameters are not supported yet. 
}


/**
* Hooking a breakpoint debugger into libjit
* 
* The libjit library provides support routines for breakpoint-based single-step debugging. 
* It isn’t a full debugger, but provides the infrastructure necessary to support one. 
* 
* The front end virtual machine is responsible for inserting "potential breakpoints"
*  into the code when functions are built and compiled.
*/
interface debugger {
	alias debugging_possible            =    jit_debugging_possible                  ; ///Determine if debugging is possible.  i.e. that threading is available and compatible with the debugger&rsquo;s requirements. 
	alias create                        =    jit_debugger_create                     ; ///Create a new debugger instance and attach it to a JIT <var>context</var>. If the context already has a debugger associated with it, then this function will return the previous debugger. 
	alias destroy                       =    jit_debugger_destroy                    ; ///Destroy a debugger instance. 
	alias get_context                   =    jit_debugger_get_context                ; ///Get the JIT context that is associated with a debugger instance. 
	alias from_context                  =    jit_debugger_from_context               ; ///Get the debugger that is currently associated with a JIT <var>context</var>, or NULL if there is no debugger associated with the context. 
	alias get_self                      =    jit_debugger_get_self                   ; ///Get the thread identifier associated with the current thread. The return values are normally values like 1, 2, 3, etc, allowing the user interface to report messages like &quot;thread 3 has stopped at a breakpoint&quot;. 
	alias get_thread                    =    jit_debugger_get_thread                 ; ///Get the thread identifier for a specific native thread.  The <var>native_thread</var> pointer is assumed to point at a block of memory containing a native thread handle.  This would be a <code>pthread_t</code> on Pthreads platforms or a <code>HANDLE</code> on Win32 platforms.  If the native thread has not been seen previously, then a new thread identifier is allocated. 
	alias get_native_thread             =    jit_debugger_get_native_thread          ; ///Get the native thread handle associated with a debugger thread identifier. Returns non-zero if OK, or zero if the debugger thread identifier is not yet associated with a native thread handle. 
	alias set_breakable                 =    jit_debugger_set_breakable              ; ///Set a flag that indicates if a native thread can stop at breakpoints. If set to 1 (the default), breakpoints will be active on the thread. If set to 0, breakpoints will be ignored on the thread.  Typically this is used to mark threads associated with the debugger&rsquo;s user interface, or the virtual machine&rsquo;s finalization thread, so that they aren&rsquo;t accidentally suspended by the debugger (which might cause a deadlock). 
	alias attach_self                   =    jit_debugger_attach_self                ; ///Attach the current thread to a debugger.  If <var>stop_immediately</var> is non-zero, then the current thread immediately suspends, waiting for the user to start it with <code>jit_debugger_run</code>.  This function is typically called in a thread&rsquo;s startup code just before any &quot;real work&quot; is performed. 
	alias detach_self                   =    jit_debugger_detach_self                ; ///Detach the current thread from the debugger.  This is typically called just before the thread exits. 
	alias wait_event                    =    jit_debugger_wait_event                 ; ///Wait for the next debugger event to arrive.  Debugger events typically indicate breakpoints that have occurred.  The <var>timeout</var> is in milliseconds, or -1 for an infinite timeout period.  Returns non-zero if an event has arrived, or zero on timeout. 
	alias add_breakpoint                =    jit_debugger_add_breakpoint             ; ///Add a hard breakpoint to a debugger instance.  The <var>info</var> structure defines the conditions under which the breakpoint should fire. The fields of <var>info</var> are as follows: </p> <dt> <code>flags</code></dt> <dd><p>Flags that indicate which of the following fields should be matched. If a flag is not present, then all possible values of the field will match. Valid flags are <code>JIT_DEBUGGER_FLAG_THREAD</code>, <code>JIT_DEBUGGER_FLAG_FUNCTION</code>, <code>JIT_DEBUGGER_FLAG_DATA1</code>, and <code>JIT_DEBUGGER_FLAG_DATA2</code>. </p> </dd> <dt> <code>thread</code></dt> <dd><p>The thread to match against, if <code>JIT_DEBUGGER_FLAG_THREAD</code> is set. </p> </dd> <dt> <code>function</code></dt> <dd><p>The function to match against, if <code>JIT_DEBUGGER_FLAG_FUNCTION</code> is set. </p> </dd> <dt> <code>data1</code></dt> <dd><p>The <code>data1</code> value to match against, if <code>JIT_DEBUGGER_FLAG_DATA1</code> is set. </p> </dd> <dt> <code>data2</code></dt> <dd><p>The <code>data2</code> value to match against, if <code>JIT_DEBUGGER_FLAG_DATA2</code> is set. </p></dd> </dl>  <p>The following special values for <code>data1</code> are recommended for marking breakpoint locations with <code>jit_insn_mark_breakpoint</code>: </p> <dt> <code>JIT_DEBUGGER_DATA1_LINE</code></dt> <dd><p>Breakpoint location that corresponds to a source line.  This is used to determine where to continue to upon a &quot;step&quot;. </p> </dd> <dt> <code>JIT_DEBUGGER_DATA1_ENTER</code></dt> <dd><p>Breakpoint location that corresponds to the start of a function. </p> </dd> <dt> <code>JIT_DEBUGGER_DATA1_LEAVE</code></dt> <dd><p>Breakpoint location that corresponds to the end of a function, just prior to a <code>return</code> statement.  This is used to determine where to continue to upon a &quot;finish&quot;. </p> </dd> <dt> <code>JIT_DEBUGGER_DATA1_THROW</code></dt> <dd><p>Breakpoint location that corresponds to an exception throw. </p></dd> </dl> </dd></dl>  <dl> <dt>jit_debugger_remove_breakpoint <dd><p>Remove a previously defined breakpoint from a debugger instance. 
	alias remove_breakpoint             =    jit_debugger_remove_breakpoint          ;
	alias remove_all_breakpoints        =    jit_debugger_remove_all_breakpoints     ; ///Remove all breakpoints from a debugger instance. 
	alias is_alive                      =    jit_debugger_is_alive                   ; ///Determine if a particular thread is still alive. 
	alias is_running                    =    jit_debugger_is_running                 ; ///Determine if a particular thread is currently running (non-zero) or stopped (zero). 
	alias run                           =    jit_debugger_run                        ; ///Start the specified thread running, or continue from the last breakpoint. </p> <p>This function, and the others that follow, sends a request to the specified thread and then returns to the caller immediately. 
	alias step                          =    jit_debugger_step                       ; ///Step over a single line of code.  If the line performs a method call, then this will step into the call.  The request will be ignored if the thread is currently running. 
	alias next                          =    jit_debugger_next                       ; ///Step over a single line of code but do not step into method calls. The request will be ignored if the thread is currently running. 
	alias finish                        =    jit_debugger_finish                     ; ///Keep running until the end of the current function.  The request will be ignored if the thread is currently running. 
	alias Break                         =    jit_debugger_break                      ; ///Force an explicit user breakpoint at the current location within the current thread.  Control returns to the caller when the debugger calls one of the above &quot;run&quot; or &quot;step&quot; functions in another thread. 
	alias quit                          =    jit_debugger_quit                       ; ///Sends a request to the thread that called <code>jit_debugger_wait_event</code> indicating that the debugger should quit. 
	alias set_hook                      =    jit_debugger_set_hook                   ; ///Set a debugger hook on a JIT context.  Returns the previous hook. </p> <p>Debug hooks are a very low-level breakpoint mechanism.  Upon reaching each breakpoint in a function, a user-supplied hook function is called. It is up to the hook function to decide whether to stop execution or to ignore the breakpoint.  The hook function has the following prototype: </p> <table><tr><td>&nbsp;</td><td><code>void hook(jit_function_t func, jit_nint data1, jit_nint data2); <code></td></tr></table>  <p>The <code>func</code> argument indicates the function that the breakpoint occurred within.  The <code>data1</code> and <code>data2</code> arguments are those supplied to <code>jit_insn_mark_breakpoint</code>.  The debugger can use these values to indicate information about the breakpoint&rsquo;s type and location. </p> <p>Hook functions can be used for other purposes besides breakpoint debugging.  For example, a program could be instrumented with hooks that tally up the number of times that each function is called, or which profile the amount of time spent in each function. </p> <p>By convention, <code>data1</code> values less than 10000 are intended for use by user-defined hook functions.  Values of 10000 and greater are reserved for the full-blown debugger system described earlier. 
}


interface vmem {
	alias init                          =    jit_vmem_init                           ;
	alias page_size                     =    jit_vmem_page_size                      ;
	alias round_up                      =    jit_vmem_round_up                       ;
	alias round_down                    =    jit_vmem_round_down                     ;
	alias reserve                       =    jit_vmem_reserve                        ;
	alias reserve_committed             =    jit_vmem_reserve_committed              ;
	alias release                       =    jit_vmem_release                        ;
	alias commit                        =    jit_vmem_commit                         ;
	alias decommit                      =    jit_vmem_decommit                       ;
	alias protect                       =    jit_vmem_protect                        ;
}

interface unwind {
	alias init                          = jit_unwind_init                            ;
	alias free                          = jit_unwind_free                            ;
	alias next                          = jit_unwind_next                            ;
	alias next_pc                       = jit_unwind_next_pc                         ;
	alias get_pc                        = jit_unwind_get_pc                          ;
	alias jump                          = jit_unwind_jump                            ;
	alias get_function                  = jit_unwind_get_function                    ;
	alias get_offset                    = jit_unwind_get_offset                      ;
}
/*
private interface _ObjModel {

	jit_objmodel _jit_objmodel                                                       ;
	
	alias  destroy                      = _jit_objmodel.destroy_model                ;

	interface Class {              
		alias  get_by_name              = _jit_objmodel.get_class_by_name            ;
		alias  get_name                 = _jit_objmodel.class_get_name               ;
		alias  get_modifiers            = _jit_objmodel.class_get_modifiers          ;
		alias  get_type                 = _jit_objmodel.class_get_type               ;
		alias  get_value_type           = _jit_objmodel.class_get_value_type         ;
		alias  get_primary_super        = _jit_objmodel.class_get_primary_super      ;
		alias  get_all_supers           = _jit_objmodel.class_get_all_supers         ;
		alias  get_interfaces           = _jit_objmodel.class_get_interfaces         ;
		alias  get_fields               = _jit_objmodel.class_get_fields             ;
		alias  get_methods              = _jit_objmodel.class_get_methods            ;
		alias  New                      = _jit_objmodel.class_new                    ;
		alias  new_value                = _jit_objmodel.class_new_value              ;
		alias  Delete                   = _jit_objmodel.class_delete                 ;
		alias  add_ref                  = _jit_objmodel.class_add_ref                ;
	}                              
	interface field {              
		alias  get_name                 = _jit_objmodel.field_get_name               ;
		alias  get_type                 = _jit_objmodel.field_get_type               ;
		alias  get_modifiers            = _jit_objmodel.field_get_modifiers          ;
		alias  load                     = _jit_objmodel.field_load                   ;
		alias  load_address             = _jit_objmodel.field_load_address           ;
		alias  store                    = _jit_objmodel.field_store                  ;
	}                              

	interface method {             
		alias  get_name                 = _jit_objmodel.method_get_name              ;
		alias  get_type                 = _jit_objmodel.method_get_type              ;
		alias  get_modifiers            = _jit_objmodel.method_get_modifiers         ;
		alias  invoke                   = _jit_objmodel.method_invoke                ;
		alias  invoke_virtual           = _jit_objmodel.method_invoke_virtual        ;
	}
}
*/
















