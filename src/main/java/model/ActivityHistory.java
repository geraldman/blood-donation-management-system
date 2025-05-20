/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package model;

import java.sql.Date;

public class ActivityHistory{
    private String activity;
    private String bloodType;
    private Date date;
    private String name;
    
    public ActivityHistory(String activity, String type, Date date, String name){
	this.activity = activity;
	this.bloodType = type;
	this.date = date;
	this.name = name;
    }
    
    public String getActivity(){
        return activity;
    }

    public void setActivity(String activity){
        this.activity = activity;
    }

    // Getter and Setter for bloodType
    public String getBloodType(){
        return bloodType;
    }

    public void setBloodType(String bloodType){
        this.bloodType = bloodType;
    }

    // Getter and Setter for date
    public Date getDate(){
        return date;
    }

    public void setDate(Date date){
        this.date = date;
    }

    // Getter and Setter for name
    public String getName(){
        return name;
    }

    public void setName(String name){
        this.name = name;
    }
}
    
   