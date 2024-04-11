.section .text
.global String_lastIndexOf_3

// +String_lastIndexOf_3(string1: X0, str: X1): int
// Returns the index of last occurrence of string str.
String_lastIndexOf_3:

String_lastIndexOf_3:
    // X0 = address of string1
    // X1 = address of str
    // X2 = length of string1
    // X3 = length of str
    // X4 = current start index for comparison in string1
    // X9 = index for iteration through str
    // X10 = temporary flag for match indication
    // X11 = temporary storage for character comparison from string1
    // X12 = temporary storage for character comparison from str
    // X13 = last occurrence index, initialized to -1 (no match)

    // Step 1: Calculate lengths of string1 and str
    MOV     X2, X0                                                                                      // Use X2 to calculate length of string1
    MOV     X3, X1                                                                                      // Use X3 to calculate length of str
    MOV     X13, #-1                                                                            // Initialize last occurrence index to -1

calculate_string1_length:
    MOV     X2, #0                                                                                      // Initialize length to 0

count_string1_length_loop:
    LDRB    W11, [X0, X2]                                                               // Load byte from string1 at X2
    CBZ     W11, done_calculating_string1_length        // If byte is 0, end of string
    ADD     X2, X2, #1                                                                          // Increment length
    B       count_string1_length_loop

done_calculating_string1_length:

calculate_str_length:
    MOV     X3, #0                                                                                      // Initialize length to 0
count_str_length_loop:
    LDRB    W12, [X1, X3]                                                               // Load byte from str at X3
    CBZ     W12, done_calculating_str_length            // If byte is 0, end of str
    ADD     X3, X3, #1                                                                          // Increment length
    B       count_str_length_loop

done_calculating_str_length:

    // Subtract length of str from length of string1 to determine starting index
    SUB     X4, X2, X3
    // Check if str is longer than string1, which means no possible match
    CMP     X3, X2
    BGT     return_index

search_loop:
    // Ensure X4 doesn't go below 0
    CMP     X4, #0
    BLT     return_index

    MOV     X9, #0                                                                                      // Reset index for str
    MOV     X10, #1                                                                                     // Assume match until proven otherwise

compare_loop:
    CMP     X9, X3                                                                                      // Have we reached the end of str?
    BGE     check_match

         ADD            X14,X4,X9

    LDRB    W11, [X0, X14]                                                                      // Load character from string1 at current start index + X9
    LDRB    W12, [X1, X9]                                                       // Load character from str at X9
    CMP     W11, W12
    BNE     no_match_found                                                              // Characters do not match
    ADD     X9, X9, #1                                                                          // Move to next character in str
    B       compare_loop

no_match_found:
    MOV     X10, #0                                                                             // Match flag to false
    SUB     X4, X4, #1                                                                          // Decrement start index in string1
    B       search_loop

check_match:
    CMP     X10, #1
    BNE     search_loop                                                                         // No match, continue search
    MOV     X13, X4                                                                             // Match found, update last occurrence index
    SUB     X4, X4, #1                                                                          // Prepare for next search
    B       search_loop

return_index:
    MOV     X0, X13                                                                             // Set return value to last occurrence index
    RET
