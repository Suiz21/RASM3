/**************** String_concat.s *****************/
// X0 = Address of main string
// X1 = Address of sub string
// X2 = temporary for character loading
// X3 = length of mainstr
// X4 = length of substr
// X5 = total length needed for new string (x3+x4+1 for null terminator)
// X6 = index for copying
// X7 = dynamically allocated memory address for the new string
.global String_concat
.extern malloc

String_concat:

        // Pushing onto stack
        STR     X30,[SP,#-16]!                          // Save x30 on the stack
        STR     X0,[SP,#-16]!                           // Save X0 on the stack, pre-decrement SP by 16
        STR     X1,[SP,#-16]!                           // Save X1 on the stack, pre-decrement SP by 16

        // Calculate the length of main string
        BL              String_length

        MOV     X3,X0                                                   // Store the length of mainstr in x3

        // Pop the stack as String_length affects our registers
        LDR     X1,[SP],#16                                     // Restore x0, post-increment sp by 16


        // Calculate length of substr
        MOV     X0,X1                                                   // Move substr into x0

        STR     X1,[SP,#-16]!                           // Save x1 on the stack

        BL              String_length                           // Call length

        MOV     X4,X0                                                   // Store the length of substr in x4

        STR     X3,[SP,#-16]!                           // Save x3 on the stack
        STR     X4,[SP,#-16]!                           // Save x4 on the stack

        // Add up lengths + 1 for size of new string
        ADD     X5,X4,X3                                                // Add lengths of strings
        ADD     X5,X5,#1                                                // Add 1 for null

        // Allocate dynamic memory of size X5
        MOV     X0,X5                                                   // Move size x5 into x0

        BL              malloc                                          // Call malloc

        // Store address/ptr of new string in x7
        MOV     X7,X0

        // Popping the stack
        LDR     X4,[SP],#16                                     // Restore x4
        LDR     X3,[SP],#16                                     // Restore x3
        LDR     X1,[SP],#16                                     // Restore x1, post-increment sp by 16
        LDR     X0,[SP],#16                                     // Restore x0, post-increment sp by 16
        LDR     X30,[SP],#16

// Copy mainstr to new memory
        MOV     X6,#0

copy_mainstr_loop:
        CMP     X6,X3                                                   // Check if we've copied all of mainstring
        BGE     copy_substr                                     // If yes, start copying substr

        LDRB    W2,[X0,X6]                                      // Load byte from mainstr
        STRB    W2,[X7,X6]                                      // Store byte in new string

        ADD     X6,X6,#1                                                // Increment index/loop control
        B               copy_mainstr_loop                       // Loop continuation

// Copy substr to new memory, after mainstr
copy_substr:
        SUB     X6,X6,X3                                                // Reset X6 for substr index

copy_substr_loop:
        CMP     X6,X4                                                   // Check if we've copied all of substr
        BGE     finish                                          // If yes, we're done

        LDRB    W2,[X1,X6]                                      // Load byte from substr
        ADD     X8,X6,X3                                                // Calculate offset for the new string

        STRB    W2,[X7,X8]                                      // Store byte in new string, after mainstr

        ADD     X6,X6,#1                                                // Increment index
        B               copy_substr_loop                        // Loop continuation

finish:
        // Null-terminate the new string
        MOV     W2,#0
        ADD     X5,X3,X4                                                // Calculate position for null terminator
        STRB    W2,[X7,X5]                                      // Store the null terminator

        // Return the address of the new string
        MOV     X0,X7
        RET
