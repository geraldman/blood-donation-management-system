/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package model;

import java.util.Date;


public class Donors {
    private int    userId;
    private Date   lastDonationDate; // convenience
    private int    bloodId;
    private String bloodName;
    private String username;


    public Donors() { }
    
    public Donors(int userId, Date lastDonationDate, int bloodId) {
        this.userId           = userId;
        this.lastDonationDate = lastDonationDate;
	this.bloodId          = bloodId;
    }

    // core

    public int  getUserId()                { return userId; }
    public void setUserId(int uid)         { this.userId = uid; }

    public int  getBloodId()               { return bloodId; }
    public void setBloodId(int bid)        { this.bloodId = bid; }
    
    public String getBloodName()	    { return bloodName; }
    public void setBloodName(String a)	    { this.bloodName = a; }
    
    public Date getLastDonationDate()      { return lastDonationDate; }
    public void setLastDonationDate(Date d){ this.lastDonationDate = d; }
    
    public String getUsername()		   { return username; }
    public void setUsername(String a)	   { this.username = a;}
    
    // aliases your DonorServlet expects:
    public void setDonorBloodId(int bid)                  { setBloodId(bid); }
    public void setDonorLastDonationDate(java.sql.Date d) { setLastDonationDate(d); }
	    
    public void setDonorUserId(int userId) {
        setUserId(userId);
    }
    public int getDonorUserId() {
        return getUserId();
    }
}
