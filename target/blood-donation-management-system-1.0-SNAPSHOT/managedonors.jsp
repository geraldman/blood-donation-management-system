<%-- 
    Document   : managedonors
    Created on : 20 May 2025, 13.15.05
    Author     : geral
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.DonorDAO, dao.BloodDAO, dao.UsersDAO, model.Donors, java.util.*"%>

<%
    DonorDAO donor = new DonorDAO();
    BloodDAO blood = new BloodDAO();
    UsersDAO user = new UsersDAO();
    List<Donors> donorList = donor.getAllDonationHistory();
%>

<!DOCTYPE html>
<html>
    <%@include file="adminheader.jsp"%>
    <div class="admin-tabs">
	<a href="admindashboard.jsp"><div class="admin-tab" >Dashboard</div></a>
	<a href="managedonors.jsp"><div class="admin-tab active" >Manage Donors</div></a>
	<a href="managerequester.jsp"><div class="admin-tab" >Manage Requesters</div></a>
	<a href="managebloodstock.jsp"><div class="admin-tab" >Modify Blood Stock</div></a>
    </div> 
    <div id="donors">
	<div class="card">
	    <h2>All Donors History</h2>
	    <div class="history-table-wrapper">
		<table class="history-table">
		    <tr>
			<th>Name</th>
			<th>Date of Donor</th>
			<th>Blood Type</th>
			<th>Actions</th>
		    </tr>
		    <%	if (donorList != null) {
			    for (Donors data : donorList) {
				int user_id = data.getUserId();
				String username = user.FindNameByID(user_id);
				Date date = data.getLastDonationDate();
				String bloodname = data.getBloodName();
		    %>
		    <tr>
			<td><%=username%></td>
			<td><%=date%></td>
			<td><%=bloodname%></td>
			<td>
			    <button class="action-btn delete-btn" onclick="confirmDeletion(<%=user_id%>, '<%=date%>')">Delete</button>
			</td>
		    </tr>
		    <%}
			}
		    %>

		</table>
	    </div>
	</div>
    </div>
    <script>
	function confirmDeletion(userId, donationDate) {
	    const confirmed = confirm("Are you sure you want to delete this donor?");
	    if (confirmed) {
		window.location.href = "DeleteDonorServlet?id=" + userId + "&date=" + encodeURIComponent(donationDate);
	    }
	}
    </script>

