<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="freeForum.freeForumDAO" %>
<%@ page import="freeForum.freeForum" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.net.URLEncoder"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html"; charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale"="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>자유 게시판 </title>
<style type="text/css">
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
		int pageNumber = 1;
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
	
	<div class="container">
		<div class="text-right mt-1">
			<a class="btn btn-dark text-white text-right" href="write.jsp">글 쓰기</a> 
			<a class="btn btn-danger text-white text-right" data-toggle="modal" href="#reportModal">신고하기</a>
		</div>
	<div class="row mt-1">
		<table class="table table-striped table-dark" style="text-align: center; border: 1px">			
			<thead>
				<tr>
					<th style="text-align: center;">글 번호</th>
					<th style="text-align: center;">작성자 ID</th>
					<th style="text-align: center;">글 제목</th>
					<th style="text-align: center;">작성일자</th>
				</tr>
			</thead>
			<tbody>				
				<%
					freeForumDAO freeForumDAO = new freeForumDAO();
					ArrayList<freeForum> list = freeForumDAO.getList(pageNumber);
					for (int i = 0; i < list.size(); i++) {
				%>
				<tr>
					<td><%= list.get(i).getfreeForumID() %></td>
					<td><%= list.get(i).getUserID() %></td>
					<td><a href="view.jsp?freeForumID=<%= list.get(i).getfreeForumID() %>"><%= list.get(i).getfreeForumTitle() %></a></td>
					<td><%= list.get(i).getfreeForumDate().substring(0, 11) + list.get(i).getfreeForumDate().substring(11, 13) + "시" 
					+ list.get(i).getfreeForumDate().substring(14, 16) + "분 "%></td>
				</tr>
				<%		
					}
				%>
			</tbody>
		</table>
	</div>
	
		<div class="row">
			<div class="col text-center">
			<% if(pageNumber != 1){
				
			%>	
			
				<a class="btn btn-primary text-white" href="freeForum.jsp?pageNumber=<%=pageNumber - 1%>">이전 페이지</a> 
			<% 
				} else {
			%>
				<a class="btn btn-secondary text-white disabled">이전 페이지</a>
			
			<% 
				}
			%>
			<% 
			if(freeForumDAO.nextPage(pageNumber+1)) {
			%>
			
				<a class="btn btn-primary text-white mx-1" href="freeForum.jsp?pageNumber=<%=pageNumber + 1%>">다음 페이지</a> 
			<%
				} else {
				
			%>
			
				<a class="btn btn-secondary text-white disabled mx-1">다음 페이지</a>
			<%
				}
			%>
	</div>
	</div>
	</div>
	
		<div class="modal fade" id="reportModal" tabindex="-1" role="dailog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content bg-dark text-white">
				<div class="modal-header">

					<h5 class="modal-tittle" id="modal">신고하기</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="report.jsp" method="post">
						<div class="form-group">
							<label>신고할 제목</label> <input type="text" name="reportTitle" class="form-control" maxlength="30">
						</div>
						<div class="form-group">
							<label>신고할 내용</label>
							<textarea name="reportContent" class="form-control" maxlength="1000" style="height: 180px;"></textarea>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">취소하기</button>
							<button type="submit" class="btn btn-danger" >신고하기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
		</div>
	
	
	<script src="./js/jquery.min.js"></script>
	<script src="./js/pooper.js"></script>
	<script src="./js/bootstrap.min.js"></script>
</body>
</html>