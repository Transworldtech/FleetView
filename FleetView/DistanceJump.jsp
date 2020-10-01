<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<html>
<head>
<title>Vehicle Tracking System</title>
  <script type="text/javascript" src="http://www.google.com/jsapi"> </script>
</head>
<body bgcolor="lightyellow">
<table border="0" cellspacing="0" cellpadding="0" width="100%">
        <tr>
          <td width="1%" height="2"><img src="images/fboxtopleft.gif" width="20" height="12" alt="bk"/></td>
          <td class="fboxtop"><img src="images/spacer.gif" width="2" height="2" alt=" " /></td>
          <td width="1%" height="2"><img src="images/fboxtopright.gif" width="20" height="12" alt="bk"/></td>
        </tr>
        <tr>
          <td width="1%" class="fboxleft"><img src="images/spacer.gif" width="2" height="2" alt=" "/></td>

          <td width="98%" class="featureboxbg">
			<!-- header file -->
			<%@ include file="headernew.jsp" %> 
			
			<!-- header file -->
          </td>
          <td width="1%" class="fboxright" ><img src="images/spacer.gif" width="2" height="2" alt=" "/></td>
        </tr>
        <tr>
          <td class="fboxlowleft">&nbsp;</td>
          <td>
			<!-- body part come here -->
			<%!
			Connection conn=null;
			Statement st,st1,st2,st3,st4,st5,st6;
			String sql,sql1,sql2,vehicle,date1,date2;
			
			 %>
			<%
			if(null==request.getQueryString())
			{
					vehicle="All";
					date2=date1=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
			
			}
			else
			{
					vehicle=request.getParameter("vehicle");
					date1=request.getParameter("data");
					date2=request.getParameter("data1");
			}
			try
			{
				//Class.forName("org.gjt.mm.mysql.Driver"); 
				//conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
				conn=fleetview.ReturnConnection();
				st=conn.createStatement();
				st1=conn.createStatement();
				st2=conn.createStatement();
				st3=conn.createStatement();
				st5=conn.createStatement();
				st6=conn.createStatement();
				
									
			%>
			<table width="100%" align="center" class="sortable">
			<tr><td  class="sorttable_nosort">
			<!-- if date range is not requred please remove this code start from this comment to -->
			
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
  		 function datevalidate()
		 {
		 	var date1=document.getElementById("data").value;
			var date2=document.getElementById("data1").value;
			var dm1,dd1,dy1,dm2,dd2,dy2;
			dy1=date1.substring(0,4);
			dy2=date2.substring(0,4);
			dm1=date1.substring(5,7);
			dm2=date2.substring(5,7);
			dd1=date1.substring(8,10);
			dd2=date2.substring(8,10);
			var date=new Date();
			var month=date.getMonth()+1;
			var day=date.getDate();
			var year=date.getFullYear();
			if(dy1>year || dy2>year)
			{
				alert("selected date should not be greater than todays date");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			else if(year==dy1 && year==dy2)
			{
	  			if(dm1>month || dm2>month)
				{
					alert("selected date should not be greater than todays date");
					document.getElementById("data").value="";
					document.getElementById("data1").value="";
					document.getElementById("data").focus;
					return false;
				}
			}
			if(dm1==month)
			{
				if(dd1>day || dd2>day)
				{
					alert("selected date should not be greater than todays date");
					document.getElementById("data").value="";
					document.getElementById("data1").value="";
					document.getElementById("data").focus;
					return false;
				}
			}
			if(dy1>dy2)
			{
				alert("From date year is should not be greater than to date year");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			else if(year==dy1 && year==dy2) if(dm1>dm2)
			{
				alert("From date month is should not be greater than to date month 5");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			if(dm1==dm2) 
			{
				if(dd1 > dd2)
				{
					alert("From date should not be greater than to date");
					document.getElementById("data").value="";
					document.getElementById("data1").value="";
					document.getElementById("data").focus;
					return false;
				}
			}
			return true;
		}

  	</script>
			<table border="0" width="100%">
			<form action="" method="get" onsubmit="return validate();">
			<tr bgcolor="#87CEFA">
			<td><b>Vehicle :</b></td><td>
			<select name="vehicle" id="vehicle">
			<%
			sql="select * from t_vehicledetails where VehicleCode in "+session.getAttribute("VehList").toString()+" order by VehicleRegNumber asc";
			ResultSet rst=st.executeQuery(sql);
			while(rst.next())
			{
				%>
				<option value="<%=rst.getString("VehicleRegNumber")%>" <% if(vehicle.equals(rst.getString("VehicleRegNumber"))){ %>Selected<% } %> ><%=rst.getString("VehicleRegNumber")%></option>				
				<%
			}
			%>
			</select>			
			</td>
			<td align="right"><b>From </b>&nbsp;&nbsp;
			  <input type="text" id="data" name="data" value="<%=date1%>"  size="15" readonly/>
			  <script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "data",         // ID of the input field
      			ifFormat    : "%Y-%m-%d",     // the date format
      			button      : "data"       // ID of the button
    			}
  				);	
				</script>
  			</td>
<!--  			<td align="left">-->
<!--				<input type="button" name="From Date" value="From Date" id="trigger">-->
<!--				-->
<!--			</td>-->
			<td align="right"><b>To </b>&nbsp;&nbsp;
			  	<input type="text" id="data1" name="data1" value="<%=date2%>" size="15" readonly/>
			  	<script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "data1",         // ID of the input field
      			ifFormat    : "%Y-%m-%d",    // the date format
      			button      : "data1"       // ID of the button
    			}
  				);
				</script>
			  	</td>
<!--			  	<td align="left">-->
<!--  			  	<input type="button" name="To Date" value="To Date" id="trigger1">-->
<!--				-->
<!--			</td>-->
			<td>
				<input type="submit" name="submit" id="submit" value="submit">
			</td>
		</tr>
		</form>
		</table>
		<!-- if date range is not requred please remove this code start from this comment to -->
		</td></tr>
			
			
			</table>
			<%
			if(!(null==request.getQueryString()))
			{			
			%>
			<table width="100%" border="1" align="center" class="sortable">
			<tr>
			<td  class="sorttable_nosort">
			<div id="report_heding"><font size="3">The Distance Jump Report for <% if(vehicle.equals("All")) {%>All Vehicles <%}else { out.print ("Vehicle "+vehicle); } %> from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date1))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date2)) %></font></div>
				<!--<div align="right">
				<a href="#" onclick="javascript:window.open('printspeedanalysis.jsp?vehicle=<%=vehicle%>&data=<%=date1%>&data1=<%=date2%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
				<a href="excelspeedanalysis.jsp?vehicle=<%=vehicle%>&data=<%=date1%>&data1=<%=date2%>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>
				<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%>
				</div>-->
			</td>
			</tr>			
			</table>
			<table width="100%" border="1" align="center" class="sortable">
			<tr>
			<th class="hed"> Sr.</th>
			<th class="hed"> From Date&Time</th>
			<th class="hed"> To Date&Time</th>
			<th class="hed"> From Location</th>
			<th class="hed"> To Location</th>
			<th class="hed"> From Km </th>
			<th class="hed"> To Km </th>
			<th class="hed"> Difference </th>
			<th class="hed"> Reason </th>
			
			
			</tr>		
			<%
				sql="select VehicleCode from t_vehicledetails where VehicleRegNumber='"+vehicle+"' order by VehicleCode ASC ";
				ResultSet rst1=st.executeQuery(sql);
				if(rst1.next())
				{	
				sql="select * from DistanceJump where VehCode = '"+rst1.getString("VehicleCode")+"' and DateAndTimeFrom >='"+date1+"' and DateAndTimeFrom <='"+date2+"' order by DateAndTimeFrom ";
				ResultSet rst0=st2.executeQuery(sql);
				int j=0,sum=0;
				String DateAndTimeFrom="",DateAndTimeTo="",LocationFrom="",LocationTo="",FromKm="",ToKm="",Reason="";
				int Diff=0;
				String LatinDecFrom="",LonginDecFrom="",LatinDecTo="",LonginDecTo="";
				while(rst0.next())
				{
					DateAndTimeFrom=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst0.getString("DateAndTimeFrom")));
					DateAndTimeTo=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst0.getString("DateAndTimeTo")));
					LocationFrom=rst0.getString("LocationFrom");
					LocationTo=rst0.getString("LocationTo");
					FromKm=rst0.getString("FromKm");
					ToKm=rst0.getString("ToKm");
					Diff=rst0.getInt("Diff");
					Reason=rst0.getString("Reason");
					sum+=Diff;
					
					sql2="select LatinDec,LonginDec from t_veh"+rst1.getString("VehicleCode")+" where concat(TheFieldDataDate,' ',TheFieldDataTime)='"+rst0.getString("DateAndTimeFrom")+"'";
					ResultSet rstfrom=st5.executeQuery(sql2);
					if(rstfrom.next())
					{
						LatinDecFrom=rstfrom.getString("LatinDec");
						LonginDecFrom=rstfrom.getString("LonginDec");
					}
					String sql3="select LatinDec,LonginDec from t_veh"+rst1.getString("VehicleCode")+" where concat(TheFieldDataDate,' ',TheFieldDataTime)='"+rst0.getString("DateAndTimeTo")+"'";
					ResultSet rstto=st6.executeQuery(sql3);
					if(rstto.next())
					{
						LatinDecTo=rstto.getString("LatinDec");
						LonginDecTo=rstto.getString("LonginDec");
					}
					
					j++;
					%>
					<tr>
					<td><div align="right"><%=j %></div></td>			
					<td><div align="left"><%=DateAndTimeFrom %></div></td>
					<td><div align="left"><%=DateAndTimeTo%></div></td>
					<td><div align="left"><%=fleetview.showNewMap(LatinDecFrom,LonginDecFrom,LocationFrom) %></div></td>
					<td><div align="left"><%=fleetview.showNewMap(LatinDecTo,LonginDecTo,LocationTo) %></div></td>
					<td><div align="right"><%=FromKm%></div></td>
					<td><div align="right"><%=ToKm%></div></td>
					<td><div align="right"><%=Diff%></div></td>
					<td><div align="left"><%=Reason%></div></td>
					</tr>
					<%
				}
				%>
				<tr class="sortbottom">
				<td class="hed" colspan="2"><div align="right">Total :</div></td>			
				<td colspan="3" class="hed"><div align="right"><%=j%></div></td>
				<td colspan="3" class="hed"><div align="right"><%=sum%></div></td>
				<td colspan="3" class="hed"><div align="right">&nbsp;</div></td>
				</tr>
				</table>
				</td>
				<%
			}
			
			}
			%>
			
			<!-- body part come here -->
				<%
				}catch(Exception e)
				{
					out.print("Exceptions--->"+e);
				}				
				finally
				{
					try
					{
					conn.close();
					}
					catch(Exception e){}
					try
					{
					fleetview.closeConnection();
					}catch(Exception e)
					{
					}
				}
				%>
			
    <td class="fboxlowright">&nbsp;</td>
    </tr>
    <tr>
       <td width="1%"><img src="images/fboxbottomleft.gif" width="20" height="20" alt="bk" /></td>
       <td width="98%" class="fboxbottom"><img src="images/spacer.gif" width="2" height="2" alt=" " /></td>
       <td width="1%"><img src="images/fboxbottomright.gif" width="20" height="20" alt="bk" /></td>
    </tr>
    </table>
   
        <%@ include file="footernew.jsp" %>
    </body>
</html>
</jsp:useBean>