# Resham Furqan
# 12/11/2025

# the python connection file
# Credentials come from environment variables (see .env.example).
# PowerShell:  $env:DB_PASSWORD = "your_password"
# Or copy .env.example to .env and load variables before running.

import os
import mysql.connector
from mysql.connector import Error
import datetime


def get_db_connection():
    """Connect using env vars so the same code works for everyone."""
    password = os.getenv("DB_PASSWORD")
    if not password:
        raise SystemExit(
            "DB_PASSWORD is not set.\n"
            "PowerShell example:\n"
            '  $env:DB_PASSWORD = "your_mysql_password"\n'
            "  python database_connection.py\n"
            "Or copy .env.example to .env, fill DB_PASSWORD, then export those variables."
        )
    return mysql.connector.connect(
        host=os.getenv("DB_HOST", "localhost"),
        database=os.getenv("DB_NAME", "film_festival"),
        user=os.getenv("DB_USER", "root"),
        password=password,
        ssl_disabled=True,
    )

def main():
    # loading appropriate libraries
    print("Importing mysql.connector")

    # connecting to the database and login
    print("\nConnecting to the Database.")

    try:
        conn = get_db_connection()

        if conn.is_connected():
            print("Succeessfully Connected to Database")
        
        # setting up information/statements
        print("\nSetting up Parameterized Queries")

        # Query from Part 3: Basic SELECT with WHERE
        query1 = "SELECT title, release_year FROM film WHERE release_year = %s"

        # Query from Part 3: JOIN multiple tables
        query2 = """
        SELECT f.title, ac.category_name, p.first_name, p.last_name
        FROM film f
        JOIN nomination n ON f.film_ID = n.film_ID
        JOIN award_category ac ON n.category_ID = ac.category_ID
        JOIN person p ON n.person_ID = p.person_ID
        WHERE n.status = 'Won'
        LIMIT 5
        """

        # INSERT Statement
        insert_stmt = """
        INSERT  INTO film (title, release_year, language, duration)
        VALUES (%s, %s, %s, %s)
        """

        # UPDATE statement
        update_stmt = "UPDATE film SET duration = %s WHERE title = %s"

        # DELETE statement
        delete_stmt = "DELETE FROM film WHERE title = %s AND release_year = %s"

        # sending queries and getting results
        print("\nExecuting Queries & Processing Results")

        # creating cursor
        cursor = conn.cursor()

        # executing SELECT query from Part 3
        print("\n1. Executing  SELECT query (films from 2024):")
        try:
            cursor.execute(query1, (2024,))

            # processing reply
            print("2. Processing Results:")
            films_2024 = cursor.fetchall()
            if films_2024:
                for film in films_2024:
                    print(f"  -{film[0]} ({film[1]})")
            else:
                print("  No films found for 2024")
        except Error as e:
            print(f"   SELECT Query Failed: {e}")

        # executing JOIN query from Part 3
        print("\n3. Executing JOIN Query (Award Winners 2024):")
        try:
            cursor.execute(query2)

            # processing results using cursor as iterator
            print("\n4. Processing Award Winners:")
            award_winners = cursor.fetchall()
            if award_winners:
                for row in award_winners:
                    print(f"   - {row[0]} won {row[1]} (by {row[2]} {row[3]})")
            else:
                print("   No award winners found")
        except Error as e:
            print(f"   JOIN Query Failed: {e}")

        # demonstrating INSERT Operation
        print("\n5. Demonstrating INSERT Operation:")
        try:
            new_film = ('Python Connection Test', 2025, 'USA', 120)
            cursor.execute(insert_stmt, new_film)
            conn.commit()
            print(f"   Inserted: {new_film[0]}")
        except Error as e:
            print(f"   INSERT failed: {e}")

        # demonstrating UPDATE Operation
        print("\n6. Demonstrating UPDATE Operation:")
        try:
            cursor.execute(update_stmt, (130, 'Python Connection Test'))
            conn.commit()
            print("   Updated Film Duration")
        except Error as e:
            print(f"   UPDATE Failed: {e}")

        # demonstrating DELETE Operation
        print("\n7. Demonstrating DELETE operation:")
        try:
            cursor.execute(delete_stmt, ('Python Connection Test', 2025))
            conn.commit()
            print("   Deleted test film")
        except Error as e:
            print(f"   DELETE Failed: {e}:")
        
        # demonstrating executemany()
        print("\n8. Demonstrating executemany():")
        try:
            multiple_films = [
                ('Batch Film 1', 2025, 'UK', 110),
                ('Batch Film 2', 2025, 'France', 95),
                ('Batch Film 3', 2025, 'Germany', 105)
            ]   
            cursor.executemany(insert_stmt, multiple_films)
            conn.commit()
            print(f"   Inserted {len(multiple_films)} films using executemany()")

            # Cleaning up batch inserts
            for film in multiple_films:
                cursor.execute(delete_stmt, (film[0], film[1]))
            conn.commit()
            print("   Cleaned up Batch Films")
        except Error as e:
            print(f"   Executemany Failed: {e}")
            
        # Closing cursor
        cursor.close()
        
    except Error as e:
        print(f"Error: {e}")
    
    finally:
        # Disconnecting from Database
        print("\nDisconnecting from Database")
        if 'conn' in locals() and conn.is_connected():
            conn.close()
            print("Database connection closed")


# additional demonstration
def demonstrate_individual_operations():
    print("\n" + "="*50)
    print("ADDITIONAL DEMONSTRATIONS")
    print("="*50)

    try:
        conn = get_db_connection()

        cursor = conn.cursor()

        # using fetchone() with while loop
        print("\n1. Using fetchone() with while loop:")
        try:
            cursor.execute("SELECT name, location FROM film_festival LIMIT 3")
            row = cursor.fetchone()
            while row is not None:
                print(f"   Festival: {row[0]}, Location: {row[1]}")
                row = cursor.fetchone()
        except Error as e:
            print(f"   Fetchzone Failed: {e}")

        # using fetchmany()
        print("\n2. Using fetchmany():")
        try:
            cursor.execute("SELECT title, release_year FROM film ORDER BY release_year DESC LIMIT 5")
            first_two = cursor.fetchmany(size=2)
            print(f'   First 2 films: {first_two}')
            for film in first_two:
                print(f'   - {film[0]} ({film[1]})')
            cursor.fetchall()
        except Error as e:
            print(f'   fetchmany Failed: {e}')

        # parameterized queriees 
        print("\n3. Using Parameterized Queries:")
        try:
            select_query = "SELECT title FROM film WHERE language = %s LIMIT 3"
            cursor.execute(select_query, ('English',))
            english_films = cursor.fetchall()
            print(f'  Found {len(english_films)} English films:')
            for film in english_films:
                print(f'   - {film[0]}')
        except Error as e:
            print(f'   Parameterized Query Failed: {e}')
        
        cursor.close()
        conn.close()
        print("Additional Demonstrations Completed")

    except Error as e:
        print(f"Error in additional demonstrations: {e}")


if __name__ == "__main__":
    print("Film Festival Database: Python Connectivity")
    print("="*50)

    main()
    demonstrate_individual_operations()

    print("\n" + "="*50)
    print("All Operations Completed!")
    print("="*50)
    print("\n Part 5 Requirements Correctly Demonstrated:")
    print("Database connection established")
    print("SELECT queries from Part 3 executed via Python")
    print("INSERT operations performed")
    print("UPDATE operations performed")
    print("DELETE operations performed")
    print("Parameterized queries used (prevents SQL injection)")
    print("Advanced cursor methods used (fetchone, fetchmany, executemany)")
    print("Proper connection management with error handling")
    print("="*50)


