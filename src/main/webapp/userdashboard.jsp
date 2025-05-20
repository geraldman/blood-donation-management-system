<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<title>Blood Donation Dashboard</title>
	<style>
	    * {
		margin: 0;
		padding: 0;
		box-sizing: border-box;
		font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
	    }

	    body {
		background-color: #f5f5f5;
		min-height: 100vh;
	    }

	    .navbar {
		background-color: #dc3545;
		padding: 1rem 2rem;
		color: white;
		box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	    }

	    .navbar h1 {
		font-size: 1.5rem;
		font-weight: 600;
	    }

	    .container {
		max-width: 1200px;
		margin: 2rem auto;
		padding: 0 1rem;
	    }

	    .dashboard-grid {
		display: grid;
		grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
		gap: 1.5rem;
		margin-top: 2rem;
	    }

	    .dashboard-card {
		background: white;
		padding: 2rem;
		border-radius: 10px;
		box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
		text-align: center;
		transition: transform 0.3s ease;
	    }

	    .dashboard-card:hover {
		transform: translateY(-5px);
	    }

	    .btn {
		display: inline-block;
		padding: 0.8rem 1.5rem;
		border: none;
		border-radius: 5px;
		cursor: pointer;
		font-weight: 500;
		text-decoration: none;
		transition: background-color 0.3s ease;
		width: 100%;
		margin: 0.5rem 0;
	    }

	    .btn-primary {
		background-color: #dc3545;
		color: white;
	    }

	    .btn-primary:hover {
		background-color: #c82333;
	    }

	    .btn-secondary {
		background-color: #6c757d;
		color: white;
	    }

	    .btn-secondary:hover {
		background-color: #5a6268;
	    }

	    .btn-danger {
		background-color: #dc3545;
		color: white;
	    }

	    .btn-danger:hover {
		background-color: #c82333;
	    }

	    .welcome-message {
		text-align: center;
		margin: 2rem 0;
		color: #333;
	    }
	</style>
    </head>
    <body>
	<!-- Navbar -->
	<nav class="navbar">
	    <h1>Blood Donation Management System</h1>
	</nav>

	<div class="container">
	    <div class="welcome-message">
		<h2>Welcome to Your Dashboard</h2>
		<p>Manage your blood donation activities here</p>
	    </div>

	    <div class="dashboard-grid">
		<div class="dashboard-card">
		    <h3>Donate Blood</h3>
		    <p>Help save lives by donating blood</p>
		    <button
			class="btn btn-primary"
			onclick="window.location.href = 'donate.jsp'"
			>
			Donate Now
		    </button>
		</div>

		<div class="dashboard-card">
		    <h3>Request Blood</h3>
		    <p>Request blood for patients in need</p>
		    <button
			class="btn btn-primary"
			onclick="window.location.href = 'request.jsp'"
			>
			Make Request
		    </button>
		</div>

		<div class="dashboard-card">
		    <h3>Donation History</h3>
		    <p>View your past donations</p>
		    <button
			class="btn btn-secondary"
			onclick="window.location.href = 'donate-history.jsp'"
			>
			View History
		    </button>
		</div>

		<div class="dashboard-card">
		    <h3>Request History</h3>
		    <p>Track your blood requests</p>
		    <button
			class="btn btn-secondary"
			onclick="window.location.href = 'request-history.jsp'"
			>
			View Requests
		    </button>
		</div>
	    </div>

	    <div style="text-align: center; margin-top: 2rem">
		<button class="btn btn-danger" onclick="window.location.href='LogoutServlet';">Logout</button>
	    </div>
	</div>
    </body>
</html>