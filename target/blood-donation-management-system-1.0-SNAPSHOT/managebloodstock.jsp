<%-- 
    Document   : managebloodrequests
    Created on : 20 May 2025, 13.32.39
    Author     : geral
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, model.Blood, dao.BloodDAO, java.sql.SQLException"%>

<%
    BloodDAO bloodDAO = new BloodDAO();
    List<Blood> bloodList = bloodDAO.findAll();
    String successMessage1 = null;
    String errorMessage1 = null;
    
%>


<!DOCTYPE html>
<html>
    <%@include file="adminheader.jsp"%>
    <style>
	.btn-icon {
	width: 30px;
	height: 30px;
	border-radius: 50%;
	border: none;
	font-size: 16px;
	font-weight: bold;
	display: flex;
	align-items: center;
	justify-content: center;
	cursor: pointer;
	transition: all 0.2s ease;
    }

    .add-btn {
	background-color: rgba(52, 199, 89, 0.2);
	color: #28a745;
    }

    .add-btn:hover {
	background-color: rgba(52, 199, 89, 0.4);
    }

    .subtract-btn {
	background-color: rgba(255, 59, 48, 0.2);
	color: var(--primary);
    }

    .subtract-btn:hover {
	background-color: rgba(255, 59, 48, 0.4);
    }
    
    .quick-actions {
	display: inline-flex;
	justify-content: center;
	gap: 20px;
	margin-top: 10px;
    }

    .inline-form {
	display: inline;
    }
    
    .blood-stock-tabs {
	display: flex;
	margin-bottom: 20px;
	border-bottom: 1px solid #eee;
    }

    .tab-btn {
	padding: 10px 40px;
	background: none;
	border: none;
	border-bottom: 2px solid transparent;
	color: var(--gray);
	font-weight: 500;
	cursor: pointer;
	transition: all 0.2s ease;
    }

    .tab-btn:hover {
	color: var(--dark);
    }

    .tab-btn.active {
	color: var(--primary);
	border-bottom: 2px solid var(--primary);
    }

    .tab-panel {
	display: none;
    }

    .tab-panel.active {
	display: block;
    }

    @media (max-width: 500px) {
	.blood-stock-tabs {
	    flex-direction: column;
	    border-bottom: none;
	}

	.tab-btn {
	    border-bottom: none;
	    border-left: 2px solid transparent;
	    text-align: left;
	}

	.tab-btn.active {
	    border-bottom: none;
	    border-left: 2px solid var(--primary);
	    background-color: rgba(255, 59, 48, 0.05);
	}
	
	.tab-panel {
	    display: none;
	}

	.tab-panel.active {
	    display: block;
	}
	
	.blood-form {
	    width: 100%;
	    max-width: 600px;
	    margin: 0 auto;
	    padding: 20px 0;
	}

	.form-group {
	    margin-bottom: 25px;
	}

	.form-group label {
	    display: block;
	    margin-bottom: 8px;
	    font-weight: 500;
	    color: var(--dark);
	}

	.form-group input,
	.form-group select {
	    width: 100%;
	    padding: 12px 15px;
	    border: 1px solid #ddd;
	    border-radius: 8px;
	    font-size: 1rem;
	    color: var(--dark);
	    background-color: var(--white);
	}

	.form-group input:focus,
	.form-group select:focus {
	    outline: none;
	    border-color: var(--secondary);
	    box-shadow: 0 0 0 2px rgba(0, 122, 255, 0.2);
	}

	.form-actions {
	    display: flex;
	    justify-content: flex-start;
	    gap: 15px;
	    margin-top: 30px;
	}

    </style>
    <div class="admin-tabs">
        <a href="admindashboard.jsp"><div class="admin-tab">Dashboard</div></a>
        <a href="managedonors.jsp"><div class="admin-tab">Manage Donors</div></a>
        <a href="managerequester.jsp"><div class="admin-tab">Manage Requesters</div></a>
        <a href="managebloodstock.jsp"><div class="admin-tab active">Modify Blood Stock</div></a>
    </div>
    
    <div class="tab-content active">
	<% if (successMessage1 != null) { %>
            <div class="alert success">
                <%= successMessage1 %>
            </div>
        <% } %>
        
        <% if (errorMessage1 != null) { %>
            <div class="alert error">
                <%= errorMessage1 %>
            </div>
        <% } %>
        <div class="card">
            <h2>Current Blood Stock</h2>
            <div class="blood-grid">
                <% 
                if (bloodList != null) {
                    for (Blood blood : bloodList) {
                        String bloodType = blood.getName();
                        int stock = blood.getStock();
                        String modifiedBy = blood.getModifiedByAdminName();
                        String statusClass = "";
                        String statusText = "";
                        
                        if (stock >= 5) {
                            statusClass = "in-stock";
                            statusText = "Available";
                        } else if (stock >= 2) {
                            statusClass = "low-stock";
                            statusText = "Low Stock";
                        } else if (stock == 1) {
                            statusClass = "critical-stock";
                            statusText = "Critical";
                        } else {
                            statusClass = "empty";
                            statusText = "Unavailable";
                        }
                %>
                <div class="blood-card">
                    <div class="blood-type"><%= bloodType %></div>
                    <div class="blood-stock">
                        <span class="stock-number"><%= stock %></span>
                        <span class="stock-unit">bags</span>
                    </div>
                    <div style="margin-bottom: 10px;" class="blood-status <%= statusClass %>"><%= statusText %></div>
                    <% if (modifiedBy != null && !modifiedBy.isEmpty()) { %>
                    <div class="last-modified">Last updated by: <%= modifiedBy %></div>
                    <% } %>
                    <div class="quick-actions">
			<% if (stock > 0) { %>
                        <form action="EditBagServlet" method="post" class="inline-form">
                            <input type="hidden" name="bloodId" value="<%= blood.getId() %>">
                            <input type="hidden" name="operation" value="reduce">
                            <input type="hidden" name="reduceAmount" value="1">
                            <button type="submit" class="btn-icon subtract-btn" title="Remove 1 bag">-</button>
                        </form>
                        <% } %>
                        <form action="EditBagServlet" method="post" class="inline-form">
                            <input type="hidden" name="bloodId" value="<%= blood.getId() %>">
                            <input type="hidden" name="operation" value="add">
                            <input type="hidden" name="addAmount" value="1">
                            <button type="submit" class="btn-icon add-btn" title="Add 1 bag">+</button>
                        </form>
                    </div>
                </div>
                <% 
                    }
                } else {
                    out.println("<div class='no-data'>No blood stock data available</div>");
                }
                %>
            </div>
        </div>
        
        <!-- Manage Blood Stock -->
        <div class="card">
            <h2>Manage Blood Stock</h2>
            <div class="blood-stock-tabs">
                <button class="tab-btn active" data-tab="add-stock"><strong>Add Stock</strong></button>
                <button class="tab-btn" data-tab="reduce-stock"><strong>Reduce Stock</strong></button>
                <button class="tab-btn" data-tab="set-stock"><strong>Set Exact Value</strong></button>
            </div>
            
            <!-- Add Stock Form -->
            <div class="tab-panel active" id="add-stock">
                <form action="EditBagServlet" method="post" class="blood-form">
                    <input type="hidden" name="operation" value="add">
                    
                    <div class="form-group">
                        <label for="bloodId-add">Blood Type:</label>
                        <select id="bloodId-add" name="bloodId" required>
                            <option value="">Select Blood Type</option>
                            <% 
                            if (bloodList != null) {
                                for (Blood blood : bloodList) {
                            %>
                            <option value="<%= blood.getId() %>"><%= blood.getName() %> (Current: <%= blood.getStock() %> bags)</option>
                            <% 
                                }
                            }
                            %>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="addAmount">Amount to Add:</label>
                        <input type="number" id="addAmount" name="addAmount" min="1" value="1" required>
                    </div>
                    
                    <div class="form-actions">
                        <button type="submit" class="btn-primary">Add to Stock</button>
                    </div>
                </form>
            </div>
            
            <!-- Reduce Stock Form -->
            <div class="tab-panel" id="reduce-stock">
                <form action="EditBagServlet" method="post" class="blood-form">
                    <input type="hidden" name="operation" value="reduce">
                    
                    <div class="form-group">
                        <label for="bloodId-reduce">Blood Type:</label>
                        <select id="bloodId-reduce" name="bloodId" required>
                            <option value="">Select Blood Type</option>
                            <% 
                            if (bloodList != null) {
                                for (Blood blood : bloodList) {
                                    if (blood.getStock() > 0) {
                            %>
                            <option value="<%= blood.getId() %>"><%= blood.getName() %> (Available: <%= blood.getStock() %> bags)</option>
                            <% 
                                    }
                                }
                            }
                            %>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="reduceAmount">Amount to Reduce:</label>
                        <input type="number" id="reduceAmount" name="reduceAmount" min="1" value="1" required>
                    </div>
                    
                    <div class="form-actions">
                        <button type="submit" class="btn-primary">Reduce Stock</button>
                    </div>
                </form>
            </div>
            
            <!-- Set Stock Form -->
            <div class="tab-panel" id="set-stock">
                <form action="EditBagServlet" method="post" class="blood-form">
                    <input type="hidden" name="operation" value="set">
                    
                    <div class="form-group">
                        <label for="bloodId-set">Blood Type:</label>
                        <select id="bloodId-set" name="bloodId" required>
                            <option value="">Select Blood Type</option>
                            <% 
                            if (bloodList != null) {
                                for (Blood blood : bloodList) {
                            %>
                            <option value="<%= blood.getId() %>"><%= blood.getName() %> (Current: <%= blood.getStock() %> bags)</option>
                            <% 
                                }
                            }
                            %>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="newStock">New Stock Quantity:</label>
                        <input type="number" id="newStock" name="newStock" min="0" required>
                    </div>
                    
                    <div class="form-actions">
                        <button type="submit" class="btn-primary">Update Stock</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        // Tab switching functionality
        document.addEventListener('DOMContentLoaded', function() {
            const tabButtons = document.querySelectorAll('.tab-btn');
            const tabPanels = document.querySelectorAll('.tab-panel');
            
            tabButtons.forEach(button => {
                button.addEventListener('click', function() {
                    // Remove active class from all buttons and panels
                    tabButtons.forEach(btn => btn.classList.remove('active'));
                    tabPanels.forEach(panel => panel.classList.remove('active'));
                    
                    // Add active class to clicked button
                    button.classList.add('active');
                    
                    // Show corresponding panel
                    const tabId = button.getAttribute('data-tab');
                    document.getElementById(tabId).classList.add('active');
                });
            });
        });
    </script>
</body>
</html>