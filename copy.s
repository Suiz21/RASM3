/* Programmer: Aidan Ramirez
 * copy (RASM_3)
 * Purpose: Copies the string given
 * Author: Aidan Ramirez
 * Date last modified: 11 April 2024
 */

// Contract for String_length:
        // Subroutine length: Provided a pointer to a null terminated string, String_length will 
        //      return the length of the string in X0
        // X0: Must point to a null terminated string
        // LR: Must contain the return address
        // All AAPCS required registers are preserved,  r19-r29 and SP.


.global copy

    .data

ptrString:        .quad 0

    .text

// Subroutine String_copy
// X0: Must point to a null terminated string
// LR: Must contain the return address
// All AAPCS required registers are preserved
//        x0... are modified and not preserved


copy:

    mov    x7,x0                    // Set x7 = x0, contains pointer to string being copied
    mov    x2,#0                    // Set x2 = 0 (x2 will be the counter that holds length of string)

loop1_copy:

    add    x2,x2,#1                // Increment x2 by 1
    ldrb    w1,[x7],#1            // Set w1 = next character in string, increment
    cmp    w1,#0                    // Check if w1 is null
    beq    exit_copy            // Branch to exit  if the null character
    b        loop1_copy            // loop

exit_copy:

    mov    x4,x2             //

    str    x0,[SP,#-16]!        // push
    str    x4,[SP,#-16]!        // push
    str    x30,[SP,#-16]!       // push

    mov    x0,x2                    // Set x0 = x2, length of string
    bl        malloc                // Allocate enough bytes for length of string

    ldr    x1,=ptrString         // load 
    str    x0,[x1]               // store x0

    ldr    x30,[SP],#16    // pop
    ldr    x4,[SP],#16    // pop
    ldr    x0,[SP],#16

    ldr    x1,=ptrString  // load 
    ldr    x1,[x1]        // load into x1
    mov    x3,#0          // reset ciybter

loop2_copy:

    ldrb    w2,[x0,x3]        // load byte, increment 3
    strb    w2,[x1,x3]        // load byte, icnrement 3
    add    x3,x3,#1           // increment 3
    cmp    x3,x4              // check if x3 equals 4
    bne    loop2_copy         // if not, repeat

    mov    x0,x1              // copy register

    RET    LR

    .end
