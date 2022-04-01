package lecture_Forum;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


public class lecture_ForumDAO {
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	public lecture_ForumDAO() {
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
	
	public int writer(lecture_ForumDTO lecture_ForumDTO) { 
	
	String SQL = "INSERT INTO lecture_Forum VALUES (NULL,?,?,?,?,?,?,?,?,?,?,?,?,0)";


	try {

		pstmt = conn.prepareStatement(SQL);
		pstmt.setString(1, lecture_ForumDTO.getUserID().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
		pstmt.setString(2, lecture_ForumDTO.getLectureName().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
		pstmt.setString(3, lecture_ForumDTO.getProfessorName().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
		pstmt.setInt(4, lecture_ForumDTO.getLectureYear());
		pstmt.setString(5, lecture_ForumDTO.getSemesterDivide().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
		pstmt.setString(6, lecture_ForumDTO.getLectureDivide().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
		pstmt.setString(7, lecture_ForumDTO.getlecture_ForumTitle().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
		pstmt.setString(8, lecture_ForumDTO.getlecture_ForumContent().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
		pstmt.setString(9, lecture_ForumDTO.getTotalScore().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
		pstmt.setString(10, lecture_ForumDTO.getprojectScore().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
		pstmt.setString(11, lecture_ForumDTO.gethowlecture().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
		pstmt.setString(12, lecture_ForumDTO.gettermproject().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
		
		return pstmt.executeUpdate(); // DB 업데이트

	} catch (Exception e) {
		e.printStackTrace();
	} finally { // 접근한 자원을 모두 해제한다.

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
	return -2; // 데이터베이스 오류

	}
	
	public ArrayList<lecture_ForumDTO> getList (String lectureDivide,String searchType, String search, int pageNumber){	// 게시글 들고오기
		if(lectureDivide.equals("전체")) {
			lectureDivide = "";
		}
		
		ArrayList<lecture_ForumDTO> lecture_ForumList = null;
		String SQL = "";
	
		try {
			if(searchType.equals("최신순")){
				
				SQL = "SELECT * FROM lecture_Forum WHERE lectureDivide LIKE ? AND CONCAT(LectureName,professorName,lecture_ForumTitle,lecture_ForumContent) LIKE " +  
				"? ORDER BY lecture_ForumID DESC LIMIT " + pageNumber * 5 + "," + pageNumber *5+6;
			
			} else if(searchType.equals("추천순")) {
				
				SQL = "SELECT * FROM lecture_Forum WHERE lectureDivide LIKE ? AND CONCAT(LectureName,professorName,lecture_ForumTitle,lecture_ForumContent) LIKE" +  
				"? ORDER BY likeCount DESC LIMIT " + pageNumber * 5 + "," + pageNumber *5+6;
			}
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,"%" +  lectureDivide + "%");
			pstmt.setString(2,"%" +  search + "%");
			rs = pstmt.executeQuery();
			
			lecture_ForumList = new ArrayList<lecture_ForumDTO>();
			while(rs.next()){
				lecture_ForumDTO lecture_Forum = new lecture_ForumDTO(
						
						rs.getInt(1),
						rs.getString(2),
						rs.getString(3),
						rs.getString(4),
						rs.getInt(5),
						rs.getString(6),
						rs.getString(7),
						rs.getString(8),
						rs.getString(9),
						rs.getString(10),
						rs.getString(11),
						rs.getString(12),
						rs.getString(13),
						rs.getInt(14)	
				);
				
					lecture_ForumList.add(lecture_Forum);
			
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally { // 접근한 자원을 모두 해제한다.

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
		return lecture_ForumList;	
		
	}
	
	public int like(String lecture_ForumID){
		
		String SQL = "UPDATE lecture_Forum SET likeCount = likeCount + 1 WHERE lecture_ForumID = ?";

		try {

			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(lecture_ForumID));
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally { // 접근한 자원을 모두 해제한다.

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
		return -1; // 오류발생

	}

	
	public int delete(String lecture_ForumID){
		
		String SQL = "DELETE FROM lecture_Forum WHERE lecture_ForumID = ?";


		try {

			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(lecture_ForumID));
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally { // 접근한 자원을 모두 해제한다.

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
		return -1; // 오류

	}
	
	public String getUserID(String lecture_ForumID){
		
		String SQL = "SELECT userID FROM lecture_Forum WHERE lecture_ForumID = ?";


		try {

			pstmt = conn.prepareStatement(SQL);

			pstmt.setInt(1, Integer.parseInt(lecture_ForumID));

			rs = pstmt.executeQuery();
			if (rs.next()) {

				return rs.getString(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally { // 접근한 자원을 모두 해제한다.

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
		return null;

	}	
	
	
}