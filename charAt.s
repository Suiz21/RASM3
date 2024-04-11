/* charAt mmer: Aidan Ramirez
 * charAt (RASM_3)
 * Purpose: print the char at index
 * Author: Aidan Ramirez
 * Date last modified: 11 April 2024
 */

// Contract for charAt:
        // Subroutine length: Provided a pointer to a null terminated string, charAt will 
        //      return the char at the given index
        // X0: Must point to a null terminated string
        // LR: Must contain the return address
        // All AAPCS required registers are preserved,  r19-r29 and SP.

 .global charAt
          .equ BUFFER, 21                               // Variable that will be used to allocate space
          .equ MAX_LEN,20                               // Creates a restriction on the length of inputs

  .data
  Char:     .byte 0x00  // holds value for char
  chLF:     .byte 0x0a  // line break

  .text
  charAt:
  
  STR X30,[SP, # -16]!  // push
  STR X0,[SP,#-16]!  // push
  STR X1,[SP,#-16]!  // push

  MOV     W1, 0            // Initialize position counter
  reachposition: 
  // Calculate the memory address of the character at position 4
    ADD     W2, W0, W1   // Add the position to the string address

  // Load the character value from memory
    LDRB    W3, [X2]         // Load byte into w3

    // Check if we've reached the 4th position
    CMP     W1, W4           // Compare with the 4th position (0-based index)
    BEQ    found_position   // If equal, jump to found_position

    ADD     W1, W1, #1     // Increment the position counter


    B reachposition  // jump to reach position

  found_position:
  // Store the character value into the Char variable
  // STRB    W3, [X1]         // Store the byte from w3 into the memory location pointed to by Char

  LDR X0,=Char // load
  STRB W3,[X0]  // store byte

  LDR X0,=Char  // load 
  BL  putch  // print

  LDR X0,=chLF // load
  BL  putch  // print

  LDR X1,[SP], #16 // pop
  LDR X0,[SP], #16  // pop
  LDR X30,[SP], #16  // pop

  RET LR


.end
