// String_replace(string1:String,oldChar:char,newChar:char):String
// This returns the new updated string after changing all the occurrences of oldChar with the newChar.
.global String_replace
.extern malloc
        .text

// X0 = address of the original string (string1)
// X1 = oldChar
// X2 = newChar
// X3 = String length
// X4 = address of new string

String_replace:
        // Push the stack
        STR     X30,[SP,#-16]!
        STR     X0,[SP,#-16]!
        STR     X1,[SP,#-16]!
        STR     X2,[SP,#-16]!


        // Calculate the length of original string and move into x3
        MOV     X6,X0                                                           // Store address of string for reference
        BL              String_length                                   // Call local function to get length

        MOV     X3,X0                                                           // Store length into x3
        ADD     X3,X3,#1

        // Push x3 onto stack
        STR     X3,[SP,#-16]!

   // Step 2: Allocate memory for the new string (size is in X3)
   MOV   X0,X3                                          // Size needed for the new string
   BL    malloc                                         // Address of the new string will be in X0

        CMP   X0,#0
        BEQ     allocation_failure                      // Check allocation result
   MOV   X4, X0                                         // Store address of new string in X4 for safekeeping

        // Popping the stack: x3,x2,x1,x0,x30
        LDR     X3,[SP],#16
        LDR     X2,[SP],#16
        LDR     X1,[SP],#16
        LDR     X0,[SP],#16
        LDR     X30,[SP],#16

   // Step 3: Copy the original string to the new location (X4)
        // Initialize the index
        MOV     X5,#0                                                           // Set index to 0 for copying

copy_str:
        CMP     X5,X3                                                           // Compare index with string length
        BGE     replace_loop                                    // Branch if greater than

        LDRB    W6,[X0,X5]                                              // Get byte from original string at current index
        STRB    W6,[X4,X5]                                              // Store byte into new string at current index

        ADD     X5,X5,#1                                                        // Increment index
        B               copy_str

   // Step 4: Replace occurrences of oldChar with newChar in the new string
replace_loop:
   LDRB  W5, [X4], #1                                   // Load byte from the new string and post-increment X4

   CMP   W5, #0
        BEQ     finish                                          // If byte is null terminator, end loop

   CMP   W5, W1                                         // Compare byte with oldChar
   BNE  replace_loop                                    // If not equal, continue loop
   SUB   X4, X4, #1                                     // Adjust X4 back to the replaced character
   STRB  W2, [X4], #1                                   // Store newChar and post-increment X4
   B     replace_loop

finish:
        SUB     X4, X4, X3                                              // Add back the length of the string
   MOV   X0, X4                                         // Set X0 to the address of the new string
   RET

allocation_failure:
   // Handle allocation failure; return NULL for simplicity
   MOV   X0, #0
   RET
