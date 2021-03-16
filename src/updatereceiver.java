

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
 * Servlet implementation class updatereceiver
 */
@WebServlet("/updatereceiver")
public class updatereceiver extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public updatereceiver() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		PrintWriter out=response.getWriter();
		response.setContentType("text/html");
		int rnewbalance=(int)session.getAttribute("rnewbalance");
		int racno=(int)session.getAttribute("racno");
		try
		{
		Class.forName("com.mysql.jdbc.Driver");
		Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3307/proj","root","naman");
		String qr="update account set balance=? where acno=?";
		PreparedStatement ps=con.prepareStatement(qr);
		ps.setInt(1, rnewbalance);
		ps.setInt(2, racno);
		int i=ps.executeUpdate();
		if(i>0)
		{
			RequestDispatcher rd=request.getRequestDispatcher("index.html");	
			rd.include(request, response);
			out.println("<script>window.alert('Transferred Successfully')</script>");
		}
		else
		{
		out.println("No");	
		}
		con.close();
		}catch(Exception e)
		{
			e.printStackTrace();
		}
	}

}
