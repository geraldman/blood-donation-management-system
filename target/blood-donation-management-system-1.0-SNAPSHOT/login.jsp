<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Login - Blood Donation System</title>
    <link rel="stylesheet" href="css/style.css" />
    <link rel="stylesheet" href="css/login.css" />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
    />
    <link
      href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
      rel="stylesheet"
    />
  </head>
  <body>
    <!-- Navbar Start -->
    <header class="minimal-header">
      <div class="container">
        <div class="header-wrapper">
          <a href="index.jsp" class="brand-logo">
            <i class="fas fa-tint"></i>
            <span>BloodLife</span>
          </a>
          <nav class="main-navigation">
            <ul>
              <li><a href="donate.jsp">Donate</a></li>
              <li><a href="request.jsp">Request</a></li>
            </ul>
          </nav>
          <button class="mobile-menu-button">
            <i class="fas fa-bars"></i>
          </button>
        </div>
      </div>
    </header>
    <!-- Navbar End -->
    <div
      class="container"
      style="max-width: 400px; margin: 120px auto 60px auto"
    >
      <div style="text-align: center; margin-bottom: 24px">
        <h2>Welcome Back</h2>
        <p style="color: var(--gray); font-size: 1rem">
          Sign in to continue to BloodLife
        </p>
      </div>
      <% if (request.getAttribute("error") != null) { %>
      <div class="error">Invalid email or password. Please try again.</div>
      <% } %>
      <form action="LoginServlet" method="post">
        <div class="form-group">
          <label for="email">Email</label>
          <div style="position: relative">
            <input
              type="email"
              id="email"
              name="email"
              placeholder="Enter your email"
              required
            />
          </div>
        </div>
        <div class="form-group">
          <label for="password">Password</label>
          <div style="position: relative">
            <input
              type="password"
              id="password"
              name="password"
              placeholder="Enter your password"
              required
            />
          </div>
        </div>
        <div class="form-group">
          <label>Login as</label>
          <div class="user-type-group">
            <label class="user-type-option">
              <input type="radio" name="userType" value="user" checked />
              <span class="user-type-label donor">User</span>
            </label>
            <label class="user-type-option">
              <input type="radio" name="userType" value="admin" />
              <span class="user-type-label requester">Admin</span>
            </label>
          </div>
        </div>
        <button type="submit" class="btn" style="width: 100%; margin-top: 18px">
          Sign In
        </button>
      </form>
      <p style="text-align: center; margin-top: 18px">
        Don't have an account? <a href="register.jsp">Register here</a>
      </p>
    </div>
  </body>
</html>
