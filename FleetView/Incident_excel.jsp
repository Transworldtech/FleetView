<!--< %@ page contentType="application/vnd.ms-excel; charset=gb2312" % >-->
<%@ page contentType="application/zip; charset=gb2312" %>

<%@ page import="java.sql.Connection" %>
    <%@ page import="java.sql.DriverManager" import="java.sql.*" import=" java.text.*"%>
    
    <%
    String sp = request.getParameter("sp");
    String theDate = request.getParameter("TheDate");
    String month = request.getParameter("month");
    System.out.println("The month:"+month);
    
    String theDate1=theDate.substring(0,4);
    
    
    System.out.println("The sp i s 1111:"+sp);
    System.out.println("The date is  :"+theDate);
    %>
<% 
	
	String filename=""+sp+"_IncidentReport_"+month+" .xls";
	
filename=filename.replace(" ","_");
response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>

<%!
	Connection conn;
	
	%>


<%

System.out.println("filename =============================== :"+filename);

//System.out.println("filename =============================== :"+filename);


DecimalFormat df = new DecimalFormat("0.00");
Statement st=null;

String MM_dbConn_DRIVER = "org.gjt.mm.mysql.Driver";
String MM_dbConn_GPS = "jdbc:mysql://localhost/db_gps";
String MM_dbConn_USERNAME = "fleetview";
String MM_dbConn_PASSWORD = "1@flv";


		Class.forName(MM_dbConn_DRIVER);
		conn = DriverManager.getConnection(MM_dbConn_GPS,MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
		st = conn.createStatement();
		
%>

<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/graph.js"></SCRIPT>

<%
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>	
<body>

<table border="0" width="750px" bgcolor="#E6E6E6" align="center">
	<tr>
		<td >
			<table border="0" width="100%">
				<tr><td colspan="11" align="center"><font color="black" size="3"><%=sp%>_Incident Report for _<%=month%> <%=theDate1%></font></td></tr>
			</table>
		</td>
	</tr>
</table>		
<br>

<%
String test_from_date = "",test_to_date = "", unit_id = "",idate=""; 

test_from_date = request.getParameter("data") ;
test_to_date = request.getParameter("data1") ;
unit_id = request.getParameter("UnitId") ;

System.out.println("from_date :- "+test_from_date) ;
System.out.println("to_date :- "+test_to_date) ;
System.out.println("unit_id :- "+unit_id) ;


//System.out.println(" from_date"+from_date+" to_date "+to_date +" UnitId"+UnitId);
%>

<%
//System.out.println(">>>>.:");
//System.out.println("srno is" +srno);

try{
	



	System.out.println("if");
	//String from_date = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(test_from_date)) ;
	//String to_date = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(test_to_date)) ;
	String from_date = sp;
	String to_date = theDate ;

%>

<div>
	<table border="0"  class="sortable"  style="width: 65em;text-align: center; margin-left: 210px">
	


	<tr> 
	<th>Sr.No.</th>
	<th>Unit Id</th>
	<th>Vehicle Code</th>
	<th>Date</th>
	<th>Time</th>
	<th>Latitude</th>
	<th>Longitude</th>
	<th>Speed</th>
	<th>Direction Degree</th>
	</tr>
	<%
	
	//from_date="2013-09-23";
	//to_date="2013-09-23";
	
	int i = 1;
	String sql="";

	 sql = "select *, FORMAT(speed,4) as Sp1 from db_gps.t_processincident  where  unitid='"+month+"' and maildatetime>='"+sp+"' and maildatetime<='"+theDate+"' order by maildatetime limit 15000";

	
	DecimalFormat dc = new DecimalFormat("#0.00");
	System.out.println(sql);
	ResultSet rs = st.executeQuery(sql);
	
	//System.out.println(rs);
	boolean flg=false;
	
	
	while(rs.next())
	{
		if(!idate.equalsIgnoreCase(rs.getString("stampdate")))
		{
			flg=false;
		}
			
		
		String UnitId1 = rs.getString("unitid");
		String vehcode = rs.getString("vehcode");
		String lati = rs.getString("lati");
		String longi = rs.getString("longi");
		String TheDate = rs.getString("stampdate");
		String TheTime = rs.getString("stamptime");
		String speed = 	rs.getString("Sp1");
		String dirdig = rs.getString("dirdig");
		 idate = rs.getString("stampdate");
		
		 System.out.println(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(TheDate)));
		 
		 java.util.Date date1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("stampdate")+" "+rs.getString("stamptime"));
	
		
		
		if(flg==false)
		{
		%>
<%-- 		<input type="hidden" name="idate" id="idate" value="< %=TheDate %>"> --%>
		
		<%
		flg=true;
		}
		
		%>
		
		
		<tr>
		<td align="right"><div align="right"><%=i %></div></td>
		<td align="right"><div align="right"><%=UnitId1 %></div></td>
		<td align="right"><div align="right"><%=vehcode %></div></td>
		<td align="right"><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(TheDate)) %></div></td>
		<td align="right"><div align="right"><%=new SimpleDateFormat("HH:mm:ss").format(new SimpleDateFormat("HH:mm:ss").parse(TheTime))  %></div></td>
		
		<%

		%>
		<td align="right"><div align="right"><%=lati %></div></td>
		<td align="right"><div align="right"><%=longi %></div></td>
		<td align="right"><div align="right"><%=speed %></div></td>
		<td align="right"><div align="right"><%=dirdig %></div></td>
	</tr>
		<%
		i++;

	}
	%> 
	</table>
	</div>
<%

}catch(Exception e) 
{
	out.print("Exception "+e);
	e.printStackTrace();
}
 %>	
 
 </table>