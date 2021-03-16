<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
int snewbalance=(int)session.getAttribute("snewbalance");
int sacno=(int)session.getAttribute("sacno");
Class.forName("com.mysql.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3307/proj","root","naman");
String qr="update account set balance=? where acno=?";
PreparedStatement ps=con.prepareStatement(qr);
ps.setInt(1, snewbalance);
ps.setInt(2, sacno);
int i=ps.executeUpdate();
if(i>0)
{
	response.sendRedirect("updatereceiver.jsp");	
}
else
{
out.println("No");	
}
%>con.close();
</body>
</html>