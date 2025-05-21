/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Filter.java to edit this template
 */
package servlet;

import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.annotation.WebFilter;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 *
 * @author geral
 */
@WebFilter(urlPatterns = {"/admindashboard.jsp", "/managebloodstock.jsp", "/managerequester.jsp", "managedonors.jsp"})
public class AuthFilterAdmin implements Filter {
    public void doFilter(ServletRequest request, ServletResponse response,
	    FilterChain chain)
	    throws IOException, ServletException {
	HttpServletRequest req = (HttpServletRequest) request;
	HttpServletResponse resp = (HttpServletResponse) response;
	HttpSession session = req.getSession(false);

	boolean loggedInUser = session != null && session.getAttribute("admin") != null;
	if(!loggedInUser){
	    resp.sendRedirect("login.jsp");
	}
	else{
	    chain.doFilter(request, response);
	}
    }

    public void destroy() {
    }

    /**
     * Init method for this filter
     */
    public void init(FilterConfig filterConfig) throws ServletException{
	
    }

}
