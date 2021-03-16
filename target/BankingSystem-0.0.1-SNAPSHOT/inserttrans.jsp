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
int sacno=(int) session.getAttribute("sacno");
int racno=(int) session.getAttribute("racno");
int amount=(int) session.getAttribute("amount");
String date=(String) session.getAttribute("date");
Class.forName("com.mysql.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3307/proj","root","naman");
String qr="insert into transactions value(?,?,?,?)";
PreparedStatement ps=con.prepareStatement(qr);
ps.setInt(1, sacno);
ps.setInt(2, racno);
ps.setString(3, date);
ps.setInt(4, amount);
int i=ps.executeUpdate();
if(i>0)
{
	RequestDispatcher rd=request.getRequestDispatcher("index.html");	
	rd.include(request, response);
	out.println("<script>window.alert('Transaction Successful')</script>");
}
else
{
	RequestDispatcher rd=request.getRequestDispatcher("index.html");	
	rd.include(request, response);
	out.println("<script>window.alert('Transaction failed')</script>");
}
%>
</body>
</html>