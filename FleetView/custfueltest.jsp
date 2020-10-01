<%@ include file="headernew.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
			<table width="100%" align="center" class="sortable">
			<tr>
			<td align="center" class="sorttable_nosort">
			<!-- <div align="left"><font color="block" size="3" >Report No: 5.4</font></div>-->
			<font color="block" size="3" ><b></>Fuel Fill up Report</b></font></td>
			</tr>
			<tr><td>
			<!-- if date range is not required please remove this code start from this comment to -->
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
			dd1=date1.substring(0,4);
			dd2=date2.substring(0,4);
			dm1=date1.substring(5,7);
			dm2=date2.substring(5,7);
			dy1=date1.substring(8,10);
			dy2=date2.substring(8,10);
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
  	
  	<body>
<form action="" method="get" name="custfuelhistory" onSubmit="return validate();">
<%!
Connection conn, con1;
Statement st,st1,st2;
String date1, date2,datenew1,datenew2, vehcode, vehregno,tbname,sql,owner,km,rating,from,to,ndcount;

%>
<%
datenew1=request.getParameter("data");
datenew2=request.getParameter("data1");
String owner=session.getAttribute("usertypevalue").toString();

if(null==datenew1)
{
	datenew1=datenew2=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	date1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datenew1));
	date2=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datenew2));

}
else
{
	date1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datenew1));
	date2=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datenew2));

}
//out.print(tbname);
try
{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
%>
			<table border="0" width="100%">
			<form action="" method="get" onsubmit="return validate();">
			<tr bgcolor="#87CEFA">
			<td align="right">
			  <input type="text" id="data" name="data" value="<%=datenew1 %>" size="15" readonly/>
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
			  	<input type="text" id="data1" name="data1" value="<%=datenew2 %>"  size="15" readonly/></td><td align="left">
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
			<td  class="sorttable_nosort">
			<div id="report_heding"><font color="brown" size="3">The Fuel Fill up Report for <%=owner %> from <%=datenew1 %> to <%=datenew2 %></font></div>
				<div align="right">
				<a href="#" onclick="javascript:window.open('printcustfuel.jsp?owner=<%=owner%>&data=<%=date1 %>&data1=<%=date2 %>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
				<a href="excelcustfuel.jsp?owner=<%=owner%>&data=<%=date1 %>&data1=<%=date2 %>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>
				<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%>
				</div>
			</td>
			</tr>
			</table>
			<table width="100%" border="1" align="center" class="sortable">
			<tr>
				<th> <b> Sr. </b></th>
				<th> <b>VehicleRegno</b></th>
				<th> <b>TheDateTime</b></th>
				<th> <b>Driver</b></th>
				<th> <b>Liters</b></th>
				<th> <b>Petrol Pump</b></th>
				<th> <b>Ent By</b></th>
			</tr>
			<%
			String trans="";
			String sql2="select * from t_group where gpname='"+owner+"'";
			ResultSet rs2=st.executeQuery(sql2);
			if(rs2.next())
			{
				trans=rs2.getString("vehregno");
			}
				int i=1;
				String sql1="select * from t_fuelinfo where (Transporter like '"+owner+"' or Transporter like '"+trans+"') and TheDateTime >= '"+date1+" 00:00:00' and TheDateTime <='"+date2+" 23:59:59' order by Thedatetime desc";
				//out.print(sql1);
				ResultSet rs1=st1.executeQuery(sql1);
				while(rs1.next())
				{
			%>		
			<tr>
				<td> <%=i %></td>
				<td> <%=rs1.getString("VehNo") %></td>
				<%
					String datef=new SimpleDateFormat("dd-MMM-yyyy hh:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").parse(rs1.getString("TheDateTime")));
				%>
				<td> <%=datef %></td>
				<td> <%=rs1.getString("Driver") %></td>
				<td> <%=rs1.getString("Litres") %></td>
				<td> <%=rs1.getString("PetrolPump") %></td>
				<td> <%=rs1.getString("EntBy") %></td>
			</tr>	
			<%
				i++;
				}
			%>
			</table>
			<%

}
catch(Exception e)
{
 	out.print("Exception::"+e);
}
%>
			<% fleetview.closeConnection(); %>
			</jsp:useBean>
        <%@ include file="footernew.jsp" %>
   
   
   
   
   
  
   
   
   
