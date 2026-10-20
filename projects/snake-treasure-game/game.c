#include <stdio.h>
#include <stdlib.h>
#include "game.h"
#include "utils.h"
#include "terminal.h"
#include "linkedlist.h"

int init_game(Game *game, const char *map_file)
{
    int i, j;

    if (!load_map(&game->map, map_file))
    {
        return 0;
    }
  
    /* initializing the player and snake positions */
    for (i = 0; i < game->map.rows; i++)
    {
        for (j = 0; j < game->map.cols; j++)
        {
            if (game->map.grid[i][j] == 3)
            {
                game->player_row = i;
                game->player_col = j;
            } else if (game->map.grid[i][j] == 4) {
                game->snake_row = i;
                game->snake_col = j;
              
            } else if (game->map.grid[i][j] == 5) {
                game->treasure_row = i;
                game->treasure_col = j;
            }
        }
    }
    /* lantern detection for DARK mode */
    #ifdef DARK
        for (i = 0; i < game->map.rows; i++)
        {
            for (j = 0; j < game->map.cols; j++)
            {
                if (game->map.grid[i][j] == 2)
                {
                    game->map.grid[i][j] = 0;
                }
            }
        }

        game->lantern_row = 5; /* lantern starts at row 5 */
        game->lantern_col = 4; /* lantern starts at col 4 */
        game->original_lantern_row = 5;
        game->original_lantern_col = 4;
        game->lantern_collected = 0; /* lantern not collected at start */ 
       
        /* upgrading map with lantern position */
        game->map.grid[game->lantern_row][game->lantern_col] = 2;
    
        game->visibility_range = 3;
        #else
        game->visibility_range = 100;
    
        #endif
        init_list(&game->undo_list);
        return 1;
}

void save_game_state(Game* game)
{
    GameState* state = (GameState*)malloc(sizeof(GameState));
    if (!state)
    {
        return;
    }
    state->player_row = game->player_row;
    state->player_col = game->player_col;
    state->snake_row = game->snake_row;
    state->snake_col = game->snake_col;
    #ifdef DARK
    state->visibility_range = game->visibility_range;
    state->lantern_collected = game->lantern_collected;
    #endif
    push(&game->undo_list, state);

}

void undo_move(Game* game)
{
    GameState* prev_state;
    
    if (is_empty(&game->undo_list))
    {
        return; /* no states to undo */
    }

    prev_state = (GameState*)pop(&game->undo_list); 
    if (prev_state == NULL)
    {   
        return; /* no states to undo */
    }

    /* clearing the current positions on map */
    game->map.grid[game->player_row][game->player_col] = 0;
    game->map.grid[game->snake_row][game->snake_col] = 0;
    
    /* restoring the game state */
    game->player_row = prev_state->player_row;
    game->player_col = prev_state->player_col;
    game->snake_row = prev_state->snake_row;
    game->snake_col = prev_state->snake_col;

    /* checking if Player and snake are at same position after undo */
    if (game->player_row == game->snake_row && game->player_col ==
        game->snake_col)
    {
        game->map.grid[game->snake_row][game->snake_col] = 4; 
    } 
    else
    {
        /* updating the map with player and snake's positions */
        game->map.grid[game->player_row][game->player_col] = 3;
        game->map.grid[game->snake_row][game->snake_col] = 4;
    }
    #ifdef DARK
    if (!prev_state->lantern_collected)
    {
        game->map.grid[game->original_lantern_row][game->original_lantern_col] = 2;
        game->lantern_row = game->original_lantern_row;
        game->lantern_col = game->original_lantern_col;
    } else {
        game->map.grid[game->original_lantern_row][game->original_lantern_col] = 0;
        game->lantern_row = -1;
        game->lantern_col = -1;
    }
    game->lantern_collected = prev_state->lantern_collected;
    game->visibility_range = prev_state->visibility_range;

    #endif

    free(prev_state);
    /* print the updates map */
    clear_screen();
    #ifdef DARK
    print_map(&game->map, game->player_row, game->player_col, 
              game->visibility_range);
    #else
    print_map(&game->map, game->player_row, game->player_col);
    #endif
}


void run_game(Game *game)
{
    char input;
    int game_over = 0;
    /* flag to control the game loop */
    
    while (!game_over)
    {
        if (game->player_row == game->snake_row && game->player_col == 
            game->snake_col)
        {
            game->map.grid[game->snake_row][game->snake_col] = 4;
        }
        else {
          game->map.grid[game->player_row][game->player_col] = 3;
          game->map.grid[game->snake_row][game->snake_col] = 4;
        }
    
        clear_screen();
        #ifdef DARK
        print_map(&game->map, game->player_row, game->player_col, 
                  game->visibility_range);
        #else
        print_map(&game->map, game->player_row, game->player_col);
        #endif
        /* handle lantern collection */
        #ifdef DARK
        if (game->player_row == game->lantern_row && 
            game->player_col == game->lantern_col 
            && !game->lantern_collected)
        {
            /* removing lantern */
            game->map.grid[game->lantern_row][game->lantern_col] = 0;
            game->visibility_range = 6;
            game->lantern_collected = 1; 
        }
        #endif
   
        /* checking for win/lose conditions */
        if (game->player_row == game->treasure_row &&
            game->player_col == game->treasure_col)
        {
            printf("You Win Yay!\n");
            game_over = 1; /* setting flag to end the game */

        } else if (game->player_row == game->snake_row && game->player_col ==
                 game->snake_col)
        {
            printf("You Lose! Better Luck Next Time!\n");
            game_over = 1;

        } else {
            /* Get the input */
            input = get_input();

            /* handling the input */
            if (input == 'u')
            {
                undo_move(game);
            }
            else if (input == 'w' || input == 'a' || input == 's' || 
                     input == 'd')
            {
                /* save the current state of game */
                save_game_state(game);
                game->map.grid[game->player_row][game->player_col] = 0;

                move_player(&game->map, &game->player_row, 
                            &game->player_col, input);
                game->map.grid[game->snake_row][game->snake_col] = 0;

                move_snake(&game->map, &game->snake_row, &game->snake_col, 
                           game->player_row, game->player_col);

                /* checking if snake ate P */
                if(game->player_row == game->snake_row && game->player_col ==
                   game->snake_col)
                {
                 
                    game->map.grid[game->snake_row][game->snake_col] = 4; 
                    clear_screen();
                    #ifdef DARK
                    print_map(&game->map, game->snake_row, game->snake_col, 
                              game->visibility_range);
                    #else
                    print_map(&game->map, game->snake_row, game->snake_col);
                    #endif
                    printf("You Lose! You ate the snake and got poisoned."
                            "Better Luck Next Time!\n");
                    game_over = 1;
                    return;
                }
                else
                {
                    game->map.grid[game->player_row][game->player_col] = 3;
                    game->map.grid[game->snake_row][game->snake_col] = 4;
                }
            }
            else
            {
                printf("Invalid input, use the above mentioned keys\n");
     
            }
        }   
    }
}

void cleanup_game(Game *game)
{
    free_map(&game->map);
    free_list(&game->undo_list);
}
