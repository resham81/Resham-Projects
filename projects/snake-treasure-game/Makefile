CC = gcc
CFLAGS = -Wall -Werror -ansi -pedantic -std=c89
OBJ = main.o game.o map.o terminal.o utils.o linkedlist.o
EXEC = treasure

ifeq ($(DARK), 1)
	CFLAGS += -DDARK
endif

$(EXEC): $(OBJ)
		$(CC) $(CFLAGS) -o $(EXEC) $(OBJ)

main.o: main.c game.h map.h terminal.h utils.h
		$(CC) $(CFLAGS) -c main.c 

game.o: game.c game.h map.h terminal.h utils.h
		$(CC) $(CFLAGS) -c game.c

map.o: map.c map.h game.h
		$(CC) $(CFLAGS) -c map.c

terminal.o: terminal.c terminal.h
		$(CC) $(CFLAGS) -c terminal.c

utils.o: utils.c utils.h map.h terminal.h
		$(CC) $(CFLAGS) -c utils.c

linkedlist.o: linkedlist.c linkedlist.h
		$(CC) $(CFLAGS) -c linkedlist.c 

clean:
		rm -f $(OBJ) $(EXEC)
