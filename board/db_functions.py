from typing import Union
import pymysql
import sys
from flask import Flask, app, render_template, request, redirect, url_for, jsonify,Response
from config.db import DATABASE_CONFIG

def db_connection():
    conn = pymysql.connect(**DATABASE_CONFIG)
    print(conn)
    return conn

# post operations
def post_student():
    insert_student_query = """INSERT INTO student (profile,fname, lname, email, phone, gender, dob, address, city, pincode, country, state, branch_name, qualification)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s,%s)"""
    return insert_student_query

def post_hobbies():
    insert_hobby_query = "INSERT INTO student_hobbies (student_id, hobbies_id) VALUES (%s, %s)"
    return insert_hobby_query
def post_edit_hobbies():
    insert_hobbies_query = "INSERT INTO student_hobbies (student_id, hobbies_id) VALUES (%s, %s)"
    return insert_hobbies_query

def get_students(sort='student_id', order='asc', offset=0, limit=4, search=None):
    base_query = """
    SELECT s.student_id, s.fname, s.lname, s.email, s.phone, s.gender, DATE_FORMAT(s.dob, '%%d-%%m-%%Y') AS dob, s.address,
    s.city, s.pincode, s.country,s.state,s.city, s.branch_name, s.qualification,s.created_by, DATE(s.created_on) AS created_date,
    GROUP_CONCAT(h.hobby SEPARATOR ', ') AS hobbies_string FROM student s
    LEFT JOIN student_hobbies sh ON sh.student_id = s.student_id
    LEFT JOIN hobbies h ON h.hobbies_id = sh.hobbies_id
    """
    search_query = ""
    if search:
        search_query = """
            WHERE fname LIKE %s OR lname LIKE %s OR email LIKE %s
        """
    
    group_order_limit_query = """
        GROUP BY s.student_id, s.fname, s.lname, s.email, s.phone, s.gender, s.dob, s.address, s.city, s.pincode, s.country,
        s.branch_name, s.qualification, s.created_by, s.created_on
        ORDER BY {} {} LIMIT %s OFFSET %s
    """.format(sort, order)
    
    final_query = base_query + search_query + group_order_limit_query
    return final_query




def get_student_details(cursor, student_id):
    query = "SELECT * FROM student WHERE student_id = %s"
    cursor.execute(query, (student_id,))
    result = cursor.fetchone()
    return result if result else {}


def get_student_email(cursor, student_id):
    cursor.execute("SELECT student_id,email FROM student WHERE student_id = %s", (student_id,))
    student_info = cursor.fetchall()
    return student_info


def get_student_hobbies(cursor, student_id):
    get_student_hobbies_query = """SELECT GROUP_CONCAT(hobbies_id SEPARATOR '|') AS hobby_id
            FROM student_hobbies
            WHERE student_id = %s"""
    cursor.execute(get_student_hobbies_query, (student_id,))
    result = cursor.fetchone()
    return result['hobby_id']

def get_details():
    list_query="""SELECT s.*, group_concat(h.hobby separator '|') as hobbies
                FROM student s
                LEFT JOIN student_hobbies sh ON s.student_id = sh.student_id
                LEFT JOIN hobbies h ON sh.hobbies_id = h.hobbies_id
                GROUP BY s.student_id
                """
    return list_query

def get_email(id):
    conn = db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT email FROM student WHERE student_id = %s", (id,))
    result = cursor.fetchone()[0]
    if result is not None:
        user_email = result[0]
    else:
        user_email = None
    conn.close()
    return user_email

def get_hobbies_list(cursor):
    get_hobbies_query = "SELECT hobbies_id, hobby FROM hobbies ORDER BY hobby ASC"
    cursor.execute(get_hobbies_query)
    return cursor.fetchall()

def get_cities_list(cursor):
    get_cities_query = "SELECT city_id, city_name FROM cities ORDER BY city_name ASC"
    cursor.execute(get_cities_query)
    return cursor.fetchall()

def get_states_list(cursor):
    get_states_query = "SELECT state_id, state_name FROM states ORDER BY state_name ASC"
    cursor.execute(get_states_query)
    return cursor.fetchall()

def get_countries_list(cursor):
    get_countries_query = "SELECT country_id, country_name FROM countries ORDER BY country_name ASC"
    cursor.execute(get_countries_query)
    return cursor.fetchall()

def get_branch_list(cursor):
    branch_list_query = "SELECT * FROM branches ORDER BY branch_id ASC"
    cursor.execute(branch_list_query)
    branchlist = cursor.fetchall()
    return branchlist

def get_qualification_list(cursor):
    qualification_list_query = "SELECT * FROM qualifications ORDER BY qualification_id ASC"
    cursor.execute(qualification_list_query)
    qualificationlist = cursor.fetchall()
    return qualificationlist

def get_delete_student(id):
    delete_student_query = "DELETE FROM student WHERE student_id = %s"
    return delete_student_query

# def edit_student(student_id):
#     update_query="""UPDATE student
#                         SET profile=%s, fname=%s, lname=%s, email=%s, phone=%s,
#                         gender=%s, dob=%s, address=%s, city=%s, pincode=%s,
#                         country=%s, qualification=%s, branch_name=%s
#                 WHERE student_id=%s"""
#     return update_query

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
