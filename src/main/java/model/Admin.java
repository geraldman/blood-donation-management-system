/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package model;

public class Admin {
    private int    id;
    private String name;
    private String email;
    private String password;

    public Admin() { }

    public Admin(int id, String name, String email, String password) {
        this.id       = id;
        this.name     = name;
        this.email    = email;
        this.password = password;
    }

    // core
    public int    getId()       { return id; }
    public void   setId(int id) { this.id = id; }

    public String getName()           { return name; }
    public void   setName(String n)   { this.name = n; }

    public String getEmail()            { return email; }
    public void   setEmail(String e)    { this.email = e; }

    public String getPassword()             { return password; }
    public void   setPassword(String pwd)   { this.password = pwd; }

    // servlet aliases
    public int    getAdminId()        { return id; }
    public void   setAdminId(int id)  { this.id = id; }

    public String getAdminName()          { return name; }
    public void   setAdminName(String n)  { this.name = n; }

    public String getAdminEmail()           { return email; }
    public void   setAdminEmail(String e)   { this.email = e; }

    public String getAdminPassword()            { return password; }
    public void   setAdminPassword(String pwd) { this.password = pwd; }
}
