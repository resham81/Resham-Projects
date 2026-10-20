CC = gcc
CFLAGS = -Wall -lm
TARGET = prime

OBJS = prime.o fileio.o primecheck.o

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) -o $(TARGET) $(OBJS) $(CFLAGS)

prime.o: prime.c prime.h
fileio.o: fileio.c prime.h
primecheck.o: primecheck.c prime.h

clean:
	rm -f *.o $(TARGET)

