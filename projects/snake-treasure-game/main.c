#include <stdio.h>
#include <stdlib.h>
#include "game.h"
#include "map.h"
#include "utils.h"


int main(int argc, char *argv[])
{
    Game game;

	/*Checking command-line argumnets */
	if (argc != 2)
	{
		printf("Usage: %s <map_file>\n", argv[0]);
		return 1;
	}
   
	if (!init_game(&game, argv[1]))
	{
		fprintf(stderr, "Failed to initialize game. \n");
		return 1;
	}
	run_game(&game);
	printf("Game Ended\n");

	cleanup_game(&game);
	return 0;
}

