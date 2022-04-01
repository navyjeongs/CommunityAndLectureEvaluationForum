package likey;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class LikeyDAO {
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	public LikeyDAO() {
		
		try {
			String dbURL = "jdbc:mysql://localhost:3306/JSForum?useSSL=false";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public int like(String userID, String lecture_ForumID, String userIP){
		
				String SQL = "INSERT INTO LIKEY VALUES (?,?,?)";

				try {

					pstmt = conn.prepareStatement(SQL);
					pstmt.setString(1, userID);
					pstmt.setString(2, lecture_ForumID);
					pstmt.setString(3, userIP);
					
					return pstmt.executeUpdate();
					
				} catch (Exception e) {
					e.printStackTrace();
				} finally { // 접근한 자원 모두 해지

					try {
						if (conn != null)
							conn.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
					try {
						if (pstmt != null)
							pstmt.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
					try {
						if (rs != null)
							rs.close();
					} catch (Exception e) {
						e.printStackTrace();
					}

				}
				return -1; // 중복 추천
	}		
}
