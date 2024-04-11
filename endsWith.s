.global endsWith
        .text
endsWith:
    // Assume x0 points to string1, x1 points to suffix
    // First, calculate lengths of string1 and suffix
    // Let's assume x2 will hold the length of string1, x3 for suffix

    // Calculate length of string1, result in x2

         // Push x30, x0 and x1 onto stack
         STR    X30,[SP,#-16]!
         STR    X0,[SP,#-16]!
    STR X1,[SP,#-16]!

         BL     String_length                                   // Calculate string1 length

    MOV X2,X0                                                           // Length in x2

         // Pop x1 off stack
         LDR    X1,[SP],#16

         MOV    X0,X1

         // Push x1 onto stack
         STR    X1,[SP,#-16]!
         // Push x2 onto stack
         STR    X2,[SP,#-16]!

    // Calculate length of suffix, result in x3

         BL     String_length                                   // Calc str1 length

         MOV    X3,X0

         LDR    X2,[SP],#16
         LDR    X1,[SP],#16
         LDR    X0,[SP],#16
         LDR    X30,[SP],#16

    // Compare lengths: if suffix is longer, return false
    CMP x3, x2
    BHI .return_false // Branch if suffix length > string1 length

    // Set pointers to the end of each string
    //ADD x0, x0, x2
         //SUB x0, x0, #1
    //ADD x1, x1, x3
         //SUB x1, x0, #1

    // Compare characters from the end
.loop_compare:
    // Correctly adjust the pointers before loading characters
    SUB x2, x2, #1 // Move backwards in string1
    SUB x3, x3, #1 // Move backwards in suffix

    // Calculate actual addresses for the current characters
    ADD x4, x0, x2 // Address of the current character in string1
    ADD x5, x1, x3 // Address of the current character in suffix

    // Load the characters from these addresses
    LDRB w4, [x4] // Load byte from string1
    LDRB w5, [x5] // Load byte from suffix

    CMP w4, w5
    B.NE .return_false // Branch if not equal
    CMP x3, #0
    B.GT .loop_compare // Continue if not at the start of suffix

    // If we reached here, all characters matched
    MOV x0, #1 // True
    RET

.return_false:
    MOV x0, #0 // False
    RET
