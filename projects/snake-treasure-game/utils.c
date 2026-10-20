#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#include "terminal.h"
#include "utils.h"
#include "map.h"
#include "game.h"
void clear_screen()
{
    system("clear"); 
}

void handle_input(Map *map, int *player_row, int *player_col, char input,
                  Game *game)
{ 
    switch (input)
    {
        case 'w':
        case 's':
        case 'a':
        case 'd':
            move_player(map, player_row, player_col, input);
            break;
        case 'u':
            undo_move(game);
            break;
        default:
            printf("Invalid input. Use 'w', 'a', 's', 'd', to move.\n");
            break;
    }
}


void move_player(Map *map, int *player_row, int *player_col, char input)
{
    int new_row, new_col;
    new_row = *player_row;
    new_col = *player_col;
    switch (input)
    {
        case 'w': new_row--; break;
        case 's': new_row++; break;
        case 'a': new_col--; break;
        case 'd': new_col++; break;
        default: return;
    }
    if (new_row >= 0 && new_row < map->rows && new_col >= 0 && new_col
        < map->cols && map->grid[new_row][new_col] != 1)
    {   
        /* reset the current position to empty */
       
        map->grid[*player_row][*player_col] = 0;
        

        /* updating player coordinates */
        *player_row = new_row;
        *player_col = new_col;

         /*marking player's new position if it is not in snake's position 
         if (map->grid[*player_row][*player_col] != 4)
         {
             map->grid[*player_row][*player_col] = 3;
          } */  
    }
}
void move_snake(Map *map, int *snake_row, int *snake_col, int player_row,
                int player_col)
{
    int directions[8][2] = {
        {-1, -1}, {-1, 0}, {-1, 1}, 
        { 0, -1}, { 0, 1},
        { 1, -1}, { 1, 0}, { 1, 1}
    };
    int new_row, new_col, dir;

    /* clear the old snake position */
    map->grid[*snake_row][*snake_col] = 0;
    
    if (abs(*snake_row - player_row) <= 1 && abs(*snake_col - player_col) <= 1)
    {
        /* move directly toward the player */
        *snake_row = player_row;
        *snake_col = player_col;
        
        /* snake eats player */
        map->grid[*snake_row][*snake_col] = 4;
        return;

    } else {
        srand(time(NULL));
        dir = rand() % 8;
        new_row = *snake_row + directions[dir][0];
        new_col = *snake_col + directions[dir][1];
        
        /* checking if the new position is valid */
        if (new_row >= 0 && new_row < map->rows && 
            new_col >= 0 && new_col < map->cols &&
            map->grid[new_row][new_col] != 1)
        {
            *snake_row = new_row;
            *snake_col = new_col;
        }
    }
    
    map->grid[*snake_row][*snake_col] = 4; /*setting new posotion */
    return;
}
        
 
