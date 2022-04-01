package likey;

public class LikeyDTO {

	String userID;
	int lecture_ForumID;
	String userIP;
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public int getlecture_ForumID() {
		return lecture_ForumID;
	}
	public void setlecture_ForumID(int lecture_ForumID) {
		this.lecture_ForumID = lecture_ForumID;
	}
	public String getUserIP() {
		return userIP;
	}
	public void setUserIP(String userIP) {
		this.userIP = userIP;
	}
	
	public LikeyDTO(){
		
	}
	public LikeyDTO(String userID, int lecture_ForumID, String userIP) {
		super();
		this.userID = userID;
		this.lecture_ForumID = lecture_ForumID;
		this.userIP = userIP;
	}
		
}
