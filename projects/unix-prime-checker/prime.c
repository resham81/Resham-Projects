
// this file handles parent-child logic, pipes, and output

#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <fcntl.h>
#include <sys/types.h>
#include "prime.h"

int main(int argc, char* argv[])
{
    if (argc != 2) 
    {
        const char* msg = "Usage: ./prime <filename>\n";
        write(STDERR_FILENO, msg, sizeof("Usage: ./prime <filename>\n") - 1); // to write error
        _exit(1); // exit right away
    }
    int count;
    int* numbers = read_numbers_from_file(argv[1], &count);
    if (numbers == NULL)
    {
        const char* msg = "Error reading numbers\n";
        write(STDERR_FILENO, msg, sizeof("Error reading numbers\n") - 1);
        _exit(1);
    }
    if (count <= 0)
    {
        const char* msg = "Error: no numbers to process\n";
        write(STDERR_FILENO, msg, sizeof("Error: no numbers to process\n") -1);
        free(numbers);
        _exit(1);
    }
    int parent_to_child[count][2]; // for sending numbers to children
    int child_to_parent[count][2]; // for receiving results from children
    pid_t pids[count];
    int i;
    for (i = 0; i < count; i++)
    {
        if (pipe(parent_to_child[i]) == -1 || pipe(child_to_parent[i]) == -1) // creating pipes
        {
            const char* msg = "Pipe creation failed\n";
            write(STDERR_FILENO, msg, sizeof("Pipe creation failed\n") - 1);
            _exit(1);
        }

    }
    int ii;
    for (ii = 0; ii < count; ii++)
    {
        pid_t pid = fork(); // creating child process
        if (pid < 0)
        {
            const char* msg = "Fork failed\n";
            write(STDERR_FILENO, msg, sizeof("Fork failed\n") - 1);
            _exit(1);
        } else if (pid == 0) {
            // closing the unused ends
            close(parent_to_child[ii][1]); // close the write end
            close(child_to_parent[ii][0]); // close the read end
            
            int num;
            read(parent_to_child[ii][0], &num, sizeof(int));

            int result = is_prime(num);
            write(child_to_parent[ii][1], &result, sizeof(int));

            close(parent_to_child[ii][0]);
            close(child_to_parent[ii][1]);
            
            free(numbers);
            _exit(0);
        } else {
            // parent
            pids[ii] = pid;
            close(parent_to_child[ii][0]); // parent does not read from this
            close(child_to_parent[ii][1]); // parent does not write to this
        }
    }
    // sending the data to children
    int j;
    for (j = 0; j < count; j++)
    {
        write(parent_to_child[j][1], &numbers[j], sizeof(int)); // sending num to child
        close(parent_to_child[j][1]); // done writing
    }
    // wait for children and read results
    int jj;
    for (jj = 0; jj < count; jj++)
    {
        int status;
        pid_t cpid = wait(&status);
        int k;
        // finding which child completed by matching PID is pids array
        for (k = 0; k < count; k++)
        {
            if (pids[k] == cpid)
            {
                int result;
                read(child_to_parent[k][0], &result, sizeof(int)); // getting the result from child

                // build the output string manually
                char buffer[100];
                int len = 0;

                // "Child "
                const char* text1 = "Child ";
                int m;
                for (m = 0; text1[m]; m++) buffer[len++] = text1[m];

                // child PID
                len += int_to_str(k, buffer + len);

                // " completed the task: "
                const char* mid = " completed the task: ";
                for (m = 0; mid[m]; m++) buffer[len++] = mid[m];

                // number tested
                len += int_to_str(numbers[k], buffer + len);

                // " is prime\n" or " is not prime\n"
                const char* text2 = (result == 1) 
                    ? " is a prime number.\n" 
                    : " is NOT a prime number.\n";
                for (m = 0; text2[m]; m++) buffer[len++] = text2[m];

                // write to stdout
                write(STDOUT_FILENO, buffer, len); // output the final result

                close(child_to_parent[k][0]);
            }
        }
    }

    free(numbers);
    return 0;
}
