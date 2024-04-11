all:
        as -g RASM3.s -o RASM3.o
        as -g length.s -o length.o
        as -g IgnoreCase.s -o  IgnoreCase.o
        as -g charAt.s -o charAt.o
        as -g substring_1.s -o substring_1.o
        as -g substring_2.s -o substring_2.o
        as -g copy.s -o copy.o
        as -g equal.s -o equal.o
        as -g startsWith1.s -o startsWith1.o
        as -g startsWith2.s -o startsWith2.o
        as -g endsWith.s -o endsWith.o
        ld -o RASM3 RASM3.o -lc endsWith.o startsWith1.o startsWith2.o length.o equal.o IgnoreCase.o charAt.o substring_1.o substring_2.o copy.o ../obj/putstring.o  ../obj/putch.o ../obj/int64asc.o ../obj/getstring.o ../obj/ascint64.o

.PHONY: clean

clean: 
        rm -f *.o run*~
