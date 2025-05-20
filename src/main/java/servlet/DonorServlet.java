package servlet;

import model.Donors;
import model.Users;
import dao.DonorDAO;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLIntegrityConstraintViolationException;
import javax.servlet.http.HttpSession;
import java.time.LocalDate;

public class DonorServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        int bloodId = Integer.parseInt(request.getParameter("bloodType"));
        LocalDate today = LocalDate.now();
	Date formattedDate = Date.valueOf(today);
        
        Donors donor = new Donors();
        donor.setDonorUserId(user.getUserId());
	donor.setDonorLastDonationDate(formattedDate);
        donor.setDonorBloodId(bloodId);
        
        try{
            DonorDAO donorDAO = new DonorDAO();
            boolean success = donorDAO.addDonor(donor);
            
            if(success){
		request.setAttribute("success", "Your blood has been donated. Thank you for your donation!");
                request.getRequestDispatcher("donate.jsp").forward(request, response);
            }
	    else{
		request.setAttribute("error", "Only one user donation per day is allowed");
                request.getRequestDispatcher("donate.jsp").forward(request, response);
            }
        }
	catch(SQLIntegrityConstraintViolationException e){
	    request.setAttribute("error", "Only one user donation per day is allowed");
	    request.getRequestDispatcher("donate.jsp").forward(request, response);
	}
	catch (SQLException e){
            e.printStackTrace();
            response.sendRedirect("userdashboard.jsp");
        }
    }
}   