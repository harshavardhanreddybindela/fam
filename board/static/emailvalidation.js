function validateEmail(){
    // get value of input email
    var email=$("#email").val();
    // use reular expression
    var reg = /^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/
    if(reg.test(email)){
        return true;
    }else{
    }
}