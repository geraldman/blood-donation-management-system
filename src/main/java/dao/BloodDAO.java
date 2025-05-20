package dao;

import model.Blood;
import java.sql.*;
import java.util.*;

public class BloodDAO {

    public List<Blood> findAll() throws SQLException {
        String sql = "SELECT b.*, a.admin_name AS modifiedBy "
                   + "FROM blood b "
                   + "LEFT JOIN admin a ON b.last_modified_by_admin_id = a.admin_id";
        List<Blood> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(new Blood(
                    rs.getInt("blood_id"),
                    rs.getString("blood_name"),
                    rs.getInt("blood_stock"),
                    rs.getInt("last_modified_by_admin_id"),
                    rs.getString("modifiedBy")
                ));
            }
        }
        return list;
    }
   
    public List<Blood> findNameandStock() throws SQLException{
	String sql = "SELECT blood_name, blood_stock FROM blood";
	List<Blood> list = new ArrayList<>();
	try(Connection conn = DBConnection.getConnection();
	    Statement st = conn.createStatement();
	    ResultSet rs = st.executeQuery(sql)){
	    while(rs.next()){
		Blood inputBlood = new Blood();
		inputBlood.setName(rs.getString("blood_name"));
		inputBlood.setStock(rs.getInt("blood_stock"));
		list.add(inputBlood);
	    }
	}
	System.out.println(list);
	return list;
    }
    
    public List<Blood> findNameandID() throws SQLException{
	String sql = "SELECT blood_id, blood_name FROM blood";
	List<Blood> list = new ArrayList<>();
	try(Connection conn = DBConnection.getConnection();
	    Statement st = conn.createStatement();
	    ResultSet rs = st.executeQuery(sql)){
	    while(rs.next()){
		Blood inputBlood = new Blood();
		inputBlood.setId(rs.getInt("blood_id"));
		inputBlood.setName(rs.getString("blood_name"));
		list.add(inputBlood);
	    }
	}
	System.out.println(list);
	return list;
    }
    
    public Blood findById(int id) throws SQLException {
        String sql = "SELECT * FROM blood WHERE blood_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Blood(
                        rs.getInt("blood_id"),
                        rs.getString("blood_name"),
                        rs.getInt("blood_stock"),
                        rs.getInt("last_modified_by_admin_id"),
                        null
                    );
                }
            }
        }
        return null;
    }
    
    public String findBloodNameById(int id) throws SQLException{
	String sql = "SELECT blood_name FROM blood WHERE blood_id = ?";
	try (Connection conn = DBConnection.getConnection();
	     PreparedStatement ps = conn.prepareStatement(sql)) {
	    ps.setInt(1, id);
	    try (ResultSet rs = ps.executeQuery()) {
		if (rs.next()) {
		    return rs.getString("blood_name");
		}
	    }
	}
	return null;
    }
    
     public boolean incrementStock(int bloodId) throws SQLException {
        String sql = "UPDATE blood SET blood_stock = blood_stock + 1 WHERE blood_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bloodId);
            return ps.executeUpdate() > 0;
        }
    }
    
    public boolean updateStock(int bloodId, int newStock, int adminId) throws SQLException {
        String sql = "UPDATE blood SET blood_stock = ?, last_modified_by_admin_id = ? WHERE blood_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, newStock);
            ps.setInt(2, adminId);
            ps.setInt(3, bloodId);
            return ps.executeUpdate() == 1;
        }
    }
    
/** used by AdminServlet to list all blood types */
    public List<Blood> getAllBloodTypes() throws SQLException {
        return findAll();
    }

    /** used by AdminServlet to update stock */
    public boolean updateBloodStock(int bloodId, int newStock, int adminId) throws SQLException {
        return updateStock(bloodId, newStock, adminId);
    }

}
