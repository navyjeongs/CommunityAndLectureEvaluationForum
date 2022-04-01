<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.User"%>
<%@ page import="user.UserDAO"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/custom.css">
<style>
	body {
        height: 100vh;
        background-image: url('images/back.jpg');
        background-repeat : no-repeat;
        background-size : cover;
      }
</style>
<title>사용자 업데이트 </title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		User user = new UserDAO().getUser(userID);
		if (!userID.equals(user.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href='index.jsp'");
			script.println("</script>");
		}
	%>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<a class="navbar-brand" href="main.jsp">Forum</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
		<span class="navbar-toggler-icon">
		</span>
		</button>
		
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item"><a class="nav-link" href="freeForum.jsp">자유 게시판</a>
				</li>
				<li class="nav-item"><a class="nav-link" href="lecture_forum.jsp">강의 소통 게시판</a>
				</li>
			</ul>
			
			<ul class="navbar-nav navbar-right">		
				<li class="nav-item dropdown-menu-right">
				<a class="nav-link dropdown-toggle" id="navbarDropdown" data-toggle="dropdown" href="#"><%= user.getUserName() %> 님</a>
				<div class="dropdown-menu dropdown-menu-right">
				<a class="dropdown-item" href="userUpdate.jsp">정보 수정</a>
				<a class="dropdown-item" href="logout.jsp">로그아웃</a>
				</div>
				</li>
			</ul>
		</div>
	</nav>
	
	<div class="container mt-5 bg-dark text-white w-50">
		<div>
			<div class="jumbotron bg-dark text-white" style="padding-top: 20px;">
			<form method="post" action="userUpdateAction.jsp">
				<h3 style="text-align: center;">회원정보 수정</h3>
				<div class="row">
					<div class="col-md-3 mt-1">
						아이디 :
					</div>
					<div class="col">
		<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20" value="<%=user.getUserID()%>" readonly>
					</div>
				</div>
				
				<div class="row mt-1">
					<div class="col-md-3 mt-1">
						비밀번호 :
					</div>
					<div class="col">
		<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20" value="<%=user.getUserPassword()%>">
					</div>
				</div>
				
				
				<div class="row mt-1">
					<div class="col-md-3 mt-1">
						이름 :
					</div>
					<div class="col">
		<input type="text" class="form-control" placeholder="이름" name="userName" maxlength="20" value="<%=user.getUserName()%>">
					</div>
				</div>
				
				
				<div class="row mt-1">
					<div class="col-md-3 mt-1">
						성별 :
					</div>
					<div class="col">
							<input type="radio" name="userGender" value="남자">남자
							<input type="radio" name="userGender" value="여자">여자
					</div>
				</div>
				
				<div class="row mt-1">
					<div class="col-md-3 mt-1">
						이메일 :
					</div>
					<div class="col">
					<input type="email" class="form-control" placeholder="이메일" name="userEmail" maxlength="50" value="<%=user.getUserEmail()%>">
					</div>
				</div>
				<div class="row mt-4">
				<input type="submit" class="btn btn-primary form-control mt-3" value="수정완료">
				</div>
			</form>
		</div>
	</div>
	</div>
	

	
	<script src="./js/jquery.min.js"></script>
	<script src="./js/pooper.js"></script>
	<script src="./js/bootstrap.min.js"></script>
	
	
</body>
</html>
