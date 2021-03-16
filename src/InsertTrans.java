

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class InsertTrans
 */
@WebServlet("/InsertTrans")
public class InsertTrans extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InsertTrans() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PrintWriter out=response.getWriter();
		response.setContentType("text/html");
		HttpSession session=request.getSession();
		int sacno=(int) session.getAttribute("sacno");
		int racno=(int) session.getAttribute("racno");
		int amount=(int) session.getAttribute("amount");
		String date=(String) session.getAttribute("date");
		try
		{
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
		
	}catch(Exception e)
		{
		e.printStackTrace();
	}

	}
}
