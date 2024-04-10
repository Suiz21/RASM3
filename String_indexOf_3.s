/****************************/
// Programmer: Alex Hwang
// Method: String_indexOf_3
//      Purpose: This method returns the index of first occurrence of specified substring str (Passed in x1).
// Author: Dr. Barnett
// Date last modified: 4/9/2024


        .global String_indexOf_3                        // Pass entry point name to linker

        .data

        .text
String_indexOf_3:
        // AAPCS registers are preserved, not used
        // Input parameters: X0: Pointer to the main string
        //                                                      X1: Pointer to the sub-string


        // Initialize variables
   mov  x4, #0                          // Current position in main string
   mov  x5, #0                                  // Current position in substring

search_loop:
   ldrb w7, [x0, x4]                            // Load character from main string

        CMP     w7,#0                                                   // If end of main string is reached, branch to mainstring_null
        BEQ     mainstring_null


    // Compare characters of main string and substring
    ldrb w8, [x1, x5]                           // Load character from substring
        CMP     W8,#0
        BEQ     found
    cmp w7, w8                                  // Compare characters
    bne next_char                               // If characters don't match, go to next character in main string

    // Characters match, continue comparison
    add x4, x4, #1                              // Move to next character in main string
    add x5, x5, #1                              // Move to next character in substring
    cmp w8, #0                                  // Check if end of substring is reached
    beq found                                   // If end of substring is reached, substring is found

    // Continue comparison
    b search_loop

next_char:
    add x4, x4, #1                              // Move to next character in main string
    mov x5, #0                                  // Reset position in substring
    b search_loop                                                       // Branch to search_loop

// If mainstring is null, check to see if substring is null as well
// If substring index is null, substring is found
mainstring_null:
        LDRB    w8,[x1,x5]                                              // Load next char of substring
        cmp     w8,#0                                                           // Compare char with null
        BEQ     found                                                           // Substring is found

        B               not_found                                               // Else substring is not found

found:

    sub x0, x4, x5          // Calculate index of first occurrence of substring in main string
    ret

not_found:
    mov x0, #-1             // Substring not found, set index to -1
    ret
