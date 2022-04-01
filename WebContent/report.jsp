<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="javax.mail.*"%>
<%@ page import="javax.mail.Transport"%>
<%@ page import="javax.mail.Message"%>
<%@ page import="javax.mail.Address"%>
<%@ page import="javax.mail.internet.InternetAddress"%>
<%@ page import="javax.mail.internet.MimeMessage"%>
<%@ page import="javax.mail.Session"%>
<%@ page import="javax.mail.Session"%>
<%@ page import="javax.mail.Authenticator"%>
<%@ page import="util.Gmail"%>
<%@ page import="java.util.Properties"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>


<%
	UserDAO userDAO = new UserDAO();
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	
	request.setCharacterEncoding("UTF-8");
	
	String reportTitle = null;
	String reportContent = null;
	
	if (request.getParameter("reportTitle") != null) {
		reportTitle = request.getParameter("reportTitle");
	}

	if (request.getParameter("reportContent") != null) {
		reportContent = request.getParameter("reportContent");
	}
	
	if(reportTitle == null || reportContent == null ){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('신고 제목과 빈칸에 빈 칸이 있는지 확인해 주세요.');");
		script.println("location.href = 'lecture.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
	
	String host = "http://localhost:8080/freeForum/";
	String from = "bronze13571@gmail.com";
	String to = "crackgood123@naver.com";
	String subject = "부경대 한마당 게시판에서 접수된 신고 메일입니다.";
	String content = "신고자 아이디: " + userID + "<br> 신고 제목: " + reportTitle + "<br>신고 내용 : " + reportContent;

	PrintWriter script1 = response.getWriter();

	Properties p = new Properties();
	
	p.put("mail.smtp.user", from);
	p.put("mail.smtp.host", "smtp.googlemail.com");
	p.put("mail.smtp.port", "587");
	p.put("mail.smtp.starttls.enable", "true");
	p.put("mail.smtp.auth", "true");
	p.put("mail.smtp.debug", "true");
	p.put("mail.smtp.socketFactory.port", "587");
	p.put("mail.smtp.socketFactory.Class", "javax.net.ssl.SSLSocketFactory");
	p.put("mail.smtp.socketFactory.fallback", "false");

	try {
		Authenticator auth = new Gmail();
		Session ses = Session.getInstance(p, auth);
		ses.setDebug(true);
		MimeMessage msg = new MimeMessage(ses);
		msg.setSubject(subject);
		Address fromAddr = new InternetAddress(from);
		msg.setFrom(fromAddr);
		Address toAddr = new InternetAddress(to);
		msg.addRecipient(Message.RecipientType.TO, toAddr);
		msg.setContent(content, "text/html;charset=UTF8");
		Transport.send(msg);
	} catch (Exception e) {
		e.printStackTrace();
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('예외 오류가 발생했습니다.');");
		script.println("histroy.back();");
		script.println("</script>");
		script.close();
		return;
	}
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('정상적으로 신고 되었습니다! 관리자가 확인할 때 까지 기다려주세요.');");
	script.println("location.href = 'main.jsp';");
	script.println("</script>");
	script.close();
%>




