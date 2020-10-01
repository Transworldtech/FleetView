<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% 
	response.setContentType("application/vnd.ms-excel");
	Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
	String showdatex = formatterx.format(new java.util.Date());
	String filename=session.getAttribute("user").toString()+showdatex+"SMS_NDRequestReport.xls";
	response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="../Connections/conn.jsp" %>
<%!
Connection conn, con1;
Statement st,st1,st2,st3;
String date1, date2,datenew1,datenew2,sql,owner,from;
String dateformat;
%>

<body>
<%

try
{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	con1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
	st2=conn.createStatement();
	st3=con1.createStatement();
	//session.setAttribute("reportno","Report No:6.0");
	String  cg= request.getParameter("cg");
			String transporter = request.getParameter("transporter");
			date1 = request.getParameter("date1");

			//out.println("date1--->"+date1);
			date2 = request.getParameter("date2");
//out.println("transporter--->"+transporter);

//session.setAttribute("date1",date1);
//session.setAttribute("date2",date2);
//session.setAttribute("transporter",transporter);
//out.println("date2--->"+date2);
//date1=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date1));
//out.println("date1--->"+date1);
//date2=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date2));
//out.println("date2--->"+date2);
%>
	
	<table width="100%" border="1" align="center" class="sortable">
					<tr>
						<th> <b> Sr. </b></th>
						<th> <b>Vehicle Reg Number</b></th>
						<th> <b>Duration(Hrs)</b></th>
						<th> <b>Sender Name</b></th>
						<th> <b> Mobile Number</b></th>
						<th> <b>Date</b></th>
						<th> <b>Time</b></th>
						<th> <b>Reason</b></th>
						<th> <b>Intimation</b></th>
					</tr>
			
<%
	String sql1 = "SELECT * FROM `t_ndaproved` WHERE Intimation='yes' AND `Transporter` LIKE '"+transporter+"' AND `StoredDate` BETWEEN '"+date1+"'AND '"+date2+"'";
	//System.out.println("I am in IN");
	//System.out.println("sql1--->"+ sql1);
	
			ResultSet rst1 = st2.executeQuery(sql1);
			int count1=1;

			while(rst1.next())
			{
%>
				<tr>
				<td style=" text-align: left"><%= count1++ %></td>
				<td style=" text-align: left"><%= rst1.getString("VehRegNo") %></td>
				<td style=" text-align: left"><%= rst1.getString("Duration") %></td>
				<td style=" text-align: left"><%= rst1.getString("SenderName") %></td>
				<td style=" text-align: left"><%= rst1.getString("MobNo") %></td>
				<td style=" text-align: left"><%= rst1.getString("StoredDate") %></td>
				<td style=" text-align: left"><%= rst1.getString("StoredTime") %></td>
				<td style=" text-align: left"><%= rst1.getString("Reason") %></td>
				<td style=" text-align: left"><%= rst1.getString("Intimation") %></td>
				</tr>
			<%
			}//end of while

			
}catch(Exception e)
			{
				out.println(e);	
			}
	
	%>
	<%@ include file="footernew.jsp" %>
	</table>
</body>

</html>
