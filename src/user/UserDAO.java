package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.sql.DataSource;


public class UserDAO {
	
	private Connection conn;
	private Statement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/jsforum?useSSL=false";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int login(String userID, String userPassword) {
		String SQL = "SELECT USERPASSWORD FROM USER WHERE USERID = '" + userID+"'";
		try {
			pstmt = conn.createStatement();
			rs = pstmt.executeQuery(SQL);
			if(rs.next()) {
				if(rs.getString(1).contentEquals(userPassword)) {
					return 1;
				}
				else
					return 0;
			}
			return -1;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2;
	}
	
	public User getUser(String userID) {
		String SQL = "SELECT * FROM USER WHERE USERID='"+userID+"'";
		try {
			pstmt = conn.createStatement();
			rs=pstmt.executeQuery(SQL);
			User user = new User();
			if(rs.next()) {
			user.setUserID(rs.getString(1));
			user.setUserPassword(rs.getNString(2));
			user.setUserName(rs.getString(3));
			user.setUserGender(rs.getString(4));
			user.setUserEmail(rs.getString(5));
			return user;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	
	public int join(User user) {
		String SQL = "INSERT INTO USER VALUES("+ "'"+ user.getUserID() + "'"+","+ "'" + user.getUserPassword() + "'"+","+ "'" 
					+ user.getUserName() + "'" +","+ "'" + user.getUserGender() + "'"+","+ "'" + user.getUserEmail() + "'"+")";
		try {
			pstmt = conn.createStatement();
			return pstmt.executeUpdate(SQL);
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;
	}

	public int modify(User user) {
		String SQL = "UPDATE USER SET userID='" + user.getUserID() + "'"+", userPassword='" + user.getUserPassword() + "'"+", userName='" + user.getUserName() + "'"
					  +", userGender='" + user.getUserGender() + "'"+", userEmail="+ "'" + user.getUserEmail() + "' WHERE userID='"+ user.getUserID() +"'";
		try {
			pstmt = conn.createStatement();
			return pstmt.executeUpdate(SQL);
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;
	} 
	

	
	
}

