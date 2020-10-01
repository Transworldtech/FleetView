<%@ include file="headernew.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

%>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/graph.js"></SCRIPT>
<script language="javascript">
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


function validate()
  {
  	if(document.getElementById("data").value=="")
  	{
  	
  		alert("Please select the from date");
  		return false;
  	}
  if(document.getElementById("data1").value=="")
  	{
  	
  		alert("Please select the to date");
  		return false;
  	}
  	return datevalidate();
  	
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
	  var date1=document.getElementById("data").value;
  //  alert("date1-------->"+date1);
	var date2=document.getElementById("data1").value;
//alert("date2-------------->"+date2);

	var dm1,dd1,dy1,dm2,dd2,dy2;
	var dd11,yy11,mm1,mm2,mm11,dd22,yy22,mm22,dd33,mm3,mm33,yy33;
	dd11=date1.substring(0,2);
	//alert("dd11"+dd11);
	dd22=date2.substring(0,2);
	//alert("dd22"+dd22);
	mm1=date1.substring(3,6);
	//alert("mm1"+mm1);
	mm2=date2.substring(3,6);
	//alert("mm2"+mm2);
	mm11=dateformat(mm1);
	//alert("mm11"+mm11);
	mm22=dateformat(mm2);
	//alert("mm22"+mm22);
	
	yy11=date1.substring(7,11);
	//alert("yy11---->"+yy11);
	yy22=date2.substring(7,11);
	//alert("yy22---->"+yy22);
	
	var date=new Date();
//	alert(date);
var month=date.getMonth()+1;
//alert(month);
	var day=date.getDate();
	//alert(day);
	var year=date.getFullYear();
	//alert(year);

	if(yy11>year  || yy22>year) 
	{
		alert("selected date should not be greater than todays date");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}
	else if(year==yy11 && year==yy22)
	{
			if(mm11>month || mm22>month)
		{
			alert("selected date should not be greater than todays date");
			document.getElementById("data").value="";
			document.getElementById("data1").value="";
			document.getElementById("data").focus;
			return false;
		}
	}
	if(mm11==month && mm22==month)
	{
		if(dd11>day || dd22>day)
		{
			alert("selected date should not be greater than todays date");
			document.getElementById("data").value="";
			document.getElementById("data1").value="";
			document.getElementById("data").focus;
			return false;
		}
	}

	if(yy11 > yy22)
	{
		alert("From date year should not be greater than to date year");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}
	else if(year==yy11 && year==yy22)
	{
		 if(mm11>mm22)
	{
		alert("From date month should not be greater than to date month");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}
	}
	if(mm11==month && mm22==month) 
	{
		if(yy11==yy22)
		{
		if(dd11 > dd22)
		{
			alert("From date should not be greater than to date");
			document.getElementById("data").value="";
			document.getElementById("data1").value="";
			document.getElementById("data").focus;
			return false;
		}
		}
	}
	else
		if(yy11<yy22)
		{
			return true;
		}
	else
		if(dd11 > dd22)
	{
			if(mm11<mm22)
			{
				return true;
			}
			
		alert("From date should not be greater than to date");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}
	  
	return true;
}

  function gotoPrint(divName)  
  {  
  	  
  	  var printContents = document.getElementById(divName).innerHTML; 
  	  var originalContents = document.body.innerHTML; 
  	  document.body.innerHTML = printContents;  
  	  window.print();
  	  document.body.innerHTML = originalContents;  
  }

  function gotoExcel(elemId, frmFldId)  
  {  
  	      
            var obj = document.getElementById(elemId);  
            var oFld = document.getElementById(frmFldId); 
            oFld.value = obj.innerHTML;  
            document.driver.action ="excel.jsp";
            document.forms["driver"].submit();
  } 
  
</script>
<%
String ddx=request.getQueryString();
if(ddx==null)
{
	data1=data2=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
}
else
{
	data1=request.getParameter("data");
	data2=request.getParameter("data1");
}
System.out.println("data1   "+data1);
System.out.println("data2   "+data2);
//String data5=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(data1));
//String data6=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(data2));
%>
<table border="0" width="100%" class="stats" align="center">
<tr align="center"><td align="center">

<!-- code start Here -->

<form name="dateform" action="" method="get" onsubmit="return validate();" >

<center >
<table class="stats" align="center" border="0" style="width: 600px;" >

<tr align="center"><td><b>From</b>&nbsp;&nbsp;
<input type="text" id="data" name="data"  value="<%=data1%>"  size="15"  readonly/>
 <script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data",         // ID of the input field
      ifFormat    : "%d-%b-%Y",     // the date format
      button      : "data"       // ID of the button
    }
  );
</script> </td>
<!--<td align="left">-->
<!--<input type="button" name="From Date" value="From Date" id="trigger" class="formElement">-->
<!---->
<!--</td>-->
<td>
<b>To</b>&nbsp;&nbsp;
<input type="text" id="data1" name="data1"  value="<%=data2%>" size="15"  readonly/>
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data1",         // ID of the input field
      ifFormat    : "%d-%b-%Y",    // the date format
      button      : "data1"       // ID of the button
    }
  );
</script></td>
<!--<td align="left">-->
<!--  <input type="button" name="To Date" value="To Date" id="trigger1" class="formElement">-->
<!---->
<!--</td>-->
<td><input type="submit" name="submit" id="submit" value="submit" ></td>
</tr>

</table>
</center>

</form>
</td></tr>
<tr align="center">
<td align="center">
<%
String dd=request.getQueryString();
if(dd==null)
{
%>

<table class="stats">
<tr><td>
<center class='bodyText'><b>Please select the dates to display the Driver Rating report</b></center>
</td></tr>
</table>
<br>
<br>
<%
}
else
{
%>

<%!
Connection conn=null, conn1=null;
Statement st, st1, st2,st3,st4,st8;
String user,sql,sql1,sql2;
String data1, data2,showdate1,showdate,DriverName,Owner;
int OScount, RAcount, RDcount,Distance;
double Rating;
int OS1,RA1,RD1,CD1,DT1,ST1,RU1,ND1;
 %>
<%
OS1=0;
RA1=0;
RD1=0;
CD1=0;
DT1=0;
ST1=0;
RU1=0;
ND1=0;
Rating = 0.0;
data1=request.getParameter("data");
data2=request.getParameter("data1");
System.out.println("data1   "+data1);
System.out.println("data2   "+data2);
Format formatter1 = new SimpleDateFormat("yyyy-MM-dd");
Format formatter2 = new SimpleDateFormat("dd-MMM-yyyy");
String data3 = "",data4 = "";
data3 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(data1));
data4 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(data2));
try{
	//Class.forName(MM_dbConn_DRIVER); 
	conn = fleetview.ReturnConnection();
	conn1 = fleetview.ReturnConnection1();
	st=conn.createStatement();
	st1=conn.createStatement();
	st2=conn1.createStatement();
	st3=conn1.createStatement();
	st4=conn1.createStatement();
	st8=conn1.createStatement();


%>
<form id="driver" name="driver"  method="post" >
<div id="table1">
<table class="stats">
<tr><th><font size="3">Driver Wise Exception Report for <%=session.getAttribute("usertypevalue").toString()%> From <%
java.util.Date ShowDate = new SimpleDateFormat("dd-MMM-yyyy").parse(data1);

showdate = formatter2.format(ShowDate);
out.print(showdate);
%> to <%
java.util.Date ShowDate1 = new SimpleDateFormat("dd-MMM-yyyy").parse(data2);

showdate1 = formatter2.format(ShowDate1);
out.print(showdate1);
String exportFileName=session.getAttribute("user").toString()+"_DriverWiseExceptionReport.xls";

%></font>  <div class="bodyText" align="right">
                           <input type="hidden" id="tableHTML" name="tableHTML" value="" />  
                           <input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 
     
                           <a href="#" style="font-weight: bold; color: black; " onclick="gotoPrint('table1');">
                           <img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img></a> 
      
                           <a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('table1','tableHTML');">
                           <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img></a>
                           <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%>
                           </div>
 </table>
<%
String usertypevalue=session.getAttribute("usertypevalue").toString();
System.out.println(" User ");
String typeofuser=session.getAttribute("TypeofUser").toString();
String SrchTrans="";
System.out.println(usertypevalue+" User "+typeofuser);
if(typeofuser.equalsIgnoreCase("Group"))
{System.out.println("IN Group ");
	sql="SELECT VehRegno FROM db_gps.t_group WHERE GPName='"+usertypevalue+"' group by VehRegno";
	System.out.println("*****8     "+sql);
	ResultSet rstGrp=st3.executeQuery(sql);
	

	SrchTrans="(";
	int k = 0;
	while(rstGrp.next())
	{
		SrchTrans=SrchTrans+"'"+rstGrp.getString("VehRegno")+"',";
		k++;
	}
	SrchTrans=SrchTrans.substring(0,SrchTrans.length()-1)+")";

}
else
{
	System.out.println("IN Else ");
	SrchTrans="('"+usertypevalue+"')";	
}
	

System.out.println(" SrchTrans : "+SrchTrans);



sql="select dcode from t_driver_ds where TheDate >='"+data3+"' and TheDate <='"+data4+"' and Transporter in "+SrchTrans+" group by dcode";
ResultSet rstdcode=st3.executeQuery(sql);
System.out.println("*****8     "+sql);

String dcodes="(";
int k = 0;
while(rstdcode.next())
{
	dcodes=dcodes+"'"+rstdcode.getString("dcode")+"',";
	k++;
}
//System.out.println("dcodes   "+dcodes);

if(k>0)
{
dcodes=dcodes.substring(0,dcodes.length()-1)+")";
%>
<div align="center">
<table  class="sortable"  border="1" style="width: 700px;text-align: center;" >
<tr>
<td class="hed">Sr.</td>
<td class="hed">Driver Name</td>
<td class="hed">Driver Code</td>
<td class="hed">OS</td>
<td class="hed">RA</td>
<td class="hed">RD</td>
<td class="hed">CD</td>
<td class="hed">DT</td>
<td class="hed">Stops</td>
<td class="hed">Run <br>Hrs.</td>
<td class="hed">ND</td>
<td class="hed">Rating</td>
</tr>
<%

//System.out.println("dcodes   "+dcodes);
sql="select Distinct(DriverID),DriverName from t_drivers where owner in "+SrchTrans+"  and  DriverName <>'-'  and DriverID in"+dcodes+" order by DriverName";
System.out.println("*****8Choose Driver     "+sql);
ResultSet rst=st.executeQuery(sql);
int i=1;
while(rst.next())
{
%>
<tr>
<td align="right" style="width: 10px;"><div align="right"><%=i%></div></td>
<%
String owner1="";
try{
String sqlowner="select * from db_gps.t_drivers where DriverID='"+rst.getString("DriverID")+"' and DriverName='"+rst.getString("DriverName")+"' limit 1";
System.out.println("Owner query is " +sqlowner);
ResultSet rsowner=st8.executeQuery(sqlowner);
if(rsowner.next())
{
	owner1=rsowner.getString("Owner");
}
System.out.println("Owner Name is " +owner1);
}catch(Exception e){e.printStackTrace();}
%>
<td align="left" style="width: 150px;"><div align="left" ><a href="driver_exceptions.jsp?data1=<%=data3%>&data2=<%=data4%>&dcode=<%=rst.getString("DriverID")%>&dname=<%=rst.getString("DriverName")%>&transporter=<%=owner1%>"><%=rst.getString("DriverName")%></a></div></td>
<td align="right" style="width: 70px;"><div  align="right" ><%=rst.getString("DriverID")%></div></td>

<%
sql = "select sum(OSCount) as os,sum(RACount) as ra,sum(RDCount) as rd,sum(CRCount) as cd,sum(StopCount) as st,sum(Distance) as dt,sum(Time_To_sec(RDuration)) as HR,sum(Rating) as rating from db_gpsExceptions.t_driver_ds where TheDate>= '"+data3+"' and TheDate <=  '"+data4+"' and Dcode='"+rst.getString("DriverID")+"'  and Transporter in "+SrchTrans+" ";
ResultSet rssum = st2.executeQuery(sql);
if(rssum.next())
{
	%>
	<td align="right" style="width: 25px;"><div align="right" ><% out.print(rssum.getInt("os")); OS1=OS1+rssum.getInt("os"); %></div></td>
	<td align="right"  style="width: 25px;"><div align="right"><% out.print(rssum.getInt("ra")); RA1=RA1+rssum.getInt("ra"); %></div></td>
	<td align="right"  style="width: 25px;"><div align="right"><% out.print(rssum.getInt("rd")); RD1=RD1+rssum.getInt("rd"); %></div></td>
	<td align="right"  style="width: 25px;"><div align="right"><% out.print(rssum.getInt("cd")); CD1=CD1+rssum.getInt("cd"); %></div></td>
	<td align="right"  style="width: 25px;"><div align="right"><% out.print(rssum.getInt("dt")); DT1=DT1+rssum.getInt("dt"); %></div></td>
	<td align="right"  style="width: 25px;"><div align="right"><% out.print(rssum.getInt("st")); ST1=ST1+rssum.getInt("st"); %></div></td>
	<td align="right"  style="width: 25px;"><div align="right"><% String rundur = "";
	int min = 0,hrs = 0,min1 = 0;
	
	min1 = rssum.getInt("HR")/60;
	hrs = min1/60;
	min = min1%60;
	
	if(hrs>9)
	{
		rundur = rundur+hrs;
	}
	else
	{
		rundur = "0"+hrs;
	}
	
	if(min>9)
	{
		rundur = rundur+":"+min;
	}
	else
	{
		rundur = rundur+":0"+min;
	}
	
	out.print(rundur);
	RU1=RU1+rssum.getInt("HR");%></div></td>
	<td align="right"  style="width: 25px;"><div align="right">
	<%
	String sql1="select count(*) ND from db_gpsExceptions.t_driver_ds where Dcode='"+rst.getString("DriverID")+"' and TheDate >='"+data3+"' and TheDate <='"+data4+"' and ND='Yes'  and  Transporter in "+SrchTrans+" ";
	ResultSet rstnd=st1.executeQuery(sql1);
	if(rstnd.next())
	{
		if(rstnd.getInt("ND") > 0) 
		{
			out.print("Yes");
			ND1++;
		}
		else
		{
			out.print("No");
		}
	}
	%>
	</div>
	</td>
	<td align="right"  style="width: 25px;"><div align="right">
	<% 
	String rt=rssum.getString("rating");
	if(rt.length() > 5)
	{
		out.print(rt.substring(0,rt.indexOf(".")+3));
	}	
	else
	{
	out.print(rt);
	}
	Rating=Rating+rssum.getDouble("rating");
	
	%>
	</div>
	</td>
	<%
}

/*
sql="select count(*) as os from t_driver_overspeed where Dcode='"+rst.getString("DriverID")+"' and FromDate >='"+data3+"' and FromDate <='"+data4+"'";
ResultSet rstos=st2.executeQuery(sql);
if(rstos.next())
{
	out.print(rstos.getInt("OS"));
	OS1=OS1+rstos.getInt("OS");
}*/
%>
</tr>

<%
/*sql="select count(*) as RA from t_driver_ra where Dcode='"+rst.getString("DriverID")+"' and TheDate >='"+data3+"' and TheDate <='"+data4+"'";
ResultSet rstra=st2.executeQuery(sql);
if(rstra.next())
{
	out.print(rstra.getInt("RA"));
	RA1=RA1+rstra.getInt("RA");
}*/
%>
<!--<td align="right" style="width: 25px;"><div align="right">-->
<%
/*sql="select count(*) as RD from t_driver_rd where Dcode='"+rst.getString("DriverID")+"' and TheDate >='"+data3+"' and TheDate <='"+data4+"'";
ResultSet rstrd=st2.executeQuery(sql);
if(rstrd.next())
{
	out.print(rstrd.getInt("RD"));
	RD1=RD1+rstrd.getInt("RD");
}*/
%><!--</div>-->
<!--</td>-->
<!--<td align="right" style="width: 25px;"><div align="right">-->
<%
/*sql="select count(*) as CR from t_driver_cr where Dcode='"+rst.getString("DriverID")+"' and FromDate >='"+data3+"' and FromDate <='"+data4+"'";
ResultSet rstcr=st2.executeQuery(sql);
if(rstcr.next())
{
	out.print(rstcr.getInt("CR"));
	CD1=CD1+rstcr.getInt("CR");
}*/
%>
<!--</div>-->
<!--</td>-->
<!--<td align="right" style="width: 25px;"><div align="right">-->
<%
/*sql="select sum(Distance) as DS from t_driver_ds where Dcode='"+rst.getString("DriverID")+"' and TheDate >='"+data3+"' and TheDate <='"+data4+"'";
ResultSet rstds=st2.executeQuery(sql);
if(rstds.next())
{
	out.print(rstds.getInt("DS"));
	DT1=DT1+rstds.getInt("DS");
}*/
%>
<!--</div>-->
<!--</td>-->
<!--<td align="right" style="width: 25px;"><div align="right">-->
<%
/*sql="select count(*) as ST from t_driver_stsp where Dcode='"+rst.getString("DriverID")+"' and FromDate >='"+data3+"' and FromDate <='"+data4+"'";
ResultSet rstst=st2.executeQuery(sql);
if(rstst.next())
{
	out.print(rstst.getInt("ST"));
	ST1=ST1+rstst.getInt("ST");
}*/
%>
<!--</div>-->
<!--</td>-->
<!--<td align="right" style="width: 25px;"><div align="right">-->
<%
//sql="select sum(HOUR(RDuration)*60 + MINUTE(RDuration)+SECOND(RDuration)/60)/60 as HR from t_driver_ds where Dcode='"+rst.getString("DriverID")+"' and TheDate >='"+data3+"' and TheDate <='"+data4+"'";
/*sql="select sum(Time_To_sec(RDuration)) as HR from t_driver_ds where Dcode='"+rst.getString("DriverID")+"' and TheDate >='"+data3+"' and TheDate <='"+data4+"'";

ResultSet rsthr=st2.executeQuery(sql);
if(rsthr.next())
{
	String rundur = "";
	int min = 0,hrs = 0,min1 = 0;
	
	min1 = rsthr.getInt("HR")/60;
	hrs = min1/60;
	min = min1%60;
	
	if(hrs>9)
	{
		rundur = rundur+hrs;
	}
	else
	{
		rundur = "0"+hrs;
	}
	
	if(min>9)
	{
		rundur = rundur+":"+min;
	}
	else
	{
		rundur = rundur+":0"+min;
	}
	
	out.print(rundur);
	RU1=RU1+rsthr.getInt("HR");
}*/
%>
<!--</div>-->
<!--</td>-->
<!--<td align="left" style="width: 25px;">-->
<!--<div align="left">-->
<%
/*sql="select count(*) ND from t_driver_ds where Dcode='"+rst.getString("DriverID")+"' and TheDate >='"+data3+"' and TheDate <='"+data4+"' and ND='Yes'";
ResultSet rstnd=st2.executeQuery(sql);
if(rstnd.next())
{
	if(rstnd.getInt("ND") > 0)
	{
		out.print("Yes");
		ND1++;
	}
	else
	{
		out.print("No");
	}
}*/
%>
<!--</div>-->
<!--</td>-->
<!--<td align="right" style="width: 25px;">-->
<!--<div align="right">-->
<%
/*sql="select sum(Rating)  as rating  from t_driver_ds where Dcode='"+rst.getString("DriverID")+"' and TheDate >='"+data3+"' and TheDate <='"+data4+"' ";
ResultSet rstrat=st2.executeQuery(sql);
if(rstrat.next())
{	
		String rt=rstrat.getString("rating");
		if(rt.length() > 5)
		{
			out.print(rt.substring(0,rt.indexOf(".")+3));
		}	
		else
		{
		out.print(rt);
		}
		Rating=Rating+rstrat.getDouble("rating");
}*/
%>
<!--</div>-->
<!--</td>-->
<!--</tr>-->
<%
i++;
}

String totdur = "";
int totmin1 = 0,tothrs = 0,totmin = 0;
totmin1 = RU1/60;
tothrs = totmin1/60;
totmin = totmin1%60;
if(tothrs>9)
{
	totdur = totdur+tothrs;
}
else
{
	totdur = "0"+tothrs;
}

if(totmin>9)
{
	totdur = totdur+":"+totmin;
}
else
{
	totdur = totdur+":0"+totmin;
}

String rat = "";
String rt=Rating+"";
if(rt.length() > 5)
{
	rat = rt.substring(0,rt.indexOf(".")+3);
}	
else
{
  rat = rt;
}

%>
<tr >
<td colspan="3" class="hed">Total </td>
<td class="hed" align="right"><div align="right"><%=OS1%></div></td>
<td class="hed" align="right"><div align="right"><%=RA1%></div></td>
<td class="hed" align="right"><div align="right"><%=RD1%></div></td>
<td class="hed" align="right"><div align="right"><%=CD1%></div></td>
<td class="hed" align="right"><div align="right"><%=DT1%></div></td>
<td class="hed" align="right"><div align="right"><%=ST1%></div></td>
<td class="hed" align="right"><div align="right"><%=totdur%></div></td>
<td class="hed" align="right"><div align="right"><%=ND1%></div></td>
<td class="hed" align="right"><div align="right"><%=rat%></div></td>
</tr>
</table>
</div>
<%
}
else
{
	%>
	<table align="center" class="stats"><tr><td align="center"><font size="3">No Data Available for selected date range  </font> </td></tr></table>
	<%
}
}catch(Exception e)
{
	System.out.print("Exception -->"+ e);
}
finally
{
	conn.close();
	conn1.close();
	try
	{fleetview.closeConnection1();}
	catch(Exception e)
	{}

	try
	{fleetview.closeConnection();}
	catch(Exception e)
	{}
}
}
%>

<!-- code end here -->
</div>
</form>
</td></tr>
</table>

<!-- footer start here -->
</jsp:useBean>
<%@ include file="footernew.jsp" %>