import mariadb
from contextlib import contextmanager


class ConnectDB:
    def __enter__(self):
        try:
            self.connection = mariadb.connect(
                user='root',
                password='',
                host='127.0.0.1',
                database='fooddelivery'
            )
            return self.connection
        except mariadb.Error as error:
            print(f"Database connection error: {error}")
            return None

    def __exit__(self, exc_type, exc_value, traceback):
        # Close the connection if it exists
        if self.connection:
            self.connection.close()



