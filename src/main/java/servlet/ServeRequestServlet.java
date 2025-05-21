/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import java.util.*;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.SQLException;
import dao.BloodDAO;
import dao.RequestDAO;
import model.Requests;


/**
 *
 * @author geral
 */
public class ServeRequestServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException{
	
	int requestID = Integer.parseInt(request.getParameter("id"));
	HttpSession session = request.getSession(false);
	int AdminID = (int) session.getAttribute("AdminId");
	
	try{
	    RequestDAO reqDAO = new RequestDAO();
	    BloodDAO bloodDAO = new BloodDAO();
	    Requests req = reqDAO.findRequestByRequestID(requestID);
	    
	    int BloodTypeID = req.getBloodId();
	    int RequestedBloodAmount = req.getQuantity();
	    int currentBloodStock = bloodDAO.getBloodStockAmountByBloodID(BloodTypeID);
	    
	    if(currentBloodStock != -1 && currentBloodStock >= RequestedBloodAmount){
		bloodDAO.updateStock(BloodTypeID, currentBloodStock - RequestedBloodAmount, AdminID);
		reqDAO.updateStatus(requestID, "served");
		reqDAO.UpdateFulfilledBlood(currentBloodStock - RequestedBloodAmount, requestID);
		response.sendRedirect("managerequester.jsp?success=1");
	    }
	    else{
		response.sendRedirect("managerequester.jsp?error=NotEnoughStock");
	    }
	}
	catch(SQLException e){
	    e.printStackTrace();
	    response.sendRedirect("managerequester.jsp?error=1");
	}
    }
}
