# config.py
import pymysql
DATABASE_CONFIG = {
    'host': 'localhost',
    'user': 'root',
    'password': '',
    'db': 'cms',
    'charset': 'utf8mb4',
    'cursorclass': pymysql.cursors.DictCursor,
}

