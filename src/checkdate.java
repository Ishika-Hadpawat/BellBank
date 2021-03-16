import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class checkdate
 */
@WebServlet("/checkdate")
public class checkdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public checkdate() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out=response.getWriter();
		response.setContentType("text/html");
		String date=request.getParameter("date");
		HttpSession session=request.getSession();
		try {
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
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	}

