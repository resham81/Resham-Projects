# -*- coding: utf-8 -*-
"""
Created on Fri Mar  7 14:29:01 2025

@author: Resham Furqan

"""

# deque class for is_path
class Deque:
    def __init__(self):
    # an empty list to hold the elements of the deque
        self.data = []
     
    # add an elemnt to the right end of the deque
    def append_right(self, value):
        self.data.append(value)
        
    # add an elemnt to the left end of the deque
    def append_left(self, value):
        self.data.insert(0, value) # 0 is the index to store value
    
    # remove and return the rightmost element    
    def pop(self):
        if len(self.data) > 0:
            return self.data.pop()
        else:
            raise IndexError("Pop from an empty deque")
            
    # remove and return the leftmost element        
    def pop_left(self):
        if len(self.data) > 0:
            return self.data.pop(0) # removing the element at 0 index
        else:
            raise IndexError("pop from an empty deque")

    #return the number of elemnts in the deque
    def size(self):
        return len(self.data)
            
# Graph Representation for Road Netwrok
class Graph:
    def __init__(self):
    # an empty adjacency list for storing locations (keys) and roads
        self.adj_list = {}
     
    # adding locations to graph, if they already do not exist
    def add_vertex(self, vertex):
        if vertex not in self.adj_list:
            self.adj_list[vertex] = []
        else:
            print(f"location {vertex} already exists")
        
    # add roads
    def add_edge(self, vertex1, vertex2, distance):
        if vertex1 not in self.adj_list or vertex2 not in self.adj_list:
            raise ValueError("One or both vertices do not exist is the graph.")
        self.adj_list[vertex1].append((vertex2, distance))
        self.adj_list[vertex2].append((vertex1, distance))
        # bidirectional roads
    
    
    # returns the list of neighbouring locations for a given location
    def get_neighbours(self, vertex):
        return self.adj_list.get(vertex, [])
    
    # display graph with locations and roads connected
    def display_graph(self):
        for vertex, edges in self.adj_list.items():
            print(f"{vertex} -> {edges}")
            
    # checking if there is a path from source to location
    # BFS approach        
    def is_path(self, source, destination):
        if source not in self.adj_list or destination not in self.adj_list:
            return False
        
        visited = set()
        queue = Deque()
        queue.append_right(source)
        while queue.size() > 0:
            node = queue.pop_left()
            if node == destination:
                return True
            if node not in visited:
                visited.add(node)
                for neighbour, _ in self.adj_list.get(node, []): 
                    if neighbour not in visited:
                        queue.append_right(neighbour)
        # marking visited locations (nodes) and checking neighbours
        # until the destination is found/ all possibilities are explored
        return False # no path, if while loop ends without finiding destination

# VehicleHashTable Implementation
class VehicleHashTable:
    def __init__(self, size):
        self.size = size
        self.table = [None] * size
# initialized a hash table with specified size and an array of None values 

    # to calculate hash value for a Vehicle's ID        
    def hash_function(self, vehicle_ID):
        hash_value = 0
        base = 31 # prime base
        mod = self.size # Modulo table size for indexing
        
        # iterates through each ID, multiplies by hash base to reduce collision
        # then applies modulo with the table size
        for char in vehicle_ID:
            hash_value = (hash_value * base + ord(char)) % mod
        #ord(char) returns the ASCII int represetation of char
        # mod operator ensures value remians within the range of hash table
        return hash_value
    
    # to insert a vehicle in hash table
    def insert(self, vehicle):
        idx = self.hash_function(vehicle.vehicle_ID)
        start_idx = idx
        while True:
            if self.table[idx] is None:
                # if the current slot is empty, insert
                self.table[idx] = vehicle
                print(f"Vehicle with ID {vehicle.vehicle_ID} added "
                      "successfully.")
                return
            if self.table[idx].vehicle_ID == vehicle.vehicle_ID:
                print(f"Vehicle with ID {vehicle.vehicle_ID} already exists.")
                return
            # resolving the collision by linear probing
            idx = (idx + 1) % self.size # incremneting the index for linear
            if idx == start_idx:
                print("Hash table is full. cannot insert more vehicles.")
                return
        self.table[idx] = vehicle
        
    # to delete a vehicle in hash table    
    def delete(self, vehicle_ID):
        idx = self.hash_function(vehicle_ID)
        start_idx = idx
        while self.table[idx] is not None:
            # loop until hash table is empty
            if self.table[idx].vehicle_ID == vehicle_ID:
                self.table[idx] = None
                return True
            # if successfully deleted otherwise move to next
            idx = (idx + 1) % self.size
            if idx == start_idx: # went through the full table
                return False # did not found the ID
        return False
    
    # to search a vehicle in hash table
    def search(self, vehicle_ID):
        idx = self.hash_function(vehicle_ID)
        while self.table[idx] is not None:
            if self.table[idx].vehicle_ID == vehicle_ID:
                return self.table[idx]
            # if vehicle found, return it
            idx = (idx + 1) % self.size
        return None
    
    # to display the hash table with info
    def display_all(self):
        print("~" * 50)
        print("Vehicle Hash Table")
        print("~" * 50)
        for i, vehicle in enumerate(self.table):
    # enumerate takes iterable (self.table) and returns a tuple
    # i is the current position of element & vehicle is the actual vehicle 
            if vehicle is not None:
                print(f"Index {i}:")
                print(f"      Vehicle ID       : {vehicle.vehicle_ID}")
                print(f"      Current Location : {vehicle.current_location}")
                print(f"      Destination      : {vehicle.destination}")
                print(f"      Distance         : "
                      f"{vehicle.distance_to_destination}")
                print(f"      Battery          : {vehicle.battery_level}")
                print("-" * 50)
                
# Vehicle Class Implementation
class Vehicle:
    # initializing the vehicle with attributes
    def __init__(self, vehicle_ID, current_location, destination, 
                 distance_to_destination, battery_level):
        if battery_level < 0 or battery_level > 100:
            raise ValueError("Battery level should be between 1 - 100")
        if distance_to_destination < 0:
            raise ValueError("Distance cannot be negative")
            
        self.vehicle_ID = vehicle_ID
        self.current_location = current_location
        self.destination = destination
        self.distance_to_destination = distance_to_destination
        self.battery_level = battery_level
     
    # updating and retrieving vehicle's attributes
    
    def set_location(self, location):
        self.current_location = location
        
    def set_destination(self, destination):
        self.destination = destination 
        
    def set_distance_to_destination(self, distance):
        self.distance_to_destination = distance

    def set_battery_level(self, level):
        self.battery_level = level

    def get_location(self):
        return self.current_location
    
    def get_destination(self):
        return self.destination
    
    def get_distance_to_destination(self):
        return self.distance_to_destination
    
    def get_battery_level(self):
        return self.battery_level
    
    # defining the less than comparison
    def __lt__(self, other):
        # compare vehicles based on distace_to_destination (for heapsort)
        return self.distance_to_destination < other.distance_to_destination
    
    # defining the greater than comparison
    def __gt__(self, other):
        # compare vehicles based on battery_level (for quicksort)
        return self.battery_level > other.battery_level
    
    # a string representation of vehicle displaying its attributes 
    def __repr__(self):
        # using the unicode char ╚, ╔, ╗, ╝, ╣, ╠, ═ (box draw characters)
    # refernce article: https://en.wikipedia.org/wiki/Box-drawing_characters
        
        return (f" ╔════════════════════════════════════╗\n"
                f" ║        Vehicle Information         ║\n"
                f" ╠════════════════════════════════════╣\n"
                f" ║ Vehicle ID       : {self.vehicle_ID:<16}║\n"      
                f" ║ Current Location : {self.current_location:<16}║\n"
                f" ║ Destination      : {self.destination:<16}║\n"
                f" ║ Distance         : {self.distance_to_destination:<16}║\n" 
                f" ║ Battery          : {self.battery_level:<16}║\n"
                f" ╚════════════════════════════════════╝")
# class for heapsort
# implementing maxHeap as priorty queue to manage vehicle sorting
class maxHeap:
    def __init__(self):
        # an empty list to represent heap
        self.heap = []
        
# helper functions to calculate indices of a given index in heap    
    def parent(self, index):
        return (index - 1) // 2
    
    def left_child(self, index):
        return 2 * index + 1
    
    def right_child(self, index):
        return 2 * index + 2
    
    def has_left_child(self, index):
        return self.left_child(index) < len(self.heap)
    
    def has_right_child(self, index):
        return self.right_child(index) < len(self.heap)
    
    # swaps the elements at two indices in the heap
    def swap(self, i, j):
        self.heap[i], self.heap[j] = self.heap[j], self.heap[i]
        
    def heapify_up(self, index):
        while (index > 0 and 
               self.heap[self.parent(index)].distance_to_destination < 
               self.heap[index].distance_to_destination):
            # ensures the heap property by comparing node with parent
            self.swap(index, self.parent(index))
            # moves it up if greater
            index = self.parent(index)
            
    def heapify_down(self, index):
        largest = index # assuming current index is largest
        if self.has_left_child(index):
            left = self.left_child(index)
            if (self.heap[left].distance_to_destination > 
                self.heap[largest].distance_to_destination):
                largest = left # update the largest
        if self.has_right_child(index):
            right = self.right_child(index)
            if (self.heap[right].distance_to_destination > 
                self.heap[largest].distance_to_destination):
                largest = right # update the largest
        if largest != index:
            self.swap(index, largest)
            # if not largest then heapify down recursively
            self.heapify_down(largest)
            
            
    def insert(self, value):
        #insert a value into the heap
        self.heap.append(value)
        # calling heapify to maintain the heap property after insertion
        self.heapify_up(len(self.heap) - 1)
    
    def pop(self):
        if not self.heap:
            raise IndexError("Cannot Pop from empty heap.")
        max_val = self.heap[0]
        self.heap[0] = self.heap[-1]
        self.heap.pop()
        if self.heap:
            self.heapify_down(0) # to restore the heap property
        return max_val
    
    def size(self):
        # return the size of the heap
        return len(self.heap)
    
    def display(self):
        for v in self.heap:
            print(v)
    
# Vehicle Recommendation based on Sorting Algorithms
def heapsort(vehicles):
    max_heap = maxHeap()
    # insert all vehicles into the heap
    for vehicle in vehicles:
        max_heap.insert(vehicle)
        
    # pop all elements from the heap to get them in sorted order
    sorted_vehicles = []
    while max_heap.size() > 0:
        sorted_vehicles.append(max_heap.pop())
    # reverse to get ascending order (max heap pops largest first)
    return sorted_vehicles[::-1]

   # Vehicle recommendation functions
def find_vehicle_with_highest_battery(vehicles):
    # lamda() takes a vehicle v and returns its battery level
   return max(vehicles, key=lambda v: v.battery_level, default=None)

def find_nearest_vehicle(location, vehicles):
    if not vehicles:
        return None
    return min(vehicles, key=lambda v: v.distance_to_destination)
    
# sorts vehicles by battery level   
def quicksort(vehicles):
    if len(vehicles) <= 1:
        return vehicles
    # recursivly divides the vehicles into three parts, and compare with pivot
    pivot = vehicles[len(vehicles) // 2] # mid element as pivot
    left = [v for v in vehicles if v.battery_level > pivot.battery_level] 
    middle = [v for v in vehicles if v.battery_level == pivot.battery_level]
    right = [v for v in vehicles if v.battery_level < pivot.battery_level] 
    return quicksort(left) + middle + quicksort(right)
    


# Interactive Menu and testing
def test_harness():
    road_network = Graph()
    vehicle_table = VehicleHashTable(10)
    vehicles = []
     
    while True:
        try:    
            print("\nAutonomous Vehicle Management System")
            print("1. Add Location (Vertex)")
            print("2. Add Road (Edge)")
            print("3. Display Road Network")
            print("4. Check Path Existence")
            print("5. Get Neighbours of a location")
            print("6. Add Vehicle")
            print("7. Delete Vehicle")
            print("8. Search Vehicle")
            print("9. Display All Vehicles")
            print("10. Get Vehicle Location")
            print("11. Get Vehicle Destination")
            print("12. Get Vehicle Distance to Destination")
            print("13. Get Vehicle Battery Level")
            print("14. Sort Vehicles by Distance (Heapsort)")
            print("15. Sort Vehicles by Battery (Quicksort)")
            print("16. Find Nearest Vehicle")
            print("17. Find Vehicle with Highest Battery")
            print("18. Exit")
        
            choice = input("Enter your choice: ").strip()
        
            if choice == '1':
                vertex = input("Enter location name: ").strip()
                road_network.add_vertex(vertex)
            
            elif choice == '2':
                vertex1 = input("Enter first location: ").strip()
                vertex2 = input("Enter second location: ").strip()
                try:
                    distance = float(input("Enter distance: "))
                    road_network.add_edge(vertex1, vertex2, distance)
                    print(f"Road between '{vertex1}' and '{vertex2}' "
                          "added successfully!")
                    
                except ValueError:
                    print("Invalid input! Distance must be a number and "
                          "both the locations should be valid.")

            elif choice == '3':
                print("\nRoad Network")
                road_network.display_graph()
            
            elif choice == '4':
                source = input("Enter source location: ").strip()
                destination = input("Enter destination location: ").strip()
                if (source not in road_network.adj_list or 
                    destination not in road_network.adj_list):
                    print("Error: One or both locations do not exist.")
                else:
                    if road_network.is_path(source, destination):
                        print(f"Path Exists between {source} and "
                              f"{destination}")
                    else:
                        print(f"No Path Exists between {source} and "
                              f"{destination}")
                    
            elif choice == '5':
                location = input("Enter location to get neighbours: ").strip()
                neighbours = road_network.get_neighbours(location)
                if neighbours:
                    print(f"Neighbours of {location}: {neighbours}")
                else:
                    print(f"No neighbours found for {location}")
                
            elif choice == '6':
                try:
                    vehicle_ID = input("Enter the vehicle ID: ").strip()
                    if vehicle_table.search(vehicle_ID):
                        print(f"Error: Vehicle with ID {vehicle_ID} already "
                              "exists.")
                    else:
                        location = input("Enter current location: ").strip()
                        if location not in road_network.adj_list:
                            print(f"Error: Location {location} does not exist "
                                  "in the road network.")
                        else:
                            destination = input("Enter destination: ").strip()
                            if destination not in road_network.adj_list:
                                print(f"Error: destination {destination} does"
                                      " not exist in the road network.")
                            else:
                                battery = float(input("Enter battery level: "))
                                distance = float(input("Enter distance to "
                                                       "destination: "))
                                vehicle = Vehicle(vehicle_ID, location, 
                                                  destination, distance, 
                                                  battery)
                                vehicle_table.insert(vehicle)
                                vehicles.append(vehicle)
                                print(f"Vehicle '{vehicle_ID}' added "
                                      "successfully!")
                except ValueError:
                    print("Invalid input! Distance and battery level "
                          "must be numbers and both locations should"
                          " exist")
                    
            elif choice == '7':
                vehicle_ID = input("Enter vehicle ID to delete: ").strip()
                if vehicle_table.delete(vehicle_ID):
                    print(f"Vehicle '{vehicle_ID}' deleted successfully!")
                else:
                    print(f"Vehicle '{vehicle_ID}' not found ")
                    
            elif choice == '8':
                vehicle_ID = input("Enter vehicle ID to search: ").strip()
                vehicle = vehicle_table.search(vehicle_ID)
                if vehicle:
                    print(f"Vehicle found:\n{vehicle}")
                else:
                    print(f"Vehicle '{vehicle_ID}' not found ")
                    
            elif choice == '9':
                print("\nAll Vehicles: ")
                vehicle_table.display_all()
                
            elif choice == '10':
                vehicle_ID = input("Enter vehicle ID to get "
                                   "location: ").strip()
                vehicle = vehicle_table.search(vehicle_ID)
                if vehicle:
                    print(f"Vehicle Location: {vehicle.get_location()}")
                else:
                    print(f"Vehicle '{vehicle_ID}' not found")
                    
            elif choice == '11':
                vehicle_ID = input("Enter vehicle ID to get "
                                   "destination: ").strip()
                vehicle = vehicle_table.search(vehicle_ID)
                if vehicle:
                    print(f"Vehicle Destination: {vehicle.get_destination()}")
                else:
                    print(f"Vehicle '{vehicle_ID}' not found")
                    
            elif choice == '12':
                vehicle_ID = input("Enter vehicle ID to get distance "
                                   "to destination: ").strip()
                vehicle = vehicle_table.search(vehicle_ID)
                if vehicle:
                    print(f"Distance to Destination: "
                          f"{vehicle.get_distance_to_destination()}")
                else:
                    print(f"Vehicle '{vehicle_ID}' not found")
                    
            elif choice == '13':
                vehicle_ID = input("Enter vehicle ID to get battery "
                                   "level: ").strip()
                vehicle = vehicle_table.search(vehicle_ID)
                if vehicle:
                    print(f"Vehicle Battery Level: "
                          f"{vehicle.get_battery_level()}")
                else:
                    print(f"Vehicle '{vehicle_ID}' not found")
                          
                
            elif choice == '14':
                if not vehicles:
                    print("No vehicles available to sort")
                else:
                    vehicles = heapsort(vehicles)
                    print("\nVehicles sorted by distance (ascending): ")
                    for v in vehicles:
                        print(v)
                        
            elif choice == '15':
                if not vehicles:
                    print("No vehicles available to sort.")
                else:
                    sorted_vehicles = quicksort(vehicles)
                    print("\nVehicles sorted by battery level (descending): ")
                    for v in sorted_vehicles:
                        print(v)
                        
            elif choice == '16':
                if not vehicles:
                    print("No vehicles available.")
                else:
                    nearest = find_nearest_vehicle(location, vehicles)
                    print(f"Nearest Vehicle:\n{nearest}")
                    
            elif choice == '17':
                if not vehicles:
                    print("No vehicles available")
                else:
                    highest_battery = find_vehicle_with_highest_battery(vehicles)
                    print(f"Vehicle with highest battery:\n{highest_battery}")
                    
            elif choice == '18':
                print("Exiting the program. Goodbye!")
                break
            
            else:
                print("Invalid choice. Please enter a number between 1 - 13.")
                
        except Exception as e:
            print(f"An Error occured: {e}. Please try again!")

test_harness()