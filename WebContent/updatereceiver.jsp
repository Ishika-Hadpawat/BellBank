<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
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
int rnewbalance=(int)session.getAttribute("rnewbalance");
int racno=(int)session.getAttribute("racno");
Class.forName("com.mysql.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3307/proj","root","naman");
String qr="update account set balance=? where acno=?";
PreparedStatement ps=con.prepareStatement(qr);
ps.setInt(1, rnewbalance);
ps.setInt(2, racno);
int i=ps.executeUpdate();
if(i>0)
{
	response.sendRedirect("InsertTrans.jsp");
}
else
{
out.println("No");	
}
con.close();
%>
</body>
</html>