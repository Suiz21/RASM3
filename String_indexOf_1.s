/****************************/
// Programmer: Alex Hwang
// Method: String_indexOf_1
//      Purpose: Returns the index of first occurrence of the specified character ch in
//          the string.
// Author: Dr. Barnett
// Date last modified: 4/9/2024


        .global String_indexOf_1                                // Pass entry point name to linker

        .data

        .text
String_indexOf_1:
        // AAPCS registers are preserved, not used
        // Input parameters: X0: Pointer to the string
        //                                                      X1: Character to find

        // Initialize index (From 0)
        MOV     X2,#0

        // Start of loop
loop:
        // Load the current character from the string
        LDRB    W3,[X0,X2]

        // Check if the current character is the specified character
        CMP     W3,W1                   // Compare current character with x1 (ch)
        BEQ     found                   // Branch if equal (character found)

        // Check if reached the end of the string (null terminator)
        MOV     W4,#0           // Load address of chNull

        CMP     W3,W4                   // Compare current character with null character
        BEQ     not_found       // Branch if equal (character = null)

        // Increment index and continue looping
        ADD     X2,X2,#1
        B               loop                    // Branch back to the start of the loop

// Character found
found:
        // Move index from x2 to x0
        MOV     X0,X2

        //      Return the index (in x0)
        RET     LR

// Character not found
not_found:
        // Return -1 (not found)
        MOV     X0,#-1
        RET     LR
