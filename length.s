/* Programmer: Aidan Ramirez
 * length (RASM_3)
 * Purpose: Counts the length of the string inputted by the user
 * Author: Aidan Ramirez
 * Date last modified: 11 April 2024
 */

// Contract for String_length:
        // Subroutine length: Provided a pointer to a null terminated string, String_length will 
        //      return the length of the string in X0
        // X0: Must point to a null terminated string
        // LR: Must contain the return address
        // All AAPCS required registers are preserved,  r19-r29 and SP.
 
  .data
 
  .global   String_length     // Provide program starting address to linker

  .text
String_length:
  // AAPCS REGISTERS AS PRESERVERED DUE TO NOT BEING USED

  MOV X7,X0     // point to first digit (leftmost) of Cstring
  MOV X2, #0    // Starts counter

  topLoop:
  LDRB W1,[X7],#1   // indirect addressing X1 = *X0, selects a specific byte that represents an ascii character
  CMP  W1, #0       // Checks to see if the byte is a null character
                    // if, so we are at the end of the string
  BEQ  bottomLoop   // Jump to the bottom of subroutine
  ADD  X2, X2, #1   // Increment the counter, this will check the next byte
  B    topLoop      // Repeats the loop

  

 bottomLoop:
 MOV  X0,X2         // Transfers the counter amount to X0, readies the length to be returned

 //  POPPED IN REVERSE ORDER (LIFO)
 
 RET  LR    // Reutrn to caller
 
 .end
