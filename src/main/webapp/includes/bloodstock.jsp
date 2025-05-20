<%-- 
    Document   : bloodstock
    Created on : 13 May 2025, 22.48.21
    Author     : geral
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, model.Blood, dao.BloodDAO, java.sql.SQLException"%>

<%
    BloodDAO bloodDAO = new BloodDAO();
    List<Blood> bloodStocks = null;
    try {
        bloodStocks = bloodDAO.findNameandStock();
        request.setAttribute("BloodStocks", bloodStocks);
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>

<div class="blood-grid">
<%
    List<Blood> BloodStocks = (List<Blood>) request.getAttribute("BloodStocks");
    if(BloodStocks != null){			
	for(Blood stock : BloodStocks){
	    String bloodtype = stock.getName();
	    int amount = stock.getStock();
	    String statusClass = "";
	    String statusText = "";

	    if(amount >=5){
		statusClass = "in-stock";
		statusText = "Available";				
	    }
	    else if(amount >=2){
		statusClass = "low-stock";
		statusText = "Low Stock";
	    }
	    else if(amount == 1){
		statusClass = "critical-stock";
		statusText = "Critical";
	    }
	    else{
		statusClass = "empty";
		statusText = "Unavailable";
	    }
	    %>
    <div class="blood-card">
	<div class="blood-type"><%=bloodtype%></div>
	    <div class="blood-stock">
		<span class="stock-number"><%=amount%></span>
		<span class="stock-unit">bags</span>
	    </div>
	<div class="blood-status <%=statusClass%>"><%=statusText%></div>
    </div>
    <%}}
    else{
	out.println("No blood stock detected");
    }
%>