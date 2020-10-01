<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% response.setContentType("application/vnd.ms-excel");
Format formatterxx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatexx = formatterxx.format(new java.util.Date());

String filename=session.getAttribute("user").toString()+showdatexx+"driver_rating_by_date.xls";
    response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="Connections/conn.jsp" %>
<%!
Connection connnew;
Statement st, st1, st2,st3,st4;
String user,sql,sql1,sql2,sql11;
String data1, data2,showdate1,showdate,DriverName,Owner,drivercode,transporter,Vcode;
int OScount, RAcount, RDcount,Distance,vid;
double Rating;
int cntos, cntra, cntrd, cntcr, cntnd, cntst,cntdt,stcount21,ss7, cntfc;
//String vehno,sdate,edate;
java.util.Date dt1=null;
java.util.Date dt2=null;
String sdate,edate;
%>
<%

NumberFormat nf = DecimalFormat.getInstance();
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2); 
try
{
Class.forName(MM_dbConn_DRIVER); 
connnew = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	//conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=connnew.createStatement();
	st1=connnew.createStatement();

	data1=request.getParameter("data1");
	data2=request.getParameter("data2");
	drivercode=request.getParameter("drivercode");
	DriverName=request.getParameter("name");
	transporter=request.getParameter("transporter");
	//Vcode=request.getParameter("VehCode");
	//System.out.println("Vcode");
	//session.setAttribute("vid",vid);
	//session.setAttribute("vehno",vehno);
	//session.setAttribute("sdate",dt1);
	//session.setAttribute("edate",dt2);
	
%>
<table border="0" width="90%" bgcolor="white" align="center">
<tr><th colspan="13">Rating Report for <%=DriverName%> (<%=drivercode%>), Transporter <%=transporter%> from date <% java.util.Date ShowDate = new SimpleDateFormat("yyyy-MM-dd").parse(data1);
Format formatter2 = new SimpleDateFormat("dd-MMM-yyyy");
showdate = formatter2.format(ShowDate);
out.print(showdate);
%> to <%
java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(data2);
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
showdate1 = formatter1.format(ShowDate1);
out.print(showdate1);
%>.<div align="right">
Date : <%
Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String sdt = fmt.format(new java.util.Date());
 out.print(sdt); %></div></th></tr>
 </table>
 <br>
<table border="1" width="100%" bgcolor="white" class="sortable">
<tr>
<td class="hed"><b>TripID</b></td>
<td class="hed"><b>Vehicle Reg.No.</b></td>
<td class="hed"><b>StartDate</b></td>
<td class="hed"><b>StartPlace</b></td>
<td class="hed"><b>EndDate</b></td>
<td class="hed"><b>EndPlace</b></td>
<td class="hed"><b>OS Duration</b></td>
<td class="hed"><b>RA Count</b></td>
<td class="hed"><b>RD Count</b></td>
<td class="hed"><b>Distance</b></td>
<td class="hed"><b>CD</b></td>
<td class="hed"><b>ND</b></td>
<td class="hed"><b>Rating</b></td>
</tr>
<%

int JCode,VehCode,RAcount,RDcount,distance,OSduration,RAcnt=0,RDcnt=0,OScnt=0,Distcnt=0;
double rating;
double rating1;
//double a,b,c;
double ctr=0.0;
double d=0.0;
String DriverID,DriverName,Transporter,vid;



cntos=0;
cntra=0;
cntrd=0;
cntdt=0;


//java.util.Date dt1 = null;
String CD="",ND="";
int i=0;
//sql="select * from t_driver_ds where dcode='"+drivercode+"' and TheDate >='"+data1+"' and TheDate <='"+data2+"' and Jcode <>'-' and distance > 0 order by TheDate asc";
//sql="select sum(RACount) as RAcount,sum(RDCount) as RDcount,sum(OSDuration) as OSDuration,DriverID,DriverName,OwnerName,Sum(KmTravelled) as Distance from t_completedjourney where StartDate>='"+data1+"' and EndDate<='"+data2+"' and KmTravelled>0 and JourneyCode <>'-'and Vehid in "+session.getAttribute("VehList").toString()+" group by DriverID,DriverName,OwnerName order by DriverName asc";
sql="select * from t_completedjourney WHERE StartDate >= '"+data1+"' AND StartDate <= '"+data2+"' AND (OwnerName LIKE '"+session.getAttribute("usertypevalue").toString()+"' OR GPName LIKE '"+session.getAttribute("usertypevalue").toString()+"') and DriverID='"+drivercode+"' order by StartDate,StartTime desc";
//System.out.println(sql);
ResultSet rst=st1.executeQuery(sql);

while(rst.next())
	
{
	//vehno=rst.getString("VehRegNo");
	//VehCode=rst.getInt("Vehid");
	OSduration=rst.getInt("OSDuration");
	 dt1 =rst.getDate("StartDate");
	//System.out.println("StartDate:::"+dt1);
	 dt2 =rst.getDate("EndDate");
	 sdate=rst.getString("StartDate");
	 edate=rst.getString("EndDate");
	//CD=rst.getString("CRCount");
	//ND=rst.getString("NDCount");
	
%>

<tr>
<td class="bodyText"><div align="right">
<%=rst.getString("TripID")%>
</div></td>
<td class="bodyText"><div align="right"><%=rst.getString("VehRegNo")%></div></td>
<td class="bodyText"><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(dt1)%></div>
<%
//java.util.Date ShowDatex = new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("TheDate"));
//Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
//String showdatex = formatterx.format(ShowDatex);
//out.print(showdatex);
%></td>
<td class="bodyText"><div align="left"><%=rst.getString("StartPlace")%></div></td>
<td class="bodyText"><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(dt2)%></div></td>
<td class="bodyText"><div align="left"><%=rst.getString("EndPlace")%></div></td>
<td class="bodyText"><div align="right">
<%
	int ss3=rst.getInt("OSDuration");
 //System.out.println("OSduration:::>>"+ss3);
	if(ss3>0)
	{
		cntos=cntos+ss3;
		out.print(""+ss3);
	}
	else
	{
		out.print(""+ss3);
	}
	%>
</div></td>
<td class="bodyText"><div align="right">
<%
	int ss2=rst.getInt("RACount");
	if(ss2>0)
	{
		cntra=cntra+ss2;
		out.print(""+ss2);
	}
	else
	{
		out.print(""+ss2);
	}
	%>


</div></td>
<td class="bodyText"><div align="right">
<%
	int ss1=rst.getInt("RDCount");
	if(ss1>0)
	{
		cntrd=cntrd+ss1;
		out.print(""+ss1);
	}
	else
	{
		out.print(""+ss1);
	}
	%>
</div></td>
<td class="bodyText"><div align="right">
<%
	int ss4=rst.getInt("KmTravelled");
	if(ss4>0)
	{
		cntdt=cntdt+ss4;
		out.print(rst.getInt("KmTravelled"));
		
	}
	else
	{
		out.print(""+ss4);
	}
	%>
</div></td>
<td class="bodyText"><div align="right">
<%
	String ss6=rst.getString("CRCount");
	if(ss6.equals("Yes"))
	{
		cntcr=cntcr+1;
		out.print(""+ss6);
	}
	else
	{
		out.print(""+ss6);
	}
	%> 


</div></td>
<td class="bodyText"><div align="right">
<%
String ss5=rst.getString("NDCount");
if(ss5.equals("Yes"))
{	cntnd=cntnd+1;
	out.print(""+ss5);
}
else
{
	out.print(""+ss5);
}
%> 


</div></td>
<td class="bodyText"><div align="right"><%
rating=((Double.valueOf(rst.getString("RACount")))/(Double.valueOf(rst.getString("KmTravelled")))*100)+((Double.valueOf(rst.getString("RDCount")))/(Double.valueOf(rst.getString("KmTravelled")))*100)+((Double.valueOf(OSduration))/10/(Double.valueOf(rst.getString("KmTravelled")))*100);

//String ll=""+rating;
//if(ll.length() >5)
//{
//out.print(ll.substring(0,5));
//}
//lse
//{
if(rst.getInt("KmTravelled")==0)
{
	out.print("NA");
}
else
{
	out.print(nf.format(rating));
}
//}

%>
</div></td></tr>
<%

i++;


}

%>
<tr>
<td class="bodyText" colspan="6"><div align="right"><b>Total</b></div></td>
<td class="bodyText"><div align="right"><b><%=cntos%></b></div></td>
<td class="bodyText"><div align="right"><b><%=cntra%></b></div></td>
<td class="bodyText"><div align="right"><b><%=cntrd%></b></div></td>
<td class="bodyText"><div align="right"><b><%=cntdt%></b></div></td>
<td class="bodyText"><div align="right"><b>
<%
if(cntcr>0)
{
	out.print("Yes");
}
else
{
	out.print("No");
}
%>
</b></div></td>
<td class="bodyText"><div align="right"><b>
<%

if(cntnd>0)
{
	out.print("Yes");
}
else
{
	out.print("No");
}
%>

</b></div></td>
<td class="bodyText"><div align="right"><b>
<%
double a,b,c;
a=(Double.valueOf(cntra))/(Double.valueOf(cntdt))*100;
b=(Double.valueOf(cntrd))/(Double.valueOf(cntdt))*100;
c=(Double.valueOf(cntos))/10/(Double.valueOf(cntdt))*100;

rating1=a+b+c;

	 //((Double.valueOf(cntra))/(Double.valueOf(cntdt))*100)+((Double.valueOf(cntrd))/(Double.valueOf(cntdt))*100)+((Double.valueOf(cntos))/10/(Double.valueOf(cntdt))*100);

out.print(nf.format(rating1));
//String  ss=""+rating1;
//if(ss.length() >5)
//{
//	ss=ss.substring(0,5);
//}
//out.print(ss);

%>

</b></div></td>

</table>
<%
}
catch(Exception e)
{
	out.print("Exception -->" +e);
}
finally
{
	connnew.close();
}
%>
<!-- code end here -->





<!-- footer start here -->
<br>
<table border="1" width="100%" bgcolor="white">
<tr ><td bgcolor="white" class="copyright" width="100%" colspan="13">
<center><b>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</b></center>
</td></tr>
</table>
<P></P>
</body>
</html>

