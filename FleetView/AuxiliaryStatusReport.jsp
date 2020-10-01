<%@ include file="headernew.jsp" %>

<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<link rel="stylesheet" type="text/css" href="css/form.css" media="all">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>	
<%!
String VehicleCode, fromdate, todate, desc,vehregno,fromtime,totime,ftime1,ftime2,ttime1,ttime2;
String vehid,ss1,ss2,ss3,dd,vehicle;
String datenew1,datenew2,date3;
Connection conn;
Statement st,sttemp,st1,stcolor,stfuel;
String sql,sql1;
%>
<%
date3=datenew1=request.getParameter("data");
datenew2=request.getParameter("data1");
VehicleCode = request.getParameter("vehcode");

String vehlist = session.getAttribute("VehList").toString();

if(null==datenew1 || datenew1.equalsIgnoreCase("null"))
{
	datenew2=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date());
	
     Calendar cal=Calendar.getInstance();
     cal.add(Calendar.DATE,-1);
     cal.add(Calendar.HOUR,+12);
     datenew1=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(cal.getTime());
   
}

try{
	conn = fleetview.ReturnConnection();
	st=conn.createStatement();
	sttemp=conn.createStatement();
	stfuel = conn.createStatement();
	st1=conn.createStatement();
	
	%>
	<table border="0" width="100%" class="stats" style="width: 900px;position: relative;text-align: center;margin-left: 250px;margin-right: 250px;">  
<tr align="center">
<td>
<!-- <div align="left"><font size="3">Report No:1.12</font></div>-->
 <font size="3"><div ><b>Auxiliary Engine Status Report</b></div></font>
<div class="bodyText" align="right">

</div>
</td>
</tr>
</table>

<br>
<form name="customdetail" method="get" action="" onsubmit="return Validate();">
	
	
	<table border="0" align="center"  align="right" class="sortable_entry" style="width: 900px;position: relative;text-align: center;margin-left: 250px;margin-right: 250px;">  
 	<tr>
	<td align="left"><b>Vehicle Reg No:</b>&nbsp;&nbsp;<select name="vehcode" id="vehcode" class="element select medium">
 	<%
 	sql = "select * from db_gps.t_vehicledetails where vehiclecode in "+vehlist+"  order by vehicleregnumber";
 	ResultSet rs = st.executeQuery(sql);
 	while(rs.next())
 	{
 		%>
		<option value="<%=rs.getString("vehiclecode") %>"><%=rs.getString("Vehicleregnumber") %></option>
 		<%
 	}
 	%>
 	</select></td>
 	<td align="left"><b>From&nbsp;&nbsp;</b>
		<input type="text" id="data" name="data" size="18" value="<%=datenew1%>"  class="element text medium"   readonly />
		<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data",         // ID of the input field
      ifFormat    : "%d-%b-%Y %H:%M:%S",     // the date format
      button      : "data" ,     // ID of the button
      showsTime	: "true"	//show time
    }
  );
		</script>
  		</td>
<!--	<td align="left">-->
<!--		<input type="button" name="From Date" value="From Date" id="trigger">-->
<!--		-->
<!--	</td>-->
	<td align="left"><b>To&nbsp;&nbsp;</b>
		<input type="text" id="data1" name="data1" value="<%=datenew2%>"  size="18"  class="element text medium"   readonly/>
		<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data1",         // ID of the input field
      ifFormat    : "%d-%b-%Y %H:%M:%S",    // the date format
      button      : "trigger1" ,      // ID of the button
      showsTime	: "true"	//show time
    }
  );
		</script>
		</td>
<!--		<td align="left">-->
<!--  		<input type="button" name="To Date" value="To Date" id="trigger1">-->
<!--		-->
<!--	</td>-->
	<td><div align="left" > 
		<!--<font color="Blue" size="1"> Note- Enter date in format(yyyy-mm-dd)</font>-->
		
		<input type="submit" name="submit" value="Submit"  style="border-style: outset; border-color: black">
	</div></td>
	</tr>
	</table>
	</form>
	

	
	<%
	System.out.println("****&&&&&&&&***");
	boolean flag=true;
	if(VehicleCode == null || VehicleCode.equals("null"))
	{
		System.out.println("****&&&&&&&&***");
	}
	else
	{
		%>
		<br>
		<table  align="center" class="sortable" border="1" style="width: 900px;position: relative;text-align: center;margin-left: 250px;margin-right: 250px;">
<tr>
<th>Sr.</th>
<th>ON Date Time</th>
<th>Start Location</th>
<th>OFF Date Time</th>
<th>Stop Location</th>
<th>Duration(HH:mm)</th>
</tr>
		<%
		fromdate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(datenew1));
		todate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(datenew2));
		int i =1,x =0;
		sql1 = "select * from db_gps.t_veh"+VehicleCode+" where Thefielddatadatetime >= '"+fromdate+"' and Thefielddatadatetime <= '"+todate+"' and Thefiledtextfilename in ('AN','AF')  order by Thefielddatadatetime";
		
		ResultSet rs1 = st1.executeQuery(sql1);
		System.out.println("&&&&6666666&&&&&   "+sql1);
		String fdate = "",tdate = "",floc ="",toloc = "",dur = "",lat1 = "",lon1 = "",lat2 = "",lon2 = "";
		while(rs1.next())
		{
			System.out.println("***"+rs1.getString("Thefiledtextfilename"));
			
			System.out.println("flag  "+flag);
			
			if(flag == true)
			{
				
			 if(rs1.getString("Thefiledtextfilename") == "AN" || rs1.getString("Thefiledtextfilename").equalsIgnoreCase("AN"))
			 {
				 System.out.println("flag  "+flag);
				 flag=false;
					x=1;
				 fdate = rs1.getString("Thefielddatadatetime");
				 floc = rs1.getString("TheFieldSubject");
				 lat1 = rs1.getString("LatinDec");
				 lon1 = rs1.getString("LonginDec");
		 	 }
			}
			
			if(x==1)
			{
				 if(rs1.getString("Thefiledtextfilename") == "AF" || rs1.getString("Thefiledtextfilename").equalsIgnoreCase("AF"))
				 {
					 System.out.println("x  "+x);
					 flag=true;
					 x++;
					 tdate = rs1.getString("Thefielddatadatetime");
					 toloc = rs1.getString("TheFieldSubject");
					 lat2 = rs1.getString("LatinDec");
					 lon2 = rs1.getString("LonginDec");
					 System.out.println("fdate  "+fdate);
					 System.out.println("tdate  "+tdate);
					 java.util.Date enddte11= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(tdate);
					 java.util.Date strdte11= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fdate);
					 long hrs = 0,mins = 0,hrdiff = 0;
					 double hrslong=0.00;
					 
					 long timediff=enddte11.getTime()-strdte11.getTime();
					 long mins11=timediff/1000/60;
					 long sec = mins11/1000;
					 long min = mins11%60;
					hrs =mins11/60;
					if(hrs>=10)
					{					
						dur = hrs+":";
					}
					else
					{					
						dur = "0"+hrs+":";
					}
					
					if(min>=10)
					{
						dur = dur+min;
						
					}
					else
					{
						dur = dur+"0"+min;
					
					}
					  
					
					
					 System.out.println("dur  "+dur);
					
					 %>
					 <tr>
					 <td><div align="right"><%=i %></div></td>
					 <td><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fdate)) %></div></td>
					 <td><div align="left"><a href="shownewmap.jsp?lat=<%=lat1%>&long=<%=lon1%>&discription=<%=floc%>" onclick="popWin=open('shownewmap.jsp?lat=<%=lat1%>&long=<%=lon1%>&discription=<%=floc%>', 'myWin','width=500, height=500'); popWin.focus(); return false">&nbsp;&nbsp;<%=floc%></a></div></td>
					 <td><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(tdate)) %></div></td>
					 <td><div align="left"><a href="shownewmap.jsp?lat=<%=lat2%>&long=<%=lon2%>&discription=<%=toloc%>" onclick="popWin=open('shownewmap.jsp?lat=<%=lat2%>&long=<%=lon2%>&discription=<%=toloc%>', 'myWin','width=500, height=500'); popWin.focus(); return false">&nbsp;&nbsp;<%=toloc%></a></div></td>
					 <td><div align="right"><%=dur%></div></td>
					 </tr>
					 <%
					 i++;
				 }
			}
			
		}
		%>
		</table>
		<%
	}
	
	
}
catch(Exception e)
{
	System.out.println("Exception--->   "+e);
}


%>

</jsp:useBean>
<%@ include file="footernew.jsp" %>