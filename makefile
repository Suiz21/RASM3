all:
                as -g RASM3.s -o RASM3.o
                as -g String_indexOf_1.s -o String_indexOf_1.o
                as -g String_indexOf_2.s -o String_indexOf_2.o
                as -g String_indexOf_3.s -o String_indexOf_3.o
                as -g IgnoreCase.s -o IgnoreCase.o
                as -g charAt.s -o charAt.o
                as -g equal.s -o equal.o
                as -g length.s -o length.o
                ld -o RASM3 RASM3.o String_indexOf_1.o String_indexOf_2.o String_indexOf_3.o IgnoreCase.o charAt.o equal.o length.o ../obj/putstring.o ../obj/putch.o ../obj/int64asc.o ../obj/getstring.o

.PHONY: clean

clean:
        rm -f *.o run *~
