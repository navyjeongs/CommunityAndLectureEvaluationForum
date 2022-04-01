<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ page import="lecture_Forum.lecture_ForumDTO"%>
<%@ page import="lecture_Forum.lecture_ForumDAO"%>
<%@ page import="java.io.PrintWriter"%>


<%
	request.setCharacterEncoding("UTF-8");

	String userID = null;
	if (session.getAttribute("userID") != null) {

		userID = (String) session.getAttribute("userID");
	}

	String LectureName = null;
	String professorName = null;
	String howlecture = null;
	String termproject = null;
	int lectureYear = 0;
	String lecture_ForumTitle = null;
	String lecture_ForumContent = null;
	String semesterDivide = null;
	String lectureDivide = null;
	String totalScore = null;
	String projectScore = null;


	
	if (request.getParameter("LectureName") != null) {
		LectureName = request.getParameter("LectureName");
	}
	
	if (request.getParameter("professorName") != null) {
		professorName = request.getParameter("professorName");
	}
	
	if (request.getParameter("lectureYear") != null) {
		try {
	lectureYear = Integer.parseInt(request.getParameter("lectureYear")) ;
		} catch (Exception e) {
	e.printStackTrace();	
		}
	}
	
	if (request.getParameter("semesterDivide") != null) {
		semesterDivide = request.getParameter("semesterDivide");
	}
	
	if (request.getParameter("lectureDivide") != null) {
		lectureDivide = request.getParameter("lectureDivide");
	}
	
	if (request.getParameter("lecture_ForumTitle") != null) {
		lecture_ForumTitle = request.getParameter("lecture_ForumTitle");
	}
	
	if (request.getParameter("lecture_ForumContent") != null) {
		lecture_ForumContent = request.getParameter("lecture_ForumContent");
	}
	
	if (request.getParameter("totalScore") != null) {
		totalScore = request.getParameter("totalScore");
	}
	
	if (request.getParameter("projectScore") != null) {
		projectScore = request.getParameter("projectScore");
	}
	
	if (request.getParameter("howlecture") != null) {
		howlecture = request.getParameter("howlecture");
	}
	
	if (request.getParameter("termproject") != null) {
		termproject = request.getParameter("termproject");
	}
	
	
	if (LectureName.equals("") || professorName.equals("") ||  lectureYear ==0 || semesterDivide.equals("")||  
	lectureDivide.equals("") || lecture_ForumTitle.equals("") || lecture_ForumContent.equals("") || totalScore.equals("") || projectScore.equals("") 
	|| howlecture.equals("") || termproject.equals("") || lecture_ForumTitle.equals("") || lecture_ForumContent.equals("")) {

		PrintWriter script = response.getWriter();

		script.println("<script>");
		script.println("alert('빈칸이 있어 게시글 작성에 실패했습니다.');");
		script.println("location.href = 'lecture_forum.jsp'");
		script.println("</script>");
		script.close();
		return;
	}

	lecture_ForumDAO lecture_ForumDAO = new lecture_ForumDAO();
	
	int result = lecture_ForumDAO.writer(new lecture_ForumDTO(0, userID, LectureName, professorName, lectureYear, semesterDivide,
	lectureDivide, lecture_ForumTitle, lecture_ForumContent, totalScore, projectScore, howlecture, termproject, 0));
	if (result == -1) {
		PrintWriter script = response.getWriter();

		script.println("<script>");
		script.println("alert('강의 소통 게시글 작성에 실패 했습니다.');");
		script.println("histroy.back();");
		script.println("</script>");
		script.close();

	} else { // 성공했을 때

		application.setAttribute("userID", userID);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'lecture_forum.jsp'");
		script.println("</script>");
		script.close();

	}
%>



