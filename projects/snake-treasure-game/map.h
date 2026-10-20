#ifndef MAP_H
#define MAP_H

typedef struct
{
    int **grid;
    int rows, cols;
} Map;

#ifdef DARK
void print_map(const Map *map, int player_row, int player_col,
               int visibility_range);
#else
void print_map(const Map *map, int player_row, int player_col);
#endif

int load_map(Map *map, const char *map_file);
void free_map(Map *map);
/* void print_map(const Map *map, int player_row, int player_col, 
               int snake_row, int snake_col, int treasure_row, 
               int treasure_col, int lantern_row, int lantern_col);
*/
#endif
