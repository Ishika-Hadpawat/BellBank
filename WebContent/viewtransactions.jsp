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
<h1 align="center" style="color:rgb(255,255,255)">Transaction Details</h1><br><hr>
<table class="table table-hover " style="color:rgb(255,255,255);font-size:20px">
    <thead>
      <tr>
        <th>Sender's Account No.</th>
        <th>Receiver's Account No. </th>
        <th>Transferred Amount</th>
        <th>Transfer Date</th>
      </tr>
    </thead>
<%
Class.forName("com.mysql.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3307/proj","root","naman");
String qr="select * from transactions";
Statement st=con.createStatement();
ResultSet rs=st.executeQuery(qr);
if(rs.next())
{
	do
	{
		int sacno=rs.getInt("sacno");
		int racno=rs.getInt("racno");
		int transam=rs.getInt("transam");
		String date=rs.getString("date");
		%>
		<tr><td><%=sacno %></td><td><%=racno %></td><td><%=transam %></td><td><%= date %></td></tr>
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
<form action="index.jsp">
<button class="btn btn-outline-light btn-lg" type="submit" style="margin-left:700px">Close</button>
</form>
</body>
</html>
