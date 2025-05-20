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

@WebFilter(urlPatterns = {"/userdashboard.jsp","/request.jsp", "/donate.jsp", "/request-history.jsp", "/donate-history.jsp"})
public class AuthFilter implements Filter {
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
	throws IOException, ServletException{

	HttpServletRequest req = (HttpServletRequest) request;
	HttpServletResponse resp = (HttpServletResponse) response;
	HttpSession session = req.getSession(false);

	boolean loggedIn = session != null && session.getAttribute("user") != null;

	if(!loggedIn){
	    resp.sendRedirect("login.jsp");
	}
	else{
	    chain.doFilter(request, response);
	}

    }
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException{
	
    }
    
    @Override
    public void destroy(){
	
    }
}
