# Unix Prime Checker

**Course:** Unix Systems Programming (USP)  
**Year:** 2025  
**Author:** Resham Furqan

C program that reads integers from a file using system calls and checks primality with parent/child processes and pipes.

**Tech:** C · Unix · Makefile

## Environment

This project uses Unix system calls (`fork`, pipes, `open`/`read`/`write`). It is meant to run on:

- **Linux**, or
- **WSL** on Windows (Ubuntu recommended)

### One-time WSL setup (Windows)

In PowerShell:

```powershell
wsl
```

Then inside WSL:

```bash
sudo apt update
sudo apt install -y build-essential
```

(`build-essential` provides `gcc` and `make`.)

> Paths in WSL look like:  
> `/mnt/c/Users/<you>/.../Resham-Projects/projects/unix-prime-checker`

## Build & run

```bash
cd projects/unix-prime-checker
make
./prime numbers.txt
```

Other sample files: `small_numbers.txt`, `large_numbers.txt`, `single_number.txt`, `numbers1.txt`

### Clean build artifacts

```bash
make clean
```

## What's included

- `prime.c`, `primecheck.c`, `fileio.c`, `prime.h`, `Makefile`
- Sample number files and report PDF
