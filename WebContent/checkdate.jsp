<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
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
String date=request.getParameter("date");
Class.forName("com.mysql.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3307/proj","root","naman");
String qr="select curdate()";
Statement st=con.createStatement();
ResultSet rs=st.executeQuery(qr);
if(rs.next())
{
	String d1=rs.getString("curdate()");
	if(d1.equals(date))
	{
		int amount=(int) session.getAttribute("amount");
		int sbalance=(int) session.getAttribute("sbalance");
		int rbalance=(int) session.getAttribute("rbalance");
		int snewbalance=sbalance-amount;
		int rnewbalance=amount+rbalance;
		session.setAttribute("snewbalance", snewbalance);
		session.setAttribute("rnewbalance", rnewbalance);
		session.setAttribute("date", date);
		response.sendRedirect("updatesender.jsp");
	}
	else
	{
		RequestDispatcher rd=request.getRequestDispatcher("transferpage.jsp");
		rd.include(request, response);
		out.println("<script>window.alert('Enter Correct Date')</script>");
	}
}
else
{
	RequestDispatcher rd=request.getRequestDispatcher("transferpage.jsp");
	rd.include(request, response);
	out.println("<script>window.alert('Invalid Account No. or Name')</script>");
}con.close();
%>
</body>
</html>