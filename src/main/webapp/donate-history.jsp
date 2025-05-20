<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Donors, model.Blood, dao.DonorDAO, java.util.*, dao.BloodDAO"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Donation History - BloodLife</title>
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
              <li>
                <a href="donate-history.jsp" class="active">Donate History</a>
              </li>
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
        <h2>Donation History</h2>
        <p style="color: var(--gray); font-size: 1rem">
          Your blood donation records
        </p>
      </div>
      <div class="history-section">
        <div class="history-table-wrapper">
          <table class="history-table">
            <thead>
              <tr>
                <th>Date</th>
                <th>Blood Type</th>
              </tr>
            </thead>
            <tbody>
		<%  
		    int userID = (int) session.getAttribute("id");
		    DonorDAO dao = new DonorDAO();
		    List<Donors> list = dao.findByUser(userID);
		    if(list != null){
			for(Donors data : list){
			    Date date = data.getLastDonationDate();
			    int bloodTypeID = data.getBloodId();
			    String bloodName = new BloodDAO().findBloodNameById(bloodTypeID);%>
			    <tr>
				<td><%=date%></td>
				<td><%=bloodName%></td>
			    </tr>
			<%}
		    }
		%>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </body>
</html>
