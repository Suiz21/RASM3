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
    ldrb    w1,[x7],#1            // Set w1 = next character in string
    cmp    w1,#0                    // Check if w1 == null character
    beq    exit_copy            // Branch to exit as w1 is the null character
    b        loop1_copy            // Repeat the loop until the null character is found

exit_copy:

    mov    x4,x2

    str    x0,[SP,#-16]!        // String to copy
    str    x4,[SP,#-16]!        // Length of string
    str    x30,[SP,#-16]!

    mov    x0,x2                    // Set x0 = x2, length of string
    bl        malloc                // Allocate enough bytes for length of string

    ldr    x1,=ptrString
    str    x0,[x1]

    ldr    x30,[SP],#16
    ldr    x4,[SP],#16
    ldr    x0,[SP],#16

    ldr    x1,=ptrString
    ldr    x1,[x1]
    mov    x3,#0

loop2_copy:

    ldrb    w2,[x0,x3]
    strb    w2,[x1,x3]
    add    x3,x3,#1
    cmp    x3,x4
    bne    loop2_copy

    mov    x0,x1

    RET    LR

    .end
