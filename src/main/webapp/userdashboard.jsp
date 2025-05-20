<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.UsersDAO, java.util.*, dao.DonorDAO"%>

<%
    UsersDAO user = new UsersDAO();
    DonorDAO donor = new DonorDAO();
    String UserName = "Guest";
    int DaysAfterDonor = 0;
    int DonationCount = 0;
    if(session.getAttribute("id") != null){
	int userID = (int) session.getAttribute("id");
	UserName = user.FindNameByID(userID);
	DaysAfterDonor = donor.findDaysSinceLastDonationByID(userID);
	DonationCount = donor.getDonationCountByUser(userID);
    }
    
%>

<!DOCTYPE html>
<html>
    <head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<title>Blood Donation Dashboard</title>
	<link
	    rel="stylesheet"
	    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
	    />
	<style>
	    :root {
		--primary: #dc3545;
		--primary-dark: #c82333;
		--primary-light: #f8d7da;
		--secondary: #6c757d;
		--secondary-dark: #5a6268;
		--success: #28a745;
		--dark: #343a40;
		--light: #f8f9fa;
		--white: #ffffff;
		--shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
		--shadow-lg: 0 10px 15px rgba(0, 0, 0, 0.1);
		--radius: 12px;
	    }

	    * {
		margin: 0;
		padding: 0;
		box-sizing: border-box;
		font-family: "Poppins", "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
	    }

	    body {
		background-color: #f8f9fa;
		min-height: 100vh;
		color: var(--dark);
	    }

	    /* Navbar Styling */
	    .navbar {
		background: linear-gradient(135deg, var(--primary), #e83e8c);
		padding: 1rem 2rem;
		color: white;
		box-shadow: var(--shadow);
		display: flex;
		justify-content: space-between;
		align-items: center;
		position: sticky;
		top: 0;
		z-index: 100;
	    }

	    .navbar h1 {
		font-size: 1.5rem;
		font-weight: 600;
		letter-spacing: 0.5px;
	    }

	    .nav-links {
		display: flex;
		gap: 1.5rem;
	    }

	    .nav-links a {
		color: white;
		text-decoration: none;
		font-weight: 500;
		transition: all 0.3s ease;
		position: relative;
	    }

	    .nav-links a:hover {
		color: var(--light);
	    }

	    .nav-links a::after {
		content: "";
		position: absolute;
		bottom: -5px;
		left: 0;
		width: 0;
		height: 2px;
		background-color: white;
		transition: width 0.3s ease;
	    }

	    .nav-links a:hover::after {
		width: 100%;
	    }

	    /* Container Styling */
	    .container {
		max-width: 1320px;
		margin: 0 auto;
		padding: 0 1.5rem;
		width: 100%;
	    }

	    /* Hero Section */
	    .hero {
		background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),
		    url("https://images.unsplash.com/photo-1615461066841-6116e20a6c04?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80");
		background-size: cover;
		background-position: center;
		color: white;
		padding: 5rem 0;
		text-align: center;
		margin-bottom: 3rem;
		border-radius: 0 0 var(--radius) var(--radius);
	    }

	    .hero-content {
		max-width: 800px;
		margin: 0 auto;
	    }

	    .hero h2 {
		font-size: 2.5rem;
		margin-bottom: 1rem;
		font-weight: 700;
	    }

	    .hero p {
		font-size: 1.25rem;
		margin-bottom: 2rem;
		opacity: 0.9;
	    }

	    /* Stats Section */
	    .stats-container {
		display: flex;
		justify-content: center;
		gap: 2rem;
		margin-bottom: 3rem;
	    }

	    .stat-card {
		background: var(--white);
		padding: 1.5rem;
		border-radius: var(--radius);
		box-shadow: var(--shadow);
		text-align: center;
		transition: all 0.3s ease;
		width: 220px;
	    }

	    .stat-card:hover {
		transform: translateY(-5px);
		box-shadow: var(--shadow-lg);
	    }

	    .stat-card i {
		font-size: 2.5rem;
		color: var(--primary);
		margin-bottom: 1rem;
	    }

	    .stat-card h3 {
		font-size: 2rem;
		font-weight: 700;
		margin-bottom: 0.5rem;
	    }

	    .stat-card p {
		color: var(--secondary);
		font-size: 0.95rem;
	    }

	    /* Dashboard Cards */
	    .dashboard-grid {
		display: grid;
		grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
		gap: 2rem;
		margin-bottom: 3rem;
	    }

	    .dashboard-card {
		background: var(--white);
		padding: 2.5rem;
		border-radius: var(--radius);
		box-shadow: var(--shadow);
		text-align: center;
		transition: all 0.3s ease;
		position: relative;
		overflow: hidden;
		border-top: 5px solid var(--primary);
	    }

	    .dashboard-card::before {
		content: "";
		position: absolute;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		background: linear-gradient(
		    135deg,
		    var(--primary-light) 0%,
		    transparent 100%
		    );
		opacity: 0;
		transition: opacity 0.3s ease;
		z-index: 0;
	    }

	    .dashboard-card:hover::before {
		opacity: 0.4;
	    }

	    .dashboard-card:hover {
		transform: translateY(-10px);
		box-shadow: var(--shadow-lg);
	    }

	    .dashboard-card i {
		font-size: 3rem;
		color: var(--primary);
		margin-bottom: 1.5rem;
		transition: transform 0.3s ease;
	    }

	    .dashboard-card:hover i {
		transform: scale(1.1);
	    }

	    .dashboard-card h3 {
		font-size: 1.5rem;
		font-weight: 600;
		margin-bottom: 1rem;
		position: relative;
		z-index: 1;
	    }

	    .dashboard-card p {
		color: var(--secondary);
		margin-bottom: 1.5rem;
		font-size: 1rem;
		position: relative;
		z-index: 1;
	    }

	    /* Button Styling */
	    .btn {
		display: inline-block;
		padding: 0.9rem 1.8rem;
		border: none;
		border-radius: 50px;
		cursor: pointer;
		font-weight: 600;
		text-decoration: none;
		transition: all 0.3s ease;
		width: 100%;
		margin: 0.5rem 0;
		position: relative;
		z-index: 1;
		overflow: hidden;
		text-transform: uppercase;
		letter-spacing: 1px;
		font-size: 0.9rem;
		box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	    }

	    .btn::before {
		content: "";
		position: absolute;
		top: 0;
		left: -100%;
		width: 100%;
		height: 100%;
		background: rgba(255, 255, 255, 0.2);
		transition: all 0.3s ease;
		z-index: -1;
	    }

	    .btn:hover::before {
		left: 100%;
	    }

	    .btn-primary {
		background: #dc3545;
		color: white;
	    }

	    .btn-primary:hover {
		background: #c82333;
	    }

	    .btn-secondary {
		background: #6c757d;
		color: white;
	    }

	    .btn-secondary:hover {
		background: #5a6268;
	    }

	    .btn-danger {
		background: #dc3545;
		color: white;
		max-width: 200px;
	    }

	    .btn-danger:hover {
		background: #c82333;
	    }

	    /* User Profile */
	    .user-profile {
		display: flex;
		align-items: center;
		gap: 1rem;
		background: var(--white);
		padding: 1.5rem;
		border-radius: var(--radius);
		box-shadow: var(--shadow);
		margin-bottom: 3rem;
	    }

	    .user-avatar {
		width: 80px;
		height: 80px;
		border-radius: 50%;
		overflow: hidden;
		border: 3px solid var(--primary);
	    }

	    .user-avatar img {
		width: 100%;
		height: 100%;
		object-fit: cover;
	    }

	    .user-info {
		flex: 1;
	    }

	    .user-info h3 {
		font-size: 1.5rem;
		margin-bottom: 0.5rem;
	    }

	    .user-info p {
		color: var(--secondary);
		margin-bottom: 0.5rem;
	    }

	    .user-blood-type {
		background: var(--primary);
		color: white;
		padding: 0.5rem 1rem;
		border-radius: 50px;
		font-weight: 600;
		display: inline-block;
	    }

	    /* Footer */
	    .footer {
		background: var(--dark);
		color: var(--light);
		padding: 4rem 0 2rem;
		margin-top: 4rem;
	    }

	    .footer-content {
		display: grid;
		grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
		gap: 2rem;
		margin-bottom: 2rem;
	    }

	    .footer-section h3 {
		font-size: 1.2rem;
		margin-bottom: 1rem;
		color: var(--white);
		position: relative;
		padding-bottom: 0.5rem;
	    }

	    .footer-section h3::before {
		content: "";
		position: absolute;
		left: 0;
		bottom: 0;
		width: 50px;
		height: 2px;
		background: var(--primary);
	    }

	    .footer-links {
		list-style: none;
	    }

	    .footer-links li {
		margin-bottom: 0.5rem;
	    }

	    .footer-links a {
		color: #adb5bd;
		text-decoration: none;
		transition: all 0.3s ease;
	    }

	    .footer-links a:hover {
		color: var(--primary);
		padding-left: 5px;
	    }

	    .social-links {
		display: flex;
		gap: 1rem;
		margin-top: 1rem;
	    }

	    .social-links a {
		display: flex;
		align-items: center;
		justify-content: center;
		width: 40px;
		height: 40px;
		border-radius: 50%;
		background: #343a40;
		color: var(--light);
		transition: all 0.3s ease;
	    }

	    .social-links a:hover {
		background: var(--primary);
		transform: translateY(-3px);
	    }

	    .footer-bottom {
		text-align: center;
		padding-top: 2rem;
		border-top: 1px solid #444;
	    }

	    /* Responsive Design */
	    @media (max-width: 992px) {
		.stats-container {
		    grid-template-columns: repeat(2, 1fr);
		}
	    }

	    @media (max-width: 768px) {
		.navbar {
		    flex-direction: column;
		    gap: 1rem;
		}

		.stats-container {
		    grid-template-columns: 1fr;
		}

		.hero h2 {
		    font-size: 2rem;
		}

		.hero p {
		    font-size: 1rem;
		}

		.user-profile {
		    flex-direction: column;
		    text-align: center;
		}
	    }

	    @media (max-width: 576px) {
		.nav-links {
		    flex-direction: column;
		    gap: 0.5rem;
		}
	    }
	</style>
    </head>
    <body>
	<!-- Navbar -->
	<nav class="navbar">
	    <h1><i class="fas fa-heartbeat"></i> Blood Donation Management System</h1>
	    <div class="nav-links">
		<a href="index.jsp"><i class="fas fa-home"></i> Home</a>
		<a href="login.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
	    </div>
	</nav>

	<!-- Hero Section -->
	<section class="hero">
	    <div class="hero-content">
		<h2>Welcome, <%=UserName%></h2>
		<p>
		    Your contributions can save up to 3 lives with each donation. Thank
		    you for making a difference!
		</p>
	    </div>
	</section>

	<div class="container">
	    <!-- Stats Section -->
	    <div class="stats-container">
		<div class="stat-card">
		    <i class="fas fa-tint"></i>
		    <h3><%=DonationCount%></h3>
		    <p>Donations Made</p>
		</div>

		<div class="stat-card">
		    <i class="fas fa-calendar"></i>
		    <h3><%=DaysAfterDonor%></h3>
		    <p>Days Since Last Donation</p>
		</div>
	    </div>

	    <!-- Dashboard Cards -->
	    <div class="dashboard-grid">
		<div class="dashboard-card">
		    <i class="fas fa-hand-holding-heart"></i>
		    <h3>Donate Blood</h3>
		    <p>
			Help save lives by donating blood and make a real difference in your
			community
		    </p>
		    <button
			class="btn btn-primary"
			onclick="window.location.href = 'donate.jsp'"
			>
			DONATE NOW
		    </button>
		</div>

		<div class="dashboard-card">
		    <i class="fas fa-medkit"></i>
		    <h3>Request Blood</h3>
		    <p>Request blood for patients in need with our streamlined process</p>
		    <button
			class="btn btn-primary"
			onclick="window.location.href = 'request.jsp'"
			>
			MAKE REQUEST
		    </button>
		</div>

		<div class="dashboard-card">
		    <i class="fas fa-history"></i>
		    <h3>Donation History</h3>
		    <p>
			View your past donations and track your contribution to saving lives
		    </p>
		    <button
			class="btn btn-secondary"
			onclick="window.location.href = 'donate-history.jsp'"
			>
			VIEW HISTORY
		    </button>
		</div>

		<div class="dashboard-card">
		    <i class="fas fa-clipboard-list"></i>
		    <h3>Request History</h3>
		    <p>Track your blood requests and their current status</p>
		    <button
			class="btn btn-secondary"
			onclick="window.location.href = 'request-history.jsp'"
			>
			VIEW REQUESTS
		    </button>
		</div>
	    </div>

	    <div style="text-align: center; margin: 3rem auto">
		<button class="btn btn-danger" onclick="window.location.href = 'login.jsp'">
		    <i class="fas fa-sign-out-alt"></i> Logout
		</button>
	    </div>
	</div>

	<!-- Footer -->
	<footer class="footer">
	    <div class="container">
		<div class="footer-content">
		    <div class="footer-section">
			<h3>About Us</h3>
			<p>
			    We are dedicated to connecting blood donors with those in need,
			    helping save lives through efficient blood donation management.
			</p>
			<div class="social-links">
			    <a href="#"><i class="fab fa-facebook-f"></i></a>
			    <a href="#"><i class="fab fa-twitter"></i></a>
			    <a href="#"><i class="fab fa-instagram"></i></a>
			    <a href="#"><i class="fab fa-linkedin-in"></i></a>
			</div>
		    </div>

		    <div class="footer-section">
			<h3>Quick Links</h3>
			<ul class="footer-links">
			    <li><a href="#">Home</a></li>
			    <li><a href="#">Donate Blood</a></li>
			    <li><a href="#">Request Blood</a></li>
			    <li><a href="#">Donation Centers</a></li>
			    <li><a href="#">FAQs</a></li>
			</ul>
		    </div>

		    <div class="footer-section">
			<h3>Contact Us</h3>
			<ul class="footer-links">
			    <li>
				<i class="fas fa-map-marker-alt"></i> 123 Medical Center, City
			    </li>
			    <li><i class="fas fa-phone"></i> +1 234 567 8901</li>
			    <li><i class="fas fa-envelope"></i> info@blooddonation.org</li>
			</ul>
		    </div>
		</div>

		<div class="footer-bottom">
		    <p>
			&copy; 2023 Blood Donation Management System. All rights reserved.
		    </p>
		</div>
	    </div>
	</footer>
    </body>
</html>