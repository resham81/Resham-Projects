#include <stdio.h>
#include <stdlib.h>
#include "map.h"
#include "game.h"

int load_map(Map *map, const char *map_file)
{
    FILE *file;
    int i, j, k;
    int walls;

    file = fopen(map_file, "r");
    if (!file)
    {
        perror("Error opening file");
        /*print error message */
        return 0;
    }

    /* reading map dimensions */
    if (fscanf(file, "%d %d", &map->rows, &map->cols) != 2)
    {
        fprintf(stderr, "Error reading map dimensions from the file.\n");
        fclose(file);
        return 0;
    }
    /* reading no. of walls */
    if (fscanf(file, "%d", &walls) != 1)
    {
        fprintf(stderr, "Error reading number of walls from the file.\n");
        fclose(file);
        return 0;
    }

    /* allocating memory for the map grid */
    map->grid = malloc(map->rows * sizeof(int *));
    if (!map->grid)
    {
        fprintf(stderr, "Memory allocation failed for map grid.\n");
        fclose(file);
        return 0;
    }

    /* allocate memory for each row */
    for (i = 0; i < map->rows; i++)
    {
        map->grid[i] = malloc(map->cols * sizeof(int));
        if (!map->grid[i])
        {
            fprintf(stderr, "Memory allocation failed for map row %d.\n", i);

            /* freeing the prev allocated memory */
            for (j = 0; j < i; j++)
            {
                free(map->grid[j]);
            }
            free(map->grid);
            fclose(file);
            return 0;
        }
    }
    /* reading map data */
    for (i = 0; i < map-> rows; i++)
    {
        for (j = 0; j < map->cols; j++)
        {
            if (fscanf(file, "%d", &map->grid[i][j]) != 1)
            {
                fprintf(stderr, "Error reading map data at row %d, column %d.\n", i, j);
            /* freeing the allocated memory before returning */
                for (k = 0; k < map->rows; k++)
                {
                    free(map->grid[k]);
                }
                free(map->grid);
                fclose(file);
                return 0;
            }
        }
    }
    fclose(file);
    return 1;
}
    
void free_map(Map *map)
{
    int i;
    if (map && map->grid)
    {
        for (i = 0; i < map->rows; i++)
        {
            if (map->grid[i])
            {
                free(map->grid[i]); /* free each row */
            }
        }
        free(map->grid); /* free the grid itself */
        map->grid = NULL;
        map->rows = 0;
        map->cols = 0;

    }
}

#ifdef DARK
void print_map(const Map *map, int player_row, int player_col,
               int visibility_range)
#else

void print_map(const Map *map, int player_row, int player_col)
#endif
{
    int i, j;
    char cell_char;
#ifdef DARK
    int distance;
#endif
    /* print top border */
    for (j = 0; j < map->cols + 2; j++)
    {
        putchar('*');
    }
    putchar('\n');

    for (i = 0; i < map->rows; i++)
    {
        putchar('*'); /* left border */

        for (j = 0; j < map->cols; j++)
        {
            cell_char = ' ';
#ifdef DARK
            /* calculate Manhattan distance */
            distance = abs(i - player_row) + abs(j - player_col);
            if (distance > visibility_range)
            {
                cell_char = ' ';
            } else {
                if (i == player_row && j == player_col)
                {
                    cell_char = 'P';
                } else {
                    switch (map->grid[i][j])
                    {       
                        case 0: cell_char = '.'; break;
                        case 1: cell_char = 'O'; break;
                        case 2: cell_char = '@'; break;
                        case 3: cell_char = 'P'; break;
                        case 4: cell_char = '~'; break;
                        case 5: cell_char = '$'; break;
                        default: cell_char = '?'; break;
                    }
                }
            }
#else
            /* normal mode */
            if (i == player_row && j == player_col)
            {
                cell_char = 'P';
            } else {
                switch (map->grid[i][j]) 
                {
                    case 0: cell_char = ' '; break;
                    case 1: cell_char = '0'; break;
                    case 2: cell_char = '@'; break;
                    case 3: cell_char = 'S'; break;
                    case 4: cell_char = '~'; break;
                    case 5: cell_char = '$'; break;
                    default: cell_char = '?'; break;
                }
            }
#endif
            putchar(cell_char);
        }
        putchar('*'); /* right border */
        putchar('\n');
    }
    /* print bottom border */
    for (j = 0; j < map->cols + 2; j++)
    {
        putchar('*');
    }
    putchar('\n');

    /* print movement instructions */
    printf("Press 'w' to move up\n");
    printf("Press 's' to move down\n");
    printf("Press 'a' to move left\n");
    printf("Press 'd' to move right\n");
    printf("Press 'u' to undo\n");
    #ifdef DARK
        printf("DARK Mode enabled. You only have visibility range of 3 blocks."
               " If you get lantern, your visibility range can increase"
               " to 6 blocks. GOOD LUCK!\n");
    #endif

}
