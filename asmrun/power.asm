#*********************************************************************
#*                                                                   *
#*                          Objective Caml                           *
#*                                                                   *
#*           Xavier Leroy, projet Cristal, INRIA Rocquencourt        *
#*                                                                   *
#* Copyright 1996 Institut National de Recherche en Informatique et  *
#* Automatique.  Distributed only by permission.                     *
#*                                                                   *
#*********************************************************************

# $Id$

        .comm   young_start, 4
        .comm   young_ptr, 4
        .comm   caml_bottom_of_stack, 4
        .comm   caml_top_of_stack, 4
        .comm   caml_last_return_address, 4
        .comm   caml_exception_pointer, 4
        .comm   gc_entry_regs, 4*32
        .comm   gc_entry_float_regs, 8*32

        .csect  .text[PR]

#### Invoke the garbage collector. r0 contains the return address

        .globl  .caml_call_gc
.caml_call_gc:
    # Set up stack frame for calling the garbage collector
        stwu    1, -64(1)
    # Record last return address into Caml code
        lwz     28, L..caml_last_return_address(2)
        stw     0, 0(28)
    # Record return address into call_gc stub code
        mflr    0
        stw     0, 72(1)
    # Record lowest stack address
        lwz     28, L..caml_bottom_of_stack(2)
	addic	0, 1, 64
        stw     0, 0(28)
    # Save current allocation pointer for debugging purposes
        lwz     28, L..young_ptr(2)
        stw     31, 0(28)
    # Save exception pointer (if e.g. a sighandler raises)
        lwz     28, L..caml_exception_pointer(2)
        stw     29, 0(28)
    # Save all registers used by the code generator
        lwz     28, L..gc_entry_regs(2)
        addic   28, 28, -4
        stwu    3, 4(28)
        stwu    4, 4(28)
        stwu    5, 4(28)
        stwu    6, 4(28)
        stwu    7, 4(28)
        stwu    8, 4(28)
        stwu    9, 4(28)
        stwu    10, 4(28)
        stwu    11, 4(28)
        stwu    12, 4(28)
        stwu    13, 4(28)
        stwu    14, 4(28)
        stwu    15, 4(28)
        stwu    16, 4(28)
        stwu    17, 4(28)
        stwu    18, 4(28)
        stwu    19, 4(28)
        stwu    20, 4(28)
        stwu    21, 4(28)
        stwu    22, 4(28)
        stwu    23, 4(28)
        stwu    24, 4(28)
        stwu    25, 4(28)
        stwu    26, 4(28)
        stwu    27, 4(28)
        lwz     28, L..gc_entry_float_regs(2)
        addic   28, 28, -8
        stfdu   1, 8(28)
        stfdu   2, 8(28)
        stfdu   3, 8(28)
        stfdu   4, 8(28)
        stfdu   5, 8(28)
        stfdu   6, 8(28)
        stfdu   7, 8(28)
        stfdu   8, 8(28)
        stfdu   9, 8(28)
        stfdu   10, 8(28)
        stfdu   11, 8(28)
        stfdu   12, 8(28)
        stfdu   13, 8(28)
        stfdu   14, 8(28)
        stfdu   15, 8(28)
        stfdu   16, 8(28)
        stfdu   17, 8(28)
        stfdu   18, 8(28)
        stfdu   19, 8(28)
        stfdu   20, 8(28)
        stfdu   21, 8(28)
        stfdu   22, 8(28)
        stfdu   23, 8(28)
        stfdu   24, 8(28)
        stfdu   25, 8(28)
        stfdu   26, 8(28)
        stfdu   27, 8(28)
        stfdu   28, 8(28)
        stfdu   29, 8(28)
        stfdu   30, 8(28)
        stfdu   31, 8(28)
    # Call the GC
        bl      .garbage_collection
        or      0, 0, 0
    # Reload new allocation pointer and allocation limit
        lwz     28, L..young_ptr(2)
        lwz     31, 0(28)
        lwz     28, L..young_limit(2)
        lwz     30, 0(28)
    # Restore all regs used by the code generator
        lwz     28, L..gc_entry_regs(2)
        addic   28, 28, -4
        lwzu    3, 4(28)
        lwzu    4, 4(28)
        lwzu    5, 4(28)
        lwzu    6, 4(28)
        lwzu    7, 4(28)
        lwzu    8, 4(28)
        lwzu    9, 4(28)
        lwzu    10, 4(28)
        lwzu    11, 4(28)
        lwzu    12, 4(28)
        lwzu    13, 4(28)
        lwzu    14, 4(28)
        lwzu    15, 4(28)
        lwzu    16, 4(28)
        lwzu    17, 4(28)
        lwzu    18, 4(28)
        lwzu    19, 4(28)
        lwzu    20, 4(28)
        lwzu    21, 4(28)
        lwzu    22, 4(28)
        lwzu    23, 4(28)
        lwzu    24, 4(28)
        lwzu    25, 4(28)
        lwzu    26, 4(28)
        lwzu    27, 4(28)
        lwz     28, L..gc_entry_float_regs(2)
        addic   28, 28, -8
        lfdu    1, 8(28)
        lfdu    2, 8(28)
        lfdu    3, 8(28)
        lfdu    4, 8(28)
        lfdu    5, 8(28)
        lfdu    6, 8(28)
        lfdu    7, 8(28)
        lfdu    8, 8(28)
        lfdu    9, 8(28)
        lfdu    10, 8(28)
        lfdu    11, 8(28)
        lfdu    12, 8(28)
        lfdu    13, 8(28)
        lfdu    14, 8(28)
        lfdu    15, 8(28)
        lfdu    16, 8(28)
        lfdu    17, 8(28)
        lfdu    18, 8(28)
        lfdu    19, 8(28)
        lfdu    20, 8(28)
        lfdu    21, 8(28)
        lfdu    22, 8(28)
        lfdu    23, 8(28)
        lfdu    24, 8(28)
        lfdu    25, 8(28)
        lfdu    26, 8(28)
        lfdu    27, 8(28)
        lfdu    28, 8(28)
        lfdu    29, 8(28)
        lfdu    30, 8(28)
        lfdu    31, 8(28)
    # Return to caller (the stub code), leaving return address into
    # Caml code in the link register
        lwz     0, 72(1)
        mtctr   0
        lwz     28, L..caml_last_return_address(2)
        lwz     0, 0(28)
        addic   0, 0, -16     # Restart the allocation (4 instructions)
        mtlr    0
    # Deallocate stack frame
        addi    1, 1, 64
    # Return
        bctr

#### Call a C function from Caml

        .globl  .caml_c_call
.caml_c_call:
	mflr    25
    # Record lowest stack address and return address
        lwz     27, L..caml_bottom_of_stack(2)
        lwz     26, L..caml_last_return_address(2)
        stw     1, 0(27)
        stw     25, 0(26)
    # Make the exception handler and alloc ptr available to the C code
        lwz     27, L..young_ptr(2)
        lwz     26, L..caml_exception_pointer(2)
        stw     31, 0(27)
        stw     29, 0(26)
    # Preserve RTOC and return address in callee-save registers
    # The C function will preserve them, and the Caml code does not
    # expect them to be preserved
    # Return address is in 25, RTOC is in 26, pointer to young_ptr in 27
        mr      26, 2
    # Call the function (descriptor in 28)
        lwz     0, 0(28)
        lwz     2, 4(28)
        mtlr    0
        lwz     11, 8(28)
        blrl
    # Restore return address
        mtlr    25
    # Restore RTOC
        mr      2, 26
    # Reload allocation pointer
        lwz     31, 0(27)             # 27 still points to young_ptr
    # Return to caller
        blr
        
#### Raise an exception from C

        .globl  .raise_caml_exception
.raise_caml_exception:
    # Reload Caml global registers
        lwz     4, L..caml_exception_pointer(2)
        lwz     5, L..young_ptr(2)
        lwz     6, L..young_limit(2)
        lwz     1, 0(4)
        lwz     31, 0(5)
        lwz     30, 0(6)
    # Say we are back into Caml code
        lwz     4, L..caml_last_return_address(2)
        li      0, 0
        stw     0, 0(4)
    # Pop trap frame
        lwz     0, 0(1)
        lwz     29, 4(1)
        mtlr    0
        lwz     2, 20(1)
        addi    1, 1, 24
    # Branch to handler
        blr

#### Start the Caml program

        .globl  .caml_start_program
.caml_start_program:
        mflr    0
    # Save return address
	stw 0, 8(1)
    # Save all callee-save registers
	stw 13, -76(1)
	stw 14, -72(1)
	stw 15, -68(1)
	stw 16, -64(1)
	stw 17, -60(1)
	stw 18, -56(1)
	stw 19, -52(1)
	stw 20, -48(1)
	stw 21, -44(1)
	stw 22, -40(1)
	stw 23, -36(1)
	stw 24, -32(1)
	stw 25, -28(1)
	stw 26, -24(1)
	stw 27, -20(1)
	stw 28, -16(1)
	stw 29, -12(1)
	stw 30, -8(1)
	stw 31, -4(1)
        stfd 14, -224(1)
        stfd 15, -216(1)
        stfd 16, -208(1)
        stfd 17, -200(1)
        stfd 18, -192(1)
        stfd 19, -184(1)
        stfd 20, -176(1)
        stfd 21, -168(1)
        stfd 22, -160(1)
        stfd 23, -152(1)
        stfd 24, -144(1)
        stfd 25, -136(1)
        stfd 26, -128(1)
        stfd 27, -120(1)
        stfd 28, -112(1)
        stfd 29, -104(1)
        stfd 30, -96(1)
        stfd 31, -88(1)
    # Allocate and link stack frame
	stwu    1, -280(1)
    # Build an exception handler
        bl      L..100
        b       L..101
L..100:
        addi    1, 1, -24
        mflr    0
        stw     0, 0(1)
        stw     2, 20(1)
        mr      29, 1
    # Record highest stack address
        lwz     3, L..caml_top_of_stack(2)
        stw     1, 0(3)
    # Initialize allocation registers
        lwz     3, L..young_ptr(2)
        lwz     31, 0(3)
        lwz     3, L..young_limit(2)
        lwz     30, 0(3)
    # Say we are inside Caml code
        lwz     3, L..caml_last_return_address(2)
        li      0, 0
        stw     0, 0(3)
    # Go for it
        bl      .caml_program
        or      0, 0, 0
    # Pop handler
        addi    1, 1, 24
    # Return with zero code
        li      3, 0
L..101:
    # Deallocate stack frame
	addi    1, 1, 280
    # Restore callee-save registers
	lwz 13, -76(1)
	lwz 14, -72(1)
	lwz 15, -68(1)
	lwz 16, -64(1)
	lwz 17, -60(1)
	lwz 18, -56(1)
	lwz 19, -52(1)
	lwz 20, -48(1)
	lwz 21, -44(1)
	lwz 22, -40(1)
	lwz 23, -36(1)
	lwz 24, -32(1)
	lwz 25, -28(1)
	lwz 26, -24(1)
	lwz 27, -20(1)
	lwz 28, -16(1)
	lwz 29, -12(1)
	lwz 30, -8(1)
	lwz 31, -4(1)
        lfd 14, -224(1)
        lfd 15, -216(1)
        lfd 16, -208(1)
        lfd 17, -200(1)
        lfd 18, -192(1)
        lfd 19, -184(1)
        lfd 20, -176(1)
        lfd 21, -168(1)
        lfd 22, -160(1)
        lfd 23, -152(1)
        lfd 24, -144(1)
        lfd 25, -136(1)
        lfd 26, -128(1)
        lfd 27, -120(1)
        lfd 28, -112(1)
        lfd 29, -104(1)
        lfd 30, -96(1)
        lfd 31, -88(1)
    # Reload return address
	lwz 0, 8(1)
	mtlr 0
    # Return
        blr

#### Callback from C to Caml

        .globl  .callback
.callback:
    # Initial shuffling of arguments
        mr      0, 3            # Closure
        mr      3, 4            # Argument
        mr      4, 0
        lwz     28, 0(4)        # Code pointer
L..102:
        mflr    0
    # Save return address
	stw 0, 8(1)
    # Save all callee-save registers
	stw 13, -76(1)
	stw 14, -72(1)
	stw 15, -68(1)
	stw 16, -64(1)
	stw 17, -60(1)
	stw 18, -56(1)
	stw 19, -52(1)
	stw 20, -48(1)
	stw 21, -44(1)
	stw 22, -40(1)
	stw 23, -36(1)
	stw 24, -32(1)
	stw 25, -28(1)
	stw 26, -24(1)
	stw 27, -20(1)
	stw 28, -16(1)
	stw 29, -12(1)
	stw 30, -8(1)
	stw 31, -4(1)
        stfd 14, -224(1)
        stfd 15, -216(1)
        stfd 16, -208(1)
        stfd 17, -200(1)
        stfd 18, -192(1)
        stfd 19, -184(1)
        stfd 20, -176(1)
        stfd 21, -168(1)
        stfd 22, -160(1)
        stfd 23, -152(1)
        stfd 24, -144(1)
        stfd 25, -136(1)
        stfd 26, -128(1)
        stfd 27, -120(1)
        stfd 28, -112(1)
        stfd 29, -104(1)
        stfd 30, -96(1)
        stfd 31, -88(1)
    # Allocate and link stack frame
	stwu    1, -280(1)
    # Set up a callback link
        addi    1, 1, -24
        lwz     9, L..caml_bottom_of_stack(2)
        lwz     10, L..caml_last_return_address(2)
        lwz     9, 0(9)
        lwz     10, 0(10)
        stw     9, 0(1)
        stw     10, 4(1)
    # Build an exception handler to catch exceptions escaping out of Caml
        bl      L..103
        b       L..104
L..103:
        addi    1, 1, -24
        lwz     9, L..caml_exception_pointer(2)
        mflr    0
        lwz     29, 0(9)
        stw     0, 0(1)
        stw     29, 4(1)
        stw     2, 20(1)
        mr      29, 1
    # Reload allocation pointers
        lwz     11, L..young_ptr(2)
        lwz     12, L..young_limit(2)
        lwz     31, 0(11)
        lwz     30, 0(12)
    # Say we are back into Caml code
        lwz     9, L..caml_last_return_address(2)
        li      0, 0
        stw     0, 0(9)
    # Call the Caml code
        lwz     0, 0(28)
        stw     2, 20(1)
        mtlr    0
        lwz     2, 4(28)
L..105:
        blrl
        lwz     2, 20(1)
    # Pop the trap frame, restoring caml_exception_pointer
        lwz     9, 4(1)
        lwz     10, L..caml_exception_pointer(2)
        addi    1, 1, 24
        stw     9, 0(10)
    # Pop the callback link, restoring caml_bottom_of_stack
    # and caml_last_return_address
        lwz     9, 0(1)
        lwz     10, 4(1)        
        lwz     11, L..caml_bottom_of_stack(2)
        lwz     12, L..caml_last_return_address(2)
        stw     9, 0(11)
        stw     10, 0(12)
        addi    1, 1, 24
    # Update allocation pointer
        lwz     11, L..young_ptr(2)
        stw     31, 0(11)
    # Deallocate stack frame
	addi    1, 1, 280
    # Restore callee-save registers
	lwz 13, -76(1)
	lwz 14, -72(1)
	lwz 15, -68(1)
	lwz 16, -64(1)
	lwz 17, -60(1)
	lwz 18, -56(1)
	lwz 19, -52(1)
	lwz 20, -48(1)
	lwz 21, -44(1)
	lwz 22, -40(1)
	lwz 23, -36(1)
	lwz 24, -32(1)
	lwz 25, -28(1)
	lwz 26, -24(1)
	lwz 27, -20(1)
	lwz 28, -16(1)
	lwz 29, -12(1)
	lwz 30, -8(1)
	lwz 31, -4(1)
        lfd 14, -224(1)
        lfd 15, -216(1)
        lfd 16, -208(1)
        lfd 17, -200(1)
        lfd 18, -192(1)
        lfd 19, -184(1)
        lfd 20, -176(1)
        lfd 21, -168(1)
        lfd 22, -160(1)
        lfd 23, -152(1)
        lfd 24, -144(1)
        lfd 25, -136(1)
        lfd 26, -128(1)
        lfd 27, -120(1)
        lfd 28, -112(1)
        lfd 29, -104(1)
        lfd 30, -96(1)
        lfd 31, -88(1)
    # Reload return address
	lwz 0, 8(1)
	mtlr 0
    # Return
        blr
    # The trap handler:
L..104:
    # Update caml_exception_pointer and young_ptr
        lwz     9, L..caml_exception_pointer(2)
        lwz     10, L..young_ptr(2)
        stw     29, 0(9)
        stw     31, 0(10)
    # Pop the callback link, restoring caml_bottom_of_stack
    # and caml_last_return_address
        lwz     9, 0(1)
        lwz     10, 4(1)        
        lwz     11, L..caml_bottom_of_stack(2)
        lwz     12, L..caml_last_return_address(2)
        stw     9, 0(11)
        stw     10, 0(12)
    # Re-raise the exception through mlraise,
    # so that local C roots are cleaned up correctly
        b       .mlraise

        .globl  .callback2
.callback2:
        mr      0, 3            # Closure
        mr      3, 4            # First argument
        mr      4, 5            # Second argument
        mr      5, 0
        lwz     28, L..caml_apply2(2)
        b       L..102
        
        .globl  .callback3
.callback3:
        mr      0, 3            # Closure
        mr      3, 4            # First argument
        mr      4, 5            # Second argument
        mr      5, 6            # Third argument
        mr      6, 0
        lwz     28, L..caml_apply3(2)
        b       L..102

#### Frame table

        .csect  .data[RW]
        .globl  system_frametable
system_frametable:
        .long   1               # one descriptor
        .long   L..105 + 4      # return address into callback
        .short  -1              # negative size count => use callback link
        .short  0               # no roots here

#### TOC entries

        .toc
L..young_limit:
        .tc     young_limit[TC], young_limit
L..young_ptr:
        .tc     young_ptr[TC], young_ptr
L..caml_bottom_of_stack:
        .tc     caml_bottom_of_stack[TC], caml_bottom_of_stack
L..caml_top_of_stack:
        .tc     caml_top_of_stack[TC], caml_top_of_stack
L..caml_last_return_address:
        .tc     caml_last_return_address[TC], caml_last_return_address
L..caml_exception_pointer:
        .tc     caml_exception_pointer[TC], caml_exception_pointer
L..gc_entry_regs:
        .tc     gc_entry_regs[TC], gc_entry_regs
L..gc_entry_float_regs:
        .tc     gc_entry_float_regs[TC], gc_entry_float_regs
L..caml_apply2:
        .tc     caml_apply2[TC], caml_apply2
L..caml_apply3:
        .tc     caml_apply3[TC], caml_apply3

#### Function closures

        .csect  caml_call_gc[DS]
caml_call_gc:
        .long   .caml_call_gc, TOC[tc0], 0

        .globl  caml_c_call
        .csect  caml_c_call[DS]
caml_c_call:
        .long   .caml_c_call, TOC[tc0], 0

        .globl  raise_caml_exception
        .csect  raise_caml_exception[DS]
raise_caml_exception:
        .long   .raise_caml_exception, TOC[tc0], 0

        .globl  caml_start_program
        .csect  caml_start_program[DS]
caml_start_program:
        .long   .caml_start_program, TOC[tc0], 0

        .globl  callback
        .csect  callback[DS]
callback:
        .long   .callback, TOC[tc0], 0

        .globl  callback2
        .csect  callback2[DS]
callback2:
        .long   .callback2, TOC[tc0], 0

        .globl  callback3
        .csect  callback3[DS]
callback3:
        .long   .callback3, TOC[tc0], 0

