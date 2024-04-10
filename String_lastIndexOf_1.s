.global String_lastIndexOf_1

// String_lastIndexOf_1: Returns the last occurrence of character 'ch' in string 'string1'.
// Parameters:
//   x0: Pointer to the string (null-terminated)
//   w1: Character to search for
// Return value:
//   w0: Index of the last occurrence of 'ch' in 'string1', or -1 if not found.

String_lastIndexOf_1:

        // Initialize the current index (x2) and the last found index (x3) to -1
        MOV     X2,#0                           // Current index
        MOV     X3,#-1                  // Last found index, -1 indicates not found


// Loop start
loop:

        // Load the current character from the string into x4
        LDRB    W4,[X0,X2]

        // Check for end of string
        CMP     X4,#0
        BEQ     done                            // If zero (null terminator), loop is done

        // Compare the current character with the search character
        CMP     W4,W1
        BEQ     update_found    // Branch if equal (current char is a match)

        // Increment the current index and continue the loop
        ADD     X2,X2,#1
        B               loop                            // Continue looping


// Update found: Store the index of the matched character into x3
update_found:
        MOV     X3,X2
        ADD     X2,X2,#1
        B               loop


// Done: Set the return value to the last found index
done:
        MOV     X0,X3
        RET
