all:
        as -g -o driver.o driver.s
        ld -o RASM3 driver.o  length.o  ../obj/putstring.o  ../obj/putch.o ../obj/int64asc.o ../obj/getstring.o ../obj/ascint64.o equal.o IgnoreCase.o charAt.o substring_2.o

.PHONY: clean

clean: 
        rm -f *.o run*~
