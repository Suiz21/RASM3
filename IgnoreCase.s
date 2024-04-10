
// PseudoCode:
// Compare lengths to begin with. 
// Go byte by byte comparing the value
// If both always have equal bytes (cspr is 0), return true
// Else, return false.

 .global IgnoreCase
          .equ BUFFER, 21                               // Variable that will be used to allocate space
          .equ MAX_LEN,20                               // Creates a restriction on the length of inputs

  .data
    EqualStr:       .asciz "True" 
    NotEqualStr:    .asciz "False" 
    chLF:           .byte 0xa                                    // (NL line feed, new line)

  .text
  IgnoreCase:
  
  STR X30,[SP, # -16]!
  STR X0,[SP,#-16]!
  STR X1,[SP,#-16]!
 
  loop:
  LDRB w2,[x0]
  LDRB w3,[x1]

  CMP W2,0x00
  BEQ equal

  CMP W2, W3
  BNE checkCase

  ADD  X0, X0,#1
  ADD  X1, X1,#1

  B loop

  checkCase:
  SUB W3, W3, #32
  CMP W2,W3
  BNE not_equal
  ADD  X0, X0,#1
  ADD  X1, X1,#1
  B   loop

  equal:
  LDR X0,=EqualStr
  BL  putstring
  LDR X0,=chLF
  BL  putch
  B   done 

  not_equal:
  LDR X0,=NotEqualStr
  BL  putstring
  LDR X0,=chLF
  BL  putch
  B   done

 done:
 LDR X1,[SP], #16
 LDR X0,[SP], #16
 LDR X30,[SP], #16

 RET LR


.end
