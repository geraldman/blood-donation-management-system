<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.RequestDAO, model.Requests, java.util.*"%>
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
			    <li><a href="donate-history.jsp">Donate History</a></li>
			    <li><a href="request.jsp">Request</a></li>
			</ul>
		    </nav>
		    <div class="header-actions">
			<% if (session.getAttribute("user") == null) { %>
			<a href="login.jsp" class="text-button">Sign In</a>
			<a href="register.jsp" class="primary-button">Register</a>
			<% } else { %>
			<a href="userdashboard.jsp" class="text-button">My Dashboard</a>
			<a href="LogoutServlet" class="primary-button">Logout</a>
			<% }%>
		    </div>
		    <button class="mobile-menu-button">
			<i class="fas fa-bars"></i>
		    </button>
		</div>
	    </div>
	</header>
	<div class="auth-container" style="max-width: 700px">
	    <div style="text-align: center; margin-bottom: 24px">
		<h2>Request History</h2>
		<p style="color: var(--gray); font-size: 1rem">
		    Your blood donation records
		</p>
	    </div>
	    <div class="history-section">
		<div class="history-table-wrapper">
		    <table class="history-table">
			<thead>
			    <tr>
				<th>Blood Type</th>
				<th>Quantity</th>
				<th>Request Fulfilled</th>
				<th>Status</th>
			    </tr>
			</thead>
			<tbody>
			    <%
				int userID = (int) session.getAttribute("id");
				RequestDAO dao = new RequestDAO();
				List<Requests> list = dao.findRequestByID(userID);
				if(list != null){
				    for(Requests data : list){
					String blood_name = data.getBloodName();
					int requested_blood_quantity = data.getQuantity();
					int requested_blood_fulfilled = data.getQuantityFulfilled();
					String status = data.getStatus();
					String status_css;
					if(status.equals("Served")){
					    status_css = "served";
					}
					else if(status.equals("Pending")){
					    status_css = "pending";
					}
					else{
					    status_css = "cancelled";
					}
					%>
					<tr>
					    <td><%=blood_name%></td>
					    <td><%=requested_blood_quantity%></td>
					    <td><%=requested_blood_fulfilled%></td>
					    <td><div class="status <%=status_css%>"><%=status%></div></td>
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
