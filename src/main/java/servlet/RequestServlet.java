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
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        
        Requests bloodRequest = new Requests();
        bloodRequest.setRequesterId(user.getUserId());
        bloodRequest.setRequesterBloodId(bloodId);
        bloodRequest.setRequestedBloodQuantity(quantity);
        bloodRequest.setRequestStatus("Pending");
        
        try {
            RequestDAO requestDAO = new RequestDAO();
            boolean success = requestDAO.addRequest(bloodRequest);
            
            if (success) {
                response.sendRedirect("requester/dashboard.jsp?success=1");
            } else {
                response.sendRedirect("requester/dashboard.jsp?error=1");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("requester/dashboard.jsp?error=1");
        }
    }
    
}