package freeForum;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class freeForumDAO {
	private Connection conn;
	private ResultSet rs;
	
	public freeForumDAO() {
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
	
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	public int getNext() {
		String SQL = "SELECT freeForumID FROM freeForum ORDER BY freeForumID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int write(String freeForumTitle, String userID, String freeForumContent) {
		String SQL = "INSERT INTO freeForum VALUES (?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, freeForumTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, freeForumContent);
			pstmt.setInt(6, 1);
			
			return pstmt.executeUpdate(); 
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
		
	public ArrayList<freeForum> getList(int pageNumber) {
		String SQL = "SELECT * FROM freeForum WHERE freeForumAvailable = 1 ORDER BY freeForumID DESC LIMIT 10 OFFSET ?";
		ArrayList<freeForum> list = new ArrayList<freeForum>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, (pageNumber -1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				freeForum freeForum = new freeForum();
				freeForum.setfreeForumID(rs.getInt(1));
				freeForum.setfreeForumTitle(rs.getString(2));
				freeForum.setUserID(rs.getString(3));
				freeForum.setfreeForumDate(rs.getString(4));
				freeForum.setfreeForumContent(rs.getString(5));
				freeForum.setfreeForumAvailable(rs.getInt(1));
				list.add(freeForum);
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM freeForum WHERE freeForumAvailable = 1 ORDER BY freeForumID DESC LIMIT 10 OFFSET ?";
		ArrayList<freeForum> list = new ArrayList<freeForum>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, (pageNumber -1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public freeForum getfreeForum(int freeForumID) {
		String SQL = "SELECT * FROM freeForum WHERE freeForumID = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, freeForumID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				freeForum freeForum = new freeForum();
				freeForum.setfreeForumID(rs.getInt(1));
				freeForum.setfreeForumTitle(rs.getString(2));
				freeForum.setUserID(rs.getString(3));
				freeForum.setfreeForumDate(rs.getString(4));
				freeForum.setfreeForumContent(rs.getString(5));
				freeForum.setfreeForumAvailable(rs.getInt(1));
				return freeForum;
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(int freeForumID, String freeForumTitle, String freeForumContent) {
		String SQL = "UPDATE freeForum SET freeForumTitle = ?, freeForumContent = ? WHERE freeForumID =?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, freeForumTitle);
			pstmt.setString(2, freeForumContent);
			pstmt.setInt(3, freeForumID);
			
			return pstmt.executeUpdate(); 
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}
	
	public int delete(int freeForumID) {
		String SQL = "UPDATE freeForum SET freeForumAvailable = 0 WHERE freeForumID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, freeForumID);
			
			return pstmt.executeUpdate(); 
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}

}
