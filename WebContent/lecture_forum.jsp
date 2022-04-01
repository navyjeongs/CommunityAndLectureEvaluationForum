<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>
<%@ page import="lecture_Forum.lecture_ForumDTO"%>
<%@ page import="lecture_Forum.lecture_ForumDAO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.net.URLEncoder"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, inital-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="./css/bootstrap.min.css">
<link rel="stylesheet" href="./css/custom.css">
<link rel="stylesheet" href="css/bootstrap.css">
<title>강의 소통 게시판</title>
</head>
<style>
	body {
        height: 100vh;
        background-image: url('images/back.jpg');
        background-repeat : repeat;
        background-size : cover;
        -webkit-background-size: cover;
 	 	-moz-background-size: cover;
 	 	-o-background-size: cover;
      }
</style>
<body>

	<%
		request.setCharacterEncoding("UTF-8");
		String searchType = "최신순";
		String lectureDivide = "전체";
		int pageNumber = 0;
		String search = "";

		if (request.getParameter("lectureDivide") != null) {
			lectureDivide = request.getParameter("lectureDivide");
		}
		
		if (request.getParameter("search") != null) {
			search = request.getParameter("search");
		}
		
		if (request.getParameter("searchType") != null) {
			searchType = request.getParameter("searchType");
		}
		
		if (request.getParameter("pageNumber") != null) {
			try {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
			} catch (Exception e) {
		out.write("검색페이지 번호 오류");
		}

			}
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
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

	<section class="container bg-dark mt-5">
		<form method="get" action="./lecture_forum.jsp" class="form-inline mt-3">
			<select name="lectureDivide" class="form-control mx-1 mt-2 ">
				<option value="전체" >전체</option>
				<option value="전공" <%if(lectureDivide.equals("전공")) out.print("selected");%>>전공</option>
				<option value="교양" <%if(lectureDivide.equals("교양")) out.print("selected");%>>교양</option>
				<option value="기타" <%if(lectureDivide.equals("기타")) out.print("selected");%>>기타</option>
			</select>
			
			<select name="searchType" class="form-control mx-1 mt-2">
			<option value="최신순">최신순</option>
			<option value="추천순" <%if(lectureDivide.equals("추천순")) out.print("selected");%>>추천순</option>
			</select>
			
			<input type="text" name="search" class="form-control mx-1 mt-2" placeholder="내용을 입력하세요.">
			
			<button type="submit" class="btn btn-secondary mx-1 mt-2">검색하기</button>
			<a class="btn btn-secondary mx-1 mt-2" data-toggle="modal" href="#registerModal">등록하기</a> 
			<a class="btn btn-danger mx-1 mt-2" data-toggle="modal" href="#reportModal">신고하기</a>
		</form>
	
	
		<%
			ArrayList<lecture_ForumDTO> lecture_ForumList = new ArrayList<lecture_ForumDTO>();
			lecture_ForumList = new lecture_ForumDAO().getList(lectureDivide, searchType, search, pageNumber);
			if(lecture_ForumList != null)
				for(int i = 0; i <lecture_ForumList.size(); i++){		//다음페이지 작성을 위해 만들었다.
					if(i==5) break;
			lecture_ForumDTO lecture_Forum = lecture_ForumList.get(i);
		%>	
		<div class="card bg-light mt-3">
			<div class="card-header bg-light">
				<div class="row">
					<div class="col-8 text-left">
					<%= lecture_Forum.getLectureDivide() %>&nbsp;
					<%= lecture_Forum.getLectureName() %>
					&nbsp;<small><%= lecture_Forum.getProfessorName() %> 교수님  &nbsp;&nbsp;</small>
					(<%= lecture_Forum.getLectureYear()%> <%= lecture_Forum.getSemesterDivide()%>)
					</div>
				</div>
			</div>
			<div class="card-body">
				<h5 class="card-title"><%= lecture_Forum.getlecture_ForumTitle()%>&nbsp;<small></small></h5>
				<p class="card-text"><%= lecture_Forum.getlecture_ForumContent()%></p>
				<div class="row">
					<div class="col-9 text-left">
						종합 : <span class="text-info"><%= lecture_Forum.getTotalScore()%></span>
						텀프 : <span class="text-info"><%= lecture_Forum.gettermproject()%></span> 
						과제 : <span class="text-info"><%= lecture_Forum.getprojectScore()%></span> 
						강의방식 : <span class="text-info"><%= lecture_Forum.gethowlecture()%></span>
						<span style="color: green;">(해당 게시글 추천 수 : <%= lecture_Forum.getLikeCount()%>)</span>
					</div>
					<div class="col-3 text-right">
						<a style="color: green;" onclick="return confirm('추천하시겠습니까?')"
						href="likeAction.jsp?lecture_ForumID=<%=lecture_Forum.getlecture_ForumID()%>">추천하기</a> 
						<a style="color: red;" onclick="return confirm('삭제하시겠습니까?')"
						href="Lec_deleteAction.jsp?lecture_ForumID=<%=lecture_Forum.getlecture_ForumID()%>">삭제하기</a>
					</div>
				</div>
			</div>
		</div>

<%
		}
	
%>
	</section>
	<section class="container bg-dark">&nbsp;
	</section>


	<ul class="pagination justify-content-center mt-3">
		<li class="page-item">
		<%
			if(pageNumber <= 0) {
		%>	
			<a class="page-link bg-secondary text-white disabled">이전 페이지</a>
		<%
			} else {	
		%>
			<a class="page-link bg-primary text-white" href="./lecture_forum.jsp?lectureDivide=<%= URLEncoder.encode(lectureDivide,"UTF-8") %>
			&searchTyp=<%=URLEncoder.encode(searchType,"UTF-8") %>&search=<%= URLEncoder.encode(search,"UTF-8") %>&pageNumber=
			<%=pageNumber -1 %>">이전 페이지</a> 
		<%
			}
		%>
		</li>
		<li>		
		<%
		if(lecture_ForumList.size() < 6 ) {
		%>
			<a class="page-link bg-secondary text-white disabled">다음 페이지</a>
		<%
			} else {
			
		%>
			<a class="page-link bg-primary text-white" href="./lecture_forum.jsp?lectureDivide=<%= URLEncoder.encode(lectureDivide,"UTF-8") %>
			&searchTyp=<%=URLEncoder.encode(searchType,"UTF-8") %>&search=<%= URLEncoder.encode(search,"UTF-8") %>&pageNumber=
			<%=pageNumber  + 1 %>">다음 페이지</a> 
		<%
			}
		%>
		</li>	
	</ul>




	<div class="modal fade" id="registerModal" tabindex="-1" role="dailog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content bg-dark text-white">
				<div class="modal-header">
					<h5 class="modal-tittle" id="modal">평가 작성</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./lecture_ForumRegisterAction.jsp" method="post">
						<div class="form-row">
							<div class="form-group col-sm-6">
								<label>교과목명</label> <input type="text" name="LectureName" class="form-control" maxlength="20">
							</div>
							<div class="form-group col-sm-6">
								<label>교수님 성함</label> <input type="text" name="professorName" class="form-control" maxlength="20">
							</div>	
						</div>	
			<div class="form-row">
				<div class="form-group col-sm-4">
								
								<label>강의 분류</label> 
								<select name="lectureDivide" class="form-control">
									<option value="전공" selected>전공</option>
									<option value="교양">교양</option>
									<option value="기타">기타</option>
								</select>				
				</div>
				<div class="form-group col-sm-4">

								<label>수강한 연도</label> <select name="lectureYear" class="form-control">
									<option value="2017">2017</option>
									<option value="2018">2018</option>
									<option value="2019">2019</option>
									<option value="2020">2020</option>
									<option value="2021"selected>2021</option>
								</select>
				</div>
							<div class="form-group col-sm-4">
								<label>수강한 학기</label> <select name="semesterDivide" class="form-control">
									<option value="1학기">1학기</option>
									<option value="여름학기">계절학기 : 여름</option>
									<option value="2학기" selected>2학기</option>
									<option value="겨울학기">계절학기 : 겨울</option>
								</select>
							</div>
			</div>
			<div class="form-group">
							<label>제목</label> <input type="text" name="lecture_ForumTitle" class="form-control" maxlength="30">
						</div>
						<div class="form-group">
							<label>내용</label>
							<textarea name="lecture_ForumContent" class="form-control" maxlength="2048" style="height: 180px;" placeholder="모욕적인 표현 및 허위로 작성시 신고 및 게시글이 삭제될 수 있습니다."></textarea>
						</div>
						<div class="form-row">
							<div class="form-group col-sm-4">
								<label>종합적인 점수</label> <select name="totalScore" class="form-control">
									<option value="A" selected>A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="E">E</option>
									<option value="F">F</option>
								</select>

							</div>
							<div class="form-group col-sm-4">
								<label>과제 양</label> <select name="projectScore" class="form-control">
									<option value="많다">많다</option>
									<option value="적당"selected>적당</option>
									<option value="널널">널널</option>
									<option value="없다">없다</option>

								</select>

							</div>
							<div class="form-group col-sm-4">
								<label>강의방식</label> <select name="howlecture" class="form-control">
									<option value="대면">대면</option>
									<option value="사전제작"selected>사전제작</option>
									<option value="실시간">실시간</option>

								</select>
							</div>

							<div class="form-group col-sm-4">
								<label>텀프 여부</label> <select name="termproject" class="form-control">
									<option value="O"selected>O</option>						
									<option value="X">X</option>

								</select>
							</div>

						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">취소하기</button>
							<button type="submit" class="btn btn-primary">등록하기</button>
						</div>


					</form>


				</div>

			</div>


		</div>
	</div>						
						
		<div class="modal fade" id="reportModal" tabindex="-1" role="dailog"
		aria-labelledby="modal" aria-hidden="true">
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