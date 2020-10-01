<%@ include file="headernew.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
 
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>

<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/graph.js"></SCRIPT>
<script type="text/javascript">
var renderStart = new Date().getTime();
window.onload=function() { 
var renderEnd=new Date().getTime();
var elapsed = new Date().getTime()-renderStart;   
var PageName = document.getElementById("PageName").value;
	try{var ajaxRequest;
	try{ajaxRequest = new XMLHttpRequest();	}
		catch (e)
		{
		try
		{ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");}
		catch (e)
		{try
		{ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");}
		catch (e)
		{alert("Your browser broke!");
		return false;
		}}}
		ajaxRequest.onreadystatechange = function()
		{if(ajaxRequest.readyState == 4)
		{try
		{var reslt=ajaxRequest.responseText;
		var result1;
		result1=reslt;
		result1=result1.replace(/^\s+|\s+$/g,'');
		if(result1=="Updated")
		{}
		}catch(e)
		{alert(e);
		}}};		 
		var queryString = "?PageName="+PageName+"&renderStart="+renderStart+"&renderEnd="+renderEnd+"&elapsed="+elapsed+"";
		ajaxRequest.open("GET","Ajax_PageLoadingTime.jsp" + queryString, true);
		ajaxRequest.send(null); 
		}
		   catch(e)
		{
			alert(e);
		}  
};
 
</script>
<table border="1" width="100%" bgcolor="white">
<tr><td>
<!-- code start here -->
<%!
Connection connnew=null;
Statement st, st1, st2,st3,st4;
String user,sql,sql1,sql2,sql11;
String data1, data2,showdate1,showdate,DriverName,Owner,drivercode,transporter,Vcode;
int OScount, RAcount, RDcount,Distance,vid;
double Rating;

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
	//Class.forName(MM_dbConn_DRIVER); 
	connnew = fleetview.ReturnConnection();
	//conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=connnew.createStatement();
	st1=connnew.createStatement();

	String UserID=session.getAttribute("UserID").toString();
	
	data1=request.getParameter("data1");
	data2=request.getParameter("data2");
	drivercode=request.getParameter("DriverID");
	DriverName=request.getParameter("DriverName");
	transporter=request.getParameter("Transporter");
	//Vcode=request.getParameter("VehCode");
	//System.out.println("Vcode");
	//session.setAttribute("vid",vid);
	//session.setAttribute("vehno",vehno);
	//session.setAttribute("sdate",dt1);
	//session.setAttribute("edate",dt2);
	
%>
<div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())%></div>
<div id="reportData">
<iframe id="myIframe" width="100%" height="850px" src="http://myfleetview.com:8080/birt/frameset?__report=Driver_Rating.rptdesign&userid=<%=UserID%>&data1=<%=data1%>&data2=<%=data2%>&DriverID=<%=drivercode%>&DriverName=<%=DriverName%>&Transporter=<%=transporter%>&__showtitle=false"> 
<!-- <iframe id="myIframe" width="100%" height="850px" src=""> -->
</iframe> 

 </div>

<%if(false){ %>
<table class="stats">
<tr><th colspan="13" ><font size="2">Rating Report for <%=DriverName%> (<%=drivercode%>), Transporter <%=transporter%> from date <% java.util.Date ShowDate = new SimpleDateFormat("yyyy-MM-dd").parse(data1);
Format formatter2 = new SimpleDateFormat("dd-MMM-yyyy");
showdate = formatter2.format(ShowDate);
out.print(showdate);
%> to <%
java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(data2);
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
showdate1 = formatter1.format(ShowDate1);
out.print(showdate1);
%>.<br>
<div align="left"><a href="javascript:history.go(-1);"><font color="white">Back</font></a></div> <div align="right">
<a href="#" onclick="javascript:window.open('printdriver_rating_by_date.jsp?data1=<%=data1%>&data2=<%=data2%>&transporter=<%=transporter%>&drivercode=<%=drivercode%>&name=<%=DriverName%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; <a href="exceldriver_rating_by_date.jsp?data1=<%=data1%>&data2=<%=data2%>&transporter=<%=transporter%>&drivercode=<%=drivercode%>&name=<%=DriverName%>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;Date : <%
Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String sdt = fmt.format(new java.util.Date());
 out.print(sdt); %></div></font></th></tr>
<tr>
<td class="hed">TripID</td>
<td class="hed">Vehicle Reg.No.</td>
<td class="hed">StartDate</td>
<td class="hed">StartPlace</td>
<td class="hed">EndDate</td>
<td class="hed">EndPlace</td>
<td class="hed">OS Duration</td>
<td class="hed">RA Count</td>
<td class="hed">RD Count</td>
<td class="hed">Distance</td>
<td class="hed">CD</td>
<td class="hed">ND</td>
<td class="hed">Rating</td>
</tr>
<%

int JCode,VehCode,RAcount,RDcount,distance,OSduration,RAcnt=0,RDcnt=0,OScnt=0,Distcnt=0;
double rating;
double rating1;
//double a,b,c;
double ctr=0.0;
double d=0.0;
String DriverID,DriverName,Transporter,vid;

int cntos, cntra, cntrd, cntcr, cntnd, cntst,cntdt,stcount21,ss7, cntfc;

cntos=0;
cntra=0;
cntrd=0;
cntdt=0;
cntnd=0;
cntcr=0;
//java.util.Date dt1 = null;
String CD="",ND="";
int i=0;
//sql="select * from t_driver_ds where dcode='"+drivercode+"' and TheDate >='"+data1+"' and TheDate <='"+data2+"' and Jcode <>'-' and distance > 0 order by TheDate asc";
//sql="select sum(RACount) as RAcount,sum(RDCount) as RDcount,sum(OSDuration) as OSDuration,DriverID,DriverName,OwnerName,Sum(KmTravelled) as Distance from t_completedjourney where StartDate>='"+data1+"' and EndDate<='"+data2+"' and KmTravelled>0 and JourneyCode <>'-'and Vehid in "+session.getAttribute("VehList").toString()+" group by DriverID,DriverName,OwnerName order by DriverName asc";
//sql="select * from t_completedjourney WHERE StartDate >= '"+data1+"' AND StartDate <= '"+data2+"' AND (OwnerName LIKE '"+session.getAttribute("usertypevalue").toString()+"' OR GPName LIKE '"+session.getAttribute("usertypevalue").toString()+"') and DriverID='"+drivercode+"' order by StartDate,StartTime desc";
sql="select * from t_completedjourney WHERE StartDate >= '"+data1+"' AND StartDate <= '"+data2+"' AND Vehid in "+session.getAttribute("VehList").toString()+" and DriverID='"+drivercode+"' order by StartDate,StartTime desc";
System.out.println(sql);
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
	String startdate="";
	String ftime1 ="";
	String ftime2 ="";
	
	String enddate ="";
	String ttime1 ="";
	String ttime2 ="";
	try{
		startdate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("StartDate")));
		ftime1    = new SimpleDateFormat("HH").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("StartDate")));
		ftime2    = new SimpleDateFormat("mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("StartDate")));
	}
	catch(Exception e){
		startdate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StartDate")));
		ftime1    = new SimpleDateFormat("HH").format(new SimpleDateFormat("HH:mm:ss").parse(rst.getString("StartTime")));
		ftime2    = new SimpleDateFormat("mm").format(new SimpleDateFormat("HH:mm:ss").parse(rst.getString("StartTime")));
	}
	
	try{
		enddate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("EndDate")));
		ttime1  = new SimpleDateFormat("HH").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("EndDate")));
		ttime2  = new SimpleDateFormat("mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("EndDate")));
	}
	catch(Exception e){
		enddate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("EndDate")));
		ttime1  = new SimpleDateFormat("HH").format(new SimpleDateFormat("HH:mm:ss").parse(rst.getString("EndTime")));
		ttime2  = new SimpleDateFormat("mm").format(new SimpleDateFormat("HH:mm:ss").parse(rst.getString("EndTime")));
	}
	
%>

<tr>
<td class="bodyText"><div align="right">
 <a href="ShowCustomReportonTWMap.jsp?tripid=<%=rst.getString("TripID")%>&vehcode=<%=rst.getString("Vehid")%>&data=<%=startdate%>&data1=<%=enddate%>&ftime1=<%=ftime1%>&ftime2=<%=ftime2%>&ttime1=<%=ttime2%>&ttime2=<%=ttime2%>&pg=drivrating" onclick="toggleDetails(<%=i%>,false);"><%=rst.getString("TripID")%> </a> 
<!--<a href="showonmap.jsp?tripid=< %=rst.getString("TripID")%>&vehcode=< %=rst.getString("Vehid")%>&sdate=< %=rst.getString("StartDate")+" "+rst.getString("StartTime")%>&vehregno=< %=rst.getString("VehRegNo")%>&ownername=< %=rst.getString("OwnerName")%>&startplace=< %=rst.getString("StartPlace")%>&endplace=< %=rst.getString("EndPlace")%>&enddate=< %=rst.getString("EndDate")+" "+rst.getString("EndTime")%>&pg=cm";">
< %=rst.getString("TripID")%></a>-->
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
		out.print("<a href='KPI_osduration.jsp?sdate="+sdate+"&edate="+edate+"&vid="+rst.getString("Vehid")+"&tripid="+rst.getString("TripID")+"'>"+ss3+"</a>");
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
		//out.print("<a href='driver_rapidacc.jsp?sdate="+sdate+"&edate="+edate+"&vehno="+rst.getString("VehRegNo")+"&vcode="+rst.getString("Vehid")+"&tripid="+rst.getString("TripID")+"'>"+ss2+"</a>");
	out.print("<a href='KPI_rapidacc.jsp?sdate="+sdate+"&edate="+edate+"&vid="+rst.getString("Vehid")+"&tripid="+rst.getString("TripID")+"'>"+ss2+"</a>");
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
		out.print("<a href='KPI_rapiddeacc.jsp?sdate="+sdate+"&edate="+edate+"&tripid="+rst.getString("TripID")+"&vid="+rst.getString("Vehid")+"'>"+ss1+"</a>");
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
}//if false
}
catch(Exception e)
{
	out.print("Exception -->" +e);
}
finally
{
	connnew.close();

try
{fleetview.closeConnection();}
catch(Exception e)
{}

}
%>
<!-- code end here -->



</td></tr>
</table>

<!-- footer start here -->
<!-- <table border="1" width="100%" bgcolor="white">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table> -->
<P></P>
</body>
</html>
</jsp:useBean>