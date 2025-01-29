# config.py
import pymysql
DATABASE_CONFIG = {
    'host': 'cms.ctya6w04ixjw.us-east-2.rds.amazonaws.com',
    'user': 'admin',
    'password': '12345678',
    'db': 'cms',
    'charset': 'utf8mb4',
    'cursorclass': pymysql.cursors.DictCursor,
}

