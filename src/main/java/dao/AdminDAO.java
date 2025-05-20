package dao;

import java.util.*;
import model.ActivityHistory;
import model.Admin;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AdminDAO {
    public Admin authenticateAdmin(String email, String password) throws SQLException {
        String sql = "SELECT * FROM admin WHERE admin_email = ? AND admin_password = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, email);
            stmt.setString(2, password);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Admin(
                        rs.getInt("admin_id"),
                        rs.getString("admin_name"),
                        rs.getString("admin_email"),
                        rs.getString("admin_password")
                    );
                }
            }
        }
        return null;
    }
    
    public List<ActivityHistory> getRecentActivites() throws SQLException{
	String sql = "SELECT \n" +
		    "    'Donation' AS activity,\n" +
		    "    b.blood_name,\n" +
		    "    d.donor_last_donation_date AS date,\n" +
		    "    u.user_name\n" +
		    "FROM donors d\n" +
		    "JOIN users u ON d.donor_user_id = u.user_id\n" +
		    "JOIN blood b ON d.donor_blood_id = b.blood_id\n" +
		    "\n" +
		    "UNION\n" +
		    "\n" +
		    "SELECT \n" +
		    "    'Request' AS activity,\n" +
		    "    b.blood_name,\n" +
		    "    r.request_date AS date,\n" +
		    "    u.user_name\n" +
		    "FROM requests r\n" +
		    "JOIN users u ON r.requester_id = u.user_id\n" +
		    "JOIN blood b ON r.requester_blood_id = b.blood_id\n" +
		    "\n" +
		    "ORDER BY date DESC";
	List<ActivityHistory> list = new ArrayList<>();
	try(Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
	     ResultSet rs = ps.executeQuery(sql)){
            while(rs.next()) {
                ActivityHistory history = new ActivityHistory(
                    rs.getString("activity"),
                    rs.getString("blood_name"),
                    rs.getDate("date"),
                    rs.getString("user_name")
                );
		list.add(history);
	    }
	}
	return list;
    }
}