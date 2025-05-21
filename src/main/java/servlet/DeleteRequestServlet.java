/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.RequestDAO;
import java.sql.SQLException;

/**
 *
 * @author geral
 */
public class DeleteRequestServlet extends HttpServlet{
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
	    throws ServletException, IOException{
        int reqId = Integer.parseInt(request.getParameter("id"));
	try{
	    RequestDAO reqDAO = new RequestDAO();
	    reqDAO.deleteRequestById(reqId);
	    response.sendRedirect("managerequester.jsp?success=3");
	}
	catch(SQLException e){
	    e.printStackTrace();
	    response.sendRedirect("managerequester.jsp?error=3");
	}
    }
}