.global endsWith

  .data
    EqualStr:       .asciz "True" 
    NotEqualStr:    .asciz "False" 
    chLF:           .byte 0xa                                    // (NL line feed, new line)

  .text
  endsWith:

 STP X29, X30,[SP, #-16]!  // Save registers
 
    // Calculate the length of the suffix string
    mov x4, x1          // Copy the pointer to suffix to x4
    mov x5, #0          // Initialize a counter for length calculation

calculate_length:
    ldrb w6, [x4], #1  // Load byte from suffix and increment pointer
    cmp w6, #0         // Check for null terminator
    beq length_calculated  // Exit loop if null terminator is found
    add x5, x5, #1     // Increment counter for each byte
    b calculate_length // Continue loop

length_calculated:
    // Subtract the length of the suffix from the pointer to move back to the appropriate position
    sub x3, x0, x5      // Move back by the length of the suffix

    // Compare strings forwards byte by byte
compare_loop:
    ldrb w4, [x0], #1  // Load byte from s1 and increment pointer
    ldrb w5, [x3], #1  // Load byte from suffix and increment pointer
    cmp w4, w5         // Compare characters
    bne not_found     // If they don't match, return false
    cbz w5, found      // If suffix has been fully compared, it matches, return true
    b compare_loop     // Otherwise, continue comparing

found:
    // Set return value to true
    LDR X0,=EqualStr
  BL  putstring
  LDR X0,=chLF
  BL  putch
  B end_function

not_found:
    // Set return value to false
   LDR X0,=NotEqualStr
  BL  putstring
  LDR X0,=chLF
  BL  putch

end_function:
    // Restore registers and return
    ldp x29, x30, [sp], #16
    ret
    b end_function
