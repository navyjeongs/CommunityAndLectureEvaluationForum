<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="lecture_Forum.lecture_ForumDAO"%>
<%@ page import="likey.LikeyDAO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>


<%
	UserDAO userDAO = new UserDAO();
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}

	request.setCharacterEncoding("UTF-8");
	String lecture_ForumID = null;

	if (request.getParameter("lecture_ForumID") != null) {
		lecture_ForumID = request.getParameter("lecture_ForumID");
	}
	
	lecture_ForumDAO lecture_ForumDAO = new lecture_ForumDAO();
	if(userID.equals(lecture_ForumDAO.getUserID(lecture_ForumID))){
		int result = new lecture_ForumDAO().delete(lecture_ForumID);
		if (result ==1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('삭제가 완료 되었습니다.');");
				script.println("location.href = 'lecture_forum.jsp';");
				script.println("</script>");
				script.close();
	
		} else {
	
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('데이터베이스 오류가 발생했습니다.');");
				script.println("location.href = 'lecture_forum.jsp';");
				script.println("</script>");
				script.close();
		}
	
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('자신의 글만 삭제가 가능 합니다.');");
		script.println("location.href = 'lecture_forum.jsp';");
		script.println("</script>");
		script.close();
		
	}
%>


