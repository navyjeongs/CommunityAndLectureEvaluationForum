<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/custom.css">
<title>사용자 업데이트</title>
</head>
<body>
	<%
	String userID = null;
	User user = new User();
	if(session.getAttribute("userID")!=null);{
	user.setUserID((String)session.getAttribute("userID"));
		userID = (String) session.getAttribute("userID");
	}

	String userName = null;
	if (request.getParameter("userName") != null) {
		user.setUserName(request.getParameter("userName"));
	}
	if (request.getParameter("userPassword") != null) {
		user.setUserPassword(request.getParameter("userPassword"));
	}
	if (request.getParameter("userGender") != null) {
		user.setUserGender(request.getParameter("userGender"));
	}
	if (request.getParameter("userEmail") != null) {
		user.setUserEmail(request.getParameter("userEmail"));
	}
	
	
	if (!userID.equals(user.getUserID())) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("</script>");
	}else{
		if(request.getParameter("userPassword") == null || request.getParameter("userName") == null || request.getParameter("userGender") == null || request.getParameter("userEmail") == null
				||request.getParameter("userPassword").equals("") || request.getParameter("userName").equals("")||request.getParameter("userGender").equals("") || request.getParameter("userEmail").equals("")){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('빈칸이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			UserDAO userDAO = new UserDAO();
			int result = userDAO.modify(user);
			
			if (result==-1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('오류가 있습니다.')");
				script.println("history.back()");
				script.println("</script>");	
			}
			else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			}
		}
	}
	%>	
	<script src="./js/jquery.min.js"></script>
	<script src="./js/pooper.js"></script>
	<script src="./js/bootstrap.min.js"></script>
</body>
</html>