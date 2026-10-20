#include <stdio.h>
#include <unistd.h>
#include <termios.h>
#include "terminal.h"

void disable_buffer()
{
    struct termios mode;
    
    tcgetattr(0, &mode);
    mode.c_lflag &= ~(ECHO | ICANON);
    tcsetattr(0, TCSANOW, &mode);
}

void enable_buffer()
{
    struct termios mode;
    
    tcgetattr(0, &mode);
    mode.c_lflag |= (ECHO | ICANON);
    tcsetattr(0, TCSANOW, &mode);
}

char get_input()
{
    char ch;
    disable_buffer();
    ch = getchar();
    enable_buffer();

    return ch;
}
