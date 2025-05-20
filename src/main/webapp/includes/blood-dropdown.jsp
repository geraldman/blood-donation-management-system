<%-- 
    Document   : blood-dropdown
    Created on : 18 May 2025, 22.00.27
    Author     : geral
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Blood, dao.BloodDAO, java.util.*" %>
<!DOCTYPE html>
<%
BloodDAO bloodDAO = new BloodDAO();
List<Blood> list = bloodDAO.findNameandID();
for(Blood Blood : list){
    String BloodName = Blood.getName();
    int BloodID = Blood.getId();%>
    <option value="<%=BloodID%>"><%=BloodName%></option>
<%}%>
