/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import model.Blood;
import dao.BloodDAO;

public class EditBagServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
	    throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            BloodDAO bloodDAO = new BloodDAO();
            int bloodId = Integer.parseInt(request.getParameter("bloodId"));
            String operation = request.getParameter("operation");
            int currentStock = 0;
            int newStock = 0;

            Blood currentBlood = bloodDAO.findById(bloodId);
            if(currentBlood != null){
                currentStock = currentBlood.getStock();
            }

            Object adminObj = session.getAttribute("admin");
            int adminId = 1; // Default admin ID

            if(adminObj != null && adminObj instanceof model.Admin){
                adminId = ((model.Admin) adminObj).getAdminId();
            }

            boolean success = false;
            String successMessage1 = null;
            String errorMessage1 = null;

            if("set".equals(operation)){
                newStock = Integer.parseInt(request.getParameter("newStock"));
                success = bloodDAO.updateBloodStock(bloodId, newStock, adminId);
                if (success){
                    successMessage1 = "Blood stock updated to " + newStock + " bags!";
                }
            } 
	    else if("add".equals(operation)){
                int addAmount = Integer.parseInt(request.getParameter("addAmount"));
                newStock = currentStock + addAmount;
                success = bloodDAO.updateBloodStock(bloodId, newStock, adminId);
                if(success){
                    successMessage1 = "Added " + addAmount + " bags to blood stock!";
                }
            } 
	    else if("reduce".equals(operation)){
                int reduceAmount = Integer.parseInt(request.getParameter("reduceAmount"));
                newStock = Math.max(0, currentStock - reduceAmount);
                success = bloodDAO.updateBloodStock(bloodId, newStock, adminId);
                if(success){
                    if(currentStock >= reduceAmount){
                        successMessage1 = "Reduced blood stock by " + reduceAmount + " bags!";
                    }
		    else{
                        successMessage1 = "Stock reduced to 0. Requested to reduce by " + reduceAmount + 
                                         " bags but only " + currentStock + " were available.";
                    }
                }
            }

            if(success){
                errorMessage1 = "Failed to update blood stock.";
            }

            if(successMessage1 != null){
                session.setAttribute("successMessage1", successMessage1);
            }
            if(errorMessage1 != null){
                session.setAttribute("errorMessage1", errorMessage1);
            }
            
        }
	catch(NumberFormatException e){
            session.setAttribute("errorMessage1", "Invalid input. Please enter valid numbers.");
        }
	catch(Exception e){
            session.setAttribute("errorMessage1", "An error occurred: " + e.getMessage());
        }
        
        // Redirect back to the JSP page after processing
        response.sendRedirect("managebloodstock.jsp");
    }
}