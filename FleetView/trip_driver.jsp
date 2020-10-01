<%@ include file="headernew.jsp" %>
<script LANGUAGE="JavaScript1.2" SRC="js/graph.js"></script>

<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
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
 


function gotoPrint(divName)  
{  
	 
	  var printContents = document.getElementById(divName).innerHTML; 
	  var originalContents = document.body.innerHTML; 
	  
		  
	  document.body.innerHTML = printContents;  
	  window.print();
	  document.body.innerHTML = originalContents;  
}

function gotoExcel(elemId,frmFldId)  
{  
	      
	     
          var obj = document.getElementById(elemId);  
          var oFld = document.getElementById(frmFldId); 
          oFld.value = obj.innerHTML;
        
          document.TripDriverReport.action ="excel.jsp";
          document.forms["TripDriverReport"].submit();
} 

</script>
<table border="1" width="100%" bgcolor="white">
   <tr>
      <td>
        <!-- code start here -->
        <%!
        Connection connnew=null;
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
		int OScount=0, RAcount=0, RDcount=0,Distance=0,vid=0,DisconnCount=0,DisconnKm=0;
		double Rating=0.00;
		int cntos=0, cntra=0, cntrd=0, cntcr=0, cntnd=0, cntst=0,cntdt=0,stcount21=0,ss7=0, cntfc=0, cntDisconn=0, cntDisconnKm=0,cntosinred=0,cntosinyellow=0,cntosingreen=0;
		//String vehno,sdate,edate;
		java.util.Date dt1=null;
		java.util.Date dt2=null;


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
		<form id="TripDriverReport" name="TripDriverReport" action="" method="post" >
					<div id="table1">
				<table class="stats">
					<tr>
					
						<th colspan="18" >
						<font size="2">Rating Report for <%=DriverName%> (<%=drivercode%>), Transporter <%=transporter%> from date <% java.util.Date ShowDate = new SimpleDateFormat("yyyy-MM-dd").parse(data1);
						Format formatter2 = new SimpleDateFormat("dd-MMM-yyyy");
						showdate = formatter2.format(ShowDate);
						out.print(showdate);
		                %> to <%
						java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(data2);
						Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
						showdate1 = formatter1.format(ShowDate1);
						out.print(showdate1);

						String exportFileName=session.getAttribute("user").toString()+"_TripDriverReport.xls"; 
						%>.<br>
						
						<div align="left"><a href="javascript:history.go(-1);"><font color="white">Back</font></a></div> 

						<div  align="right">
						<input type="hidden" id="tableHTML" name="tableHTML" value="" />  
						<input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" />
      
						<a href="#" style="font-weight: bold; color: black; " onclick="gotoPrint('table1');">
						<img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img></a> 
		      
						<a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('table1','tableHTML');">
						<img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img></a>
						
						<%
						Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
						String sdt = fmt.format(new java.util.Date());
 						out.print(sdt); %></div></font>
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
						<td class="hed">OS Duration<br>In Red Zone<br>(in Sec)</td>
						<td class="hed">OS Duration<br>In Yellow Zone<br>(in Sec)</td>
						<td class="hed">OS Duration<br>In Green Zone<br>(in Sec)</td>
						<td class="hed">RA Count</td>
						<td class="hed">RD Count</td>
                        <td class="hed">Distance</td>
						<td class="hed">CD</td>
						<td class="hed">ND</td>
						<td class="hed">Disconnection<br>Count</td>
						<td class="hed">Disconnection<br>Km</td>
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
sql="select * from t_completedjourney WHERE StartDate >= '"+data1+"' AND StartDate <= '"+data2+"' AND (OwnerName LIKE '"+session.getAttribute("usertypevalue").toString()+"' OR GPName LIKE '"+session.getAttribute("usertypevalue").toString()+"') and DriverID='"+drivercode+"' and OwnerName = '"+transporter+"' order by StartDate,StartTime desc";
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
//	 System.out.println("StartDate--->>"+sdate);
/*#################################change#############################*/

/*=====================================================
	parameters passed to show_custom_detail_rept_onMap.jsp
	start date
	Start time-> Hrs mins separate
	end date
	end time-> hrs mins separate
==============================================changes================================*/
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
		cntos=cntos+ss3;
		//out.print("<a href='trip_os.jsp?tripid="+rst.getString("TripID")+"&OwnerName="+transporter+"&sdate="+sdate+"&edate="+edate+"&vehno="+rst.getString("VehRegNo")+"&vcode="+rst.getString("Vehid")+"'>"+ss3+"</a>");
		out.print("<a href='KPI_osduration.jsp?tripid="+rst.getString("TripID")+"&sdate="+sdate+"&edate="+edate+"&vid="+rst.getString("Vehid")+"'>"+ss3+"</a>");
	}
	else
	{
		out.print(""+ss3);
	}
	%>
</div></td>
<td class="bodyText"><div align="right"><%=rst.getInt("OSDurationInRedZone")%></div></td>
<td class="bodyText"><div align="right"><%=rst.getInt("OSDurationInYellowZone")%></div></td>
<td class="bodyText"><div align="right"><%=rst.getInt("OSDurationInGreenZone")%></div></td>
<%
cntosinred=cntosinred+(int)rst.getDouble("OSDurationInRedZone");
cntosinyellow=cntosinyellow+(int)rst.getDouble("OSDurationInYellowZone");
cntosingreen=cntosingreen+(int)rst.getDouble("OSDurationInGreenZone");
%>
<td class="bodyText"><div align="right">
<%
	int ss2=rst.getInt("RACount");
	if(ss2>0)
	{
		cntra=cntra+ss2;
	
		//out.print("<a href='KPI_osduration.jsp?tripid="+rst.getString("TripID")+"&sdate="+sdate+"&edate="+edate+"&vehno="+rst.getString("VehRegNo")+"&vcode="+rst.getString("Vehid")+"'>"+ss2+"</a>");
		out.print("<a href='KPI_rapidacc.jsp?tripid="+rst.getString("TripID")+"&sdate="+sdate+"&edate="+edate+"&vid="+rst.getString("Vehid")+"'>"+ss2+"</a>");
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
		out.print("<a href='KPI_rapiddeacc.jsp?tripid="+rst.getString("TripID")+"&sdate="+sdate+"&edate="+edate+"&vid="+rst.getString("Vehid")+"'>"+ss1+"</a>");
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
<td class="bodyText"><div align="right">
<%
ss7=rst.getInt("DisconnectionCount");
if(ss7>0)
{
	cntDisconn=cntDisconn+ss7;

	//out.print("<a href='KPI_osduration.jsp?tripid="+rst.getString("TripID")+"&sdate="+sdate+"&edate="+edate+"&vehno="+rst.getString("VehRegNo")+"&vcode="+rst.getString("Vehid")+"'>"+ss2+"</a>");

	//out.print("<a href='KPI_rapiddisconn.jsp?tripid="+rst.getString("TripID")+"&sdate="+sdate+"&edate="+edate+"&vid="+rst.getString("Vehid")+"'>"+ss7+"</a>");

	%>	
	<a href="disconnectedDetailsReport.jsp?vehicleCode=<%=rst.getString("Vehid")%>&VehicleRegNo=<%=rst.getString("VehRegNo")%>&ownerName=<%=rst.getString("OwnerName")%>&fromDateTime=<%=rst.getString("Startdate")%>&toDateTime=<%=rst.getString("EndDate")%>&counterv=<%=rst.getInt("DisconnectionCount")%>&tripid=<%=rst.getString("TripId")%>"> <%=ss7%> </a>

<%	
	
	
}
else
{
	out.print(""+ss7);
}
%>

</div></td>

<td class="bodyText"><div align="right">
<%
    int ss8=rst.getInt("DisconnectionKm");
	if(ss8>0)
	{
		cntDisconnKm=cntDisconnKm+ss8;
	
		//out.print("<a href='KPI_osduration.jsp?tripid="+rst.getString("TripID")+"&sdate="+sdate+"&edate="+edate+"&vehno="+rst.getString("VehRegNo")+"&vcode="+rst.getString("Vehid")+"'>"+ss2+"</a>");
		//out.print("<a href='KPI_rapiddisconn.jsp?tripid="+rst.getString("TripID")+"&sdate="+sdate+"&edate="+edate+"&vid="+rst.getString("Vehid")+"'>"+ss7+"</a>");
		out.println(""+ss8);
	}
	else
	{
		out.print(""+ss8);
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
<td class="bodyText"><div align="right"><b><%=cntosinred%></b></div></td>
<td class="bodyText"><div align="right"><b><%=cntosinyellow%></b></div></td>
<td class="bodyText"><div align="right"><b><%=cntosingreen%></b></div></td>
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
<td class="bodyText"><div align="right"><b><%=cntDisconn%></b></div></td>
<td class="bodyText"><div align="right"><b><%=cntDisconnKm%></b></div></td>
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
</div>
</form>
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
<table border="1" width="100%" bgcolor="white">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
<P></P>
</body>
</html>
</jsp:useBean>