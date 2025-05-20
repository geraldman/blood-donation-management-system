<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Request Blood - BloodLife</title>
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
              <li><a href="request-history.jsp">Request History</a></li>
            </ul>
          </nav>
          <div class="header-actions">
            <a href="login.jsp" class="text-button">Sign In</a>
            <a href="register.jsp" class="primary-button">Register</a>
          </div>
          <button class="mobile-menu-button">
            <i class="fas fa-bars"></i>
          </button>
        </div>
      </div>
    </header>
    <div class="auth-container">
      <div style="text-align: center; margin-bottom: 24px">
        <h2>Request Blood</h2>
        <p style="color: var(--gray); font-size: 1rem">
          Fill the form to request blood
        </p>
      </div>
      <form action="RequestServlet" method="post">
        <div class="form-group">
          <label for="bloodType">Blood Type</label>
          <select
            id="bloodType"
            name="requester_blood_id"
            required
            style="
              width: 100%;
              padding: 14px 16px;
              border-radius: 8px;
              border: 1.5px solid #e0e0e0;
              background: #fafbfc;
              font-size: 1rem;
              margin-top: 6px;
            "
          >
            <option value="">Select Blood Type</option>
            <%@include file="includes/blood-dropdown.jsp"%>
          </select>
        </div>
        <div class="form-group">
          <label for="quantity">Requested Quantity (bags)</label>
          <input
            type="number"
            id="quantity"
            name="requested_blood_quantity"
            min="1"
            max="10"
            placeholder="Enter quantity"
            required
          />
        </div>
        <button type="submit" class="btn">Request</button>
      </form>
    </div>
  </body>
</html>
