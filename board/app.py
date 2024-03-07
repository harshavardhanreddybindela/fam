from curses import flash
import smtplib
from flask_session.__init__ import Session
from werkzeug.security import check_password_hash
from flask_mail import Mail, Message 
import os
import sys
import csv
import io
from flask import Flask, render_template, request, redirect, session, url_for, jsonify,Response
import pymysql
from config.db import DATABASE_CONFIG
from db_functions import get_branch_list, get_email, get_qualification_list, get_students,get_delete_hobbies,db_connection, post_edit_hobbies,post_student,post_hobbies,get_delete_student,get_hobbies_list,edit_student,get_student_hobbies,get_student_details

# # Initialize Flask app
app = Flask(__name__)
# mail = Mail(app)
app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"
Session(app)
conn = db_connection()

app.config['MAIL_SERVER'] = 'smtp.gmail.com'
app.config['MAIL_PORT'] = 587
app.config['MAIL_USE_TLS'] = True
app.config['MAIL_USERNAME'] = 'harshareddy4400@gmail.com'
app.config['MAIL_PASSWORD'] = 'gdzc jhpd tyqs aaks'
mail = Mail(app)


@app.route("/sendmail/<int:id>")
def sendmail(id):
    conn = db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT student_id,email FROM student WHERE student_id = %s", (id,))
    result = cursor.fetchone()
    # print(result)
    if result:
        user_email = result['email']
        # print(user_email)
        msg = Message('Test',
                  sender='harshareddy4400@gmail.com',
                  recipients=[user_email],
                  )
        
        msg.body = 'Hello Flask message sent from Flask-Mail'
        mail.send(msg)
    else:
        return 'No user found to send email to.'
    return 'Sent'




@app.route('/home')
def home():
    if 'fname' in session:
        welcomeMsg = f"Welcome, {session['fname']}!"
    else:
        welcomeMsg = "Welcome!"
    return render_template('home.html', message=welcomeMsg)


@app.route('/add_student')
def add_student():
    cursor = conn.cursor()
    try:
        data={}
        cursor.execute("SELECT branch_id, branch_name FROM branches ORDER BY branch_id ASC")
        data['branchlist'] = cursor.fetchall()
        cursor.execute("SELECT qualification_id, qualification FROM qualifications ORDER BY qualification_id ASC")
        data['qualificationlist'] = cursor.fetchall()
        cursor.execute("SELECT hobbies_id, hobby FROM hobbies ORDER BY hobbies_id ASC")
        data['hobbies'] = cursor.fetchall()
        return render_template('add_student.html', data = data)
    except Exception as e:
        print("Error fetching branches,qualification,hobbies:", e)
        return render_template('add_student.html', data=data)
    finally:
        conn.close()


# Define a route for the registration form
@app.route('/register', methods=['GET', 'POST'])
def register():
    # Extract student info from form da
    student_info = request.form.to_dict()
    if request.method == 'POST':
        
        file = request.files['profile']
        if file.filename != '':
            file.save(file.filename)
            student_info['profile'] ='abc.jpg'
        student_info['fname'] = request.form['fname'] #request is a class in built-in libraries
        student_info['lname'] = request.form['lname']
        student_info['email'] = request.form['email']
        student_info['phone'] = request.form.get('phone', '')
        student_info['branch'] = request.form['branch']
        student_info['qualification'] = request.form['qualification']
        student_info['gender'] = request.form.get('gender', '')
        student_info['dob'] = request.form['dob']
        student_info['address'] = request.form['address']
        student_info['city'] = request.form['city']
        student_info['pincode'] = request.form['pincode']
        student_info['country'] = request.form['country']
        student_info['hobbies'] = '|'.join(request.form.getlist('hobbies[]'))

        try:
            with conn.cursor() as cursor:
                
                data = {}
                insert_student_query= post_student()
                data['add_student']=cursor.execute(insert_student_query,(student_info['profile'],student_info['fname'], student_info['lname'], student_info['email'], student_info['phone'], student_info['gender'], student_info['dob'], student_info['address'], student_info['city'], student_info['pincode'], student_info['country'], student_info['branch'],student_info['qualification']))
                student_id = cursor.lastrowid
                print(data['add_student'])
                for hobby_id in student_info['hobbies'].split('|'):
                    insert_hobby_query = post_hobbies()
                    data['post_hobbies']=cursor.execute(insert_hobby_query, (student_id, hobby_id))
                conn.commit()
                email=student_info['email']
                fname=student_info['fname']
                print(fname)
                msg = Message('Thank You for Your Submission',
                      sender='harshareddy4400@gmail.com',
                      recipients=[email])
                msg.body = """
                Hello {}!,
                    Thank you for your submission. You are registered as a student in our website \t
                Thanks and Regards,
                Harsha
                Note:this is a test run by Harsha Reddy""".format(fname)
                mail.send(msg)
        except Exception as e:
            conn.rollback()  # Rollback the transaction in case of an error
            return f"Error: {str(e)}"
    return render_template('add_student.html',data=data)
@app.route('/list/', defaults={'page': 1}, methods=['GET', 'POST'])
@app.route('/list/page/<int:page>', methods=['GET'])
def list_students(page):
    conn = db_connection()
    cursor = conn.cursor()
    id = request.args.get('id', None)
    sort = request.args.get('sort', 'student_id')
    order = request.args.get('order', 'asc').lower()
    current_sort = request.args.get('current_sort')
    current_order = request.args.get('current_order', 'asc')
    prev_page = max(page - 1, 1)
    next_page = page + 1
    offset = 4 * (page - 1)

    if sort == current_sort:
        order = 'desc' if current_order == 'asc' else 'asc'
    valid_sort_columns = ['student_id', 'fname', 'lname', 'email', 'phone', 'branch_name', 'qualification', 'dob', 'address', 'city', 'pincode', 'country']
    if sort not in valid_sort_columns or order not in ['asc', 'desc']:
        sort = 'student_id','fname'
        order = 'asc'
        
    try:
        data = {}
        print("*******")
        student_list_query = get_students(id=id, sort=sort, order=order, offset=offset)
        cursor.execute(student_list_query, (offset,))
        data['studentlist'] = cursor.fetchall()
        data['all_hobbies'] = get_hobbies_list(cursor)
        data['hobbies_dict'] = dict((hobby['hobbies_id'], hobby['hobby']) for hobby in data['all_hobbies'])
        # print(data['studentlist'])
        return render_template('student_list.html', page=page, data=data, prev_page=prev_page, next_page=next_page)
    except Exception as e:
        print(f"Error: {e}")
        return render_template('error_page.html', error_message=str(e))
    finally:
        conn.close()

# Define a route for deleting a student
@app.route('/delete/<int:id>', methods=['GET'])
def delete_student(id):
    try:
        cursor = conn.cursor()
        delete_query = get_delete_student(id)
        cursor.execute(delete_query, (id,))
        conn.commit()
        return redirect(url_for('list_students', msg="Student deleted successfully"))
    except Exception as e:
        print(f"Error: {e}")
        return redirect(url_for('list_students', msg="Error: In Deleting Student"))
    finally:
        if conn:
            conn.close()


# Define a route for editing a student
@app.route('/edit_student/<int:id>', methods=['GET'])
def edit_student(id):
    conn = db_connection()
    try:
        data={}
        with conn.cursor(pymysql.cursors.DictCursor) as cursor:
            data['all_hobbies'] = get_hobbies_list(cursor)
            data['selected_hobbies'] = get_student_hobbies(cursor, id)
            data['branch_list'] = get_branch_list(cursor)
            data['qualification_list'] = get_qualification_list(cursor)
            student = get_student_details(cursor, id)
            if not student:
                return "Student not found", 404
            data['student'] = student
            return render_template('edit_student.html', student=student, data=data)
    except Exception as e:
        return "Error fetching data", 500
    finally:
        conn.close()

# Define a route for updating a student's information
@app.route('/update_student/<int:id>', methods=['POST'])
def update_student(id):
    if request.method == 'POST':
        # Retrieve form data
        profile = request.form['profile']
        fname = request.form['fname']
        lname = request.form['lname']
        email = request.form['email']
        phone = request.form['phone']
        branch_name = request.form['branch']
        qualification = request.form['qualification']
        gender = request.form.get('gender', '')
        dob = request.form['dob']
        address = request.form['address']
        city = request.form['city']
        pincode = request.form['pincode']
        country = request.form['country']
        hobbies = request.form.getlist('hobbies[]')

        conn = None
        try:
            data={}
            conn = db_connection()
            with conn.cursor() as cursor:
                update_query = """UPDATE student
                                SET profile=%s, fname=%s, lname=%s, email=%s, phone=%s,
                                gender=%s, dob=%s, address=%s, city=%s, pincode=%s,
                                country=%s, qualification=%s, branch_name=%s
                                WHERE student_id=%s"""
                data['update']=cursor.execute(update_query, (profile, fname, lname, email, phone, gender, dob,
                                              address, city, pincode, country, qualification,
                                              branch_name, id))

                # Delete existing hobbies for the student
                delete_hobbies_query = "DELETE FROM student_hobbies WHERE student_id = %s"
                cursor.execute(delete_hobbies_query, (id,))

                # Insert new hobbies for the student
                insert_hobby_query = "INSERT INTO student_hobbies (student_id, hobbies_id) VALUES (%s, %s)"
                for hobby_id in hobbies:
                    cursor.execute(insert_hobby_query, (id, hobby_id))
            conn.commit()
            print('Student updated successfully.')
        except Exception as e:
            print(f"Error updating student: {str(e)}")
            conn.rollback()  # Rollback the transaction in case of an error
        finally:
            if conn:
                conn.close()
        return redirect(url_for('list_students'))

@app.route('/email_check', methods=['GET'])
def email_check():
    conn = db_connection()
    cursor = conn.cursor()
    try:
        email = request.args.get('emailVal')
        # validate the received values
        if email:
            cursor.execute("SELECT * FROM student WHERE email=%s", email)
            row = cursor.fetchone()
            if row:
                resp = jsonify('<span style="\'color:red;\'">Email unavailable</span>')
                resp.status_code = 200
                return resp
            else:
                resp = jsonify('<span style="\'color:green;\'">Email available</span>')
                resp.status_code = 200
                return resp
        else:
            resp = jsonify('<span style="\'color:red;\'">Email is required field.</span>')
            resp.status_code = 200
            return resp
    except Exception as e:
            print(e)
    finally:
            cursor.close()
            conn.close()
    return True

@app.route('/export_students_csv')
def export_csv():
    conn = db_connection()
    cursor = conn.cursor(pymysql.cursors.DictCursor)
    cursor.execute("""SELECT s.*,group_concat(hobbies_id separator '|') as hobbies FROM student s
                JOIN student_hobbies sh ON s.student_id = sh.student_id
                GROUP BY s.student_id""")
    result = cursor.fetchall()
    si = io.StringIO()
    cw = csv.writer(si)
    print(result)
    cw.writerow(result[0].keys())
    for row in result:
        cw.writerow(row.values())

    output = si.getvalue()
    conn.close()

    return Response(
        output,
        mimetype="text/csv",
        headers={"Content-Disposition": "attachment;filename=student_list.csv"}
    )


@app.route('/login', methods=['GET', 'POST'])
def login():
    error = None
    conn = None
    try:
        if request.method == 'POST':
            email = request.form['email']
            password = request.form['password']
            conn = db_connection()
            with conn.cursor() as cursor:
                cursor.execute('SELECT student_id, fname, email, password FROM student WHERE email = %s', (email,))
                user = cursor.fetchone()
            
            if user and user['password'] == password:
                session['user_id'] = user['student_id']
                session['username'] = user['email']
                session['fname'] = user['fname']
                return redirect(url_for('home'))
            else:
                error = "Invalid email or password"
    except Exception as e:
        error = "An error occurred: {}".format(str(e))
    finally:
        if conn:
            conn.close()
    return render_template('login.html', error=error)
    
    
@app.route('/about')
def about():
    return render_template('about.html')

@app.route('/contact')
def contact():
    return render_template('contact.html')

@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('login'))


if __name__ == '__main__':
    app.run(debug=True)
