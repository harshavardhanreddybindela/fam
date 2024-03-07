from typing import Union
import pymysql
import sys
from flask import Flask, app, render_template, request, redirect, url_for, jsonify,Response
from config.db import DATABASE_CONFIG

def db_connection():
    conn = pymysql.connect(**DATABASE_CONFIG)
    
    return conn

def post_student():
    insert_student_query = """INSERT INTO student (profile,fname, lname, email, phone, gender, dob, address, city, pincode, country, branch_name, qualification)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s,%s)"""
    return insert_student_query

def post_hobbies():
    insert_hobby_query = "INSERT INTO student_hobbies (student_id, hobbies_id) VALUES (%s, %s)"
    
    return insert_hobby_query
def get_students(id=None, sort='student_id', order='asc', offset=0):
    if id is None:
        student_list = """
                        SELECT s.*, group_concat(h.hobby SEPARATOR ', ') as hobbies_string FROM student s
                        JOIN student_hobbies sh on (sh.student_id = s.student_id)
                        JOIN hobbies h on (h.hobbies_id = sh.hobbies_id)
                        GROUP BY s.student_id
                        ORDER BY {} {} LIMIT 4 OFFSET %s""".format(sort, order)
    else:
        student_list = """
        SELECT s.*,group_concat(hobbies_id separator '|') as hobbies FROM student s
        JOIN student_hobbies sh ON s.student_id = sh.student_id  WHERE s.student_id = %s
        GROUP BY s.student_id
        """
    return student_list

def get_delete_student(id):
    delete_student_query = "DELETE FROM student WHERE student_id = %s"
    return delete_student_query

def edit_student(student_id):
    update_query="""UPDATE student 
                        SET profile=%s, fname=%s, lname=%s, email=%s, phone=%s,
                        gender=%s, dob=%s, address=%s, city=%s, pincode=%s,
                        country=%s, qualification=%s, branch_name=%s
                WHERE student_id=%s"""
    return update_query

def get_student_details(cursor, student_id):
    query = "SELECT * FROM student WHERE student_id = %s"
    cursor.execute(query, (student_id,))
    return cursor.fetchone()  # Assuming this returns a dictionary


def get_hobbies_list(cursor):
    get_hobbies_query = "SELECT hobbies_id, hobby FROM hobbies ORDER BY hobby ASC"
    cursor.execute(get_hobbies_query)
    return cursor.fetchall()


def get_student_hobbies(cursor, student_id):
    get_student_hobbies_query = """SELECT GROUP_CONCAT(hobbies_id SEPARATOR '|') AS hobby_ids
               FROM student_hobbies
               WHERE student_id = %s"""
    cursor.execute(get_student_hobbies_query, (student_id,))
    result = cursor.fetchone()
    return result['hobby_ids'].split('|')

def get_delete_hobbies(id):
    delete_hobbies_query = "DELETE FROM student_hobbies WHERE student_id = %s"
    return delete_hobbies_query

def post_edit_hobbies():
    insert_hobbies_query = "INSERT INTO student_hobbies (student_id, hobbies_id) VALUES (%s, %s)"
    return insert_hobbies_query

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

def get_email(id):
    conn = db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT email FROM student WHERE student_id = %s", (id,))
    result = cursor.fetchone()[0]
    if result is not None:
        user_email = result[0]
    else:
        # Handle the case where no data was found
        user_email = None 
    conn.close()
    return user_email

if __name__ == '__main__':
    app.run(debug=True)
