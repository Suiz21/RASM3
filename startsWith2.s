/* Programmer: Aidan Ramirez
 * starsWith_2 (RASM_3)
 * Purpose: Check if something starts with a certain string
 * Author: Aidan Ramirez
 * Date last modified: 11 April 2024
 */

// Contract for startsWith_2:
        // Subroutine length: Provided a pointer to a null terminated string, startsWith_1 will 
        // return a true or false statement
        // X0: Must point to a null terminated string
        // LR: Must contain the return address
        // All AAPCS required registers are preserved,  r19-r29 and SP.
 .global startsWith_2
          .equ BUFFER, 21                               // Variable that will be used to allocate space
          .equ MAX_LEN,20                               // Creates a restriction on the length of inputs

  .data
    EqualStr:       .asciz "True" 
    NotEqualStr:    .asciz "False" 
    chLF:           .byte 0xa                                    // (NL line feed, new line)

  .text
  startsWith_2:
  
  STR X30,[SP, # -16]!          // push registers
  STR X0,[SP,#-16]!
  STR X1,[SP,#-16]!
 
  loop:
  LDRB w2,[x0]                  // load byte
  LDRB w3,[x1]                  // load byte

  CMP W3,0x00                   // compare to null
  BEQ equal                     // branch if equal

  CMP W2, W3                    // compare bytes
  BNE not_equal                 // branch if not equal

  ADD  X0, X0,#1                // increment
  ADD  X1, X1,#1                // increment


  B loop                        // loop

  equal:
  LDR X0,=EqualStr              // load
  BL  putstring                 // print
  LDR X0,=chLF                  // load
  BL  putch                     // print
  B   done                      // finish

  not_equal:
  LDR X0,=NotEqualStr           // load
  BL  putstring                 // print
  LDR X0,=chLF                  // load
  BL  putch                     // print
  B   done                      // finish

 done:
 LDR X1,[SP], #16               // pop registers
 LDR X0,[SP], #16
 LDR X30,[SP], #16

 RET LR


.end
