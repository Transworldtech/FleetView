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

%>
<%
String fromdate="",todate="";
int ftime1=0;
int ftime2=0;
int ttime1=0;
int ttime2=0;
String sdate,edate;
String user,sql="",sql1="",sql2="",sql11="";
String data1=null, data2=null,showdate1=null,showdate=null,DriverName=null,Owner,drivercode,transporter,Vcode;
int OScount=0, RAcount=0, RDcount=0,Distance=0,vid=0;
double Rating=0.00;
int cntos=0, cntra=0, cntrd=0, cntcr=0, cntnd=0, cntst=0,cntdt=0,stcount21=0,ss7=0, cntfc=0;
//String vehno,sdate,edate;
java.util.Date dt1=null;
java.util.Date dt2=null;


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
	DriverName=request.getParameter("DriverName");
	transporter=request.getParameter("transporter");
	//Vcode=request.getParameter("VehCode");
	//System.out.println("Vcode");
	//session.setAttribute("vid",vid);
	//session.setAttribute("vehno",vehno);
	//session.setAttribute("sdate",dt1);
	//session.setAttribute("edate",dt2);
	
%>
<table class="stats">
<tr>
<th colspan="13" >
<font size="2">
Rating Report for <%=DriverName%> (<%=drivercode%>), Transporter <%=transporter%> from date <% java.util.Date ShowDate = new SimpleDateFormat("yyyy-MM-dd").parse(data1);
Format formatter2 = new SimpleDateFormat("dd-MMM-yyyy");
showdate = formatter2.format(ShowDate);
out.print(showdate);
%> to <%
java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(data2);
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
showdate1 = formatter1.format(ShowDate1);
out.print(showdate1);
%>.<br>

 </font>
 </th>
 </tr>

<tr>
<td class="hed">TripID</td>
<td class="hed">Vehicle Reg.No.</td>
<td class="hed">StartDate</td>
<td class="hed">StartPlace</td>
<td class="hed">EndDate</td>
<td class="hed">EndPlace</td>
<td class="hed">OS Duration<br>(in Sec)</td>
<td class="hed">RA Count</td>
<td class="hed">RD Count</td>
<td class="hed">Distance</td>
<td class="hed">CD</td>
<td class="hed">ND</td>
<td class="hed">Rating</td>
</tr>
<%
int JCode,VehCode,distance,OSduration,RAcnt=0,RDcnt=0,OScnt=0,Distcnt=0;
double rating;
double rating1;
//double a,b,c;
double ctr=0.0;
double d=0.0;
String DriverID,Transporter;
//cntos=0;
//cntra=0;
//cntrd=0;
//cntdt=0;

//java.util.Date dt1 = null;
String CD="",ND="";
int i=0;
//sql="select * from t_driver_ds where dcode='"+drivercode+"' and TheDate >='"+data1+"' and TheDate <='"+data2+"' and Jcode <>'-' and distance > 0 order by TheDate asc";
//sql="select sum(RACount) as RAcount,sum(RDCount) as RDcount,sum(OSDuration) as OSDuration,DriverID,DriverName,OwnerName,Sum(KmTravelled) as Distance from t_completedjourney where StartDate>='"+data1+"' and EndDate<='"+data2+"' and KmTravelled>0 and JourneyCode <>'-'and Vehid in "+session.getAttribute("VehList").toString()+" group by DriverID,DriverName,OwnerName order by DriverName asc";
sql="select * from t_completedjourney WHERE StartDate >= '"+data1+"' AND StartDate <= '"+data2+"' AND (OwnerName LIKE '"+session.getAttribute("usertypevalue").toString()+"' OR GPName LIKE '"+session.getAttribute("usertypevalue").toString()+"') and DriverID='"+drivercode+"' and OwnerName = '"+transporter+"'order by StartDate Asc";
	
//System.out.println("sql in trip_driver--->"+sql);
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
//	 System.out.println("StartDate--->>"+sdate);
/*#################################change#############################*/

/*=====================================================
	parameters passed to show_custom_detail_rept_onMap.jsp
	start date
	Start time-> Hrs mins separate
	end date
	end time-> hrs mins separate
==============================================*/
	try
	{
	  fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(sdate));
	}
	catch(Exception e)
	{
	
		try
    	{
			fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(sdate));
    	}
    	catch(Exception x)
    	{
    		fromdate=sdate;
    	}
	
		
	}
	// System.out.println("StartDate--->>"+fromdate);
	try
	{
	java.util.Date dt=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(sdate);
	 ftime1=dt.getHours();
	 ftime2=dt.getMinutes();
	}
	catch(Exception e)
  	{
  		ftime1=00;
  		ftime1=00;
  	}

	 edate=rst.getString("EndDate");
	 try
	 {
	 	todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(edate));
	 }
	 catch(Exception e)
	 {
			 
		 try
	  		{
	  			
			 todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(edate));
	  		}
	  		catch(Exception c)
	  		{
	  			todate=edate;
	  		}
		 
	}
	try
	{
	java.util.Date edt=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(edate);
	 ttime1=edt.getHours();
	 ttime2=edt.getMinutes();
	}
	catch(Exception e)
  	{
  		ttime1=23;
  	 	ttime2=59;
  	}
	 /*#################################change#############################*/
	
%>

<tr>
<td class="bodyText"><div align="right">
<!--change -->
<a href="ShowCustomReportonTWMap.jsp?tripid=<%=rst.getString("TripID")%>&vehcode=<%=rst.getString("Vehid")%>&data=<%=fromdate %>&data1=<%= todate%>&ftime1=<%=ftime1 %>&ftime2=<%=ftime2 %>&ttime1=<%=ttime1 %>&ttime2=<%=ttime2 %>&vehregno=<%=rst.getString("VehRegNo")%>&ownername=<%=rst.getString("OwnerName")%>&startplace=<%=rst.getString("StartPlace")%>&endplace=<%=rst.getString("EndPlace")%>&pg=cm";">
<!-- 
<a href="showonmap.jsp?tripid=<%=rst.getString("TripID")%>&vehcode=<%=rst.getString("Vehid")%>&sdate=<%=rst.getString("StartDate")%>&vehregno=<%=rst.getString("VehRegNo")%>&ownername=<%=rst.getString("OwnerName")%>&startplace=<%=rst.getString("StartPlace")%>&endplace=<%=rst.getString("EndPlace")%>&enddate=<%=rst.getString("EndDate")%>&pg=cm";">
-->
<%=rst.getString("TripID")%></a>
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
		cntos=cntos+ss3;out.print(""+ss3);
		//out.print("<a href='trip_os.jsp?tripid="+rst.getString("TripID")+"&OwnerName="+transporter+"&sdate="+sdate+"&edate="+edate+"&vehno="+rst.getString("VehRegNo")+"&vcode="+rst.getString("Vehid")+"'>"+ss3+"</a>");
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
	
		//out.print("<a href='KPI_osduration.jsp?tripid="+rst.getString("TripID")+"&sdate="+sdate+"&edate="+edate+"&vehno="+rst.getString("VehRegNo")+"&vcode="+rst.getString("Vehid")+"'>"+ss2+"</a>");
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
		
		//out.print("<a href='trip_rd.jsp?tripid="+rst.getString("TripID")+"OwnerName="+transporter+"&sdate="+sdate+"&edate="+edate+"&vehno="+rst.getString("VehRegNo")+"&vcode="+rst.getString("Vehid")+"'>"+ss1+"</a>");
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
		//out.print("<a href='driver_rapiddeacc.jsp?sdate="+rst.getString("StartDate")+"&edate="+rst.getString("EndDate")+"&vehno="+rst.getString("VehRegNo")+"&vcode="+rst.getString("Vehid")+"&data1="+data1+"&data2="+data2+"'>"+ss4+"</a>");
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
//out.println("RDCount-- >"+cntrd);
//out.print("RACount-->"+cntra);
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
//System.out.println("A::>>"+a);
//System.out.println("B::>>"+b);
//System.out.println("C::>>"+c);
rating1=a+b+c;
 //System.out.println("Rate::>>"+rating1);
	 //((Double.valueOf(cntra))/(Double.valueOf(cntdt))*100)+((Double.valueOf(cntrd))/(Double.valueOf(cntdt))*100)+((Double.valueOf(cntos))/10/(Double.valueOf(cntdt))*100);

out.print(nf.format(rating1));
//String  ss=""+rating1;
//if(ss.length() >5)
//{
//	ss=ss.substring(0,5);
//}
//out.print(ss);
//System.out.println("RateNew::>>"+rating1);
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
	try{
		connnew.close();
	}
	catch(Exception e)
	{
		
	}
}
%>
<!-- code end here -->





<!-- footer start here -->
<%@ include file="footernew.jsp" %>

