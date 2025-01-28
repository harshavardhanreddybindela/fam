**To-d0**
Using the AWS S3 make the profile pictures of student to submit into the bucket
MVC concepts

**Priority Tasks**
Create countries Table with columns-country_id, country_name
Create states Table with columns-state_id, state_name
Create cities Table with columns-city_id, city_name
create table country_states with columns country_id, state_id as foreign keys
create table state_cities with columns  state_id, city_id
check why profile photo is not retrieving in the edit form
Check what is cookies? and implement the cookies in the project
difference between the cookies and session
read the material(JS,HTML)


the load more use page number set limit to 4 and when load more
Ex: if page==2 then offset=limit*page - limit, order by student_name ASC

comment the previous and next button and add load more button by using the get another four record //**using the append // Load on scroll down**

**Task Completed**
Add Hobbies to the student list(write a join query for the hobbies to get the hobby names)
Export button- Complete pages has to download csv
login user -validate the username and password
need to get a msg in the same page and it has to redirect to the login page back(Add the msg as GET parameter)
After login redirect to home page(Add a Home Page - Display Wecome Msg with User Name)
Add a Menu HTML links- add student,view students, About US, Contact US after logging in it must have navbar
session implementation
Send Email when student is added to the database
Onclick Delete implement Ajax Event(Get parameter using the id to the delete function, Giving response Success or fail //till here it will delete the record in the database, Using javascript it has to delete the frontend record)

**Backlog**
Add image to the edit form and it has to retrieve the file from the database
Pagination -First and Last

data tables
MySQL Transactions

**Sprint Tasks Completed**
Create sessions which will not allow users to access directly list or any other tabs - Difficult
Check the session where to implement in the flask //middleware - implement session here - Difficult
add session destory after clicking on logout
store password in encrypted form
when user login entered password it has to match the password using decrypted

add created_on(datetime),created_by(int)//
add updated_on(datetime),updated_by(int)
add created_on and get the only the date(no time) from db to the list
Add dob pickers using the JQuery by download a file input type has to be text
add the 50 dummy data to the database
search functionality in list for fname, lastname, email
Import the excel file for the branches and that has to insert into the database when imported //**only has to accept the csv and csv
branch CRUD operation // add the text field to add these into the db column must have the same column name as it is in the db
**pdf writing add button for the name,phone,email,address has to download in the pdf format**
set the time duration in session expire time for 2 mints
when importing excel if it has existing branches in it it has to throw an error with row number and branch name, new  no of records inserted
add red color when password is entered wrong //declare a class for span
**It has to capture the search using Ajax**
dob format to dd mm yyyy validate in list page

**Facebook type loading the list - Remove Loadmore button and append the records automaticlly when scrolled down// Use the Jquery event for this(bottom)**
Date picker for the edit form
pdf writing column width adjustment
search functionality when appended
branch csv rows as to update only when all branches in that is new// use the SQL transactions in that(check what is it, check about rollback and commit,

SAVEPOINT:
The `SAVEPOINT` command establishes a point in the transaction at which all previous modifications are stored. A `SAVEPOINT` command can be issued solely for modifications made since the last save point.

AUTOCOMMIT Mode:
MySQL's auto-commit feature is enabled by default. When the auto-commit mode is enabled, each SQL statement is evaluated as a transaction, and the outcome determines whether the statement is committed or rolled back. )

**user roles implementation** -
add is_admin column in student table with default value 0, update is_admin==1 for couple of records
for regualr users show home,edit_profile, contact, about //problem with edit_profile
for admin show all except edit_profile


Create the datalist.html and load all the records integrate the table datatable plugin(explore all the options i.e search,sort etc) -https://datatables.net/examples/basic_init/table_sorting.html

Create a document for all the project

**Challenges - it's harder unless we know, simple when we find it**
I have a student list that has all details of a student, where the list used to show me the numberical values of hobbies but the users will not understand what it is, So I would like to show what it is, then I tried different things but I felt why I am trying this complex instead of that why can't I try dict and then I used that make them display in names.

I have one more challenge in my list which is the auto load on scroll like a facebook feed, I was getting the response from backend which means their is no problem with the backend then I figured out that I have not appended the records to the table, then I come to know how important to inspect the HTML work. 

Second thing which I felt diificult was I tried to save the profile pictures of students into my local machine and then retrieve them in the edit form, I tried a lot but the problem was with the administrator settings.




Ajax Calculator project:
explored the closest
Create a calculation page, show html table with columns (X, Y, Operation, Result) using JQuery
first td get the input text
second td get the input text
third td add
fourth td get the input text

first td get the input text //4
second td get the input text //2
third td sub
fourth td get the input text //2 it has to show

first td get the input text
second td get the input text
third td mul
fourth td get the input text

first td get the input text
second td get the input text
third td div
fourth td get the input text