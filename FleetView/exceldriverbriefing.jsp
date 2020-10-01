<%@ include file="Connections/conndriver.jsp" %>

<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% response.setContentType("application/vnd.ms-excel");
response.addHeader("Content-Disposition", "attachment;filename=driverbriefing.xls");
%>

<link href="css/css.css" rel="StyleSheet" type="text/css">
<script src="elabel.js" type="text/javascript"></script>
<script src="sorttable.js" type="text/javascript"></script>

<%!
Connection con1, con2;
String driveridjsp="";
String sql24,sql25,sql26;
ResultSet rs24,rs25,rs26;
%>

<% 
try {

 Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
con2 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt1=con1.createStatement(), stmt2=con2.createStatement(), stmt3=con2.createStatement(),stmt4=con2.createStatement();
ResultSet rs1=null, rs2=null, rs3=null, rs4=null, rs5=null, rs6=null, rs7=null, rs8=null, rs9=null, rs10=null, rs11=null, rs12=null, rs13=null, rs14=null, rs15=null, rs16=null;
String sql1="", sql2="", sql3="", sql4="", sql5="", sql6="", sql7="", sql8="", sql9="", sql10="", sql11="", sql12="", sql13="", sql14="", sql15="", sql16="";
String lastmnthdate="", lastsixdate="", riskratingfrmtd="";

String driverid=request.getParameter("driverid");
String drivername=request.getParameter("drivername");

	java.util.Date tdydte = new java.util.Date();
	Format formatter = new SimpleDateFormat("yyyy-MM-dd");
	String tdydte1=formatter.format(tdydte);

NumberFormat nf = DecimalFormat.getNumberInstance();
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);	
nf.setGroupingUsed(false);
	

	sql1="SELECT DATE_SUB('"+tdydte1+"', INTERVAL 30 DAY)";
	rs1=stmt1.executeQuery(sql1);	
	if(rs1.next())	
	{
		lastmnthdate=rs1.getString(1);
	}
	

	sql3="SELECT DATE_SUB('"+tdydte1+"', INTERVAL 180 DAY)";
	rs3=stmt1.executeQuery(sql3);	
	if(rs3.next())	
	{
		lastsixdate=rs3.getString(1);
	}
	
		
%>
	
	<table border="0" class="stats">
	   <tr>
		<td>
		    <table border="0" width="100%">
			<tr>
				<td> <div align="center"> <font color="maroon" size="2"> <B> Driver Briefing / De-Briefing Report</B> </font> </div> </td>
			</tr>
		    </table>		
		   		
		    <table class="stats">
	                   <tr>
				<td valign="top"> 

					<table border="1" width="100%" valign="top">
	                   		    <tr>
						<td> <B> Driver Name </B> </td>
						<td> <%=drivername%>"  </td>
					    </tr>
					     <tr>
						<td> <B> Driver Id</B> </td>
						<td> <%=driverid%> </td>
					    </tr>
					     <tr>
						<td> <B> Training Details </B> </td>
						<td> <textarea name="trngdets" class="formElement"/> </textarea> </td>
					    </tr>	
					 </table>

				     
				</td>

				</tr></table>						
<!-- -------------------- For Last Trip ---------------------------------------------- -->
			<!-- ------------------------Showing all trips done so far (Castrol) ----------------------------- -->
				 <table class="stats">
				   <tr>
					<td align="center"> <font color="maroon" size="2" > <B> Trips done so far</B> <font> </td>
				   </tr>
				    <tr>
					<td> 
	
					 <table class="stats">
				   	   <tr>
						<td> <B> Sr No</B> </td>
						<td> <B> Trip Id</B> </td>
						<td> <B> From</B> </td>
						<td> <B> To</B> </td>
						<td> <B> Distance</B> </td>
						<td> <B> Rating </B> </td> 
					   </tr>
<%
	int i=1;
	sql24="select distinct(JCode) as JCode from t_driver_ds where DCode='"+driverid+"' and JCode <> '-' ";
	rs24=stmt2.executeQuery(sql24);
	while(rs24.next())
	{
		int dist=0, oscnt=0, rdcnt=0, racnt=0,  osduration=0;
		double riskrating=0.0;
		int racalc=0, rdcalc=0, oscalc=0;
		//String tripstdate="", tripenddate="";
		java.util.Date tripstdate=new java.util.Date();
		java.util.Date tripenddate=new java.util.Date();	

		String tripid=rs24.getString("JCode");

		sql25="select sum(Distance) as sumdist, sum(OSCount) as sumos, sum(RDCount) as sumrd, sum(RACount) as sumra, avg(rating) as Rating from t_driver_ds where JCode='"+tripid+"' ";
		rs25=stmt3.executeQuery(sql25);
		if(rs25.next())
		{
			dist=rs25.getInt("sumdist");
			oscnt=rs25.getInt("sumos");
			rdcnt=rs25.getInt("sumrd");
			racnt=rs25.getInt("sumra");
			riskrating=rs25.getDouble("rating");
		} 

		riskratingfrmtd=nf.format(riskrating);	
	
		sql4="select * from t_completedjourney where TripId='"+tripid+"' ";
		rs4=stmt1.executeQuery(sql4);
		if(rs4.next())
		{
			tripstdate=rs4.getDate("StartDate");
			tripenddate=rs4.getDate("EndDate");
			
		}
	
%>
			<tr>	
				<td> <%=i%> </td>
				<td> <%=tripid%> </td>
				<td> <%=new SimpleDateFormat("dd-MMM-yyyy").format(tripstdate)%> </td>
				<td> <%=new SimpleDateFormat("dd-MMM-yyyy").format(tripenddate)%> </td>
				<td> <%=dist%> </td>
				<td> <%=riskratingfrmtd%>  </td>
			</tr>
<%	
	i++;					
	}
%>	
					 </table>


					</td>
					
				   </tr>
				 </table>
	      </tr>
	        <tr>
			<td> <input type="button" name="print" value="Print" onclick="javascript:window.print();" class="formElement"/></td>
		</tr>	
	</table>

<% 

	
} catch(Exception e) { out.println("Exception----->" +e); }
finally
{
con1.close();
}
%>
<table border="1" width="100%">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>

</body>
</html>
