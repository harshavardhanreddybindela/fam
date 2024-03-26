# Standard library imports
import csv
from datetime import timedelta
import io
import os
import smtplib
import sys
import traceback
from functools import wraps

# Third-party library imports
from argon2 import PasswordHasher, verify_password
from argon2.exceptions import InvalidHashError
from fpdf import FPDF
import pandas as pd
from flask import Flask, jsonify, redirect, render_template, request, Response, session, url_for,flash
from flask_mail import Mail, Message
from flask_session.__init__ import Session
from werkzeug.security import check_password_hash, generate_password_hash
import pymysql

# Local application/library specific imports
from config.db import DATABASE_CONFIG
from config.middleware import login_validation,clear_flash
from db_functions import db_connection, get_branch_list, get_delete_student, get_details, get_hobbies_list, get_qualification_list, get_student_details, get_student_hobbies, get_students, post_edit_hobbies, post_hobbies, post_student,get_student_hobbies, get_students, post_edit_hobbies, post_hobbies, post_student

# Create a new Flask application instance
app = Flask(__name__)



# Configure session to be not permanent and use the filesystem for storage
app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"

# Initialize the session with the app configuration
Session(app)
app.permanent_session_lifetime = timedelta(minutes=60)

# Establish a database connection
conn = db_connection()

# Mail configuration
# These settings are necessary for Flask-Mail, allowing your app to send emails through a specified SMTP server
app.config['MAIL_SERVER'] = 'smtp.gmail.com'
app.config['MAIL_PORT'] = 587
app.config['MAIL_USE_TLS'] = True
app.config['MAIL_USERNAME'] = 'harshareddy4400@gmail.com'
app.config['MAIL_PASSWORD'] = 'gdzc jhpd tyqs aaks'

# File upload configuration
app.config['UPLOAD_FOLDER'] = 'uploads/'

# Initialize the Flask-Mail extension with the app configuration
mail = Mail(app)



@app.route("/")
def index():
    if not session.get("name"):
        return redirect("/login")
    return render_template('index.html')

@app.route('/home', methods=['GET', 'POST'])
@login_validation
def home():
    # """
    # Serves the home page. Handles both GET and POST requests.
    # On POST, it processes login attempts and file uploads.
    # For file uploads, it saves the file and processes its content with parseCSV function.
    # Sets a welcome message based on session info.
    # """
    # POST request handling logic
    if request.method == 'POST':
        if 'login' in request.form:
            # Process login attempt
            session['fname'] = 'UserFirstName'  # Example session variable setting
            flash('Login successful')
            return redirect(url_for('home'))
        elif 'files' in request.files:
            # Process file upload
            uploaded_file = request.files['files']
            if uploaded_file.filename != '':
                file_path = os.path.join(app.config['UPLOAD_FOLDER'], uploaded_file.filename)
                uploaded_file.save(file_path)
                parseCSV(file_path)
                flash('File uploaded and processed successfully')
            return redirect(url_for('home'))
    
    # GET request handling, setting welcome message
    if 'fname' in session:
        welcomeMsg = f"Welcome, {session['fname']}!"
    else:
        welcomeMsg = "Welcome!"
    return render_template('home.html', message=welcomeMsg)

def parseCSV(filepath):
    cursor = conn.cursor()
    col_names = ['branch_name']  # Define column names for parsing
    
    csvData = pd.read_csv(filepath, names=col_names, header=None)
    inserted_branches = []  # To store information about newly inserted branches
    
    try:
        for i, row in csvData.iterrows():
            branch_name = row['branch_name']
            
            # Check if the branch exists
            cursor.execute("SELECT COUNT(*) FROM branches WHERE branch_name = %s", (branch_name,))
            result = cursor.fetchone()
            if result['COUNT(*)'] > 0:  # Branch exists
                flash(f"Error: Branch '{branch_name}' already exists in the branch list at row {i+1}")
            else:
                # Insert the branch if it doesn't exist
                sql = "INSERT INTO branches (branch_name) VALUES (%s)"
                value = (branch_name,)
                cursor.execute(sql, value)
                inserted_branches.append(branch_name)
        
        # Commit the changes after processing all rows
        conn.commit()
        
        if inserted_branches:
            flash(f"The following branches were inserted: {', '.join(inserted_branches)}")
    except Exception as e:
        flash(f"Error: {e}")
        flash(f"Error occurred: {e}")
        conn.rollback()

        
@app.before_request
def before_request():
    if not session.get("user_id") and request.endpoint not in ['login']:
        return redirect(url_for('login'))

@app.route('/add_student')
@login_validation
def add_student():
    cursor = conn.cursor()
    try:
        data={}
        cursor.execute("SELECT branch_id, branch_name FROM branches ORDER BY branch_id ASC")
        data['branch_list'] = cursor.fetchall()
        
        
        cursor.execute("SELECT qualification_id, qualification FROM qualifications ORDER BY qualification_id ASC")
        data['qualification_list'] = cursor.fetchall()
        
        cursor.execute("SELECT hobbies_id, hobby FROM hobbies ORDER BY hobbies_id ASC")
        data['hobbies'] = cursor.fetchall()
        return render_template('add_student.html', data = data)
    except Exception as e:
        flash("Error fetching branches,qualification,hobbies:", e)
        return render_template('add_student.html', data=data)

@app.route('/crud_branches', methods=['POST', 'GET'])
def crud_branches():
    data={}
    if request.method == 'POST':
        conn = db_connection()
        cursor = conn.cursor()
        
        if 'submit_add' in request.form:
            branch_name = request.form.get('branch_name')
            try:
                data['add_branch']=cursor.execute("INSERT INTO branches (branch_name) VALUES (%s)", (branch_name,))
                conn.commit()
                data['message'] = "Branch added successfully!"
            except pymysql.Error as e:
                flash(f"An error occurred: {e}")
                conn.rollback()
                
        elif 'submit_delete' in request.form:
            branch_id = request.form.get('branch_id')
            branch_name = request.form.get('branch_name')
            try:
                data['delete_branch']=cursor.execute("DELETE FROM branches WHERE branch_id = %s OR branch_name = %s", (branch_id, branch_name))
                conn.commit()
                data['message'] = "Branch deleted successfully!"
            except pymysql.Error as e:
                flash(f"An error occurred: {e}")
                conn.rollback()

        elif 'submit_update' in request.form:  # Update a Branch
            branch_id = request.form.get('branch_id')
            branch_name = request.form.get('branch_name')
            try:
                data['update_branch']=cursor.execute("UPDATE branches SET branch_name = %s WHERE branch_id = %s", (branch_name, branch_id))
                conn.commit()
                data['message'] = "Branch updated successfully!"
            except pymysql.Error as e:
                flash(f"An error occurred: {e}")
                conn.rollback()
        else:
            pass
        cursor.close()
        conn.close()

    return render_template('crud_branches.html',data=data)


@app.route('/register', methods=['POST'])
def register():
    error = None
    conn = None
    try:
        if request.method == 'POST':
            # Extract student info from form data
            student_info = {}
            student_info['profile'] = request.files['profile']
            student_info['fname'] = request.form['fname']
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
            password = request.form['password']

            ph = PasswordHasher()
            hashed_password = ph.hash(password)  # Generate hashed password

            # Store hashed password in the database
            conn = db_connection()
            with conn.cursor() as cursor:
                data = {}
                insert_student_query = post_student()
                data['add_student'] = cursor.execute(insert_student_query, (student_info['profile'], student_info['fname'], student_info['lname'], student_info['email'], student_info['phone'], student_info['gender'], student_info['dob'], student_info['address'], student_info['city'], student_info['pincode'], student_info['country'], student_info['branch'], student_info['qualification'], hashed_password))  # Insert hashed password
                student_id = cursor.lastrowid
                for hobby_id in student_info['hobbies'].split('|'):
                    insert_hobby_query = post_hobbies()
                    data['post_hobbies'] = cursor.execute(insert_hobby_query, (student_id, hobby_id))
                conn.commit()
                email = student_info['email']
                fname = student_info['fname']
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
        error = "An error occurred: {}".format(str(e))
        # Log the error for further investigation
        traceback.print_exc()  # Print the full traceback

    finally:
        if not conn:
            conn.close()
    return render_template('add_student.html', data=data,student_info=student_info,error=error)

@app.route('/list/', defaults={'page': 1}, methods=['GET', 'POST'])
@app.route('/list/page/<int:page>', methods=['GET', 'POST'])
@login_validation
def list_students(page):
    conn = db_connection()
    cursor = conn.cursor()

    # Search functionality integrated
    search = request.args.get('search', '')
    
    limit = 4
    offset = limit * page - limit
    sort = request.args.get('sort', 'student_id')
    order = request.args.get('order', 'asc').lower()
    current_sort = request.args.get('current_sort')
    current_order = request.args.get('current_order', 'asc')
    
    if sort == current_sort:
        order = 'desc' if current_order == 'asc' else 'asc'

    valid_sort_columns = [
        'student_id', 'fname', 'lname', 'email', 'phone', 'branch_name',
        'qualification', 'dob', 'address', 'city', 'pincode', 'country','created_date'
    ]
    
    if sort not in valid_sort_columns:
        sort = 'student_id'
        
    if order not in ['asc', 'desc']:
        order = 'asc'

    try:
        data = {}
        
        if search:
            search_term = f'%{search}%'
            student_list_query = get_students(sort=sort, order=order, limit=limit, offset=offset)
            cursor.execute(student_list_query, (search_term, search_term, search_term, limit, offset))
        else:
            student_list_query = get_students(sort=sort, order=order, limit=limit, offset=offset)
            cursor.execute(student_list_query, (limit, offset))

            


        data['studentlist'] = cursor.fetchall()
        data['all_hobbies'] = get_hobbies_list(cursor)
        data['hobbies_dict'] = {hobby['hobbies_id']: hobby['hobby'] for hobby in data['all_hobbies']}
        
        prev_page = max(page - 1, 1)
        next_page = page + 1
        if request.args.get('is_ajax'):
            return render_template('student_tr.html', data=data,page=page)
        else:
            return render_template('student_list.html', page=page, data=data, search=search, prev_page=prev_page, next_page=next_page)
    except Exception as e:
        flash(f"Error: {e}")
        return render_template('error_page.html', error_message=str(e))
    finally:
        if conn:
            conn.close()


# Define a route for deleting a student
@app.route('/delete/<int:id>', methods=['GET'])
@login_validation
def delete_student(id):
    try:
        data={}
        cursor = conn.cursor()
        delete_query = get_delete_student(id)
        data['delete_student']=cursor.execute(delete_query, (id,))
        conn.commit()
        flash("Student deleted successfully", "success")
    except Exception as e:
        flash(f"Error: {e}")
    finally:
        if not conn:
            conn.close()
        return redirect(url_for('list_students'))

# Define a route for editing a student
@app.route('/edit_student/<int:id>', methods=['GET'])
@login_validation
def edit_student(id):
    conn = db_connection()
    cursor=conn.cursor()
    try:
        print("Entering Edit")
        data={}
        with conn.cursor(pymysql.cursors.DictCursor) as cursor:
            data['all_hobbies'] = get_hobbies_list(cursor)
            data['selected_hobbies'] = get_student_hobbies(cursor, id)
            data['branch_list'] = get_branch_list(cursor)
            data['qualification_list'] = get_qualification_list(cursor)
            student = get_student_details(cursor, id)
            if not student:
                return "Student not found", 404
            return render_template('edit_student.html',student=student, data=data)
    except Exception as e:
        return "Error fetching data",e
    
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
            print("Entering Update")
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
            flash('Student updated successfully.')
        except Exception as e:
            flash(f"Error updating student: {str(e)}")
            conn.rollback()  # Rollback the transaction in case of an error
        finally:
            if not conn:
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
            flash(e)
    finally:
            if not conn:
                conn.close()
    return True

@app.route('/download_pdf/<int:id>', methods=['GET'])
def download_pdf(id):
    conn = None
    cursor = None
    try:
        conn = db_connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        
        cursor.execute("SELECT CONCAT(fname, ' ', lname) AS name , email, phone FROM student WHERE student_id = %s", (id,))
        
        result = cursor.fetchall()

        if not result:
            return "No data available for the specified student.", 404

        pdf = FPDF()
        pdf.add_page()
        
        page_width = pdf.w - 2 * pdf.l_margin
        
        pdf.set_font('Times','B',14.0)
        pdf.cell(page_width, 0.0, 'Student Data', align='C')
        pdf.ln(10)
        
        pdf.set_font('Courier', '', 12)
        
        col_widths = {
            'Name': page_width * 0.3,
            'Email': page_width * 0.4,
            'Phone': page_width * 0.3
        }
        
        # Header
        pdf.cell(col_widths['Name'], 10, 'Name', border=1,)
        pdf.cell(col_widths['Email'], 10, 'Email', border=1)
        pdf.cell(col_widths['Phone'], 10, 'Phone', border=1)
        pdf.ln(10)  # Increase line spacing after the header

        # Loop through rows
        for row in result:
            pdf.cell(col_widths['Name'], 10, row.get('name', ''), border=1)
            pdf.cell(col_widths['Email'], 10, row.get('email', ''), border=1)
            pdf.cell(col_widths['Phone'], 10, row.get('phone', ''), border=1)
            pdf.ln(10)  # Increase line spacing after each row

        pdf.ln(15)  # Increase line spacing after all rows

        pdf.set_font('Times', '', 10.0)
        pdf.cell(page_width, 10, '- end of report -', align='C')

        output = pdf.output(dest='S').encode('latin-1')
        return Response(output, mimetype='application/pdf', headers={'Content-Disposition': 'attachment;filename=student_report.pdf'})
    except Exception as e:
        flash(e)
        return "An error occurred while generating the report for the specified student.", e
    finally:
        if not conn:
            conn.close()

        

@app.route('/export_students_csv')
def export_csv():
    conn = db_connection()
    cursor = conn.cursor(pymysql.cursors.DictCursor)
    user_id = session.get('user_id')
    email = session.get('username')
    if user_id and email:
        student_info = get_student_details(cursor, user_id)
        if student_info:
            fname = student_info['fname']
            # Query to retrieve all students along with their hobbies
            cursor.execute(get_details())
            result = cursor.fetchall()
            if result:
                si = io.StringIO()
                cw = csv.writer(si)
                cw.writerow(result[0].keys())
                for row in result:
                    cw.writerow(row.values())
                output = si.getvalue()
                
                msg = Message('Test',
                            sender='harshareddy4400@gmail.com',
                            recipients=[email]
                            )
                msg.body = f"""Hello {fname}!,
                            Here we attached the requested student list to this email.
                            Thanks and Regards,
                            Harsha

                            Note: This is a Test run by Harsha Reddy"""

                msg.attach("student_list.csv", "text/csv", output)
                mail.send(msg)
                return redirect(url_for('list_students', msg="Email Sent Successfully"))
            else:
                return 'Email Not Sent, Check the login'
    else:
        return 'User not logged in.'

def encrypt_password(password):
    return generate_password_hash(password)

def validate_password(password, stored_hash):
    return check_password_hash(stored_hash, password)

@app.route('/login', methods=['GET', 'POST'])
def login():
    error = None
    conn = None
    cursor = None
    try:
        if request.method == 'POST':
            email = request.form['email']
            password = request.form['password']

            if not email or not password:
                error = "Please enter both email and password."
                return render_template('login.html', error=error)

            conn = db_connection()
            cursor = conn.cursor()
            cursor.execute('SELECT student_id, fname, email, password FROM student WHERE email = %s', (email,))
            user = cursor.fetchone()

            if user:
                hashed_password = user['password']
                ph = PasswordHasher()
                try:
                    ph.verify(hashed_password, password)
                    session['user_id'] = user['student_id']
                    session['username'] = user['email']
                    session['fname'] = user['fname']
                    return redirect(url_for('home'))
                except Exception as e:
                    error = "Invalid email or password."
            else:
                error = "User not found."

    except Exception as e:
        error = "An error occurred: {}".format(str(e))
        traceback.print_exc()

    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()
    return render_template('login.html', error=error)


@app.route('/about')
@login_validation
def about():
    return render_template('about.html')

@app.route('/contact')
@login_validation
def contact():
    return render_template('contact.html')

@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('login'))



# @app.route("/load_more")
# def load_more():
#     print("Entering into Loadmore")
#     offset = request.args.get('offset', 0)
#     cursor = conn.cursor()
#     cursor.execute('SELECT * FROM student LIMIT 4 OFFSET %s', (offset,))
#     results = cursor.fetchall()
#     cursor.close()

#     data = request.json['data']
#     data.extend(results)

#     return jsonify(data=data)

if __name__ == '__main__':
    app.run(debug=True)
