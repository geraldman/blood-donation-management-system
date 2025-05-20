package servlet;
        
import model.Users;
import dao.UsersDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        Users user = new Users();
        user.setUserName(name);
        user.setUserEmail(email);
        user.setUserPassword(password); 
        
        try {
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
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred. Please try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}