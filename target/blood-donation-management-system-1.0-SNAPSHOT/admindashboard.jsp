<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.DonorDAO, dao.RequestDAO, model.ActivityHistory, dao.AdminDAO, java.util.*"%>

<%
    DonorDAO donor = new DonorDAO();
    RequestDAO req = new RequestDAO();
    AdminDAO admin = new AdminDAO();

    int requestAmount = req.getAllRequestCount();
    int donorAmount = donor.getAllDonationCount();
    int requestBloodQuantity = req.getTotalRequestsBloodQuantity();
    int requestBloodFullfiled = req.getTotalRequestsBloodFullfiledQuantity();
    List<ActivityHistory> list = admin.getRecentActivites();
%>

<!DOCTYPE html>
<%@include file="adminheader.jsp"%>
<div class="admin-tabs">
    <a href="admindashboard.jsp"><div class="admin-tab active" >Dashboard</div></a>
    <a href="managedonors.jsp"><div class="admin-tab" >Manage Donors</div></a>
    <a href="managerequester.jsp"><div class="admin-tab" >Manage Requesters</div></a>
    <a href="managebloodstock.jsp"><div class="admin-tab" >Modify Blood Stock</div></a>
</div>  
<!-- Dashboard Tab -->
<div class="tab-content active" id="dashboard">
    <div class="stats-grid">
	<div class="stat-card">
	    <h3><%=donorAmount%></h3>
	    <p>Total Blood Collected</p>
	</div>
	<div class="stat-card">
	    <h3><%=requestAmount%></h3>
	    <p>Total Requesters</p>
	</div>
	<div class="stat-card">
	    <h3><%=requestBloodQuantity%></h3>
	    <p>Total Blood Requests</p>
	</div>
	<div class="stat-card">
	    <h3><%=requestBloodFullfiled%></h3>
	    <p>Donated Blood</p>
	</div>
    </div>

    <div class="card">
	<h2>Recent Activities</h2>
	<div class="history-table-wrapper">
	    <table class="history-table">
		<tr>
		    <th>Activity</th>
		    <th>Blood Type</th>
		    <th>Date</th>
		    <th>Name</th>
		</tr>
		    <%
			if (list != null) {
			    for (ActivityHistory data : list) {
				String activity = data.getActivity();
				String blood_type = data.getBloodType();
				Date date = data.getDate();
				String name = data.getName();
		    %>
		<tr>
		    <td><%=activity%></td>
		    <td><%=blood_type%></td>
		    <td><%=date%></td>
		    <td><%=name%></td>
		</tr>
		    <%
			    }
			}
		    %>
	    </table>
	</div>
    </div>
</div>

<!-- Requesters Tab -->
<div class="tab-content" id="requesters">
    <div class="card">
	<h2>All Requesters</h2>
	<div class="history-table-wrapper">
	    <table class="history-table">
		<tr>
		    <th>ID</th>
		    <th>Name</th>
		    <th>Email</th>
		    <th>Hospital</th>
		    <th>Phone</th>
		    <th>Actions</th>
		</tr>
		<tr>
		    <td>sfs</td>
		    <td>sfs</td>
		    <td>sfs</td>
		    <td>sfs</td>
		    <td>sfs</td>
		    <td>
			<button class="action-btn edit-btn">Edit</button>
			<button class="action-btn delete-btn">Delete</button>
		    </td>
		</tr>
	    </table>
	</div>
    </div>
</div>

<!-- Donations Tab -->
<div class="tab-content" id="donations">
    <div class="card">
	<h2>All Donations</h2>
	<div class="history-table-wrapper">
	    <table class="history-table">
		<tr>
		    <th>ID</th>
		    <th>Donor</th>
		    <th>Blood Type</th>
		    <th>Date</th>
		    <th>Status</th>
		    <th>Actions</th>
		</tr>
		<tr>
		    <td>sff</td>
		    <td>sfs</td>
		    <td>sfs</td>
		    <td>sfs</td>
		    <td><span class="status pending">pending</span></td>
		    <td>
			<% // if (donationsRs.getString("status").equals("Pending")) {%>
			<!--				    <form action="UpdateDonationServlet" method="post" style="display: inline;">
								<input type="hidden" name="id" value="entah">
								<input type="hidden" name="status" value="Completed">
								<button type="submit" class="action-btn approve-btn">Approve</button>
							    </form>-->
			<% //} %>
			<button class="action-btn delete-btn">Delete</button>
		    </td>
		</tr>
		<% //} %>
	    </table>
	</div>
    </div>
</div>

<!-- Requests Tab -->
<div class="tab-content" id="requests">
    <div class="card">
	<h2>All Blood Requests</h2>
	<div class="history-table-wrapper">
	    <table class="history-table">
		<tr>
		    <th>ID</th>
		    <th>Requester</th>
		    <th>Blood Type</th>
		    <th>Units</th>
		    <th>Date</th>
		    <th>Status</th>
		    <th>Actions</th>
		</tr>
		<tr>
		    <td>sfs</td>
		    <td>sfs</td>
		    <td>sfs</td>
		    <td>sfsf</td>
		    <td>sfs</td>
		    <td><span class="status pending">pending</span></td>
		    <td>
			<% // if (requestsRs.getString("status").equals("Pending")) {%>
			<!--				    <form action="UpdateRequestServlet" method="post" style="display: inline;">
								<input type="hidden" name="id" value="entah">
								<input type="hidden" name="status" value="Served">
								<button type="submit" class="action-btn approve-btn">Serve</button>
							    </form>-->
			<% // } %>
			<button class="action-btn delete-btn">Delete</button>
		    </td>
		</tr>
	    </table>
	</div>
    </div>
</div>
</div>

</body>
</html>