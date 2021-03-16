

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class CheckReceiver
 */
@WebServlet("/CheckReceiver")
public class CheckReceiver extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckReceiver() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out=response.getWriter();
		response.setContentType("text/html");
		String acno=request.getParameter("acno");
		String rhname=request.getParameter("hname");
		String am=request.getParameter("amount");
		int amount=Integer.parseInt(am);
		String date=request.getParameter("date");
		int racno=Integer.parseInt(acno);
		HttpSession session=request.getSession();
		try {
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
						response.sendRedirect("checkdate?date="+date+"");
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
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
