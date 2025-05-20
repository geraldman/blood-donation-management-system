package dao;

import model.Donors;
import java.sql.*;
import java.sql.Date;
import java.util.*;
import java.time.temporal.ChronoUnit;
import java.time.LocalDate;

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
    
    public int getAllDonationCount() throws SQLException{
	String sql = "SELECT COUNT(*) FROM donors";
        try(Connection conn = DBConnection.getConnection();
	    PreparedStatement ps = conn.prepareStatement(sql)){
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                return rs.getInt(1);
            }
        }
        return 0;
    }
    
    public int getDonationCountByUser(int userId) throws SQLException{
        String sql = "SELECT COUNT(*) FROM donors WHERE donor_user_id = ?";
        try(Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                return rs.getInt(1);
            }
        }
        return 0;
    }
    
    public Date getLastDonationDateByUser(int userId) throws SQLException {
        String sql = "SELECT MAX(donor_last_donation_date) AS last_date FROM donors WHERE donor_user_id = ?";
        try(Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                return rs.getDate("last_date");
            }
        }
        return null;
    }
    
    public int daysSinceLastDonation(Date lastDonationDate){
	if (lastDonationDate == null){
	    return -1;
	}

	LocalDate donationLocalDate = lastDonationDate.toLocalDate();
	LocalDate today = LocalDate.now();

	long daysBetween = ChronoUnit.DAYS.between(donationLocalDate, today);
	return (int) daysBetween;
    }
    
    public int findDaysSinceLastDonationByID(int userId) throws SQLException{
	return daysSinceLastDonation(getLastDonationDateByUser(userId));
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
    
    public List<Donors> getAllDonationHistory() throws SQLException{
	String sql = "SELECT u.user_id, d.donor_last_donation_date, b.blood_name "
		+ "FROM donors d JOIN users u ON d.donor_user_id = u.user_id "
		+ "JOIN blood b ON d.donor_blood_id = b.blood_id";
	List<Donors> list = new ArrayList<>();
	try(Connection conn = DBConnection.getConnection();
	    PreparedStatement ps = conn.prepareStatement(sql);
	    ResultSet rs = ps.executeQuery()){
	    while(rs.next()){
		Donors d = new Donors();
		d.setUserId(rs.getInt("user_id"));
		d.setLastDonationDate(rs.getDate("donor_last_donation_date"));
		d.setBloodName(rs.getString("blood_name"));
		list.add(d);
	    }
	}
	return list;
    }
    
    public boolean deleteDonorByUserIdAndDate(int userId, Date date) throws SQLException{
	String sql = "DELETE FROM donors WHERE donor_user_id = ? AND donor_last_donation_date = ?";
	try(Connection conn = DBConnection.getConnection();
	     PreparedStatement ps = conn.prepareStatement(sql)){
	    ps.setInt(1, userId);
	    ps.setDate(2, date);
	    return ps.executeUpdate() > 0;
	}
    }
    
    public boolean addDonor(Donors d) throws SQLException {
    return addDonation(d);
    }
}
