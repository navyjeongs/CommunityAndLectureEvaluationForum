<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="freeForum.freeForumDAO" %>
<%@ page import="freeForum.freeForum" %>
<%@ page import="java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html"; charset="UTF-8">
<title>자유게시판 삭제하기</title>
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
		if (!userID.equals(freeForum.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'freeForum.jsp'");
			script.println("history.back()");
			script.println("</script>");
		} else {
			freeForumDAO freeForumDAO = new freeForumDAO();
			int result = freeForumDAO.delete(freeForumID);
			if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('게시글 삭제에 실패했습니다!')");
		script.println("history.back()");
		script.println("</script>");
			} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('게시글을 삭제했습니다!')");
		script.println("location.href = 'freeForum.jsp'");
		script.println("</script>");
			}				
		}
	%>
</body>
</html>