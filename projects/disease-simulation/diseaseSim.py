# -*- coding: utf-8 -*-
"""
Created on Wed Nov 20 16:15:46 2024

@author: resha
"""
# diseaseSim.py - simulates the spread of disease through a population
# Student Name   : Resham Furqan
# Version history:
# 28/10/24 - beta version released for FOP assignment

import numpy as np
import matplotlib.pyplot as plt
import random

# function to distribute people randomly in the grid
def distribute(grid, num_r, num_c, numpeep):
    """
    populate the grid with a specified number of people randomly distributed
    """
    for i in range(numpeep):
        rpos = random.randint(0, num_r-1)
        cpos = random.randint(0, num_c-1)
        grid[rpos, cpos] += 1
    return grid
"""the loop runs for numpeep times, randomly places a person at a time by 
selecting a random row and column, then increments that grid postition by 1,
indicating a person has been placed in that grid position.
"""
# function to create scatter plot data from the grid
def make_scatter(grid, num_r, num_c):
    """
    Extract scatter plot data (row, column, size) from the grid
    """
    r_values = []
    c_values = []
    count_values = []
# for storing the row and column indices and pop counts for grid cells that
# contain people
    for row in range(num_r):
        for col in range(num_c):
            if grid[row, col] > 0:
# checks if the grid cell contains any people (> 0 means people are there)
                r_values.append(row)
                c_values.append(col)
                count_values.append(grid[row, col]*100) 
                # scaled by 100 for better visibility
    return(r_values, c_values, count_values)

# function to display the grid in the terminal   
def display_grid(grid, num_r, num_c):
    """
    Print the grid in a readable format
    """
    for row in range(num_r-1, -1, -1):
        """loops through the rows of grid, starting from bottom row to the top
        row (0). the last -1 indicates the backward movement"""
        for col in range(num_c):
            print(grid[row, col], end=" ")
        print() # after printing all the cols in current row, it moves to next
           
# applying extension 1
def get_neighbourhood_type():
    """
    ask the user to select a neighbourhood type
    """
    valid_neighbourhood_types = {"Moore", "VonNeumann"}
    for _ in range(3):  # Allow 3 attempts
        neighbourhood_type = input(
            "Select neighbourhood (Moore or VonNeumann): "
        ).strip() # strip to remove any surrounding whitespaces
        if neighbourhood_type in valid_neighbourhood_types:
            return neighbourhood_type
        print("Invalid choice. Please select Moore or VonNeumann.")
    return "Moore"  # Default if no valid input

# applying extension 2
# function to infect or transition individuals based on probability   
def infect(inf, notinf, rec, dead, immune, r, c, prob_infect, 
           prob_recover, prob_death):
    """
    Simulate infection spread, recovery, death, and immunity transitions for
    individuals in a grid cell
    """
    if prob_infect > 0: # checks if infection is possible
        for peep in range(notinf[r, c]): # loops through all uninfected peep
        # notinf[r, c] is the count of uninfected people in the cell
            if (random.random() < prob_infect * inf[r, c] 
                and immune[r, c] == 0): 
                """random is used for generating a random float number between
                0 and 1, to simulate an event occuring with a certain 
                probability. prob_infect * inf[r, c] calculates the effective
                infection probability."""
                inf[r, c] +=1 # infected people increase
                notinf[r, c] -=1 # uninfected decrease
                print("***** New infection (", r, ",", c, ")")    
    for peep in range(inf[r, c]): # handle recovery/death for infected people
        rand_val = random.random()
        if rand_val < prob_recover:
            inf[r, c] -= 1 # infected people decrease
            rec[r, c] += 1 # recovered people increase
            immune[r, c] += 1 # move to immune grid after recovery
        elif rand_val < prob_recover + prob_death:
            inf[r, c] -= 1 # infected is decreased as the person dies
            dead[r, c] += 1
    return inf, notinf, rec, dead, immune   

# applying extension 3
infected_stats = []
uninfected_stats = []
immune_stats = []
recovered_stats = []
dead_stats = []  
# function to calculate statistics         
def plot_stats(stats, num_steps):
    """
    plot the stats of disease spread across simulation steps
    """
    plt.figure(figsize=(10, 6)) # initializing the plot size
    stats = [infected_stats, uninfected_stats, recovered_stats, 
             dead_stats, immune_stats]
    colors = ["r", "b", "g", "k", "m"]
    labels = ["Infected", "Uninfected", "Recovered", "Dead", "Immune"]
    for stat, color, label in zip(stats, colors, labels):
        # zip is used here to iterate over multiple lists
        plt.plot(range(num_steps), stat, label=label, color=color)
        # plots a 2D line grapgh
        # num_steps is the x axis values, the simulation steps
        # satts is the y axis values, population counts for that category
        # label adds the legend for this line
    plt.title("Disease Simulation Statistics")
    plt.xlabel("Timesteps")
    plt.ylabel("Population Count")
    plt.legend() # displays the legend with labels 
    plt.grid(True) # to add a grid to the bg, to easily read the values 
    plt.show()

# applying extension 4            
# function to add barriers
def add_barriers(grid, num_barriers, num_rows, num_cols):
    """
    add barriers to the grid in random locations
    """
    #calculate max possible attempts per barriers
    attempts_max = num_rows * num_cols 
    placing_barriers = num_barriers
    # single for loop for all attempts    
    for attempt in range(num_barriers * attempts_max):
        # only try to place barriers if we still have barriers to place
        if placing_barriers > 0:
            rpos = random.randint(0, num_rows-1)
            cpos = random.randint(0, num_cols-1)
            if grid[rpos, cpos] == 0:
                grid[rpos, cpos] = 1# mark as a barrier
                placing_barriers -= 1
    return grid 
 
# applying extension 5        
# function to initialize airports 
def add_airports(grid, airport_locations):
    """
    add airports at specified locations on the grid
    """
    # airport_locations is a list of tuples
    for r, c in airport_locations:
        grid[r, c] = 1 # mark as an airport
    print(f"Airports added at: {airport_locations}")
    return grid

# function to move people between airports
def move_between_airports(infected, unifected, recovered, dead, immune, 
                          airport_locations, num_rows, num_cols):
    """
    move people between airports based on their states
    """
# using list comprehnsions to create new lists based on exsisting iterable
    valid_airport_locations = [(r, c) for (r, c) in airport_locations 
                               if 0 <= r < num_rows and 0 <= c < num_cols]
    # ensuring all provided airport locations are within the grid
    for (r, c) in valid_airport_locations:
        # filter out the current airport
        possible_targets = [loc for loc in valid_airport_locations 
                            if loc != (r, c)] # excluding current airport
        # if no other airports are available we do not proceed with the move
        if len(possible_targets) > 0:
            # select a random target airport but excluding the current one
            target_airport = random.choice(possible_targets)
            tr, tc = target_airport
            # ensure target coordinates are in grid bounds
            tr = max(0, min(tr, num_rows -1)) 
            tc = max(0, min(tc, num_cols -1))
            # transfer a portion of the population
            for grid in [infected, unifected, recovered, dead, immune]:
                num_to_move = grid[r, c] // 2 # move half the population
                grid[r, c] -= num_to_move
                grid[tr, tc] += num_to_move
    return infected, uninfected, recovered, dead, immune

# function to move people randomly          
def move_peeps(cur, next, r, c, num_rows, num_cols, barriers, 
              neighbourhood="Moore"):
    """
    move people from current grid to the next based on neighbourhood selected
    """
    for peep in range(cur[r,c]):
        if neighbourhood == "Moore":
            rMove = random.randint(-1, 1)
            cMove = random.randint(-1, 1) 
        elif neighbourhood == "VonNeumann":
            rMove, cMove = random.choice([(0, 1), (0, -1), (1, 0), (-1, 0)])
        nr, nc = r + rMove, c + cMove
        if 0 <= nr < num_rows and 0 <= nc < num_cols and barriers[nr, nc] == 0:
            next[nr, nc] += 1 # moving the person to the next grid position
        else:
            next[r, c] += 1 # stay in place if movement is invalid
    return next

# function to plot grids with legends
def plot_grids(infected, uninfected, recovered, dead, immune, num_rows, 
              num_cols):
    """
    plot grids as scatter plot for better visualiazation 
    """
    plt.figure(figsize=(10, 10)) 
    Irows, Icols, Icount = make_scatter(infected, num_rows, num_cols)
    Urows, Ucols, Ucount = make_scatter(uninfected, num_rows, num_cols)
    Rrows, Rcols, Rcount = make_scatter(recovered, num_rows, num_cols)
    Drows, Dcols, Dcount = make_scatter(dead, num_rows, num_cols)
    Imrows, Imcols, Imcount = make_scatter(immune, num_rows, num_cols)
    Arows, Acols, Acount = make_scatter(airports, num_rows, num_cols)
    Brows, Bcols, Bcount = make_scatter(barriers, num_rows, num_cols)
   # plots infected with colors and labels
    plt.scatter(Icols, Irows, s=Icount, c="b", alpha=0.5, label="Infected") 
    print("Infected: ", np.sum(infected))
    # alpha=0.5 for ensuring the points are semi-transparent
    plt.scatter(Ucols, Urows, s=Ucount, c="orange", alpha=0.5, 
                label="Uninfected")
    print("Uninfected: ", np.sum(uninfected))
    plt.scatter(Rcols, Rrows, s=Rcount, c="g", alpha=0.5, label="Recovered")
    print("Recovered: ", np.sum(recovered))
    plt.scatter(Dcols, Drows, s=Dcount, c="k", alpha=0.5, label="Dead")
    print("Dead: ", np.sum(dead))
    plt.scatter(Imcols, Imrows, s=Imcount, c="m", alpha=0.5, label="Immune")
    print("Immune: ", np.sum(immune))
    print("Aiports: ", np.sum(airports))
    plt.scatter(Bcols, Brows, s=Bcount, c="brown", alpha=0.5, label="Barriers")
    print("Barriers: ", np.sum(barriers))
    plt.legend() # to explain the colors for each group
    plt.title("Disease Spread Simulation") 
    plt.xlabel("Columns")
    plt.ylabel("Rows")
    plt.grid(True)
    plt.show()

# applying extension 6
# initialize parameters based on arguments
INIT_POP = 500
INIT_INFECTED = 5
INIT_DEAD = 6
INIT_RECOVER = 8
INIT_IMMUNE = 7
num_cols = int(input("Enter number of columns: "))
num_rows = int(input("Enter number of rows: "))
num_steps = int(input("Enter number of simulation steps: "))
prob_infect = float(input("Enter infection probability: "))
prob_recover = float(input("Enter recovery probability: "))
prob_death = float(input("Enter death probability: "))
prob_immunity = float(input("Enter immunity probability: "))
num_barriers = int(input("Enter number of barriers: "))
num_airports = int(input("Enter number of airports: "))
airports_locations = [(random.randint(0, num_rows -1), 
                       random.randint(0, num_cols -1))
                      for _ in range(num_airports)]

# grid initialization
infected = np.zeros((num_rows, num_cols), dtype=int) 
uninfected = np.zeros((num_rows, num_cols), dtype=int)
recovered = np.zeros((num_rows, num_cols), dtype=int)
dead = np.zeros((num_rows, num_cols), dtype=int)
immune = np.zeros((num_rows, num_cols), dtype=int)
airports = np.zeros((num_rows, num_cols), dtype=int)
barriers = np.zeros((num_rows, num_cols), dtype=int) 

# initial distribution of people
distribute(infected, num_rows, num_cols, INIT_INFECTED)
distribute(uninfected, num_rows, num_cols, INIT_POP)
distribute(dead, num_rows, num_cols, INIT_DEAD)
distribute(recovered, num_rows, num_cols, INIT_RECOVER)
distribute(immune, num_rows, num_cols, INIT_IMMUNE)
add_barriers(barriers, num_barriers, num_rows, num_cols)
add_airports(airports, airports_locations)

# display initial grids
print("Initial Infected Grid:")
display_grid(infected, num_rows, num_cols)
print("\nInitial Uninfected Grid:")
display_grid(uninfected, num_rows, num_cols)
print("Initial Dead Grid:")
display_grid(dead, num_rows, num_cols)
print("Initial Recovered Grid:")
display_grid(recovered, num_rows, num_cols)
print("Initial Immune Grid:")
display_grid(immune, num_rows, num_cols)
print("Barrier positions:")
display_grid(barriers, num_rows, num_cols)
print("airport positions:")
display_grid(airports, num_rows, num_cols)

plot_grids(infected, uninfected, recovered, dead, immune, num_rows, num_cols)
neighbourhood_type = get_neighbourhood_type()
# simulation loop
for timestep in range(num_steps):
    """
    run the disease spread simulation
    """
    print("\n################### TIMESTEP", timestep, "###################\n")
    # creating temporary grids to store updated states
    infected2 = np.zeros((num_rows, num_cols), dtype=int) 
    uninfected2 = np.zeros((num_rows, num_cols), dtype=int)
    recovered2 = np.zeros((num_rows, num_cols), dtype=int)
    dead2 = np.zeros((num_rows, num_cols), dtype=int)
    immune2 = np.zeros((num_rows, num_cols), dtype=int)
    
    for row in range(num_rows):
        for col in range(num_cols):
            infect(infected2, uninfected2, recovered2, dead2, immune2, 
                   row, col, prob_infect, prob_recover, prob_death)
        # movemnet logic: move individuals between grids based on their status
            move_between_airports(infected2, uninfected2, recovered2, dead2, 
                                  immune2, airports_locations, num_rows, 
                                  num_cols)
            # move individual within each grid
            move_peeps(infected, infected2, row, col, num_rows, num_cols, 
                      barriers, neighbourhood=neighbourhood_type)
            move_peeps(uninfected, uninfected2, row, col, num_rows, num_cols, 
                      barriers, neighbourhood=neighbourhood_type)
            move_peeps(recovered, recovered2, row, col, num_rows, num_cols, 
                      barriers, neighbourhood=neighbourhood_type)
            move_peeps(dead, dead2, row, col, num_rows, num_cols, 
                      barriers, neighbourhood=neighbourhood_type)
            move_peeps(immune, immune2, row, col, num_rows, num_cols, 
                      barriers, neighbourhood=neighbourhood_type)
            
     # at the end of the timestep, update the original grids 
     #with the new values from the temporary grids     
    infected = infected2
    uninfected = uninfected2
    recovered = recovered2
    dead = dead2
    immune = immune2          
     
    # record statistics
    infected_stats.append(np.sum(infected))
    uninfected_stats.append(np.sum(uninfected))
    recovered_stats.append(np.sum(recovered))
    dead_stats.append(np.sum(dead))
    immune_stats.append(np.sum(immune))
    
    plot_grids(infected, uninfected, recovered, dead, immune, num_rows, 
               num_cols)
    
plot_stats([infected_stats, uninfected_stats, recovered_stats, dead_stats, 
           immune_stats], num_steps)
print("Done")
print("\nFinal Statistics:")
print(f"Total Uninfected: {uninfected_stats[-1]}")
print(f"Total Infected: {infected_stats[-1]}")
print(f"Total Recovered: {recovered_stats[-1]}")
print(f"Total Dead: {dead_stats[-1]}")
print(f"Total Immune: {immune_stats[-1]}")
