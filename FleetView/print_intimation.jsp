<%@ include file="headerprintnew.jsp" %> 
<%@page import="com.fleetview.beans.classes"%>
<%@page import="javax.swing.text.NumberFormatter"%>
 <jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

%>
 <table border="0" width="100%">
<tr ><td>

<%

fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
			
			<table width="100%" align="center" class="sortable">
			<tr>
			<td align="center" class="sorttable_nosort">
			<div align="left"><font size="3">Report No:13.1</font></div>
			<font color="block" size="3" ><b></>SMSReport</b></font>
			
			</td>
			</tr>
			</table>
			<tr><td>
			<script language="javascript">	
  	</script>
  <%!
Connection conn, con1;
Statement st,st1,st2,st3;
String date1, date2,datenew1,datenew2,sql,owner,from;
String dateformat;
%>

<body>
<%
date1=request.getParameter("data");
date2=request.getParameter("data1");
String transporter = request.getParameter("transporter");
//out.println("transporter-->"+transporter);
//out.println("date1--->"+date1);
//out.println("date2--->"+date2);
try
{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	con1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
	st2=conn.createStatement();
	st3=con1.createStatement();
	
//String transporter = request.getParameter("transporter");
//out.println("transporter--->"+transporter);
//date1 = request.getParameter("date1");
String  cg= request.getParameter("cg");
//out.println("cg--->"+cg);
//date2 = request.getParameter("date2");

%>
	
	<table width="100%" border="1" align="center" class="sortable">
					<tr>
						<th> <b> Sr. </b></th>
						<th> <b>Vehicle Reg Number</b></th>
						<th> <b>Duration(Hrs)</b></th>
						<th> <b>Sender Name</b></th>
						<th> <b> Mobile Number</b></th>
						<th> <b>Date-Time</b></th>
						<th> <b>Reason</b></th>
						<th> <b>Intimation</b></th>
					</tr>
			
<%

	
		
		try{
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
						<td style=" text-align: left"><%= rst1.getString("StoredDate") %>  <%= rst1.getString("StoredTime") %></td>
						<td style=" text-align: left"><%= rst1.getString("Reason") %></td>
						<td style=" text-align: left"><%= rst1.getString("Intimation") %></td>
						</tr>
					<%
					}//end of while
		}catch(Exception e)
		{
		 	out.print("Exception::"+e);
		}


			
}catch(Exception e)
			{
				out.println(e);	
			}
	
	%>
	</table>
	</table>
	
</body>
<%@ include file="footernew.jsp" %>
</html>
</jsp:useBean>	