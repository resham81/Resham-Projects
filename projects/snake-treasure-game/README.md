# Snake Treasure Game

**Course:** C Programming  
**Year:** 2025  
**Author:** Resham Furqan

Terminal game where you navigate a map, avoid a moving snake, collect a lantern and treasure, and can undo moves via a linked list of game states.

**Tech:** C · Linked lists · Makefile

## Environment

Best run on **Linux** or **WSL** (same toolchain as the Unix prime checker).

### One-time WSL setup (Windows)

```bash
sudo apt update
sudo apt install -y build-essential
```

## Build & run

```bash
cd projects/snake-treasure-game
make
./treasure map.txt
```

> The executable is named **`treasure`** (not `main`).

### Optional dark mode build

```bash
make clean
make DARK=1
./treasure map.txt
```

### Controls

Follow on-screen / assignment controls (movement + undo). Quit when finished.

### Clean build artifacts

```bash
make clean
```

## What's included

- Game, map, linked list, terminal, and utils modules
- `map.txt` sample map
