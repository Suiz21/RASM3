.global String_toLowerCase
        .text
// String_toLowerCase(string1:String):String  It converts the string to lower case string
String_toLowerCase:

// Add 32 to convert to lowercase

        // Push to the stack: x30,x0
        STR     X30,[SP,#-16]!
        STR     X0,[SP,#-16]!

        BL              String_length                           // X0 = string length

        ADD     X0,X0,#1                                                // Add 1 for null
        MOV     X1,X0                                                   // Store string length in x1

        //      Push x1 to the stack
        STR     X1,[SP,#-16]!

        // Allocate new dynamic memory for string
        BL              malloc

        // Check to see if malloc failed
        CMP     X0,#0
        BEQ     malloc_failure

        // Save new string in x2
        MOV     X2,X0

        // Pop the stack
        LDR     X1,[SP],#16
        LDR     X0,[SP],#16
        LDR     X30,[SP],#16

        SUB     X1,X1,#1                                                // Exclude null from the loop
        MOV     X3,#0                                                   // Initialize index for loop
convert_loop:
        // Load current char
        LDRB    W4,[X0,X3]

        // Convert to lowercase if uppercase ASCII
        CMP     W4,#0x41                                                // 'A'
        BLT     skip_conversion
        CMP     W4,#0x5A                                                // 'Z'
        BGT     skip_conversion

        // Convert by adding 32 ('a' - 'A')
        ADD     W4,W4,#32

skip_conversion:
        // Store the converted character
        STRB    W4,[X2,X3]

        // Check to see if we've reached the end of the string
        ADD     X3,X3,#1
        CMP     X3,X1
        BLT     convert_loop

        // Null-terminate the new string
        MOV     W4,#0
        STRB    W4,[X2,X3]

        // Return the address of the new string
        MOV     X0,X2
        RET

malloc_failure:
        // Handle memory allocation failure
        MOV     X0,#0                                                   // Return NULL to indicate failure
        RET
