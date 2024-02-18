# Import necessary modules and libraries
import os
# os.chmod('board/media/profile', 755)
import sys
from flask import Flask, render_template, request, redirect, url_for, jsonify,flash
from werkzeug.utils import secure_filename
import pymysql
from config.db import DATABASE_CONFIG  # Import database configuration
# Initialize Flask app
app = Flask(__name__)


# Create a MySQL database connection using the configuration from DATABASE_CONFIG
conn = pymysql.connect(**DATABASE_CONFIG)

@app.route('/add_student')
def add_student():
    conn = pymysql.connect(**DATABASE_CONFIG)
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
        cursor.close()
        conn.close()


# Define a route for the registration form
@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        # Retrieve data from the HTML form
        # profile =request.form['profile']
        # raise SystemExit
        
        file = request.files['profile']
        if file.filename != '':
            # BASE_DIR ='/media/'
            # MEDIA_ROOT = BASE_DIR / 'profile/'
            file.save(file.filename)
            profile ='abc.jpg'
        fname = request.form['fname'] #request is a class in built-in libraries
        lname = request.form['lname']
        email = request.form['email']
        phone = request.form.get('phone', '')
        branch = request.form['branch']
        qualification = request.form['qualification']
        gender = request.form.get('gender', '')
        dob = request.form['dob']
        address = request.form['address']
        city = request.form['city']
        pincode = request.form['pincode']
        country = request.form['country']
        hobbies = '|'.join(request.form.getlist('hobbies[]'))
        
        # if 'profile' in request.files:
        #     file = request.files['profile']
        #     if file.filename == '':
        #         flash('No selected file')
        #         return redirect(request.url)
        #     if file:  # If a file is present
        #         filename = secure_filename(file.filename)
        #         save_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
        #         file.save(save_path)
        #         # Now you have the path where the file is saved
        #         profile_path = save_path("/board/media/profile")
        # if not os.path.exists(app.config['UPLOAD_FOLDER']):
        #     os.makedirs(app.config['UPLOAD_FOLDER'])

        try:
            with conn.cursor() as cursor:
                # Create a new record
                sql = """INSERT INTO student (profile,fname, lname, email, phone, gender, dob, address, city, pincode, country, hobbies, branch_name, qualification)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s,%s,%s)"""
                sql1=cursor.execute(sql, (profile,fname, lname, email, phone, gender, dob, address, city, pincode, country, hobbies, branch,qualification))
                print(sql1)
                conn.commit()  # Commit changes
                return "Registration successful"
        except Exception as e:
            return f"Error: {str(e)}"
    return render_template('add_student.html')
    
@app.route('/list/', defaults={'page': 1}, methods=['GET', 'POST'])
@app.route('/list/page/<int:page>', methods=['GET'])
def list_students(page):
    conn = pymysql.connect(**DATABASE_CONFIG)
    cursor = conn.cursor()
    id = request.args.get('id', None)
    sort = request.args.get('sort', 'student_id')
    order = request.args.get('order', 'asc').lower()
    current_sort = request.args.get('current_sort')
    current_order = request.args.get('current_order', 'asc')
    if sort == current_sort:
        order = 'desc' if current_order == 'asc' else 'asc'
    valid_sort_columns = ['student_id', 'fname', 'lname', 'email', 'phone', 'branch_name', 'qualification', 'dob', 'address', 'city', 'pincode', 'country']
    if sort not in valid_sort_columns or order not in ['asc', 'desc']:
        sort = 'student_id','fname'
        order = 'asc'

    try:
        data = {}
        if id is None:
            prev_page = page - 1
            next_page = page + 1
            query = f"SELECT * FROM student ORDER BY {sort} {order} LIMIT 4 OFFSET %s"
            cursor.execute(query, (4 * (page - 1),))
            data['studentlist'] = list(cursor.fetchall())
            return render_template('student_list.html', page=page,data=data, prev_page=prev_page, next_page=next_page, id=id, sort=sort, order=order)
        else:
            query = f"SELECT * FROM student WHERE student_id = %s ORDER BY {sort}"
            cursor.execute(query, (id,))
            data['studentlist'] = cursor.fetchall()
            return render_template('student_list.html', data=data, id=id, sort=sort, order=order)  # Including sort/order in rendering
    except Exception as e:
        print(f"Error: {e}")
        return render_template('error_page.html', error_message=str(e))
    finally:
        conn.close()


# Define a route for deleting a student
@app.route('/delete/<int:id>', methods=['GET'])
def delete_student(id):
    try:#Fatal,warning,notice Error #Check this for python
        with conn.cursor() as cursor:
            # Delete record
            sql = "DELETE FROM student WHERE student_id = %s"
            print(sql)
            cursor.execute(sql, (id,))
            conn.commit()
        # Redirect to the list page with a success message
        return redirect(url_for('list_students', msg="Student deleted successfully"))
    except Exception:
        # Redirect to the list page with an error message if something goes wrong
        return redirect(url_for('list_students', msg=f"Error: In Deleting Student"))


def fetch_hobbies(cursor):
    cursor.execute("SELECT * FROM hobbies ORDER BY hobby ASC")
    return cursor.fetchall()

def fetch_student_hobbies(cursor, student_id):
    cursor.execute("SELECT hobbies FROM student WHERE student_id = %s", (student_id,))
    result = cursor.fetchone()
    if result and result['hobbies']:
        return result['hobbies'].split(',')
    return []
# Define a route for editing a student
@app.route('/edit_student/<int:id>', methods=['GET'])
def edit_student(id):
    conn = pymysql.connect(**DATABASE_CONFIG)
    try:
        with conn.cursor(pymysql.cursors.DictCursor) as cursor:
            # Fetch student details
            all_hobbies = fetch_hobbies(cursor)
            selected_hobbies = fetch_student_hobbies(cursor, id)
            # print(selected_hobbies)
            # print(all_hobbies)
            cursor.execute("SELECT * FROM student WHERE student_id = %s", (id,))
            student = cursor.fetchone()
            if not student:
                return "Student not found", 404
            
            # Correctly prepare the selected hobbies list
            selected_hobbies = student['hobbies'].split('|') if student['hobbies'] else []

            # Fetch branches
            cursor.execute("SELECT * FROM branches ORDER BY branch_id ASC")
            branchlist = cursor.fetchall()

            # Fetch qualifications
            cursor.execute("SELECT * FROM qualifications ORDER BY qualification_id ASC")
            qualificationlist = cursor.fetchall()

            # Fetch hobbies
            # cursor.execute("SELECT * FROM student ORDER BY hobbies ASC")
            # hobbies = cursor.fetchall()

            return render_template('edit_student.html', student=student, selected_hobbies=selected_hobbies,
                                   branchlist=branchlist, qualificationlist=qualificationlist, all_hobbies=all_hobbies)
    except Exception as e:
        print(f"Error: {e}")
        return "Error fetching data", 500
    finally:
        conn.close()


# Define a route for updating a student's information
@app.route('/update_student/<int:id>', methods=['POST'])
def update_student(id):
    if request.method == 'POST':
        # Extract form data
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
        hobbies = '|'.join(request.form.getlist('hobbies[]'))

        conn = None
        try:
            conn = pymysql.connect(**DATABASE_CONFIG)
            with conn.cursor() as cursor:
                # Update the student record
                sql = """
                UPDATE student 
                SET fname=%s, lname=%s, email=%s, phone=%s, gender=%s, dob=%s, 
                    address=%s, city=%s, pincode=%s, country=%s, hobbies=%s, 
                    qualification=%s, branch_name=%s 
                WHERE student_id=%s
                """
                cursor.execute(sql, (fname, lname, email, phone, gender, dob, address, city, pincode, 
                                     country, hobbies, qualification, branch_name, id))
                conn.commit()
                print('Student updated successfully.', 'success')
        except Exception as e:
                print(f"Error updating student: {str(e)}", 'error')
        finally:
            if conn:
                conn.close()
        return redirect(url_for('list_students'))
        
@app.route('/email_check', methods=['GET'])
def email_check():
    conn = pymysql.connect(**DATABASE_CONFIG)
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

if __name__ == '__main__':
    app.run(debug=True)
