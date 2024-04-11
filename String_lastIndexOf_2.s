.global String_lastIndexOf_2

// String_lastIndexOf_1: Returns the last occurrence of character 'ch' in string 'string1'.
// Parameters:
//   x0: Pointer to the string (null-terminated)
//   w1: Character to search for
// Return value:
//   w0: Index of the last occurrence of 'ch' in 'string1', or -1 if not found.


        /*// Initialize the last found index (x3) to -1
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
        RET*/

String_lastIndexOf_2:
    // Registers:
    // X0 = address of string1
    // X1 = character 'ch' to search for
    // X2 = fromIndex
    // X3 = current index in string1 (for the backward search)
    // X4 = length of string1
    // X5 = temporary storage for characters from string1 during comparison
    // X6 = last occurrence index, initialized to -1

    MOV     X3, X0                      // Copy base address of string1 to X3 for length calculation
    MOV     X4, #0                      // Initialize length counter

find_length:
    LDRB                 W5, [X3], #1           // Load byte from string1, post-increment X3

         CMP        W5, #0
         BEQ             length_found           // If zero (null-terminator), length is found

    ADD     X4, X4, #1          // Increment length counter
    B            find_length

length_found:
    SUB     X3, X4, #1          // Adjust X3 to point to the last character (X4 holds length, so subtract 1 for zero-based index)

    // Validate fromIndex, ensure it's not beyond the end of the string
    CMP     X2, X4
    BLT          start_search           // If fromIndex < length, start search from fromIndex
    MOV     X2, X3                      // If fromIndex >= length, start search from the end

start_search:
    ADD     X3, X0, X2          // Set X3 to the address to start the search from
    MOV     X6, #-1                     // Initialize last occurrence index to -1

search_loop:
    CMP     X3, X0
    BLT     return_index                // Exit condition: If X3 is less than X0, we've searched the whole string
    LDRB                 W5, [X3]               // Load the current character into W5
    SUB     X3, X3, #1          // Decrement X3 to move backwards through the string

    CMP     W5, W1                      // Compare the loaded character with 'ch'
    BEQ          char_found                     // If not equal, continue loop

    B            search_loop

char_found:
         SUB            X6, X3, X0                      // Calculate the index by subtracting base address of string1 from X3
    ADD                 X6, X6, #1                      // Adjust for the post-decrement
    B           return_index            // Jump to return the index

return_index:
    MOV     X0, X6                      // Move last occurrence index to X0 for return
    RET
