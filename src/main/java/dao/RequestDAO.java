package dao;

import model.Requests;
import java.sql.*;
import java.util.*;

public class RequestDAO {

    public boolean addRequest(Requests r) throws SQLException {
        String sql = "INSERT INTO requests (request_id, requester_id, requester_blood_id, requested_blood_quantity, request_status) "
                   + "VALUES (NULL, ?, ?, ?, 'Pending')";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, r.getUserId());
            ps.setInt(2, r.getBloodId());
            ps.setInt(3, r.getQuantity());
            return ps.executeUpdate() == 1;
        }
    }

    public List<Requests> findAll() throws SQLException {
        String sql = "SELECT rq.*, u.user_name, b.blood_name "
                   + "FROM requests rq "
                   + "JOIN users u ON rq.requester_id = u.user_id "
                   + "JOIN blood b ON rq.requester_blood_id = b.blood_id";
        List<Requests> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Requests rq = new Requests(
                    rs.getInt("request_id"),
                    rs.getInt("requester_id"),
                    rs.getInt("requester_blood_id"),
                    rs.getInt("requested_blood_quantity"),
		    rs.getInt("requested_blood_fulfilled"),
                    rs.getString("request_status")
                );
                rq.setUserName(rs.getString("user_name"));
                rq.setBloodName(rs.getString("blood_name"));
                list.add(rq);
            }
        }
        return list;
    }
    
    public List<Requests> findRequestByID(int userID) throws SQLException{
	String sql = "SELECT b.blood_name, rq.*"
		    + "FROM requests rq "
		    + "JOIN blood b ON rq.requester_blood_id = b.blood_id "
		    + "WHERE rq.requester_id = ?";
	List<Requests> list = new ArrayList<>();
	try(Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){
	    ps.setInt(1, userID);
	    try(ResultSet rs = ps.executeQuery()){	
		while(rs.next()){
		    Requests r = new Requests(
			rs.getString("blood_name"),
			rs.getInt("requested_blood_quantity"),
			rs.getInt("requested_blood_fullfiled"),
			rs.getString("request_status")
		    );
		    list.add(r);
		}
	    }
	}
	return list;
    }

    public boolean updateStatus(int requestId, String newStatus) throws SQLException {
        String sql = "UPDATE requests SET request_status = ? WHERE request_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setInt(2, requestId);
            return ps.executeUpdate() == 1;
        }
    }
}
