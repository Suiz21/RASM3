 .global _start
        .equ  BUFFER, 21 // Variable that will be used to allocated space
        .equ MAX_LEN,20 // Creates a restriction on the length of inputs

  .data
  szPrompt1:    .asciz "s1 = " // Holds the prompt for value s1
  szPrompt2:    .asciz "s2 = " // Holds the prompt for value s2
  szPrompt3:    .asciz "s3 = " // Holds the prompt for value s3
  szBuffer:        .skip BUFFER        // Holds the string value we input
  szS1:            .asciz "Cat in the hat."          //  Saves our first input
  szS2:            .skip BUFFER          //  Saves our second input
  szS3:            .skip BUFFER          //  Saves our third input
  dbLength:        .skip BUFFER       // Value that will hold the length of the string
  szOutLength1:    .asciz "s1.length() = "       // Will output the intro for the output
  szOutLength2:    .asciz "s2.length() = "       // Will output the intro for the output
  szOutLength3:    .asciz "s3.length() = "       // Will output the intro for the output
  szOutEquals1:     .asciz "String_equals(s1,s3) = " // Output first equals calls
  szOutEquals2:     .asciz "String_equals(s1,s1) = " // Output second equals calls
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

 // ***** Equals (Case 1) ******/                                                                               NEEDS SP CHANGE
 LDR X0,=szOutEquals1
 BL  putstring
 LDR X0,=szS1
 LDR X1,=szS3
 BL  Equals

// ***** Equals (Case 2) ******/                                                                                NEEDS SP CHANGE
 LDR X0,=szOutEquals2
 BL  putstring
 LDR X0,=szS1
 LDR X1,=szS1
 BL  Equals


// Setup the parameters to exit the program
// and then call Linux to do it.
   mov X0,#0  // Use 0 return code
   mov X8,#93 //Service code 93 terminates
   svc 0  // Call Linux to terminate


 
 .end
