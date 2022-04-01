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
<title>자유 게시판</title>
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
			script.println("alert('유효하지 않는 글입니다.')");
			script.println("location.href = 'freeForum.jsp'");
			script.println("history.back()");
			script.println("</script>");
		}
		freeForum freeForum = new freeForumDAO().getfreeForum(freeForumID);
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
		<div class="row">
			<table class="table table-bordered table-dark" style="border: 1px">
				<thead>
					<tr>
						<th colspan="3" style="text-align: center;">게시판 글보기</th>						
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%; text-align: center;">게시글 작성자</td>
						<td colspan="2" style="text-align: left;"><%= freeForum.getUserID() %></td>
					</tr>
					<tr>
						<td style="width: 20%; text-align: center;">게시글 제목</td>
						<td colspan="2" style="text-align: left;"><%= freeForum.getfreeForumTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("\n", "<br>") %></td>
					</tr>
					<tr>
						<td style="width: 20%; text-align: center;">게시글 작성일자</td>
						<td colspan="2" style="text-align: left;"><%= freeForum.getfreeForumDate().substring(0, 11) + freeForum.getfreeForumDate().substring(11, 13) + "시" + freeForum.getfreeForumDate().substring(14, 16) + "분 " %></td>
					</tr>
					<tr>
						<td style="width: 20%; text-align: center;">게시글 내용</td>
						<td colspan="2" style="min-height: 200px; text-align: left;"><%= freeForum.getfreeForumContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("\n", "<br>") %></td>
					</tr>
				</tbody>
			</table>
			
			<a href="freeForum.jsp" class="btn btn-primary">목록</a>
			<%
				if (userID != null && userID.equals(freeForum.getUserID())) {
			%>
			<a href="update.jsp?freeForumID=<%= freeForumID %>" class="btn btn-primary mx-2">수정</a>
			<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="delete.jsp?freeForumID=<%= freeForumID %>" class="btn btn-primary">삭제</a>
			<%
				}
			%>		
		</div>
	</div>
	
	<script src="./js/jquery.min.js"></script>
	<script src="./js/pooper.js"></script>
	<script src="./js/bootstrap.min.js"></script>
</body>
</html>