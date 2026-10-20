
//this file handles reading integers from a text file using only system calls

#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include "prime.h"

int* read_numbers_from_file(const char* filename, int* count)
{
    int fd = open(filename, O_RDONLY); // to open file in read only mode
    if (fd < 0)
    {
        const char* msg = "Error: cannot open file\n";
        write(STDERR_FILENO, msg, sizeof("Error: cannot open file\n") - 1); // system call to write erorr
        _exit(1); // to exit right away
    }
    char ch;
    int num = 0;
    int num_count = 0;
    int size = 10; //initial array size
    int* numbers = (int*) malloc(size * sizeof(int));

    // the first int in the file represents the total count of the numbers to follow
    int is_first = 1; // flag to indicate first int is being read (total count)
    int total = 0;
    int has_number = 0; // track if we are building a number

    while (read(fd, &ch, 1) == 1) // to read one char at a time
    {
        if (ch >= '0' && ch <= '9')
        {
            num = num * 10 + (ch - '0'); // converting char digit to int
            has_number = 1;
        } else if (ch == '\n' || ch == ' ' || ch == '\t')
        {
            if (has_number)
            {
                if (is_first) 
                {
                    total = num; // 1st num is the total count
                    is_first = 0;
                    *count = total;
                    free(numbers); // reallocate array to exact size needed
                    numbers = (int*) malloc(total * sizeof(int));
                    num_count = 0;
                }else {
                    // regular numbers are stored in the array
                    if (num_count < total)
                    {
                        numbers[num_count++] = num;
                    }
                }
                num = 0;
                has_number = 0;
            }
        }
    }
        // handling last no. if file does not end with '\n'
        if (has_number && !is_first && num_count < total)
        {
            numbers[num_count++] = num;
        }
        close(fd);
        
        // verify we read expected number of integers
        if (num_count != total)
        {
            const char* msg = "Error: incorrect number of integers read\n";
            write(STDERR_FILENO, msg, sizeof("Error: incorrect number of integers read\n") -1);
            free(numbers);
            return NULL;
        }
        return numbers;
    }
    
