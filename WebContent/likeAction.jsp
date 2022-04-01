<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="lecture_Forum.lecture_ForumDAO"%>
<%@ page import="likey.LikeyDAO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>

<%! public static String getCilentIP(HttpServletRequest request){
	
		String ip = request.getHeader("X-FORWARDED-FOR");
		if (ip == null || ip.length() ==0 ){
				ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() ==0 ){
			ip = request.getHeader("WL-Proxy-Client-IP");
	}
		if (ip == null || ip.length() ==0 ){
			ip = request.getRemoteAddr();
	}
	return ip;
		
	}%>

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

	if (request.getParameter("lecture_ForumID") != null) {
		lecture_ForumID = request.getParameter("lecture_ForumID");
	}
	lecture_ForumDAO lecture_ForumDAO = new lecture_ForumDAO();
	
	LikeyDAO likeyDAO = new LikeyDAO();
	
	int result = likeyDAO.like(userID, lecture_ForumID, getCilentIP(request));
	PrintWriter script = response.getWriter();
		if (result == 1){
	result = lecture_ForumDAO.like(lecture_ForumID);
	
	if(result == 1){
		
		script.println("<script>");
		script.println("alert('추천을 +1 했습니다.');");
		script.println("location.href = 'lecture_forum.jsp';");
		script.println("</script>");
		script.close();
		
		
	} else {
		
		script.println("<script>");
		script.println("alert('데이터베이스 오류가 발생했습니다.');");
		script.println("location.href = 'lecture_forum.jsp';");
		script.println("</script>");
		script.close();
		
	}
	
		} else {
	
	script.println("<script>");
	script.println("alert('이미 해당 글에 추천을 눌렀습니다.');");
	script.println("location.href = 'lecture_forum.jsp';");
	script.println("</script>");
	script.close();
		}
%>


