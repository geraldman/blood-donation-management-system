/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package model;

public class Blood {
    private int    id;
    private String name;
    private int    stock;
    private int    modifiedByAdminId;
    private String modifiedByAdminName; // convenience

    public Blood() { }

    public Blood(int id, String name, int stock, int modifiedByAdminId, String modifiedByAdminName) {
        this.id                  = id;
        this.name                = name;
        this.stock               = stock;
        this.modifiedByAdminId   = modifiedByAdminId;
        this.modifiedByAdminName = modifiedByAdminName;
    }
    
    public int    getId()                    { return id; }
    public void   setId(int id)              { this.id = id; }

    public String getName()                  { return name; }
    public void   setName(String name)       { this.name = name; }

    public int    getStock()                 { return stock; }
    public void   setStock(int stock)        { this.stock = stock; }

    public int    getModifiedByAdminId()     { return modifiedByAdminId; }
    public void   setModifiedByAdminId(int i){ this.modifiedByAdminId = i; }

    public String getModifiedByAdminName()           { return modifiedByAdminName; }
    public void   setModifiedByAdminName(String nm)  { this.modifiedByAdminName = nm; }

    public void setInt(int aInt) {
	throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
    
}
