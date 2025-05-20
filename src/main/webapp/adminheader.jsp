<%-- 
    Document   : adminheader
    Created on : 20 May 2025, 13.16.25
    Author     : geral
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String AdminName = (String) session.getAttribute("AdminName");
%>

<html>
    <head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>Admin Panel - Blood Donation System</title>
	<link rel="stylesheet" href="css/style.css" />
	<link rel="stylesheet" href="css/login.css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
	<style>
	    .admin-container {
		max-width: 1200px;
		margin: 80px auto;
		padding: 20px;
	    }
	    
	    a{
		color: inherit;
		text-decoration: inherit;
	    }
	    
	    .header-wrapper {
		display: flex;
		justify-content: space-between;
		align-items: center;
	    }

	    .container {
		width: 100%;
		max-width: 1200px;
		margin: 0 auto;
		padding: 0 20px;
	    }

	    .admin-tabs {
		display: flex;
		border-bottom: 1px solid #e0e0e0;
		margin-bottom: 20px;
		align-items: center;
		justify-content: center;
	    }

	    .admin-tab {
		padding: 12px 24px;
		margin-right: 10px;
		cursor: pointer;
		border-bottom: 3px solid transparent;
		font-weight: 600;
	    }

	    .admin-tab.active {
		border-bottom: 3px solid var(--primary);
		color: var(--primary);
	    }

	    .tab-content {
		display: none;
	    }

	    .tab-content.active {
		display: block;
	    }

	    .card {
		background: white;
		border-radius: 10px;
		box-shadow: 0 2px 10px rgba(0,0,0,0.05);
		padding: 20px;
		margin-bottom: 20px;
	    }

	    .stats-grid {
		display: grid;
		grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
		gap: 20px;
		margin-bottom: 30px;
	    }

	    .stat-card {
		background: white;
		border-radius: 10px;
		box-shadow: 0 2px 10px rgba(0,0,0,0.05);
		padding: 20px;
		text-align: center;
	    }

	    .stat-card h3 {
		margin-bottom: 5px;
		font-size: 2rem;
		color: var(--primary);
	    }

	    .stat-card p {
		color: #666;
		margin: 0;
	    }

	    .action-btn {
		padding: 6px 12px;
		border-radius: 6px;
		cursor: pointer;
		font-weight: 600;
		font-size: 0.9rem;
		margin-right: 5px;
	    }

	    .edit-btn {
		background: #f0f7ff;
		color: #0056b3;
		border: 1px solid #0056b3;
	    }

	    .delete-btn {
		background: #fff0f0;
		color: var(--primary);
		border: 1px solid var(--primary);
	    }

	    .approve-btn {
		background: #e8f5e9;
		color: #388e3c;
		border: 1px solid #388e3c;
	    }
	</style>
    </head>
    <body>
	<!-- Navbar Start -->
	<header class="minimal-header">
	    <div class="container">
		<div class="header-wrapper">
		    <div style="display:flex; gap: 12px">
			<a href="index.jsp" class="brand-logo">
			    <i class="fas fa-tint"></i>
			    <span>BloodLife</span>
			</a>
			<h2 style="font-weight: 400;">Admin Panel</h2>
		    </div>
		    <nav class="main-navigation">
			<ul>
			    <li><a href="LogoutServlet">Logout</a></li>
			</ul>
		    </nav>
		    <button class="mobile-menu-button">
			<i class="fas fa-bars"></i>
		    </button>
		</div>
	    </div>
	</header>
	<!-- Navbar End -->
	<div class="admin-container">
	    <h1>Hello, <%=AdminName%></h1>

	    