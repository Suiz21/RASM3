/* Programmer: Aidan Ramirez
 * substring_1 (RASM_3)
 * Purpose: Prints substring based on parameters
 * Author: Aidan Ramirez
 * Date last modified: 11 April 2024
 */

// Contract for String_length:
        // Subroutine length: Provided a pointer to a null terminated string, returns appropriate substring
        // X0: Must point to a null terminated string
        // LR: Must contain the return address
        // All AAPCS required registers are preserved,  r19-r29 and SP.
 .global substring_1
          .equ BUFFER, 21                               // Variable that will be used to allocate space
          .equ MAX_LEN,20                               // Creates a restriction on the length of inputs

  .data
  Char:     .byte 0x00
  chLF:     .byte 0x0a

  .text
  substring_1:
  
  STR X30,[SP, # -16]!  // push

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
    B reachposition        //  jump

write_position: 
 // Calculate the memory address of the character at position 4
    ADD     W2, W0, W1   // Add the position offset to the string address

// Load the character value from memory
    LDRB    W3, [X2]         // Load byte into w3

    ADD     W1, W1, #1  // increment

    STR X0,[SP,#-16]!   // push
    STR X1,[SP,#-16]!
    STR X3,[SP, #-16]!
    
    LDR X6,=Char        // load register
    STRB W3,[X6]        // store byte

    LDR X0,=Char        // load
    BL  putch           // print
   
    LDR X3, [SP], #16   // pop registers
    LDR X1,[SP], #16
    LDR X0,[SP], #16

        // Check if we've reached the 4th position
    CMP     W1, W5           // Compare with the 4th position (0-based index)
    BEQ    found_position   // If equal, jump to found_position

    // Increment the position counter

    B write_position    // loop

found_position:
 // Store the character value into the Char variable

 LDR X0,=chLF           // load register
 BL  putch              // print

 LDR X30,[SP], #16      // pop

 RET LR


.end
