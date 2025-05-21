<%-- 
    Document   : dropdown-alert.
    Created on : 21 May 2025, 21.29.19
    Author     : geral
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%
    String successMessage = request.getParameter("success");
    if(successMessage != null){
        session.removeAttribute("success");
        if(successMessage.equals("1")){
            successMessage = "Blood successfully served!";
        } 
	else if(successMessage.equals("2")){
            successMessage = "Donation successfully added!";
        }
%>
    <div id="Dropdown" class="dropdown-alert success show">
        <%= successMessage %>
    </div>
        
<% } %>

<%
    String errorMessage = request.getParameter("error");
    if(errorMessage != null){
        session.removeAttribute("error");
	if(errorMessage.equals("NotEnoughStock")){
	    errorMessage = "Stock not enough to be served!";
	}
%>
    <div id="Dropdown" class="dropdown-alert error show">
        <%= errorMessage %>
    </div>
        
<% } %>

<style>
    .dropdown-alert{
        position: fixed;
        top: 20px;
        left: 50%;
        transform: translateX(-50%);
        padding: 12px 24px;
        border-radius: 10px;
        font-weight: 600;
        font-size: 14px;
        border: 2px solid;
        text-align: center;
        z-index: 9999;
	opacity: 0;
	visibility: hidden;
        transition: opacity 0.5s, visibility 0.5s;
    }

    .dropdown-alert.show{
	visibility: visible;
	opacity: 1;
        display: block;
    }

    .dropdown-alert.success{
        background-color: #f0fff4;
        color: #2e7d32;
        border-color: #2e7d32;
    }

    .dropdown-alert.error{
        background-color: #fff0f0;
        color: #d32f2f;
        border-color: #d32f2f;
    }
</style>

<script>
    window.onload = function(){
	console.log("Dropdown script loaded");
	const alert = document.getElementById('Dropdown');
	if(alert){
	    setTimeout(() => {
		alert.classList.remove('show');
	    }, 3000); // Hide after 3 seconds
	}
    };
</script>