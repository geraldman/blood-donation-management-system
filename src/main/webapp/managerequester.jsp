<%-- 
    Document   : managerequester
    Created on : 20 May 2025, 13.31.56
    Author     : geral
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.RequestDAO, model.Requests, dao.BloodDAO, java.util.*"%>

<%
    RequestDAO req = new RequestDAO();
    List<Requests> list = req.findAll();
%>


<!DOCTYPE html>
<html>
    <%@include file="adminheader.jsp"%>
    <div class="admin-tabs">
	<a href="admindashboard.jsp"><div class="admin-tab" >Dashboard</div></a>
	<a href="managedonors.jsp"><div class="admin-tab" >Manage Donors</div></a>
	<a href="managerequester.jsp"><div class="admin-tab active" >Manage Requesters</div></a>
	<a href="managebloodstock.jsp"><div class="admin-tab" >Modify Blood Stock</div></a>
    </div> 
    <div class="tab-content active">
	<div class="card">
	    <h2>All Blood Requests History</h2>
	    <div class="history-table-wrapper">
		<table class="history-table">
		    <tr>
			<th>Requester</th>
			<th>Blood Type</th>
			<th>Req. Amount</th>
			<th>Req. Fulfilled</th>
			<th>Date</th>
			<th>Status</th>
			<th>Actions</th>
		    </tr>
		    <%if (list != null) {
			    for (Requests data : list) {
				int requestID = data.getId();
				String requesterName = data.getUserName();
				String BloodType = data.getBloodName();
				int Amount = data.getQuantity();
				int AmountFulfilled = data.getQuantityFulfilled();
				Date date = data.getRequestDate();
				String status = data.getStatus();
		    %>
		    <tr>
			<td><%=requesterName%></td>
			<td><%=BloodType%></td>
			<td><%=Amount%></td>
			<td><%=AmountFulfilled%></td>
			<td><%=date%></td>
			<td><span class="status <%=status%>"><%=status%></span></td>
			<td>
			    <%if(status.equals("pending")){%>
			    <form action="ServeRequestServlet" method="post" style="display: inline;">
			    <input type="hidden" name="id" value="<%=requestID%>">
			    <input type="hidden" name="status" value="Served">
			    <button type="submit" class="action-btn approve-btn">Serve</button>
			    </form>
			    <form action="CancelRequestServlet" method="post" style="display: inline;">
			    <input type="hidden" name="id" value="<%=requestID%>">
			    <input type="hidden" name="status" value="Cancel">
			    <button type="submit" class="action-btn delete-btn">Cancel</button>
			    </form>
			    <% }
			    else{%>
			    <form action="DeleteRequestServlet" method="post" style="display: inline;">
			    <input type="hidden" name="id" value="<%=requestID%>">
			    <input type="hidden" name="status" value="Cancel">
			    <button type="submit" class="action-btn delete-btn">Delete</button>
			    </form>
			    <%}%>   
			</td>
		    </tr>
		    <%}} %>
		</table>
	    </div>
	</div>
    </div>