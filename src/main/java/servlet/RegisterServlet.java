package servlet;
        
import model.Users;
import dao.UsersDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Admin;
import dao.AdminDAO;

public class RegisterServlet extends HttpServlet{    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
	    throws ServletException, IOException {
	String username = request.getParameter("name");
	String email = request.getParameter("email");
	String password = request.getParameter("password");
	String usertype = request.getParameter("userType");

	if(usertype.equals("user")){
	    try {
		Users user = new Users();
		user.setUserName(username);
		user.setUserEmail(email);
		user.setUserPassword(password); 

		UsersDAO userDAO = new UsersDAO();
		int success = userDAO.registerUser(user);

		if (success == 1) {
		    response.sendRedirect("login.jsp?success=1");
		} 
		else if(success == -1){
		    request.setAttribute("error", "Registration failed. An email already exists");
		    request.getRequestDispatcher("register.jsp").forward(request, response);
		}
		else {
		    request.setAttribute("error", "Registration failed. Please try again.");
		    request.getRequestDispatcher("register.jsp").forward(request, response);
		}
	    } 
	    catch (Exception e) {
		e.printStackTrace();
		request.setAttribute("error", "An error occurred. Please try again.");
		request.getRequestDispatcher("register.jsp").forward(request, response);
	    }
	}

	if(usertype.equals("admin")){
	    try {
		Admin admin = new Admin();
		admin.setName(username);
		admin.setEmail(email);
		admin.setPassword(password); 

		AdminDAO adminDAO = new AdminDAO();
		int success = adminDAO.registerAdmin(admin);

		if (success == 1) {
		    response.sendRedirect("login.jsp?success=1");
		} 
		else if(success == -1){
		    request.setAttribute("error", "Registration failed. An email already exists");
		    request.getRequestDispatcher("register.jsp").forward(request, response);
		}
		else {
		    request.setAttribute("error", "Registration failed. Please try again.");
		    request.getRequestDispatcher("register.jsp").forward(request, response);
		}
	    } 
	    catch (Exception e) {
		e.printStackTrace();
		request.setAttribute("error", "An error occurred. Please try again.");
		request.getRequestDispatcher("register.jsp").forward(request, response);
	    }
	}
    }
}