from flask import Flask
from ConnectionBD.ConnectBD import ConnectDB

app = Flask(__name__)
# Дальше идет конфигурация и регистрация маршрутов Flask

if __name__ == '__main__':
    # Тестирование подключения к базе данных
    with ConnectDB() as db_connection:
        if db_connection:
            print("Успешно подключились к базе данных!")
        else:
            print("Не удалось подключиться к базе данных.")

    # Запуск Flask-приложения
    app.run(debug=True, port=5000)
