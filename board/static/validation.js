function validateForm() {
  let a = document.getElementById("fname").value;
  if (a == "") {
    alert("Please Enter First Name");
    return false;
  }
  let b = document.getElementById("lname").value;
  if (b==""){
    alert("Please Enter Last Name");
    return false;
  }
  let c = document.getElementById("email").value;
  if (c==""){
    alert("Please Enter Email");
    return false;
  }
  let d = document.getElementById("phone").value;
    if (d==""){
    alert("Please Enter Phone number");
    return false;
  }
  var l = document.getElementsByName("branch")[0]; // Get the select element by name
  var strUser1 = l.options[l.selectedIndex].value;
  if (strUser1 == "select") { // Check against the value of the default option
      alert("Please select your branch");
      return false;
  }

  var e = document.getElementById("qualification");
  var strUser = e.options[e.selectedIndex].value;
  if (strUser === "select") {
      alert("Please select your qualification");
      return false;
  }
  if ( ( myform.gender[0].checked == false ) && ( myform.gender[1].checked == false ) )
  {
    alert ( "Please choose your Gender: Male or Female" );
    return false;
  }
  let f = document.getElementById('dob').value;
    if(f== ""){
      alert("Please select your date of birth");
      return false;
    }
  let h = document.getElementById("address").value;
    if (h==""){
    alert("Please Enter Address");
    return false;
  }
  let i = document.getElementById("city").value;
    if (i==""){
    alert("Please Enter city");
    return false;
  }
  let j = document.getElementById("pincode").value;
    if (j==""){
    alert("Please Enter pincode");
    return false;
  }
  let k = document.getElementById("country").value;
    if (k==""){
    alert("Please Enter country");
    return false;
  }
  var hobbies = document.getElementsByName("hobbies[]");
  var hobbyChecked = false;
    for (let i = 0; i < hobbies.length; i++) {
        if (hobbies[i].checked) {
            hobbyChecked = true;
            break;
        }
    }
    if (!hobbyChecked) {
        alert("Please check at least one of your hobbies");
        return false;
    }

  // Password validation
  var passwordInput = document.getElementById("password");
  var password = passwordInput.value.trim(); // Trim leading and trailing spaces

  // Check if password is empty
  if (password === "") {
      alert("Please enter a password.");
      return false;
  }

  // Check if password meets the required criteria
  var passwordPattern = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}$/;
  if (!passwordPattern.test(password)) {
      alert("Password must contain at least one digit, one lowercase letter, one uppercase letter, and be at least 8 characters long.");
      return false;
  }

  // All validations passed, return true to allow form submission
  return true;
}
