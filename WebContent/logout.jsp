<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html"; charset="UTF-8">
<title>로그아웃 처리</title>
</head>

<body>

	<%
		session.invalidate();
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('정상적으로 로그아웃 되었습니다.');");
		script.println("location.href='index.jsp'");
		script.println("</script>");
		script.close();
	%>

</body>
</html>