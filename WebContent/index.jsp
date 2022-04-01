<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html"; charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale"="1">

<link rel="stylesheet" href="/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/custom.css">
<link rel="stylesheet" href="fonts/material-icon/css/material-design-iconic-font.min.css">
<link rel="stylesheet" href="css/style.css">
<title>로그인 화면</title>
<style>
	body {
        height: 100vh;
        background-image: url('images/back.jpg');
        background-repeat : no-repeat;
        background-size : cover;
      }
</style>

</head>
<body>
	 <section class="m-5">
            <div class="container">
                <div class="signin-content">
                    <div class="signin-image ">
                        <figure><img src="images/signin-image.jpg" alt="sing up image"></figure>
                        <a href="join.jsp" class="signup-image-link">Create an account  &lt;- Click Here</a>
                    </div>
                    <div class="signin-form">
                        <h3 class="form-title">Login</h3>
                        <form method="post" action="login.jsp" class="register-form" id="login-form">
                            <div class="form-group">
                                <label for="your_name"><i class="js js-account material-icons-name"></i></label>
                                <input type="text" name="userID" id="your_name" placeholder="Your ID"/>
                            </div>
                            <div class="form-group">
                                <label for="your_pass"><i class="js js-lock"></i></label>
                                <input type="password" name="userPassword" id="your_pass" placeholder="Password"/>
                            </div>        
                            <div class="form-group form-button">
                                <input type="submit" name="signin" id="signin" class="form-submit" value="Log in"/>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </section>


    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="js/main.js"></script>

</body>
</html>