function signUpValidateForm() {
  console.log("entering signup validation");
  let fname = document.getElementById("fname").value;
  if (fname === "") {
    alert("Please Enter First Name");
    return false;
  }

  let email = document.getElementById("email").value;
  if (email === "") {
    alert("Please Enter Email");
    return false;
  }

  let password = document.getElementById("password").value;
  if (password === "") {
    alert("Please Enter Password");
    return false;
  }

  // Password validation
  var passwordPattern = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}$/;
  if (!passwordPattern.test(password)) {
    alert(
      "Password must contain at least one digit, one lowercase letter, one uppercase letter, and be at least 8 characters long."
    );
    return false;
  }

  return true;
}
