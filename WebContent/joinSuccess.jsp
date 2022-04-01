<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html"; charset="UTF-8">
<title>회원 가입 시도 </title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		
		if (user.getUserID() == null || user.getUserGender() == null || user.getUserEmail() == null
				|| user.getUserPassword() == null  || user.getUserName() == null  ) {	//가입 내용중 빈칸이 있을 때
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('가입 내용중 빈칸이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
		} else {
			UserDAO userDAO = new UserDAO();
			
			int rst = userDAO.join(user);
			if (rst == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 사용중인 아이디 입니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else { //회원 가입 성공
				session.setAttribute("userID", user.getUserID());
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>
