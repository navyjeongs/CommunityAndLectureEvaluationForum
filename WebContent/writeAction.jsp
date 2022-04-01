<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="freeForum.freeForumDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="freeForum" class="freeForum.freeForum" scope="page" />
<jsp:setProperty name="freeForum" property="freeForumTitle" />
<jsp:setProperty name="freeForum" property="freeForumContent" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html"; charset="UTF-8">
<title>자유 게시판 글 작동</title>
</head>
<body>
	<%
		String userID = null;
			if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
			}
	
		if (freeForum.getfreeForumTitle() == null || freeForum.getfreeForumContent() == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('빈 칸이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
		} else {
				freeForumDAO freeForumDAO = new freeForumDAO();
				int result = freeForumDAO.write(freeForum.getfreeForumTitle(), userID, freeForum.getfreeForumContent());
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('자유게시판 글 작성에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else { // 글 작성을 성공했을 때 
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'freeForum.jsp'");
					script.println("</script>");
				}
		}
		
	%>
</body>
</html>