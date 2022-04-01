<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html"; charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale"="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>자유 게시판 글 쓰기</title>
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
	<% 
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		
		User user = new UserDAO().getUser(userID);
		
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
	
	
			
	<div class="container mt-5">
		<div class="w-100">
			<form method="post" action="writeAction.jsp">
				<table class="table table-bordered table-dark" style="text-align: center; border: 3px">
				<thead>
					<tr>
						<th style="text-align: center;">자유 게시판 글 쓰기  </th>				
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="text" class="form-control" placeholder="글 제목" name="freeForumTitle" maxlength="50"></td>
					</tr>
					<tr>
						<td><textarea class="form-control" placeholder="모욕적인 표현 및 허위로 작성시 신고 및 게시글이 삭제될 수 있습니다." name="freeForumContent" maxlength="2048" style="height: 350px"></textarea></td>						
					</tr>
				</tbody>
			</table>
			<div class ="row">
				<div class ="col">
				<input type="submit" class="btn btn-primary pull-right" value="글쓰기">
				<a class="btn btn-secondary" href="freeForum.jsp">돌아가기</a> 
				</div>
			</div>
			</form>						
		</div>
	</div>
	
	<script src="./js/jquery.min.js"></script>
	<script src="./js/pooper.js"></script>
	<script src="./js/bootstrap.min.js"></script>
</body>
</html>