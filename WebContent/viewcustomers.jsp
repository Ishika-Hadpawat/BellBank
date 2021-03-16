<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<html>
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body style="background-color:rgb(22, 29, 50);font-family:courier">
<h1 align="center" style="color:rgb(255,255,255)">Customer Details</h1><hr>
<table class="table table-hover " style="color:rgb(255,255,255);font-size:20px">
    <thead>
      <tr>
        <th>Account No.</th>
        <th>Account Holder's Name</th>
        <th>Account Balance</th>
        <th>Transfer</th>
      </tr>
    </thead>
<%
Class.forName("com.mysql.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3307/proj","root","naman");
String qr="select * from account";
Statement st=con.createStatement();
ResultSet rs=st.executeQuery(qr);
if(rs.next())
{
	do
	{
		int acno=rs.getInt("acno");
		String hname=rs.getString("hname");
		int balance=rs.getInt("balance");
		%>
		<tr><td><%=acno %></td><td><%=hname %></td><td><%=balance %></td><td><a class="btn btn-info btn-lg" href="transferpage.jsp?acno=<%= acno %>&balance=<%= balance %>" role="button" style="color:rgb(0,0,0);">Transfer Money</a></td></tr>
		<%
	}while(rs.next());
}
else
{
out.println("No Users Available");	
}
con.close();
%>
</table><br><br>
<form action="index.html">
<button class="btn btn-outline-light btn-lg" type="submit" style="margin-left:700px">Close</button>
</form>
</body>
</html>
