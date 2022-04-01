<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html"; charset="UTF-8">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<link rel="stylesheet" href="fonts/material-icon/css/material-design-iconic-font.min.css">
<link rel="stylesheet" href="css/style.css">
<title>회원가입 폼</title>
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
                <div class="signup-content">
                    <div class="signup-form">
                        <h2 class="form-title">Sign up</h2>
                        <form method="POST"  action="joinSuccess.jsp" class="register-form" id="register-form">
                            <div class="form-group">
                                <label for="name"><i class="js js-account material-icons-name"></i></label>
                                <input type="text" name="userName" id="name" placeholder="Your Name"/>
                            </div>
                             <div class="form-group">
                                <label for="name"><i class="js js-account material-icons-name"></i></label>
                                <input type="text" name="userID" id="userID" placeholder="Your ID"/>                                
                            </div>
                            	
                            <div class="form-group">
                                <label for="pass"><i class="js js-lock"></i></label>
                                <input type="password" name="userPassword" id="pass" placeholder="Password"/>
                            </div>
                            <div class="form-group">
                                <label for="email"><i class="js js-email"></i></label>
                                <input type="email" name="userEmail" id="email" placeholder="Your Email"/>
                            </div>

                            <div class="form-group">
                                <input type="radio" name="userGender" value ="남자"  id="agree-term" class="agree-term"/>남성
                                 &nbsp;&nbsp;&nbsp;
                                <input type="radio" name="userGender" value ="여자" id="agree-term" class="agree-term"/>여성
                            </div>
                            <div class="form-group form-button">
                                <input type="submit" name="signup" id="signup" class="form-submit" value="Signup"/>
                            </div>
                        </form>
                    </div>
                    <div class="signup-image">
                        <figure><img src="images/signup-image.jpg" alt="sing up image"></figure>
                        <a href="index.jsp" class="signup-image-link">I am already member  &lt;- Click Here</a>
                    </div>
                </div>
            </div>
        </section>



	
	<script src="vendor/jquery/jquery.min.js"></script>
    <script src="js/main.js"></script>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>