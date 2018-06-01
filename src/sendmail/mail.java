package sendmail;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class mail
 */
@WebServlet("/mail")
public class mail extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public mail() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String fileformat = request.getParameter("datatype");
		String time = request.getParameter("date");
		String file = request.getParameter("filename");
		String size = request.getParameter("size");

		PrintWriter out = response.getWriter();

		HttpSession session = request.getSession();
		String user = (String) session.getAttribute("user");

		try {
			Connection con = null;
			String table = "";
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			con = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/cloudstorage", "root",
					"");
			Statement stmt1 = con.createStatement();
			String sql1 = "SELECT * from data where user='"
					+ session.getAttribute("user") + "' and fileformat='"
					+ fileformat + "'";

			ResultSet rs1 = stmt1.executeQuery(sql1);
			if (rs1.next()) {
				String key = rs1.getString("deckey");

				String sql = "SELECT emailid from user where username='" + user
						+ "'";
				ResultSet rs = stmt1.executeQuery(sql);
				if (rs.next()) {
					String mail = rs.getString("emailid");
					System.out.print(user);
					System.out.print(mail);
					String msg = "you decription key for file " + file + " is "
							+ key;

					SimpleSendEmail send = new SimpleSendEmail(
							"inboticstesting0@gmail.com",mail, "key", msg,
							"inboticstesting");

					request.getRequestDispatcher(
							"filedecrypt.jsp?filename=" + file + "&size="
									+ size + "&date=" + time + "&datatype="
									+ fileformat + "").include(request,
							response);

					out.println("<script type=\"text/javascript\">");
					out.println("alert('Decryption key send to your mail id please check you mail id');");
					out.println("</script>");
				}
			}
		} catch (Exception e) {
System.out.print(e);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
