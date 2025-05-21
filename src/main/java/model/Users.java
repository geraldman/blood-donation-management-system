/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package model;

public class Users{
    private int    id;
    private String name;
    private String email;
    private String password;

    public Users() { }

    public Users(int id, String name, String email, String password) {
        this.id       = id;
        this.name     = name;
        this.email    = email;
        this.password = password;
    }
    
    public Users(String name, String email, String password) {
        this.name     = name;
        this.email    = email;
        this.password = password;
    }

    
    // core getters/setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    // aliases your servlets use:
    public int    getUserId()       { return id; }
    public void   setUserId(int id) { this.id = id; }

    public String getUserName()         { return name; }
    public void   setUserName(String n) { this.name = n; }

    public String getUserEmail()           { return email; }
    public void   setUserEmail(String e)   { this.email = e; }

    public String getUserPassword()            { return password; }
    public void   setUserPassword(String pwd)  { this.password = pwd; }
}
