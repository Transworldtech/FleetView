<%@ include file="headernew.jsp" %>

<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body style="font-family: Arial">
<script type="text/javascript">
function gotoPrint(divName)  
{    
	  var printContents = document.getElementById(divName).innerHTML; 
	  var originalContents = document.body.innerHTML; 
	  document.body.innerHTML = printContents;  
	  window.print();
	  document.body.innerHTML = originalContents;  
}

function gotoExcel(elemId,frmFldId,filename)  
{  
	try
	{
	//alert("Hiii");
	    window.location.reload();
	     var obj = document.getElementById(elemId);  
          var oFld = document.getElementById(frmFldId); 
          oFld.value = obj.innerHTML;  
          document.DriverIncentive.action ="excel.jsp";
          document.forms["DriverIncentive"].submit();
	}
	catch(e)
	{
		alert(e);
	}
} 


</script>
<%
System.out.println("*********     hfgsbhdvfdsm");
java.util.Date NewDate =new java.util.Date();
long dateMillis = NewDate.getTime();
long dayInMillis = 1000* 60 *60 *24;
dateMillis = dateMillis - dayInMillis;
NewDate.setTime(dateMillis);
Format NewFormatter = new SimpleDateFormat("yyyy-MM-dd");
Format NewFormatter1 = new SimpleDateFormat("dd-MMM-yyyy");
String data1 = NewFormatter.format(NewDate);
String data2 = NewFormatter.format(NewDate);
String data3 = NewFormatter1.format(NewDate);
String data4 = NewFormatter1.format(NewDate);
session.setAttribute("data1",data1);
session.setAttribute("data2",data2);
session.setAttribute("data3",data3);
session.setAttribute("data4",data4);
String user,usertypevalue;
user=session.getAttribute("user").toString();
usertypevalue=session.getAttribute("usertypevalue").toString();
String exportFileName=session.getAttribute("user").toString()+"_DriverIncentiveForTankerReport.xls";  
String Mon=request.getParameter("data1");
String Yer=request.getParameter("data2");
String Mon1=request.getParameter("data3");
String Yer1=request.getParameter("data4");
if(Mon == null)
{
	Calendar Cal = Calendar.getInstance();
	int Monint = Cal.get(Calendar.MONTH)+1;
	if(Monint < 10)
	{
		Mon = "0"+Monint;
		Mon1 = "0"+Monint;
	}
	else
	{
		Mon = ""+Monint;
		Mon1 = ""+Monint;
	}
	
	Yer = ""+Cal.get(Calendar.YEAR);
	Yer1 = ""+Cal.get(Calendar.YEAR);
}
System.out.println("4673    "+Mon+"   "+Yer);
String QueryDate=Yer+"-"+Mon+"-01";
String QueryDate1 =Yer1+"-"+Mon1+"-01";
System.out.println("QueryDate "+QueryDate);
System.out.println("QueryDate1 "+QueryDate1);
String sql = "";
%>

	<div style="margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em" align="center">
<form name="driverincentive" method="get">
<%System.out.println("\n$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");%>
  
		<table align="center" border="0" style="text-align: center; margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em">
		<tr>
		<td align="center">
		 <table style="width: 500px;">
                 <tr>
                 <td align="center" ><br>
                <font size="2" face="Arial"><b>From</b></font>&nbsp;
<select name="data1" style="">
<%
if(Mon == "01" ||  Mon.equalsIgnoreCase("01"))
	{
	%>
	<option value="01" selected="selected" >JAN</option>
	<%
	}
	else
	{
		%>
		<option value="01" selected="selected" >JAN</option>
		<%
	}
if(Mon == "02" ||  Mon.equalsIgnoreCase("02"))
{
%>
<option value="02" selected="selected" >FEB</option>
<%
}
else
{
	%>
	<option value="02" >FEB</option>
	<%
}
if(Mon == "03" ||  Mon.equalsIgnoreCase("03"))
{
%>
<option value="03" selected="selected" >MAR</option>
<%
}
else
{
	%>
	<option value="03" >MAR</option>
	<%
}
if(Mon == "04" ||  Mon.equalsIgnoreCase("04"))
{
%>
<option value="04" selected="selected" >APR</option>
<%
}
else
{
	%>
	<option value="04" >APR</option>
	<%
}
if(Mon == "05" ||  Mon.equalsIgnoreCase("05"))
{
%>
<option value="05" selected="selected" >MAY</option>
<%
}
else
{
	%>
	<option value="05" >MAY</option>
	<%
}
if(Mon == "06" ||  Mon.equalsIgnoreCase("06"))
{
%>
<option value="06" selected="selected" >JUNE</option>
<%
}
else
{
	%>
	<option value="06" >JUNE</option>
	<%
}
if(Mon == "07" ||  Mon.equalsIgnoreCase("07"))
{
%>
<option value="07" selected="selected" >JULY</option>
<%
}
else
{
	%>
	<option value="07" >JULY</option>
	<%
}
if(Mon == "08" ||  Mon.equalsIgnoreCase("08"))
{
%>
<option value="08" selected="selected" >AUG</option>
<%
}
else
{
	%>
	<option value="08" >AUG</option>
	<%
}
if(Mon == "09" ||  Mon.equalsIgnoreCase("09"))
{
%>
<option value="09" selected="selected" >SEPT</option>
<%
}
else
{
	%>
	<option value="09" >SEPT</option>
	<%
}
if(Mon == "10" ||  Mon.equalsIgnoreCase("10"))
{
%>
<option value="10" selected="selected" >OCT</option>
<%
}
else
{
	%>
	<option value="10" >OCT</option>
	<%
}
if(Mon == "11" ||  Mon.equalsIgnoreCase("11"))
{
%>
<option value="11" selected="selected" >NOV</option>
<%
}
else
{
	%>
	<option value="11" >NOV</option>
	<%
}
if(Mon == "12" ||  Mon.equalsIgnoreCase("12"))
{
%>
<option value="12" selected="selected" >DEC</option>
<%
}
else
{
	%>
	<option value="12" >DEC</option>
	<%
}
	%>
</select>
&nbsp;&nbsp;
<select name="data2" style="">
<%
if(Yer == "2013" ||  Mon.equalsIgnoreCase("2013"))
	{
	%>
	<option value="2013" selected="selected" >2013</option>
	<%
	}
else
{
	%>
	<option value="2013" selected="selected" >2013</option>
	<%
}

if(Yer == "2014" ||  Mon.equalsIgnoreCase("2014"))
	{
	%>
	<option value="2014" selected="selected" >2014</option>
	<%
	}
else
{
	%>
	<option value="2014" >2014</option>
	<%
}

if(Yer == "2015" ||  Mon.equalsIgnoreCase("2015"))
	{
	%>
	<option value="2015" selected="selected" >2015</option>
	<%
	}
else
{
	%>
	<option value="2015" >2015</option>
	<%
}

if(Yer == "2016" ||  Mon.equalsIgnoreCase("2016"))
	{
	%>
	<option value="2016" selected="selected" >2016</option>
	<%
	}
else
{
	%>
	<option value="2016" >2016</option>
	<%
}

if(Yer == "2017" ||  Mon.equalsIgnoreCase("2017"))
	{
	%>
	<option value="2017" selected="selected" >2017</option>
	<%
	}
else
{
	%>
	<option value="2017" >2017</option>
	<%
}

if(Yer == "2018" ||  Mon.equalsIgnoreCase("2018"))
	{
	%>
	<option value="2018" selected="selected" >2018</option>
	<%
	}
else
{
	%>
	<option value="2018" >2018</option>
	<%
}

if(Yer == "2019" ||  Mon.equalsIgnoreCase("2019"))
	{
	%>
	<option value="2019" selected="selected" >2019</option>
	<%
	}
else
{
	%>
	<option value="2019">2019</option>
	<%
}

if(Yer == "2020" ||  Mon.equalsIgnoreCase("2020"))
	{
	%>
	<option value="2020" selected="selected" >2020</option>
	<%
	}
else
{
	%>
	<option value="2020" >2020</option>
	<%
}
	%>	
</select>
</td>
 <td align="center" ><br><font size="2" face="Arial"><b>To </b></font>&nbsp;
<select name="data3" style="">
<%
if(Mon1 == "01" ||  Mon1.equalsIgnoreCase("01"))
	{
	%>
	<option value="01" selected="selected" >JAN</option>
	<%
	}
	else
	{
		%>
		<option value="01" selected="selected" >JAN</option>
		<%
	}
if(Mon1 == "02" ||  Mon1.equalsIgnoreCase("02"))
{
%>
<option value="02" selected="selected" >FEB</option>
<%
}
else
{
	%>
	<option value="02" >FEB</option>
	<%
}
if(Mon1 == "03" ||  Mon1.equalsIgnoreCase("03"))
{
%>
<option value="03" selected="selected" >MAR</option>
<%
}
else
{
	%>
	<option value="03" >MAR</option>
	<%
}
if(Mon1 == "04" ||  Mon1.equalsIgnoreCase("04"))
{
%>
<option value="04" selected="selected" >APR</option>
<%
}
else
{
	%>
	<option value="04" >APR</option>
	<%
}
if(Mon1 == "05" ||  Mon1.equalsIgnoreCase("05"))
{
%>
<option value="05" selected="selected" >MAY</option>
<%
}
else
{
	%>
	<option value="05" >MAY</option>
	<%
}
if(Mon1 == "06" ||  Mon1.equalsIgnoreCase("06"))
{
%>
<option value="06" selected="selected" >JUNE</option>
<%
}
else
{
	%>
	<option value="06" >JUNE</option>
	<%
}
if(Mon1 == "07" ||  Mon1.equalsIgnoreCase("07"))
{
%>
<option value="07" selected="selected" >JULY</option>
<%
}
else
{
	%>
	<option value="07" >JULY</option>
	<%
}
if(Mon1 == "08" ||  Mon1.equalsIgnoreCase("08"))
{
%>
<option value="08" selected="selected" >AUG</option>
<%
}
else
{
	%>
	<option value="08" >AUG</option>
	<%
}
if(Mon1 == "09" ||  Mon1.equalsIgnoreCase("09"))
{
%>
<option value="09" selected="selected" >SEPT</option>
<%
}
else
{
	%>
	<option value="09" >SEPT</option>
	<%
}
if(Mon1 == "10" ||  Mon1.equalsIgnoreCase("10"))
{
%>
<option value="10" selected="selected" >OCT</option>
<%
}
else
{
	%>
	<option value="10" >OCT</option>
	<%
}
if(Mon1 == "11" ||  Mon1.equalsIgnoreCase("11"))
{
%>
<option value="11" selected="selected" >NOV</option>
<%
}
else
{
	%>
	<option value="11" >NOV</option>
	<%
}
if(Mon1 == "12" ||  Mon1.equalsIgnoreCase("12"))
{
%>
<option value="12" selected="selected" >DEC</option>
<%
}
else
{
	%>
	<option value="12" >DEC</option>
	<%
}
	%>
</select>

&nbsp;&nbsp;
<select name="data4" style="">
<%
if(Yer1 == "2013" ||  Yer1.equalsIgnoreCase("2013"))
	{
	%>
	<option value="2013" selected="selected" >2013</option>
	<%
	}
else
{
	%>
	<option value="2013" selected="selected" >2013</option>
	<%
}

if(Yer1 == "2014" ||  Yer1.equalsIgnoreCase("2014"))
	{
	%>
	<option value="2014" selected="selected" >2014</option>
	<%
	}
else
{
	%>
	<option value="2014" >2014</option>
	<%
}

if(Yer1 == "2015" ||  Yer1.equalsIgnoreCase("2015"))
	{
	%>
	<option value="2015" selected="selected" >2015</option>
	<%
	}
else
{
	%>
	<option value="2015" >2015</option>
	<%
}

if(Yer1 == "2016" ||  Yer1.equalsIgnoreCase("2016"))
	{
	%>
	<option value="2016" selected="selected" >2016</option>
	<%
	}
else
{
	%>
	<option value="2016" >2016</option>
	<%
}

if(Yer1 == "2017" ||  Yer1.equalsIgnoreCase("2017"))
	{
	%>
	<option value="2017" selected="selected" >2017</option>
	<%
	}
else
{
	%>
	<option value="2017" >2017</option>
	<%
}

if(Yer1 == "2018" ||  Yer1.equalsIgnoreCase("2018"))
	{
	%>
	<option value="2018" selected="selected" >2018</option>
	<%
	}
else
{
	%>
	<option value="2018" >2018</option>
	<%
}

if(Yer1 == "2019" ||  Yer1.equalsIgnoreCase("2019"))
	{
	%>
	<option value="2019" selected="selected" >2019</option>
	<%
	}
else
{
	%>
	<option value="2019">2019</option>
	<%
}

if(Yer1 == "2020" ||  Yer1.equalsIgnoreCase("2020"))
	{
	%>
	<option value="2020" selected="selected" >2020</option>
	<%
	}
else
{
	%>
	<option value="2020" >2020</option>
	<%
}
	%>	
</select>
</td>
<td align="center"><br><input type="submit" name="submit" id="submit" value="submit"></td>
</tr>
</table>
		</td>
		</tr>
		</table>
		</form>
		</div>
		<div style="margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em; " align="center">
<form name="DriverIncentive" name="DriverIncentive" action="" method="post">
<div id="table1" align="center" style="width: 850px;">
<%!
Connection con=null;
Statement st=null;
Statement st1=null;
Statement st2=null;
%>
<%
try
{
System.out.println("*********     hfgsbhdvfdsm");
Class.forName(MM_dbConn_DRIVER);
con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=con.createStatement();
st1=con.createStatement();
st2=con.createStatement();	
%>
<div style="font-size: 1.4em;" align="center">
	Driver Incentive Report For Tanker Trips From  <%=new SimpleDateFormat("MMM-yyyy").format(new SimpleDateFormat("MM-yyyy").parse(Mon+"-"+Yer))  %>  To <%=new SimpleDateFormat("MMM-yyyy").format(new SimpleDateFormat("MM-yyyy").parse(Mon1+"-"+Yer1))  %></div>
<table border="0" width="100%" align="center">
<tr>
<td align="left">
                        <br>
                        <font size="2" color="black"> Disclaimer : The Calculated Amount may change if there is a change in the status or count of Violation</font></b> 
                       
                       </td>
                       <td align="right">
                       <br>
                           <div class="bodyText" align="right">
                           <input type="hidden" id="tableHTML" name="tableHTML" value="" />  
                           <input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 
     
                           <a href="#" style="font-weight: bold; color: black; " onclick="gotoPrint('table1');">
                           <img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img></a> 
      
                            <a href="DriverIncentiveTankExcel.jsp?data1=<%=Mon%>&data2=<%=Yer%>&data3=<%=Mon1%>&data4=<%=Yer1%>" title="Export to Excel">
                           <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img></a>
                           <%=fleetview.PrintDate() %>
                           </div>
                       </td>
</tr>
</table>

<table class="sortable" width="100%" align="center">
<tr>
<th style="width: 10px">Sr No</th>
<th style="width: 50px">Driver Id</th>
<th style="width: 160px">Driver Name</th>
<th style="width: 160px">Transporter </th>
<th style="width: 25px">Total Trips</th>
<th style="width: 40px">Total Km</th>
<!--<th>Trips Point</th>-->
<th style="width: 25px">Trips with Zero DVI</th>
<!--<th>Primary / Secondary Trips</th>-->

<!--<th>Primary / Secondary Rate</th>-->
<th style="width: 40px">Actual Incentive</th>
<th style="width: 40px">Entitled Price</th>
<!--<th>Actual Incentive</th>-->
<th style="width: 50px">Month</th>

</tr>
<%
if(usertypevalue.equalsIgnoreCase("ALL") || usertypevalue.equals("Castrol"))
{
 sql="select * from db_gps.t_driverincentivedetails where primarytrips=0 and formonth>='"+QueryDate+"'  and formonth <= '"+QueryDate1+"' ORDER BY finalIncentive DESC,driverid  ";
}
else
{
	sql="select * from db_gps.t_driverincentivedetails where primarytrips=0 and formonth>='"+QueryDate+"'  and formonth <= '"+QueryDate1+"'    and transporter = '"+usertypevalue+"'  ORDER BY finalIncentive DESC,driverid ";
}
System.out.println("sql  "+sql);
ResultSet rs= st.executeQuery(sql);


int i=1;
while(rs.next())
{
   
%>
<tr>   
<td style="text-align: right;" align="right"><%=i++ %></td>
<td style="text-align: right;" align="right" >
<a href="driverIncentiveShowTrips.jsp?driverid=<%=rs.getString("driverid")%>&category=tanker&month=<%=QueryDate%>&month1=<%=QueryDate1 %>" target="_blank"><%=rs.getString("driverid") %>
</a>
</td>
<td style="text-align: left;" align="left" ><%=rs.getString("drivername") %></td>
<td style="text-align: left;" align="left"><%=rs.getString("transporter") %></td>
<td style="text-align: right;" align="right"><%=rs.getString("totaltrips") %></td>
<td style="text-align: right;" align="right"><%=rs.getString("totaldist") %></td>
<!--<td style="text-align: right:" align="right">< %=rs.getString("tripsPoint") %></td>-->
<td style="text-align: right;" align="right"><%=rs.getString("tripswithzerodvi") %></td>
<!--<td style="text-align: right:" align="right">< %=rs.getString("primarytrips") %></td>-->
<!--<td style="text-align: right:" align="right">< %=rs.getString("primaryrate") %></td>	-->
<td style="text-align: right;" align="right"><%=rs.getString("totalincentive") %></td>
<td style="text-align: right;" align="right"><%=rs.getString("finalIncentive") %></td>
<td style="text-align: center;" align="center"><% if(rs.getString("formonth")==null || rs.getString("formonth").equalsIgnoreCase("null"))
			{
	out.print("-");
			} 
else{out.print(new SimpleDateFormat("MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("formonth"))));} %></td>
</tr>
<%}
%>
</table>
<%
}
catch(Exception e)
{
	//out.print("Exception "+e);
	e.printStackTrace();
}
finally
{
	try
	{
		con.close();
	}catch(Exception e)
	{e.printStackTrace();}
	try
	{
		fleetview.closeConnection();
	}catch(Exception e)
	{e.printStackTrace();}
}
%>

</div>
</form>
</div>
</body>
		</html>
	



</jsp:useBean>
<%@ include file="footernew.jsp" %>	