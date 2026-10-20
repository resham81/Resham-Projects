# Disease Spread Simulation

**Course:** Fundamentals of Programming (FOP)  
**Year:** 2024  
**Author:** Resham Furqan

Simulates disease spread across a population on a 2D grid, with random placement and visual output using NumPy and Matplotlib.

**Tech:** Python · NumPy · Matplotlib

## Environment

- **OS:** Windows, macOS, or Linux
- **Python:** 3.10+ recommended
- **Packages:**
  ```bash
  pip install numpy matplotlib
  ```

## Run

From this folder (VS Code / PowerShell / terminal):

```bash
cd projects/disease-simulation
python diseaseSim.py
```

The program asks for inputs (grid size, steps, probabilities, barriers, airports, neighbourhood type). Plot windows open via Matplotlib — close them to continue/finish.

### Example inputs (for a quick smoke test)

| Prompt | Example |
|--------|---------|
| columns / rows | `20` / `20` |
| simulation steps | `10` |
| infection / recovery / death / immunity probs | `0.3` / `0.2` / `0.05` / `0.1` |
| barriers / airports | `2` / `1` |
| neighbourhood | `Moore` |

## What's included

- `diseaseSim.py` — main simulation
- Report documents
