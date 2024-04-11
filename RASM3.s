/****************************/
// Programmer: Alex Hwang       & Aiden Ramirez
// Lab#: RASM3
//
// Author: Dr. Barnett
// Date last modified: 4/9/2024

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
  szOutIgnoreCase1:     .asciz "String_equalsIgnoreCase(s1,s3) = " // Output first ignore case calls
  szOutIgnoreCase2:     .asciz "String_equalsIgnoreCase(s1,s2) = " // Output second ignore case calls
  szOutEquals1:     .asciz "String_equals(s1,s3) = " // Output first equals calls
  szOutEquals2:     .asciz "String_equals(s1,s1) = " // Output second equals calls
  szCharAt:        .asciz "String_charAt(s2,4) =  " // Output second equals calls
  szIndexOf1:            .asciz "String_indexOf_1(s2,'g') = "   // Output indexOf_1
  szIndexOf2:            .asciz "String_indexOf_2(s2,'g',9) = " // Output indexOf_2
  szIndexOf3:            .asciz "String_indexOf_3(s2,\"eggs\") = "  // Output indexOf_3
  szLastIndex1:          .asciz "String_lastIndexOf_1(s2,'g') = "               // Output lastIndexOf_1
  szLastIndex2:  .asciz "String_lastIndexOf_2(s2,'g',6) = "     // Output lastIndexOf_2
  szLastIndex3:  .asciz "String_lastIndexOf_3(s2,\"egg\") = "   // Output lastIndexOf_3
  szConcat:                      .asciz "String_concat(s1,s2) = "                                       // Output concat
  szReplace:             .asciz "String_replace(s1,'a','o') = "                                                                   // Output replace
  string_eggs:           .asciz "eggs"
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

// ***** IgnoreCase (Case 1) ******/                                                                            NEEDS SP CHANGE
 LDR X0,=szOutIgnoreCase1
 BL  putstring
 LDR X0,=szS1
 LDR X1,=szS3
 BL  IgnoreCase

// ***** IgnoreCase (Case 2) ******/                                                                            NEEDS SP CHANGE
 LDR X0,=szOutIgnoreCase2
 BL  putstring
 LDR X0,=szS1
 LDR X1,=szS2
 BL  IgnoreCase

// ***** charAt    ******/                                                                              NEEDS SP CHANGE
 LDR X0,=szCharAt
 BL  putstring
 MOV W4,#4
 LDR X0,=szS2
 BL  charAt

// ***** #13 output: String_indexOf_1(s2,'g') = 7    ******/
        LDR     X0,=szIndexOf1                          // Load address of output string
        BL              putstring                                       // Print

        LDR     X0,=szS2                                                // Load s2 into x0
        MOV     X1,#0x67                                                // Load 'g' into x1

        BL              String_indexOf_1                        // Call method

        LDR     X1,=szBuffer                            // Load address of szBuffer
        BL              int64asc                                                // Convert int to string

        LDR     X0,=szBuffer                            // Load address of szbuffer
        BL              putstring                                       // Print converted string
        LDR     X0,=chLF                                                // newline print
        BL              putch

// ***** #14 output: String_indexOf_2(s2,'g',9) = -1   ******/
        LDR     X0,=szIndexOf2                          // Load address of output string
        BL              putstring                                       // Print

        LDR     X0,=szS2                                                // Load s2 into x0
        MOV     X1,#0x67                                                // Load 'g' into x1
        MOV     X2,#9                                                   // Load 9 into x2

        BL              String_indexOf_2                        // Call method

        LDR     X1,=szBuffer                            // Load address of szBuffer
        BL              int64asc                                                // Convert int to string

        LDR     X0,=szBuffer                            // Load address of szBuffer
        BL              putstring                                       // Print converted string
        LDR     X0,=chLF                                                // newline print
        BL              putch

// ***** #15 output: String_indexOf_3(s2,eggs) = 6   ******/
        LDR     X0,=szIndexOf3                          // Load address of output string
        BL              putstring                                       // Print

        LDR     X0,=szS2                                                // Load s2 into x0
        LDR     X1,=string_eggs                 // Load szEggs into x1

        BL              String_indexOf_3                        // Call method

        // Convert int to string
        LDR     X1,=szBuffer                            // Load address of szBuffer
        BL              int64asc                                                // Convert into to string

        // Print string
        LDR     X0,=szBuffer                            // Load address of szBuffer
        BL              putstring                                       // Print converted string
        LDR     X0,=chLF                                                // newline print
        BL              putch

// ***** #16 output: String_lastIndexOf_1(s2,'g') = 8   ******/
        LDR     X0,=szLastIndex1                        // Load address of output string
        BL              putstring                                       // Print

        LDR     X0,=szS2                                                // Load s2 into x0
        MOV     X1,#0x67                                                //      Load 'g' into x1

        BL              String_lastIndexOf_1            // Call method

        // Convert int to string
        LDR     X1,=szBuffer                            // Load address of szBuffer
        BL              int64asc                                                // Convert into to string

        // Print string
        LDR     X0,=szBuffer                            // Load address of szBuffer
        BL              putstring                                       // Print converted string
        LDR     X0,=chLF                                                // newline print
        BL              putch

// ***** #17 output: String_lastIndexOf_2(s2,'g',6) = -1   ******/
        LDR     X0,=szLastIndex2                        // Load address of output string
        BL              putstring                                       // Print

        LDR     X0,=szS2                                                // Load s2 into x0
        MOV     X1,#0x67                                                //      Load 'g' into x1
        MOV     X2,#6                                                   // Load 6 into x2

        BL              String_lastIndexOf_2            // Call method

        // Convert int to string
        LDR     X1,=szBuffer                            // Load address of szBuffer
        BL              int64asc                                                // Convert into to string

        // Print string
        LDR     X0,=szBuffer                            // Load address of szBuffer
        BL              putstring                                       // Print converted string
        LDR     X0,=chLF                                                // newline print
        BL              putch

// ***** #18 output: String_lastIndexOf_3(s2,"eggs") = 6   ******/
        LDR     X0,=szLastIndex3                        // Load address of output string
        BL              putstring                                       // Print

        LDR     X0,=szS2                                                // Load s2 into x0
        LDR     X1,=string_eggs                 // Load address of string_eggs into x1

        BL              String_lastIndexOf_3            // Call method

        // Convert int to string
        LDR     X1,=szBuffer                            // Load address of szBuffer
        BL              int64asc                                                // Convert into to string

        // Print string
        LDR     X0,=szBuffer                            // Load address of szBuffer
        BL              putstring                                       // Print converted string
        LDR     X0,=chLF                                                // newline print
        BL              putch

// ***** #19 output: String_replace(s1,'a','o') = "Cot in the hot."   ******/
        LDR     X0,=szReplace                           // Load address of output string
        BL              putstring                                       // Print

        LDR     X0,=szS1                                                // Load s1 into x0
        MOV     X1,#0x61                                                // Load 'a' into x1
        MOV     X2,#0x6F                                                // Load 'o' into x2

        BL              String_replace                          // replace the a's w o's

        BL              putstring

        LDR     X0,=chLF
        BL              putch


// ***** #22 output: String_concat(s1,s2) = "Cat in the hat.Green eggs and ham."   ******/
        LDR     X0,=szConcat                            // Load address of output str
        BL              putstring                                       // Print

        LDR     X0,=szS1                                                // Load address of szS1 into x0
        LDR     X1,=szS2                                                // Load address of szS2 into x1

        BL              String_concat

        BL              putstring

        LDR     X0,=chLF
        BL              putch



// Setup the parameters to exit the program
// and then call Linux to do it.
   mov X0,#0                                            // Use 0 return code
   mov X8,#93                                           // Service code 93 terminates
   svc 0                                                        // Call Linux to terminate



 .end
