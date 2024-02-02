from flask import Flask, render_template, request
from database import db, Student

app = Flask(__name__) #To create a Flask object with current python file
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+mysqlconnector://root:@localhost/cms'  # Adjust MySQL connection string
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db.init_app(app)

@app.route('/', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
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
        hobbies = ','.join(request.form.getlist('hobbies[]'))

        print("Received form data:")
        print(f"First Name: {fname}")
        print(f"Last Name: {lname}")
        # Print other form data as needed

        student = Student(fname=fname, lname=lname, email=email, phone=phone, branch_name=branch_name,
                          qualification=qualification, gender=gender, dob=dob, address=address,
                          city=city, pincode=pincode, country=country, hobbies=hobbies)
        db.session.add(student)
        db.session.commit()
        return "Registration successful"

    return render_template('register.html')
    
if __name__ == '__main__':
    app.run(debug=True)

