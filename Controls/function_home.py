import logging
import unittest
from contextlib import contextmanager
from ConnectionBD.ConnectBD import ConnectDB


# Настройка логирования
logging.basicConfig(level=logging.INFO)

@contextmanager
def get_cursor():
    """Получение курсора для работы с базой данных."""
    connection = None
    try:
        connection = ConnectDB().connection
        cursor = connection.cursor(dictionary=True)
        yield cursor
        connection.commit()
    except Exception as e:
        logging.error(f"Database error: {e}")
        if connection:
            connection.rollback()
        raise
    finally:
        if connection:
            connection.close()

def execute_query(query, args=(), fetch=False):
    with ConnectDB() as connection:
        with connection.cursor(dictionary=True) as cursor:
            cursor.execute(query, args)
            if fetch:
                return cursor.fetchall()
            else:
                connection.commit()
