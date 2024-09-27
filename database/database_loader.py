import psycopg2  # type: ignore
from psycopg2 import sql  # type: ignore


class DatabaseManager:
    def __init__(self, config):
        """Initialize the database connection and create tables."""
        self.conn = psycopg2.connect(
            dbname=config["dbname"],
            user=config["user"],
            password=config["password"],
            host=config["host"],
            port=config["port"],
        )
        self.conn.autocommit = True

    def run_sql(self, sql_query):
        with open(sql_query) as q:
            query = q.read()
        with self.conn.cursor() as cursor:
            cursor.execute(query)

    def insert_data(self, table, data):
        """Insert data into the table."""
        # Assuming data is a list of tuples corresponding to the table columns
        with self.conn.cursor() as cursor:
            placeholders = ", ".join(["%s"] * len(data[0]))  # create placeholders
            query = sql.SQL("INSERT INTO {} VALUES ({})").format(
                sql.Identifier(table), sql.SQL(placeholders)
            )
            cursor.executemany(query, data)
            self.conn.commit()

    def close(self):
        """Close the database connection."""
        self.conn.close()
