package lecture_Forum;

public class lecture_ForumDTO {

	int lecture_ForumID;
	String userID;
	String LectureName;
	String professorName;
	int lectureYear;
	String semesterDivide;
	String lectureDivide;
	String lecture_ForumTitle;
	String lecture_ForumContent;
	String totalScore;
	String projectScore;
	String howlecture;
	String termproject;
	int likeCount;
	
	public lecture_ForumDTO() {
	}
	
	public lecture_ForumDTO(int lecture_ForumID, String userID, String lectureName, String professorName, int lectureYear,
			String semesterDivide, String lectureDivide, String lecture_ForumTitle, String lecture_ForumContent,
			String totalScore, String projectScore, String howlecture, String termproject, int likeCount) {
		super();
		this.lecture_ForumID = lecture_ForumID;
		this.userID = userID;
		LectureName = lectureName;
		this.professorName = professorName;
		this.lectureYear = lectureYear;
		this.semesterDivide = semesterDivide;
		this.lectureDivide = lectureDivide;
		this.lecture_ForumTitle = lecture_ForumTitle;
		this.lecture_ForumContent = lecture_ForumContent;
		this.totalScore = totalScore;
		this.projectScore = projectScore;
		this.howlecture = howlecture;
		this.termproject = termproject;
		this.likeCount = likeCount;
	}
	public int getlecture_ForumID() {
		return lecture_ForumID;
	}
	public void setlecture_ForumID(int lecture_ForumID) {
		this.lecture_ForumID = lecture_ForumID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getLectureName() {
		return LectureName;
	}
	public void setLectureName(String lectureName) {
		LectureName = lectureName;
	}
	public String getProfessorName() {
		return professorName;
	}
	public void setProfessorName(String professorName) {
		this.professorName = professorName;
	}
	public int getLectureYear() {
		return lectureYear;
	}
	public void setLectureYear(int lectureYear) {
		this.lectureYear = lectureYear;
	}
	public String getSemesterDivide() {
		return semesterDivide;
	}
	public void setSemesterDivide(String semesterDivide) {
		this.semesterDivide = semesterDivide;
	}
	public String getLectureDivide() {
		return lectureDivide;
	}
	public void setLectureDivide(String lectureDivide) {
		this.lectureDivide = lectureDivide;
	}
	public String getlecture_ForumTitle() {
		return lecture_ForumTitle;
	}
	public void setlecture_ForumTitle(String lecture_ForumTitle) {
		this.lecture_ForumTitle = lecture_ForumTitle;
	}
	public String getlecture_ForumContent() {
		return lecture_ForumContent;
	}
	public void setlecture_ForumContent(String lecture_ForumContent) {
		this.lecture_ForumContent = lecture_ForumContent;
	}
	public String getTotalScore() {
		return totalScore;
	}
	public void setTotalScore(String totalScore) {
		this.totalScore = totalScore;
	}
	public String getprojectScore() {
		return projectScore;
	}
	public void setprojectScore(String projectScore) {
		this.projectScore = projectScore;
	}
	public String gethowlecture() {
		return howlecture;
	}
	public void sethowlecture(String howlecture) {
		this.howlecture = howlecture;
	}
	public String gettermproject() {
		return termproject;
	}
	public void settermproject(String termproject) {
		this.termproject = termproject;
	}
	public int getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	
	
}
