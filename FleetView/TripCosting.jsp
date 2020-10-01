<%@ include file="/Connections/conn.jsp" %>
<jsp:include page="headernew.jsp">
<jsp:param name="reportname" value="TripCosting.jsp" />
</jsp:include>     
<%@page import="java.util.Date"%>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<link href="css/currentPositions.css" rel="stylesheet" type="text/css"></link>
<script src="includes/mytripinclude.js" type="text/javascript"></script>
  	<html>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/graph.js"></SCRIPT>

<script>

function validate()
{
	if(document.getElementById("data1").value=="")
	{
	
		alert("Please select the from date");
		return false;
	}
if(document.getElementById("data2").value=="")
	{
	
		alert("Please select the to date");
		return false;
	}
var v1=document.dateform.rateperhour.value;
if(v1.length=="")
{
	alert("Enter Rate/Hr");
	return false;
}
var v2=document.dateform.rateperkmm.value;
if(v2.length=="")
{
	alert("Enter Rate/Km");
	return false;
}

var amount=document.getElementById("rateperhour").value;
var numericExpression = /^[0-9 .]+$/;
if(!(amount.match(numericExpression)))
{
          alert("Rate/Hr has to be Numeric");

//document.getElementById("lblNameMsg2").style.display="";
        return false;
//document.ereceipt.amount.value=document.ereceipt.amount.value.substring(0, document.receipt.amount.value.length-1);
        //return false;
}

var amount1=document.getElementById("rateperkmm").value;
var numericExpression = /^[0-9 .]+$/;
if(!(amount1.match(numericExpression)))
{
          alert("Rate/Km has to be Numeric");

//document.getElementById("lblNameMsg2").style.display="";
        return false;
//document.ereceipt.amount.value=document.ereceipt.amount.value.substring(0, document.receipt.amount.value.length-1);
        //return false;
}


	return datevalidate();
	return true;
}
function dateformat(days)
 {
		if(days=='Jan')
			return(1);
		else
			if(days=='Feb')
				return(2);
			else
				if(days=='Mar')
					return(3);
				else
					if(days=='Apr')
						return(4);
					else
						if(days=='May')
							return(5);
						else
							if(days=='Jun')
								return(6);
							else
								if(days=='Jul')
									return(7);
								else
									if(days=='Aug')
										return(8);
									else
										if(days=='Sep')
											return(9);
										else
											if(days=='Oct')
												return(10);
											else
												if(days=='Nov')
													return(11);
												else
													if(days=='Dec')
														return(12);
	}
		  		  

	function datevalidate()
	{
		
		var date1=document.getElementById("data1").value;
		var date2=document.getElementById("data2").value;
		var dm1,dd1,dy1,dm2,dd2,dy2,dm11,dm22;
		dy1=date1.substring(0,2);
		dy2=date2.substring(0,2);
		dm1=date1.substring(3,6);
		dm2=date2.substring(3,6);

		dm11=dateformat(dm1);
		dm22=dateformat(dm2);	
		dd1=date1.substring(7,11);
		dd2=date2.substring(7,11);
		var date=new Date();
		var month=date.getMonth()+1;
		//var month1=date2.getMonth();
		var day=date.getDate();
		var year=date.getFullYear();
		
		
		
		
		if(dd1>dd2)
		{  
			
			
			
			alert("From date should not be greater than to date");
			//document.getElementById("data").value="";
			//document.getElementById("data1").value="";
			document.getElementById("data1").focus;
			return false;
			
		}
		
		else if(year==dd1 && year==dd2) if(dm11>dm22)
		{
			
			alert("From date should not be greater than to date");
			//document.getElementById("data").value="";
			//document.getElementById("data1").value="";
			document.getElementById("data1").focus;
			return false;
		}
		 if(dm1==dm2 && dd1==dd2) {
		if(dy1 > dy2)
		{
			alert("From date should not be greater than to date");
			//document.getElementById("data").value="";
			//document.getElementById("data1").value="";
			document.getElementById("data1").focus;
			return false;
		}
		}
		return true;
	}


	function empval(){
		
		var empname123=document.dateform.empname.value;
		document.getElementById("empn").style.display = "none";

		if(empname123==null || empname123=="" || empname123.length==0){
			document.getElementById("empn").style.display = "";
			return false;
		}
	}
	
function birt(){
	
	//alert("Hi");
	//var vehicle1=document.getElementById("vehlist").value;
	var a=validate();
	//alert("GetValidate------->"+a);
	if(a==true)
		{
		
		
	//var userid=document.getElementById("user").value;
	//alert( userid);
	 var owner=document.getElementById("ownername").value;
	var date1= document.getElementById("data1").value;
	var date2= document.getElementById("data2").value;
	var rateperhour= document.getElementById("rateperhour").value;
	var rateperkmm= document.getElementById("rateperkmm").value;
	var head= document.getElementById("heading").value;
	//alert(owner);
		
	var date = date1.split("-");
	var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun','Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
	for(var j=0;j<months.length;j++)
	{
	    if(date[1]==months[j])
	    {
	         date[1]=months.indexOf(months[j])+1;
	    }                      
	} 
	if(date[1]<10)
	{
	    date[1]='0'+date[1];
	}                        
	var formattedDate1 = date[2]+'-'+date[1]+'-'+date[0];
	formattedDate1=formattedDate1+" 00:00:00";
	//alert(date[1]);
	//alert(date[0]);
	
	var dat = date2.split("-");
	var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun','Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
	for(var j=0;j<months.length;j++){
	    if(dat[1]==months[j]){
	         dat[1]=months.indexOf(months[j])+1;
	     }                      
	} 
	if(dat[1]<10){
	    dat[1]='0'+dat[1];
	}                        
	var formattedDate2 = dat[2]+'-'+dat[1]+'-'+dat[0];
	formattedDate2=formattedDate2+" 23:59:59";
	
//	alert(vehicle);
//alert(date1);
//alert(formattedDate2);
//alert(formattedDate1);
	//alert(date2);
	//var owner1=owner.replace("Al","Al Rama");
	//alert(owner);
	//alert(owner1);
	var querystring="&Date1="+formattedDate1+"&Date2="+formattedDate2+"&Owner="+owner1+"&RatePerHour="+rateperhour+"&RatePerKm="+rateperkmm+"";
	//alert(querystring);
	document.getElementById("myIframe").src="http://myfleetview.com:8080/birttest/frameset?__report=Costing_report_1.rptdesign&RatePerKm="+rateperkmm+"&RatePerHour="+rateperhour+"&Date1="+formattedDate1+"&Date2="+formattedDate2+"&Owner="+owner+"&Head="+head+"&__showtitle=false";
//	document.getElementById("myIframe").src="http://103.8.126.138:8080/birttest/frameset?__report=Costing_report_1.rptdesign&Date1=2015-12-07 00:00:00&Date2=2015-12-09 23:59:59&Owner=Al Rama&RatePerHour=10&RatePerKm=50&__showtitle=false";
//	document.getElementById('myIframe').src="http://103.8.126.138:8080/birt/frameset?__report=driverreport1.rptdesign&_title='My Viewer'&date1=2015-03-01&date2=2015-08-28&drivername="+driver+"";
	document.getElementById("reportData").style.display="";
	//document.getElementById("footer").style.display="none";
	return true;
		}
	else
		{
			return false;
		}
}  
</script>

<body>
<%!
Connection conn=null,conn1=null;
Statement st,st1,stcom,strch,st2,st3,st11,stt1,stt2,st12,st13,st14,st15,st16,st4,sto,st20,st21,st22,strep;
String fromdate,search="",todate,sql,sql1,sql2,sql3,transporter,pageflag,datenew1,datenew2,fromdatetime,todatetime, vendor1,category1,startp,endp,ven,startp1,endp1,vendername,
categoryname,startplacename,endplacename,statusname,vehino,vehicleno,vehiclecode,Sqlv="",distributorname="";
 String sqlname=null,briefing="",sqlbrif=null,Dbriefing="",etaclose="",reportclose="",tripsrch="",vehsrch="",spsrch="",driv="";
 String	epsrch="",ownsrch="",statuasrch="",statuarsrun="",etaclose1="",sdtime1="",sddate1="",etdate="",repdate="",reportclose1="",STripId="",drivername="";
 
%><%
//Class.forName(MM_dbConn_DRIVER); 
conn = fleetview.ReturnConnection();
conn1 = fleetview.ReturnConnection1();	
st=conn.createStatement();
st1=conn.createStatement();
st2=conn.createStatement();
String data1="",data2="",rateperkmm="",rateperhr12345="",owner1="",head="";
//java.util.Date formattedDate1,formattedDate2;
String formattedDate1="",formattedDate2="";

%><%
try{
	String owner="";
	//owner=session.getValue("usertypevalue").toString(); 
	owner=session.getAttribute("usertypevalue").toString();
//out.println("Targetvalue1::>>>"+owner);%>
	<input type="hidden" name="ownername" id="ownername" value=<%=owner%> />
	<% System.out.println("owner:-"+owner);
	search=request.getParameter("searchid");
if(!(null==request.getQueryString()) && (null==search)){
fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data1")));
todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data2")));
%>

<%
datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
System.out.println("datenew1"+datenew1);
datenew2=datenew1;
}
datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
System.out.println("datenew1"+datenew1);
datenew2=datenew1;
%>
<%!
String datex1, datex2, data1, data2;
%>
<%
String ddx = request.getQueryString();
	
	if (ddx == null) {
		datex1 = datex2 = new SimpleDateFormat("dd-MMM-yyyy")
				.format(new java.util.Date());
		data1 = data2 = new SimpleDateFormat("yyyy-MM-dd")
				.format(new java.util.Date());
	
		/* Calendar c = Calendar.getInstance();   // this takes current date
	    c.set(Calendar.DAY_OF_MOvar numericExpression = /^[0-9 .]+$/;
        if(!(amount.match(numericExpression)))
        {
                  //alert("Payment value has to be Numeric");

document.getElementById("lblNameMsg2").style.display="";
                return false;
document.ereceipt.amount.value=document.ereceipt.amount.value.substring(0, document.receipt.amount.value.length-1);
                //return false;
        }
NTH, 1);
	    System.out.println(" current date "+new SimpleDateFormat("dd-MMM-yyyy").format(c.getTime())); 
	    datex1=new SimpleDateFormat("dd-MMM-yyyy").format(c.getTime()); */
	
	
	} else {
		data1 = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(request.getParameter("data1")));
		data2 = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(request.getParameter("data2")));

		datex1 = request.getParameter("data1");
		datex2 = request.getParameter("data2");
	}

System.out.println(" datex1 "+datex1+" datex2 "+datex2);
String dt = new SimpleDateFormat("yyyy-MM-dd")
.format(new SimpleDateFormat("dd-MMM-yyyy")
	.parse(datex1));

String dt1 = new SimpleDateFormat("yyyy-MM-dd")
.format(new SimpleDateFormat("dd-MMM-yyyy")
	.parse(datex2));
	


%>

<%
	%>

<table border="2" width="100%" align="center" class="stats">
<tr>
<td>
	<font size="3"><B>Trips Costing Report</B></font></td>
</tr>
</table>


<form name="dateform" id="dateform" action="" method="get" onsubmit="return validate();">
<table border="2" align="center" class="sortable_entry"><tr>
<td><b>From </b>&nbsp;&nbsp;&nbsp;&nbsp;
<input type="text" id="data1" name="data1" class="element text medium" style="width: 100px" value="<%=datenew1%>"  size="15" readonly/>
  </td>
<script type="text/javascript">
  Calendar.setup(    {
      inputField  : "data1",         // ID of the input field
      ifFormat    : "%d-%b-%Y",     // the date format
      button      : "data1"       // ID of the button
    }  );
</script><td>
<b>To</b> &nbsp;&nbsp;&nbsp;&nbsp;
<input type="text" id="data2" name="data2" class="element text medium" style="width: 100px" value="<%=datenew2%>" size="15" readonly/>
</td>
<script type="text/javascript">
  Calendar.setup(    {
      inputField  : "data2",         // ID of the input field
      ifFormat    : "%d-%b-%Y",    // the date format
      button      : "data2"       // ID of the button
    }  );
</script>

<td>
<font color="red">*</font><label name="rateperhr" id="rateperhr" ><b>Rate Per/Hr :</b></label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" class="element text small" size="10" name="rateperhour" id="rateperhour" /><label name="empn" id="empn" style="display: none;"><font color="red">Please Enter Rate/Hr</font></label></td>
<td>
<font color="red">*</font><label name="rateperkm" id="rateperkm" ><b>Rate Per/Km :</b></label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" class="element text small" size="10" name="rateperkmm" id="rateperkmm" /></td>
<td>
&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" name="button" style="border-style: outset; border-color: black" value="Submit" onclick="birt()" ">
</td></tr></table>


<% 
String rateperkm="",rateperhr="",newtriptimemin1="",newtriptimemin123="",newtriptimemin12345="";
String TripID="",VehRegNo="",DriverName="",OwnerName="",StartPlace="",StartDate="",EndPlace="",EndDate="",noofdays="",triptime="",joborderno="",revenue="",containerno="",KmTravelled="";
/* String sqlquery="select a.TripID,a.VehRegNo,a.DriverName,a.OwnerName,b.StartPlace,b.StartDate,b.EndPlace,b.EndDate,DateDIFF(b.EndDate,b.StartDate) as noofdays,TimeDIFF(b.EndDate,b.StartDate) as triptime,a.joborderno,a.revenue,a.containerno,b.KmTravelled from db_gps.t_startedjourney a inner join db_gps.t_completedjourney b on a.TripID=b.TripID where a.StartDate>='2015-12-07' and b.EndDate<='2015-12-09'";
System.out.println("search is***"+sqlquery );

ResultSet rssrch=st2.executeQuery(sqlquery);
rateperkm=request.getParameter("rateperkmm");
rateperhr=request.getParameter("rateperhour");

double newrateperkm = Double.parseDouble(rateperkm);
double newrateperhr = Double.parseDouble(rateperhr);

while(rssrch.next())
{
	TripID=rssrch.getString("a.TripID");
	VehRegNo=rssrch.getString("a.VehRegNo");
	DriverName=rssrch.getString("a.DriverName");
	OwnerName=rssrch.getString("a.OwnerName");
	DriverName=rssrch.getString("a.DriverName");
	StartPlace=rssrch.getString("b.StartPlace");
	StartDate=rssrch.getString("b.StartDate");
	EndPlace=rssrch.getString("b.EndPlace");
	EndDate=rssrch.getString("b.EndDate");
	noofdays=rssrch.getString("noofdays");
	triptime=rssrch.getString("triptime");
	joborderno=rssrch.getString("a.joborderno");
	revenue=rssrch.getString("a.revenue");
	containerno=rssrch.getString("a.containerno");
	KmTravelled=rssrch.getString("b.KmTravelled");
	
	out.println("triptime is***"+triptime);
	//triptime.sp
	if(triptime.contains(":")){
		//triptime=triptime.replaceFirst(regex, replacement)
				//triptime = triptime.substring(0,triptime.length() - 3);
				
		     java.util.Date dt=new SimpleDateFormat("HH:mm:ss").parse(triptime);
				String triptimehr=""+dt.getHours();
				String triptimemin=""+dt.getMinutes();	
	            //ftime3=""+dt.getSeconds();
				 //StringTokenizer st = new StringTokenizer(triptime," "); 
				double triptimemin1 = Double.parseDouble(triptimemin);
				double newtriptimemin=((triptimemin1/60)*100);
				 newtriptimemin1 = Double.toString(newtriptimemin);
				 newtriptimemin123 = newtriptimemin1.substring(0, 1);
				 newtriptimemin12345=triptimehr+"."+newtriptimemin123;
				
				
		//StringTokenizer st = new StringTokenizer(triptime," "); 
				
		//triptime=triptime.replaceAll(":", ".");
		out.println("newtriptimemin12345 is:-"+newtriptimemin12345);
		//fixedtm.replaceAll(".", ":");
		out.println("fixedtm2:-"+triptime);
	}
	double newKmTravelled = Double.parseDouble(KmTravelled);
	out.println("newKmTravelled:-"+newKmTravelled);
	//double newtriptime = Double.parseDouble(triptime);
	double newtriptime = Double.parseDouble(newtriptimemin12345);
	out.println("newtriptime in first");
	out.println("newtriptime:-"+newtriptime);
	out.println("newtriptime in last");
	
	double TOTALCOST=(newKmTravelled * newrateperkm) + (newtriptime * newrateperhr);
System.out.println("search is***"+TOTALCOST);
out.println("TOTALCOST is***"+TOTALCOST);
System.out.println("search is***"+KmTravelled);

} */
 data1 =request.getParameter("data1");
//out.println("data1:-"+data1);
data2 =request.getParameter("data2");
//out.println("data2:-"+data2);
try{
	formattedDate1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data1")));
	// formattedDate1=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(data1));
 //formattedDate1=new SimpleDateFormat("yyyy-MM-dd").parse(data1);
 //out.println("formattedDate1:-"+formattedDate1);
 //formattedDate2=new SimpleDateFormat("yyyy-MM-dd").parse(data2);
 formattedDate2 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data2")));
 //formattedDate2=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(data2));
 //out.println("formattedDate2:-"+formattedDate2);
}catch(Exception e){
	//out.println(e);
}
 rateperkmm =request.getParameter("rateperkmm");
 //out.println("rateperkmm:-"+rateperkmm);
 rateperhr12345 =request.getParameter("rateperhour");
 //out.println("rateperhr12345:-"+rateperhr12345);
 //owner="Al Rama";
 //head="Test Report";
 head="Trip Costing Report From "+new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(dt))+" To "+new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(dt1));
 //out.println("Heading"+head);
%>
<input type="hidden" id="heading" name="heading" value="<%=head%>" />
<%//head =request.getParameter("heading");
//out.println("Head"+head); %>
 <div id="reportData1">
<%-- <iframe id="myIframe" width="100%" height="850px" src="http://myfleetview.com:8080/birt/frameset?__report=JRM_report.rptdesign&userid=<%=UserID%>&__showtitle=false"> --%> 
<!-- <iframe id="myIframe" width="100%" height="850px" src="http://103.8.126.138:8080/birttest/frameset?__report=Costing_report_1.rptdesign&Date1=2015-12-07 00:00:00&Date2=2015-12-09 23:59:59&Owner=Al Rama&RatePerHour=10&RatePerKm=50&Head=Test&__showtitle=false"> -->
<iframe id="myIframe" width="100%" height="850px" src="http://myfleetview.com:8080/birttest/frameset?__report=Costing_report_1.rptdesign&RatePerKm=<%=rateperkmm%>&RatePerHour=<%=rateperhr12345 %>&Date1=<%=dt %>&Date2=<%=dt1 %>&Owner=<%=owner %>&Head=<%=head %>&__showtitle=false">  
</iframe> 

 </div> 
 
 <% String Bt=request.getParameter("button");
 //out.println("IN hereeeeeeeeeeee"+Bt);
		if(Bt=="Submit")
		{ //out.println("IN hereeeeeeeeeeee inside");%>
<div id="reportData">
<%-- <iframe id="myIframe" width="100%" height="850px" src="http://myfleetview.com:8080/birt/frameset?__report=JRM_report.rptdesign&userid=<%=UserID%>&__showtitle=false"> --%> 
<!-- <iframe id="myIframe" width="100%" height="850px" src="http://103.8.126.138:8080/birttest/frameset?__report=Costing_report_1.rptdesign&Date1=2015-12-07 00:00:00&Date2=2015-12-09 23:59:59&Owner=Al Rama&RatePerHour=10&RatePerKm=50&Head=Test&__showtitle=false"> -->
<iframe id="myIframe" width="100%" height="850px" src="">  
</iframe> 
<%
		}
 %>
 
 </div>
 
<% 
}
catch(Exception e)
{e.printStackTrace();}
finally{		try
		{			conn.close();		}catch(Exception e)
		{}
		try		{
			conn1.close();		}catch(Exception e)		{}
		
		try
		{
		fleetview.closeConnection1();
		}catch(Exception e)
		{}
		try
		{
		fleetview.closeConnection();
		}catch(Exception e)
		{
		}

}


%>

</form>
</body>
</html>
<%-- <jsp:include page="footernew.jsp"/> --%>
</jsp:useBean>