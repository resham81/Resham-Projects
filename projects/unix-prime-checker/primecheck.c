
//this file handles primality checking using trial division and nanosleep()

#include <time.h>
#include "prime.h"

int is_prime(int n) 
{
    if (n < 2) return 0;
    if (n == 2) return 1;
    if (n % 2 == 0) return 0;

    struct timespec delay = {0, 1000000}; // 1 millisecond
    int i;
    for (i = 3; i*i <= n; i += 2)
    {
        nanosleep(&delay, NULL);
        if (n % i == 0)
            return 0;
    }
    return 1;
}

// int_to_str: converts integer n to string buffer, returns number of chars written
int int_to_str(int n, char* buffer)
{
    int len = 0;
    if (n == 0)
    {
        buffer[len++] = '0';
        return len;
    }

    int temp = n;
    char rev[20];
    int i = 0;

    if (n < 0)
    {
        buffer[len++] = '-';
        temp = -n;
    }

    while (temp > 0)
    {
        rev[i++] = (temp % 10) + '0';
        temp /= 10;
    }

    // reverse the digits
    while (i > 0)
    {
        buffer[len++] = rev[--i];
    }

    return len;
}

