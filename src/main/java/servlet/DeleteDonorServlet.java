package servlet;

import dao.DonorDAO;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DeleteDonorServlet extends HttpServlet{
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        String userIdStr = request.getParameter("id");
        String dateStr = request.getParameter("date");

        if(userIdStr != null && dateStr != null){
            try {
                int userId = Integer.parseInt(userIdStr);
                Date donationDate = Date.valueOf(dateStr);

                DonorDAO dao = new DonorDAO();
                dao.deleteDonorByUserIdAndDate(userId, donationDate);

                response.sendRedirect("managedonors.jsp?deleted=1");
            } 
	    catch(IllegalArgumentException | SQLException e){
                e.printStackTrace();
                response.sendRedirect("managedonors.jsp?error=1");
            }
        } else {
            response.sendRedirect("managedonors.jsp?error=1");
        }
    }
}