    package servlet;

    import dao.UsersDAO;
    import model.Users;
    import javax.servlet.ServletException;
    import javax.servlet.annotation.WebServlet;
    import javax.servlet.http.HttpServlet;
    import javax.servlet.http.HttpServletRequest;
    import javax.servlet.http.HttpServletResponse;
    import javax.servlet.http.HttpSession;
    import java.io.IOException;
    import java.sql.SQLException;

    @WebServlet("/login")
    public class LoginServlet extends HttpServlet {
        private UsersDAO userDAO;

        @Override
        public void init() throws ServletException {
            super.init();
            userDAO = new UsersDAO();
        }
        
        public boolean isUserLoggedIn(HttpServletRequest req){
            HttpSession session = req.getSession(false);
            return session != null && session.getAttribute("user") != null;
        }
        
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp)
                throws ServletException, IOException {
            if(isUserLoggedIn(req)){ // Checking if user has a session/logged on
                resp.sendRedirect("userdashboard.jsp"); //taro klo misalnya udah ada user interface
                return;
            }
            // Forward to login page
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        }

        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp)
                throws ServletException, IOException {
            String email = req.getParameter("email");
            String password = req.getParameter("password");

            try {
                Users user = userDAO.authenticateUser(email, password);
                if (user != null) {
                    // Successful login
                    HttpSession session = req.getSession(true);
                    session.setAttribute("user", user);
		    session.setAttribute("Username", user.getName());
		    session.setAttribute("id", user.getId());
                    resp.sendRedirect("userdashboard.jsp"); // or your dashboard
                } else {
                    // Failed login
                    req.setAttribute("error", "Invalid email or password");
                    req.getRequestDispatcher("login.jsp").forward(req, resp);
                }
            } catch (SQLException e) {
                throw new ServletException("Database access error", e);
            }
        }   
    }