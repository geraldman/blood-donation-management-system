<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, model.Blood"%>

<!DOCTYPE html>
<html>
    <head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>BloodLife | Modern Blood Donation</title>
	<link rel="stylesheet" href="css/style.css" />
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
	<!-- Minimalist Header -->
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
				<% if (session.getAttribute("user") != null) { %>
			    <li><a href="userdashboard.jsp">Dashboard</a></li>
				<% } %>
			</ul>
		    </nav>
		    <div class="header-actions">
			<% if (session.getAttribute("user") == null) { %>
			<a href="login.jsp" class="text-button">Sign In</a>
			<a href="register.jsp" class="primary-button">Register</a>
			<% } else { %>
			<a href="userdashboard.jsp" class="text-button">My Dashboard</a>
			<a href="logout.jsp" class="primary-button">Logout</a>
			<% }%>
		    </div>
		    <button class="mobile-menu-button">
			<i class="fas fa-bars"></i>
		    </button>
		</div>
	    </div>
	</header>

	<!-- Hero Section -->
	<section class="minimal-hero">
	    <div class="container">
		<div class="hero-content">
		    <h1>Give Blood.<br />Save Lives.</h1>
		    <p class="hero-subtext">
			Join our community of donors and help save thousands of lives every
			year through simple blood donation.
		    </p>
		    <div class="hero-cta">
			<a href="donate.jsp" class="primary-button large">Donate Now</a>
			<a href="request.jsp" class="secondary-button large"
			   >Request Blood</a
			>
		    </div>
		</div>
		<div class="hero-image">
		    <img src="images/blood.png" alt="Blood donation illustration" />
		</div>
	    </div>
	</section>

	<!-- How It Works -->
	<section class="minimal-process">
	    <div class="container">
		<h2 class="section-title">How It Works</h2>
		<div class="process-steps">
		    <div class="step">
			<div class="step-icon">1</div>
			<h3>Register</h3>
			<p>Create your profile in minutes</p>
		    </div>
		    <div class="step">
			<div class="step-icon">2</div>
			<h3>Donate</h3>
			<p>Visit a nearby donation center</p>
		    </div>
		    <div class="step">
			<div class="step-icon">3</div>
			<h3>Save Lives</h3>
			<p>Your blood helps those in need</p>
		    </div>
		</div>
	    </div>
	</section>

	<!-- Blood Availability Section -->
	<section class="blood-availability">
	    <div class="container">
		<h2 class="section-title">Blood Type Availability</h2>
		<p class="section-subtitle">Current stock levels in our blood bank</p>

		<!-- Blood Stock jsp section -->
		<%@ include file="includes/bloodstock.jsp"%>

		<div class="blood-legend">
		    <div class="legend-item">
			<span class="legend-color in-stock"></span>
			<span class="legend-text">Available (5+ bags)</span>
		    </div>
		    <div class="legend-item">
			<span class="legend-color low-stock"></span>
			<span class="legend-text">Low Stock (1-4 bags)</span>
		    </div>
		    <div class="legend-item">
			<span class="legend-color critical-stock"></span>
			<span class="legend-text">Critical (1 bag)</span>
		    </div>
		</div>

		<div class="blood-notice">
		    <i class="fas fa-exclamation-circle"></i>
		    <p>
			When stock reaches 1 bag, please consider donating to help save
			lives.
		    </p>
		</div>
	    </div>
	</section>

	<script src="js/main.js"></script>
    </body>
</html>
