package dao;

import model.Blood;
import model.Donors;
import java.sql.*;
import java.util.*;

public class DonorDAO {

    public boolean addDonation(Donors d) throws SQLException {
        String sql = "INSERT INTO donors (donor_user_id, donor_last_donation_date, donor_blood_id) "
                   + "VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, d.getUserId());
            ps.setInt(3, d.getBloodId());
            ps.setDate(2, new java.sql.Date(d.getLastDonationDate().getTime()));
            return ps.executeUpdate() == 1;
        }
    }
    
    public String findBloodNameByID(int BloodID) throws SQLException{
	String sql = "SELECT blood_name WHERE blood_id = ?";
	String BloodName;
	try(Connection conn = DBConnection.getConnection();
	    PreparedStatement ps = conn.prepareStatement(sql)){
	    ps.setInt(1, BloodID);
	    try(ResultSet rs = ps.executeQuery()){
		BloodName = rs.getString("blood_name");
	    }
	}
	return BloodName;
    }

    public List<Donors> findByUser(int userId) throws SQLException {
        String sql = "SELECT d.*, b.blood_name "
                   + "FROM donors d JOIN blood b ON d.donor_blood_id = b.blood_id "
                   + "WHERE d.donor_user_id = ?";
        List<Donors> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Donors d = new Donors(
                        rs.getInt("donor_user_id"),
                        rs.getDate("donor_last_donation_date"),
                        rs.getInt("donor_blood_id")
                    );
                    list.add(d);
                }
            }
        }
        return list;
    }

    public boolean addDonor(Donors d) throws SQLException {
    return addDonation(d);
    }
}
