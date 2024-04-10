.global charAt
          .equ BUFFER, 21                               // Variable that will be used to allocate space
          .equ MAX_LEN,20                               // Creates a restriction on the length of inputs

  .data
  Char:     .byte 0x00
  chLF:     .byte 0x0a

  .text
  charAt:
  
  STR X30,[SP, # -16]!
  STR X0,[SP,#-16]!
  STR X1,[SP,#-16]!

  Mov     W1, 0            // Initialize position counter
reachposition: 
 // Calculate the memory address of the character at position 4
    ADD     W2, W0, W1   // Add the position offset to the string address

// Load the character value from memory
    LDRB    W3, [X2]         // Load byte into w3

    // Check if we've reached the 4th position
    CMP     W1, W4           // Compare with the 4th position (0-based index)
    BEQ    found_position   // If equal, jump to found_position

    // Increment the position counter
    ADD     W1, W1, #1

    B reachposition

found_position:
 // Store the character value into the Char variable
// STRB    W3, [X1]         // Store the byte from w3 into the memory location pointed to by Char

 LDR X0,=Char
 STRB W3,[X0]

 LDR X0,=Char
 BL  putch

 LDR X0,=chLF
 BL  putch

 LDR X1,[SP], #16
 LDR X0,[SP], #16
 LDR X30,[SP], #16

 RET LR


.end