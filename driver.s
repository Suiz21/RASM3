.global _start
        .equ  BUFFER, 21 // Variable that will be used to allocated space
        .equ MAX_LEN,20 // Creates a restriction on the length of inputs

  .data
  szPrompt1:    .asciz "s1 = " // Holds the prompt for value s1
  szPrompt2:    .asciz "s2 = " // Holds the prompt for value s2
  szPrompt3:    .asciz "s3 = " // Holds the prompt for value s3
  szBuffer:        .skip BUFFER        // Holds the string value we input
  szS1:            .skip BUFFER          //  Saves our first input
  szS2:            .skip BUFFER          //  Saves our second input
  szS3:            .skip BUFFER          //  Saves our third input
  szStar1:         .asciz "hat."
  szStar2:         .asciz "Cat"
  szEnd:           .asciz "in the hat."
  dbLength:        .skip BUFFER       // Value that will hold the length of the string
  szOutLength1:    .asciz "s1.length() = "       // Will output the intro for the output
  szOutLength2:    .asciz "s2.length() = "       // Will output the intro for the output
  szOutLength3:    .asciz "s3.length() = "       // Will output the intro for the output
  szOutIgnoreCase1:     .asciz "String_equalsIgnoreCase(s1,s3) = " // Output first ignore case calls
  szOutIgnoreCase2:     .asciz "String_equalsIgnoreCase(s1,s2) = " // Output second ignore case calls
  szOutEquals1:     .asciz "String_equals(s1,s3) = " // Output first equals calls
  szOutEquals2:     .asciz "String_equals(s1,s1) = " // Output second equals calls
  szOutSub1:       .asciz  "String_substring_1(s3,4,14) = " // Output substring1
  szOutSub2:       .asciz  "String_substring_2(s3,7) = "    // Output substring2
  szOutCopy:       .asciz  "String_copy(s1)"        // Output execution of copy
  szCopied:        .asciz  "s1 = "                  // Outputs s1
  szCopy:          .asciz  "s4 = "                  // Outputs s4
  szCharAt:        .asciz "String_charAt(s2,4) =  " // Output char call
  szOutStart1:     .asciz "String_startsWith_1(s1,11, hat) = " 
  szOutStart2:     .asciz "String_startsWith_2(s1, Cat) = " // Outputs second start call 
  szLength:        .skip BUFFER     /// Will output the string length
  chLF:            .byte 0xa  // (NL line feed, new line)

  .text
  _start:

/****** Preparing to call putstring(x0) ******/
  LDR  X0,=szPrompt1    // Loading the address of szPrompt1 into X0
  BL   putstring        // Display "Enter X" prompt

  /****** Preparing to call getstring(x0,x1) ******/
  LDR X0,=szS1       // Load the address of szX into X0, getstring argument
  MOV X1,MAX_LEN         //  Store value into X1
  BL  getstring          // Calling the getstring function

 /****** Preparing to call putstring(x0) ******/
  LDR  X0,=szPrompt2    // Loading the address of szPrompt1 into X0
  BL   putstring        // Display "Enter X" prompt

  /****** Preparing to call getstring(x0,x1) ******/
  LDR X0,=szS2       // Load the address of szX into X0, getstring argument
  MOV X1,MAX_LEN         //  Store value into X1
  BL  getstring          // Calling the getstring function

 /****** Preparing to call putstring(x0) ******/
  LDR  X0,=szPrompt3    // Loading the address of szPrompt1 into X0
  BL   putstring        // Display "Enter X" prompt

  /****** Preparing to call getstring(x0,x1) ******/
  LDR X0,=szS3       // Load the address of szX into X0, getstring argument
  MOV X1,MAX_LEN         //  Store value into X1
  BL  getstring          // Calling the getstring function


/******* STRING LENGTH *****/
  LDR  X0,=szS1             // Load string address itno X0
  BL   String_length            // Get length of string
  LDR  X1,=dbLength             // Load address of dbLength into X1
  STR  X0, [X1]                 // Store contents of X1 into X0
  
  // Put dbLength into szLength
  LDR X1, =szLength      // Load address of szLength into X2
  BL  int64asc           // Convert to ascii for print

  // Output Length
  LDR  X0,=szOutLength1    // Load szOut into X0
  BL   putstring         // Print
  LDR  X0,=szLength      // Load szLength int X0
  BL   putstring         // Print
  LDR  X0,=chLF          // Load chLF into X0
  BL   putch             // Print

  LDR  X0,=szS2             // Load string address itno X0
  BL   String_length            // Get length of string
  LDR  X1,=dbLength             // Load address of dbLength into X1
  STR  X0, [X1]                 // Store contents of X1 into X0
  
  // Put dbLength into szLength
  LDR X1, =szLength      // Load address of szLength into X2
  BL  int64asc           // Convert to ascii for print

  // Output Length
  LDR  X0,=szOutLength2    // Load szOut into X0
  BL   putstring         // Print
  LDR  X0,=szLength      // Load szLength int X0
  BL   putstring         // Print
  LDR  X0,=chLF          // Load chLF into X0
  BL   putch             // Print
 
  LDR  X0,=szS3             // Load string address itno X0
  BL   String_length            // Get length of string
  LDR  X1,=dbLength             // Load address of dbLength into X1
  STR  X0, [X1]                 // Store contents of X1 into X0
  
  // Put dbLength into szLength
  LDR X1, =szLength      // Load address of szLength into X2
  BL  int64asc           // Convert to ascii for print

  // Output Length
  LDR  X0,=szOutLength3    // Load szOut into X0
  BL   putstring         // Print
  LDR  X0,=szLength      // Load szLength int X0
  BL   putstring         // Print
  LDR  X0,=chLF          // Load chLF into X0
  BL   putch             // Print

  // ***** Equals (Case 1) ******/
  LDR X0,=szOutEquals1
  BL  putstring
  LDR X0,=szS1
  LDR X1,=szS3
  BL  Equals

  // ***** Equals (Case 2) ******/
  LDR X0,=szOutEquals2
  BL  putstring
  LDR X0,=szS1
  LDR X1,=szS1
  BL  Equals

  // ***** IgnoreCase (Case 1) ******/
  LDR X0,=szOutIgnoreCase1
  BL  putstring
  LDR X0,=szS1
  LDR X1,=szS3
  BL  IgnoreCase

  // ***** IgnoreCase (Case 2) ******/
  LDR X0,=szOutIgnoreCase2
  BL  putstring
  LDR X0,=szS1
  LDR X1,=szS2
  BL  IgnoreCase

  // ***** strCopy *****/
  LDR X0,=szOutCopy
  BL  putstring
  LDR X0,=chLF
  BL  putch
  LDR X1,=szCopied
  BL  putstring
  LDR X0,=szS1
  BL  putstring
  LDR X0,=szCopy
  LDR X0,=szS1
  BL  copy
  BL  putstring
  LDR X0,=chLF
  BL  putch

  // ***** charAt    ******/
  LDR X0,=szCharAt
  BL  putstring
  MOV W4,#4
  LDR X0,=szS2
  BL  charAt


  // **** substring_1 ****/
  LDR X0,=szOutSub1
  BL  putstring
  MOV W4,#4
  MOV W5,#14
  LDR X0,=szS3
  BL  substring_1

  // **** substring_2 ****/
  LDR X0,=szOutSub2
  BL  putstring
  MOV W4,#7
  LDR X0,=szS3
  BL  substring_2

  // **** startsWith_1 **** //
  LDR X0,=szOutStart1
  BL  putstring
  MOV X4,#11
  LDR X0,=szS1
  LDR X1,=szStar1
  BL  startsWith_1

  // **** startsWith_2 **** //
  LDR X0,=szOutStart2
  BL  putstring
  LDR X0,=szS1
  LDR X1,=szStar2
  BL  startsWith_2

  // **** endsWith **** //
  LDR X0,=szS1
  LDR X1,=szEnd
  BL  endsWith

// Setup the parameters to exit the program
// and then call Linux to do it.
   mov X0,#0  // Use 0 return code
   mov X8,#93 //Service code 93 terminates
   svc 0  // Call Linux to terminate


 
 .end
