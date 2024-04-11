all:
                as -g RASM3.s -o RASM3.o
                as -g String_indexOf_1.s -o String_indexOf_1.o
                as -g String_indexOf_2.s -o String_indexOf_2.o
                as -g String_indexOf_3.s -o String_indexOf_3.o
                as -g String_lastIndexOf_1.s -o String_lastIndexOf_1.o
                as -g String_lastIndexOf_2.s -o String_lastIndexOf_2.o
                as -g String_lastIndexOf_3.s -o String_lastIndexOf_3.o
                as -g String_concat.s -o String_concat.o
                as -g String_replace.s -o String_replace.o
                as -g String_toLowerCase.s -o String_toLowerCase.o
                as -g String_toUpperCase.s -o String_toUpperCase.o
                as -g length.s -o length.o
                as -g IgnoreCase.s -o IgnoreCase.o
                as -g substring_1.s -o substring_1.o
                as -g substring_2.s -o substring_2.o
                as -g strcpy.s -o strcpy.o
                as -g equal.s -o equal.o
                as -g startsWith1.s -o startsWith1.o
                as -g startsWith2.s -o startsWith2.o
                as -g endsWith.s -o endsWith.o
                as -g charAt.s -o charAt.o

                ld -o RASM3 RASM3.o -lc String_indexOf_1.o String_indexOf_2.o String_indexOf_3.o String_lastIndexOf_1.o String_lastIndexOf_2.o String_lastIndexOf_3.o String_concat.o String_replace.o String_toLowerCase.o String_toUpperCase.o endsWith.o startsWith1.o startsWith2.o IgnoreCase.o charAt.o equal.o length.o substring_2.o substring_1.o strcpy.o ../obj/putstring.o ../obj/putch.o ../obj/int64asc.o ../obj/getstring.o

.PHONY: clean

clean:
        rm -f *.o run *~
