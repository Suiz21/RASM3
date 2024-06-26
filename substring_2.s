/* Programmer: Aidan Ramirez
 * substring_2 (RASM_3)
 * Purpose: Prints a substring based on given parameters
 * Author: Aidan Ramirez
 * Date last modified: 11 April 2024
 */

// Contract for substring_2:
        // Subroutine length: Provided a pointer to a null terminated string, String_length will 
        //      return the length of the string in X0
        // X0: Must point to a null terminated string
        // LR: Must contain the return address
        // All AAPCS required registers are preserved,  r19-r29 and SP.
 .global substring_2
          .equ BUFFER, 21                               // Variable that will be used to allocate space
          .equ MAX_LEN,20                               // Creates a restriction on the length of inputs

  .data
  Char:     .byte 0x00
  chLF:     .byte 0x0a

  .text
  substring_2:
  
  STR X30,[SP, # -16]!          // Push

  MOV     W1, 0            // Initialize position counter

reachposition: 
 // Calculate the memory address of the character at position 4
    ADD     W2, W0, W1   // Add the position offset to the string address

// Load the character value from memory
    LDRB    W3, [X2]         // Load byte into w3
 
    // Check if we've reached the 4th position
    CMP     W1, W4           // Compare with the 4th position (0-based index)
    BEQ    write_position   // If equal, jump to found_position

    // Increment the position counter
    ADD     W1, W1, #1          // increment
    B reachposition             // loop

write_position: 
 // Calculate the memory address of the character at position 4
    ADD     W2, W0, W1   // Add the position offset to the string address

// Load the character value from memory
    LDRB    W3, [X2]         // Load byte into w3
 
    STR X0,[SP,#-16]!           // push
    STR X1,[SP,#-16]!
    STR X3,[SP, #-16]!
    
    LDR X6,=Char                // load
    STRB W3,[X6]                // store byte

    LDR X0,=Char                // load
    BL  putch                   // print
   
    LDR X3, [SP], #16           // pop
    LDR X1,[SP], #16
    LDR X0,[SP], #16
    // Check if we've reached the 4th position
    CMP     W3, 0x00           // Compare with the 4th position (0-based index)
    BEQ    found_position   // If equal, jump to found_position

    // Increment the position counter
    ADD     W1, W1, #1          // incremnet
    B write_position            // loop

found_position:
 // Store the character value into the Char variable

 LDR X0,=chLF                   //  load
 BL  putch                      // print

 LDR X30,[SP], #16              // pop

 RET LR


.end
