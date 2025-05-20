package dao;

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
}