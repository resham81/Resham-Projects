# Film Festival Database

**Course:** Database Systems (DBS)  
**Year:** 2025  
**Author:** Resham Furqan

Full MySQL database for film festivals, films, people, and awards — including schema, seed data, analytical queries, views, triggers, stored procedures, and a Python connectivity demo.

**Tech:** MySQL · SQL · Python

## Environment

- **OS:** Windows, macOS, or Linux
- **MySQL Server:** 8.x recommended (must be installed and running)
- **Python:** 3.10+
- **Package:**
  ```bash
  pip install mysql-connector-python
  ```

Credentials are read from **environment variables** so the same code works for everyone. Never commit a real password.

| Variable | Default | Required |
|----------|---------|----------|
| `DB_PASSWORD` | _(none)_ | **Yes** |
| `DB_HOST` | `localhost` | No |
| `DB_NAME` | `film_festival` | No |
| `DB_USER` | `root` | No |

See `.env.example` for a template. Keep a real `.env` out of git (listed in root `.gitignore`).

## Setup database

From this folder, with MySQL running:

```bash
mysql -u root -p < create_tables.sql
mysql -u root -p < insert_data.sql
```

(You can also run those `.sql` files in MySQL Workbench.)

Optional advanced SQL demos: `advanced_features.sql`, `query*.sql`, `test_*.sql`.

## Run Python connector

### Windows (PowerShell)

```powershell
cd projects\film-festival-database
$env:DB_PASSWORD = "your_mysql_password"
python database_connection.py
```

### macOS / Linux / WSL

```bash
cd projects/film-festival-database
export DB_PASSWORD="your_mysql_password"
python database_connection.py
```

### Expected behaviour

- **Password not set:** script exits with a clear message telling you to set `DB_PASSWORD`
- **MySQL + schema ready:** connects and demos SELECT / INSERT / UPDATE / DELETE / cursor methods

## What's included

- SQL: create tables, inserts, queries, advanced features, tests
- `database_connection.py` — Python CRUD / cursor demos
- `.env.example` — safe credential template
- Report and user guide PDFs
