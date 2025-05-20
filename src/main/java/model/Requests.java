/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package model;
import java.sql.Date;

public class Requests {
    private int    id;
    private int    userId;
    private int    bloodId;
    private int    quantity;
    private int	   quantity_fulfilled;
    private Date   request_date;
    private String status;
    private String userName;   // convenience
    private String bloodName;  // convenience

    public Requests() { }
    
    public Requests(String bloodname, int quantity, int quantity_fulfilled, Date date,String status){
	this.bloodName = bloodname;
	this.quantity = quantity;
	this.quantity_fulfilled = quantity_fulfilled;
	this.request_date = date; 
	this.status = status;
    }
    
    public Requests(int id, int userId, int bloodId, int quantity, int quantity_fulfilled, Date date, String status) {
        this.id       = id;
        this.userId   = userId;
        this.bloodId  = bloodId;
        this.quantity = quantity;
	this.quantity_fulfilled = quantity_fulfilled;
	this.request_date = date;
        this.status   = status;
    }

    // core
    public int    getId()       { return id; }
    public void   setId(int i)  { this.id = i; }

    public int    getUserId()          { return userId; }
    public void   setUserId(int u)     { this.userId = u; }

    public int    getBloodId()             { return bloodId; }
    public void   setBloodId(int b)        { this.bloodId = b; }

    public int    getQuantity()         { return quantity; }
    public void   setQuantity(int q)    { this.quantity = q; }
    
    public int	  getQuantityFulfilled()	{ return quantity_fulfilled; }
    public void	  setQuantityFulfilled(int a)	{ this.quantity_fulfilled = a; }
    
    public Date	  getRequestDate()		{ return request_date;}
    public void	  setRequestDate(Date d)	{ this.request_date = (d!=null) ? d : new Date(System.currentTimeMillis());}
    
    public String getStatus()           { return status; }
    public void   setStatus(String s)   { this.status = s; }

    public String getUserName()              { return userName; }
    public void   setUserName(String un)     { this.userName = un; }

    public String getBloodName()             { return bloodName; }
    public void   setBloodName(String bn)    { this.bloodName = bn; }

    // aliases your RequestServlet expects:
    public void setRequesterBloodId(int b)       { setBloodId(b); }
    public void setRequestedBloodQuantity(int q) { setQuantity(q); }
    public void setRequestStatus(String s)       { setStatus(s); }
    public void setRequestedBloodFulfilled(int a)	 { setQuantityFulfilled(a); }
    
    public void setRequesterId(int userId) {
        this.setUserId(userId);
    }
    public int getRequesterId() {
        return this.getUserId();
    }
    
}
