package dao;

import model.Users;
import java.sql.*;

public class UsersDAO{

    public Users authenticateUser(String email, String password) throws SQLException {
        String sql = "SELECT user_id, user_name, user_email FROM users WHERE user_email = ? AND user_password = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Users(
                        rs.getInt("user_id"),
                        rs.getString("user_name"),
                        rs.getString("user_email"),
                        null
                    );
                }
            }
        }
        return null;
    }
    
    public String FindNameByID(int userID) throws SQLException{
	String sql = "SELECT user_name FROM users WHERE user_id = ?";
	String result = null;
	try (Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){
	    ps.setInt(1, userID);
	    try(ResultSet rs = ps.executeQuery()){
		if(rs.next()){
		result = rs.getString("user_name");
		}
	    }
	}
	return result;
    }
    
    public int registerUser(Users u) throws SQLException{
        String sql = "INSERT INTO users (user_id, user_name, user_email, user_password) VALUES (NULL, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, u.getName());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getPassword());
            int result  = ps.executeUpdate();
            return result;
        }
        catch(SQLIntegrityConstraintViolationException e){
            return -1;
        }
    }
}
