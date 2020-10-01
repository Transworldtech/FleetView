<%@ include file="headernew.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
			<table width="100%" align="center" >
			<tr>
			<td align="center">
			<div align="left"><font size="3" >Report No: 1.0</font></div>
			<font  size="3" ><b>Page Heading</b></font></td>
			</tr>
			<tr><td>
			<!-- if date range is not requred please remove this code start from this comment to -->
			
			<script language="javascript">
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
  <%!
Connection conn, conn1;
Statement st,st1,st2,st3;
String aa,regno,sq,searchveh;
%>

<%
try{
	conn=fleetview.ReturnConnection();
	conn1 = fleetview.ReturnConnection1();
	st=conn.createStatement();
	st1=conn.createStatement();
	st2=conn.createStatement();	
	st3=conn1.createStatement();
	%>
	
			<table border="0" width="100%">
			<form action="" method="get" onsubmit="return validate();">
			<tr>
			<td align="right">
			  <input type="text" id="data" name="data"  size="15" readonly/>
  			</td>
  			<td align="left">
				<input type="button" name="From Date" value="From Date" id="trigger" >
				<script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "data",         // ID of the input field
      			ifFormat    : "%d-%b-%Y",     // the date format
      			button      : "trigger"       // ID of the button
    			}
  				);	
				</script>
			</td>
			<td align="right">
			  	<input type="text" id="data1" name="data1"   size="15" readonly/></td><td align="left">
  			  	<input type="button" name="To Date" value="To Date" id="trigger1" >
				<script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "data1",         // ID of the input field
      			ifFormat    : "%d-%b-%Y",    // the date format
      			button      : "trigger1"       // ID of the button
    			}
  				);
				</script>
			</td>
			<td>
				<input type="submit" name="submit" id="submit" value="submit" >
			</td>
		</tr>
		</form>
		</table>
		<!-- if date range is not requred please remove this code start from this comment to -->
		</td></tr>
			<tr>
			<td>
			<div  align="center"><font size="3">Exception Report From 11 pm to 5 pm </font></div>
				<div align="right">
				<a href="#" onclick="javascript:window.open('print.jsp');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
				<a href="excel.jsp"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>
				<%=fleetview.PrintDate()%>
				</div>
			</td>
			</tr>
			</table>
			<table width="100%" border="1" align="center" class="sortable">
			<tr>
			<th> <b> Sr.No </b></th>
			<th> <b>VehicleRegNo</b></th>
			<th> <b>Transporter</b></th>
			<th> <b>OS Count</b></th>
			<th> <b>RA Count</b></th>
			<th> <b>RD Count</b></th>
			<th> <b>CD Count</b></th>
			<th> <b>ND Count</b></th>
			<th> <b>Stopages Count</b></th>
			</tr>		
		<%
		  	int oscount=0,rdcount=0,cdcount=0,ndcount=0,racount=0,stopcount=0;
			boolean flag=true;
			int i=1,ostot=0,rdtot=0,cdtot=0,ratot=0,stoptot=0,ndtot=0;
			String sql1="select * from t_vehicledetails where status = '-' order by ownername asc";
		    ResultSet rs1=st1.executeQuery(sql1);
		    while(rs1.next())
		    {
		    	String vehcode=rs1.getString("vehiclecode");
		    	String vehno=rs1.getString("vehicleregnumber");
		    	String owner=rs1.getString("ownername");
		    	String sql2="select count(*) from t_veh"+vehcode+"_overspeed where concat(FromDate,' ',Fromtime) between '2009-11-07 22:59:59' and '2009-11-08 05:00:00'";
		    	ResultSet rs2=st3.executeQuery(sql2);
				while(rs2.next())
				{
					oscount=rs2.getInt(1);
					ostot=ostot+oscount;
					
				}
				String sql3="select count(*) from t_veh"+vehcode+"_ra where concat(TheDate,' ',TheTime) between '2009-11-07 22:59:59' and '2009-11-08 05:00:00'";
		    	ResultSet rs3=st3.executeQuery(sql3);
				while(rs3.next())
				{
					racount=rs3.getInt(1);
					ratot=ratot+racount;
					
					
				}
				String sql4="select count(*) from t_veh"+vehcode+"_rd where concat(TheDate,' ',TheTime) between '2009-11-07 22:59:59' and '2009-11-08 05:00:00'";
		    	ResultSet rs4=st3.executeQuery(sql4);
				while(rs4.next())
				{
					rdcount=rs4.getInt(1);
					rdtot=rdtot+rdcount;
					
					
				}
				String sql5="select count(*) from t_veh"+vehcode+"_nd where concat(FromDate,' ',Fromtime) between '2009-11-07 22:59:59' and '2009-11-08 05:00:00'";
		    	ResultSet rs5=st3.executeQuery(sql5);
				while(rs5.next())
				{
					ndcount=rs5.getInt(1);
					ndtot=ndtot+ndcount;
					
					
				}
				String sql6="select count(*) from t_veh"+vehcode+"_stsp where concat(FromDate,' ',Fromtime) between '2009-11-07 22:59:59' and '2009-11-08 05:00:00'";
		    	ResultSet rs6=st3.executeQuery(sql6);
				while(rs6.next())
				{
					stopcount=rs6.getInt(1);
					stoptot=stoptot+stopcount;
					
					
				}
				String sql7="select count(*) from t_veh"+vehcode+"_cr where concat(FromDate,' ',Fromtime) between '2009-11-07 22:59:59' and '2009-11-08 05:00:00'";
		    	ResultSet rs7=st3.executeQuery(sql7);
				while(rs7.next())
				{
					cdcount=rs7.getInt(1);
					cdtot=cdtot+cdcount;
				}
			if( oscount==0 && rdcount==0 && cdcount==0 && ndcount==0 &&racount==0 &&stopcount==0)	
			{
				
			}
			else
			{ 
				
		%>	
			
			<tr>
			<td><%=i %></td>
			<td><%=vehno %></td>
			<td><%=owner %></td>
			<td><%=oscount %></td>
			<td><%=racount %></td>
			<td><%=rdcount %></td>
			<td><%=cdcount %></td>
			<td><%=ndcount %></td>
			<td><%=stopcount %></td>
			
			
			</tr>	
		<%
			i++;
			}
			}
		%>	
			
			<tr class="sortbottom">
			<td colspan="3" class="hed"> Total :</td>
			<td class="hed"> <%=ostot %></td>
			<td class="hed"> <%=ratot %></td>
			<td class="hed"> <%=rdtot %></td>
			<td class="hed"> <%=cdtot %></td>
			<td class="hed"> <%=ndtot %></td>
			<td class="hed"> <%=stoptot %></td>
			
			</tr>	
			</table>
	<%
	
	}catch(Exception e)
	{
		out.print("Exception -->"+e);
	}
	%>

	<% fleetview.closeConnection(); %>
	<% fleetview.closeConnection1(); %>		
		
			</jsp:useBean>
			
        <%@ include file="footernew.jsp" %>
   
