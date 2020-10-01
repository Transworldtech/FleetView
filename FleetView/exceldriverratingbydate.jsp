<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());

String filename=session.getAttribute("user").toString()+showdatex+"driver_rating_by_date.xls";
    response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="Connections/conn.jsp" %>

<%!
Connection connnew,conn1;
Statement st, st1, st2,st3,st4,st5;
String user,sql,sql1,sql2;
String data1, data2,showdate1,showdate,DriverName,Owner,datenew1,datenew2,Transporter;
String DriverID;
%>
<%
int OScount, RAcount, RDcount,Distance;
double Rating;
boolean flag;

//NumberFormat nf=DecimalFormat.getInstance();

int JCode,VehCode,distance,OSduration,RAcnt=0,RDcnt=0,OScnt=0,Distcnt=0,dailyctr=0,weeklyctr=0,alldailyctr=0,allweeklyctr=0;
double rating;
//double a,b,c;
double ctr=0.0;
double d=0.0;

String ll="";


 %>
<%

NumberFormat nf = DecimalFormat.getInstance();
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2); 

data1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data1")));
data2=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data2")));
datenew1=request.getParameter("data1");
datenew2=request.getParameter("data2");
//System.out.println("datenew1::>>>>"+datenew1);
//System.out.println("datenew2::>>>>"+datenew2);
Transporter=session.getAttribute("usertypevalue").toString();
//System.out.println("Transporter");

try{
	Class.forName(MM_dbConn_DRIVER); 
	connnew = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=connnew.createStatement();
	st1=connnew.createStatement();
	st2=connnew.createStatement();
	st3=connnew.createStatement();
	st4=connnew.createStatement();
	st5=connnew.createStatement();
	
%>
<table border="1" width="90%" bgcolor="white" align="center">

<tr><td colspan="9" align="center"><font size="3"><b>Driver Rating Report for Transporter <%= Transporter%> From <%=datenew1%> to <%=datenew2%>. </b></font>
</td></tr>
 </table>
 <br>
 <table border="1" width="100%" bgcolor="white" class="sortable">
<tr>
<td class="hed"><b>SR.</b></td>
<td class="hed"><b>Driver Name</b></td>
<td class="hed"><b>Driver Code</b></td>
<td class="hed"><b>Transporter</b></td>
<td class="hed"><b>OS Duration</b></td>
<td class="hed"><b>RA Count</b></td>
<td class="hed"><b>RD Count</b></td>
<td class="hed"><b>Distance</b></td>
<td class="hed"><b>Daily CD Violation</b></td>
<td class="hed"><b>Weekly CD Violation</b></td>
<td class="hed"><b>Rating</b></td>
</tr>
<%
String DriverIdlist="(";

sql="SELECT sum( RACount ) AS RAcount, sum( RDCount ) AS RDcount, sum( OSDuration ) AS OSDuration, DriverID, DriverName, OwnerName, Sum( KmTravelled ) AS Distance FROM t_completedjourney WHERE StartDate >= '"+data1+"' AND StartDate <= '"+data2+"' AND (OwnerName LIKE '"+session.getAttribute("usertypevalue").toString()+"' OR GPName LIKE '"+session.getAttribute("usertypevalue").toString()+"') GROUP BY DriverID, DriverName, OwnerName ORDER BY DriverName ASC";

//System.out.println("SQL:::"+sql);
//sql="select distinct(Dcode), avg(Rating) as Rating ,sum(Distance) as Distance from t_driver_ds where TheDate >='"+data1+"' and TheDate <='"+data2+"' and distance > 0 and Jcode <>'-' group by Dcode order by Rating,Distance desc";
ResultSet rst=st2.executeQuery(sql);
int i=1;
while(rst.next())
{
	DriverIdlist=DriverIdlist+","+rst.getString("DriverID");
	dailyctr=0;
	weeklyctr=0;
	//VehCode=rst.getInt("Vehid");
	RAcount=rst.getInt("RAcount");
	//System.out.println("RACount::"+RAcount);
	RDcount=rst.getInt("RDCount");
	//System.out.println("RDCount::"+RDcount);
	OSduration=rst.getInt("OSDuration");
	//System.out.println("OSDuration::"+OSduration);
	DriverID=rst.getString("DriverID");
	//System.out.println("DriverID-----------------123--------------------------->" + DriverID);

	
	//System.out.println("DriverCode::"+DriverID);
	DriverName=rst.getString("DriverName");
	//System.out.println("DriverName::"+DriverName);
	Transporter=rst.getString("OwnerName");
	//System.out.println("Transporter::"+Transporter);
	//rating=rst.getDouble("Rating");
	distance=rst.getInt("Distance");
	//System.out.println("Distance::"+distance);
	
	%>
	<tr>
	<td class="bodyText"><div align="right"><%=i%></div></td>
	<td class="bodyText"><div align="left"><%=DriverName%></div></td>
	<td class="bodyText"><div align="right"><%=DriverID%></div></td>
	<td class="bodyText"><div align="left"><%=Transporter%></div></td>
	<td class="bodyText"><div align="right"><%=OSduration%></div></td>
	<td class="bodyText"><div align="right"><%=RAcount%></div></td>
	<td class="bodyText"><div align="right"><%=RDcount%></div></td>
	<td class="bodyText"><div align="right"><%=distance%></div></td>
	
		<%	
	
		String str = "SELECT count(*) as count FROM `t_CastrolDrivers6` WHERE TheDte  BETWEEN '"+ data1 + "' AND '" + data2 + "' AND DrinHrs > 10 and DriverID = '" + DriverID + "'"; 
		//System.out.println(str);
		ResultSet myrst = st4.executeQuery(str);
		
		while(myrst.next()) {
		
			dailyctr=myrst.getInt("count");
			alldailyctr=alldailyctr+dailyctr;
			
		} 
		if(dailyctr>0)
		{
			%>	
			 <td class="bodyText"><div align="right"><%=dailyctr %></div></td>
		<%	
		}
		else
		{
			%>
			<td class="bodyText"><div align="right"><%=dailyctr %></div></td>
			 
		<%
		}
		
		String str1 = "SELECT count(*) as count FROM `t_CastrolDrivers6` WHERE TheDte  BETWEEN '"+ data1 + "' AND '" + data2 + "' AND LastWeekRDurInHrs > 60 and DriverID = '" + DriverID + "'"; 
		//System.out.println(str);
		ResultSet myrst1 = st5.executeQuery(str1);
		
		while(myrst1.next()) {
		
			weeklyctr=myrst1.getInt("count");
			allweeklyctr=allweeklyctr+weeklyctr;
		}  
		if(weeklyctr>0)
		{
			%>	
			 <td class="bodyText"><div align="right"><%=weeklyctr %></div></td>
		<%	
		}
		else
		{
			%>
			<td class="bodyText"><div align="right"><%=weeklyctr %></div></td>
			<%
			
		}
		%>
		<td class="bodyText"><div align="right">
	<%
	if(distance ==0)
	{
	out.print("NA");
	}
	else
	{
		rating=(((Double.valueOf(RAcount)/distance)*100)+((Double.valueOf(RDcount)/distance)*100)+((Double.valueOf(OSduration)/10/distance)*100));
		out.print(nf.format(rating));
	}
	%></div></td>
		
	</tr>
	<%
	i++;
	RAcnt=RAcnt+RAcount;
	//System.out.println("RACnt::::"+RAcnt);
	RDcnt=RDcnt+RDcount;
	//System.out.println("RDCnt::::"+RDcnt);
	OScnt=OScnt+OSduration;
	//System.out.println("OSCnt::::"+OScnt);
	Distcnt=Distcnt+distance;
	//System.out.println("Distcnt::::"+Distcnt);
	//ctr=ctr+d;
	//cntrate=cntrate+rating;
	
	}
DriverIdlist=DriverIdlist+")";
//System.out.println(DriverIdlist);
    ctr=(((Double.valueOf(RAcnt)/Distcnt)*100)+((Double.valueOf(RDcnt)/Distcnt)*100)+((Double.valueOf(OScnt)/10/Distcnt)*100));
    
	
    
	
	%>
	<tr>
	<td class="bodyText" colspan="4"><div align="right"><b>Total</b></div></td>
		<td class="bodyText"><div align="right"><b><%=OScnt%></b></div></td>
	<td class="bodyText"><div align="right"><b><%=RAcnt%></b></div></td>
	<td class="bodyText"><div align="right"><b><%=RDcnt%></b></div></td>
	<td class="bodyText"><div align="right"><b><%=Distcnt%></b></div></td>
	<%if(alldailyctr>0)
		{%>
	<td class="bodyText"><div align="right"><b><%=alldailyctr%></b></div></td>
	<%}
	else
	{
	%>
	<td class="bodyText"><div align="right"><b><%=0%></b></div></td>
	<%} %>
		<%if(allweeklyctr>0)
		{%>
	<td class="bodyText"><div align="right"><b><%=allweeklyctr%></b></div></td>
	<%}
	else
	{
	%>
	<td class="bodyText"><div align="right"><b><%=0%></b></div></td>
	<%} %>
	<td class="bodyText"><div align="right"><b><%=nf.format(ctr)%></b></div></td>
	</tr>
	

</table>
<%
}catch(Exception e)
{
	out.print("Exception -->"+ e);
}
finally
{
	try
	{
		conn1.close();
	}catch(Exception e)
	{}
	try
	{
		connnew.close();
	}catch(Exception e)
	{}
	
}

%>
<!-- code end here -->

<br>
<table border="1" width="100%" bgcolor="white">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center><b>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</b></center>
</td></tr>
</table>

