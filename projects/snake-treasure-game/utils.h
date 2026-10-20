#ifndef UTILS_H
#define UTILS_H
#include "game.h"
#include "map.h"

void clear_screen();
char get_input();
void move_player(Map *map, int *player_row, int *player_col, char input);
void move_snake(Map *map, int *snake_row, int *snake_col, 
                int player_row, int player_col);
void handle_input(Map *map, int *player_row, int *player_col, char input,
                  Game *game);

#endif

