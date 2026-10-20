#ifndef GAME_H
#define GAME_H
#include "linkedlist.h"
#include "map.h"

typedef struct
{
    Map map;
    int player_row, player_col;
    int snake_row, snake_col;
    int treasure_row, treasure_col;
    int lantern_row, lantern_col;
    int game_over;
    int visibility_range;
    int lantern_collected;
    int original_lantern_row, original_lantern_col;
    LinkedList undo_list;    

} Game;

typedef struct
{
    int player_row, player_col;
    int snake_row, snake_col;
    #ifdef DARK
    int visibility_range;
    int lantern_collected;
    #endif
} GameState;

int init_game(Game *game, const char *map_file);
void run_game(Game *game);
void cleanup_game(Game *game);
void undo_move(Game *game);

#endif
