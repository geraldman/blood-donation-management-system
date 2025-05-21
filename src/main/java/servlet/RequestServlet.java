package servlet;

import model.Requests;
import model.Users;
import dao.RequestDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.time.LocalDate;
import java.sql.Date;

public class RequestServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("../login.jsp");
            return;
        }
        
        int bloodId = Integer.parseInt(request.getParameter("bloodType"));
        String bloodquantityStr = request.getParameter("requested_blood_quantity");
	if(bloodquantityStr == null || bloodquantityStr.isEmpty()){
	    response.sendRedirect("request.jsp?error=");
	    return;
	}
	int bloodquantity = Integer.parseInt(bloodquantityStr);
	LocalDate today = LocalDate.now();
	Date formattedDate = Date.valueOf(today);
		
        Requests bloodRequest = new Requests();
        bloodRequest.setRequesterId(user.getUserId());
        bloodRequest.setRequesterBloodId(bloodId);
        bloodRequest.setRequestedBloodQuantity(bloodquantity);
	bloodRequest.setRequestDate(formattedDate);
        bloodRequest.setRequestStatus("Pending");
        
        try {
            RequestDAO requestDAO = new RequestDAO();
            boolean success = requestDAO.addRequest(bloodRequest);
            
            if (success) {
                response.sendRedirect("request.jsp?success=5");
            } else {
                response.sendRedirect("request.jsp?error=5");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("request.jsp?error=5");
        }
    }
    
}