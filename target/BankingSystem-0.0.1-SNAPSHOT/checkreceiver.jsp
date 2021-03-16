<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
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
String acno=request.getParameter("acno");
String rhname=request.getParameter("hname");
String am=request.getParameter("amount");
int amount=Integer.parseInt(am);
String date=request.getParameter("date");
int racno=Integer.parseInt(acno);
Class.forName("com.mysql.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3307/proj","root","naman");
String qr="select * from account where acno=?";
PreparedStatement ps=con.prepareStatement(qr);
ps.setInt(1, racno);
ResultSet rs=ps.executeQuery();
if(rs.next())
{
	String hname=rs.getString("hname");
	int rbalance=rs.getInt("balance");
	if(rhname.equals(hname))
	{
		int sbalance=(int) session.getAttribute("sbalance");
		if(amount<=sbalance)
		{
			session.setAttribute("amount", amount);
			session.setAttribute("racno", racno);
			session.setAttribute("rbalance", rbalance);
			response.sendRedirect("checkdate.jsp?date="+date+"");
		}
		else
		{
			RequestDispatcher rd=request.getRequestDispatcher("transferpage.jsp");
			rd.include(request, response);
			out.println("<script>window.alert('Not Sufficient Balance')</script>");
		}
	}
	else
	{
		RequestDispatcher rd=request.getRequestDispatcher("transferpage.jsp");
		rd.include(request, response);
		out.println("<script>window.alert('Invalid Account No. or Name')</script>");
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