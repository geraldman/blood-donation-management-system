package servlet;

import model.Blood;
import dao.BloodDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AdminServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("admin") == null) {
            response.sendRedirect("../login.jsp");
            return;
        }
        
        try {
            BloodDAO bloodDAO = new BloodDAO();
            List<Blood> bloodList = bloodDAO.getAllBloodTypes();
            
            request.setAttribute("bloodList", bloodList);
            request.getRequestDispatcher("/admin/manage-blood.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("../login.jsp?error=1");
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("admin") == null) {
            response.sendRedirect("../login.jsp");
            return;
        }
        
        int bloodId = Integer.parseInt(request.getParameter("bloodId"));
        int newStock = Integer.parseInt(request.getParameter("newStock"));
        int adminId = ((model.Admin)session.getAttribute("admin")).getAdminId();
        
        try {
            BloodDAO bloodDAO = new BloodDAO();
            boolean success = bloodDAO.updateBloodStock(bloodId, newStock, adminId);
            
            if (success) {
                response.sendRedirect("AdminServlet?success=1");
            } else {
                response.sendRedirect("AdminServlet?error=1");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("AdminServlet?error=1");
        }
    }
}