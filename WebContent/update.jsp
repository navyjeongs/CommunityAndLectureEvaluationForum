<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="freeForum.freeForum" %>
<%@ page import="freeForum.freeForumDAO" %>
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
<title>게시글 수정</title>
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
		int freeForumID = 0;
		if (request.getParameter("freeForumID") != null) {
			freeForumID = Integer.parseInt(request.getParameter("freeForumID"));
		}
		if (freeForumID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('오류가 있습니다.')");
			script.println("location.href = 'freeForum.jsp'");
			script.println("history.back()");
			script.println("</script>");
		}
		freeForum freeForum = new freeForumDAO().getfreeForum(freeForumID);
		if (!userID.equals(freeForum.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('게시글 주인이 아닙니다.')");
			script.println("location.href = 'freeForum.jsp'");
			script.println("history.back()");
			script.println("</script>");
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
			<form method="post" action="updateAction.jsp?freeForumID=<%= freeForumID %>">
				<table class="table table-bordered table-dark" style="text-align: center; border: 1px">
				<thead>
					<tr>
						<th colspan="2" style="text-align: center;">자유 게시판 글 수정</th>						
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="text" class="form-control" placeholder="글 제목" name="freeForumTitle" maxlength="50" value="<%= freeForum.getfreeForumTitle() %>"></td>
					</tr>
					<tr>
						<td><textarea class="form-control" placeholder="글 내용" name="freeForumContent" maxlength="2048" style="height: 350px"><%= freeForum.getfreeForumContent() %></textarea></td>						
					</tr>
				</tbody>
			</table>
			<input type="submit" class="btn btn-primary pull-right" value="글수정">
			</form>						
		</div>
	</div>
	
	
	<script src="./js/jquery.min.js"></script>
	<script src="./js/pooper.js"></script>
	<script src="./js/bootstrap.min.js"></script>
</body>
</html>