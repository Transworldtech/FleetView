<%@ include file="headernew.jsp" %>
<form action="#" method="get" name="driverhistory" >
<%!
Connection conn, con1;
Statement st,st1, stmt1;
String date1, date2,datenew1,datenew2, vehcode, vehregno,tbname,sql,owner,km,rating,from,to,ndcount;

%>
<%
datenew1=request.getParameter("data");
datenew2=request.getParameter("data1");
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
try{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
%>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
	fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>


			<table width="100%" align="center" class="sortable">
			<tr>
			<td align="center" class="sorttable_nosort">
			<div align="left"><font color="block" size="3" >Report No: 1.0</font></div>
			<font color="block" size="3" >Keypad Event Report</font></td>
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
		<%
 if(!(null==request.getParameter("submit")))
 {
	 
	 
 %>
			<tr>
			<td  class="sorttable_nosort">
			<div id="report_heding"><font color="brown" size="3">EMRI Keypad Report </font></div>
				<div align="right">
				<a href="#" onclick="javascript:window.open('print.jsp');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
				<a href="excel.jsp"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>
				<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%>
				</div>
			</td>
			</tr>
			</table>
			<table width="100%" border="1" align="center" class="sortable">
			<tr>
			<th> <b> Sr. </b></th>
			<th> <b>Updated Date Time</b></th>
			<th> <b>Stamp Type</b></th>
			<th> <b>Location</b></th>
			
			</tr>
			
			<%
				String sql="select * from t_veh3119  where TheFiledTextFileName like 'K%' and TheFieldDataDate between '"+date1+"' and '"+date2+"' order by concat(TheFieldDataDate,TheFieldDataTime) asc ";
				
			
			%>		
			<tr>
				<td> 1</td>
				<td> data</td>
				<td> data</td>
				<td> data</td>
				
			</tr>	
			
			<tr class="sortbottom">
			<td colspan="2" class="hed"> Total :</td>
			<td class="hed"> val</td>
			<td class="hed"> val</td>
			
			</tr>	
			
	<%
 }
	
}  catch(Exception e)
  {
 	out.print("Exception::"+e);
 }
  finally
	{
		conn.close();
	}
%>	
			
			
		
			</jsp:useBean>
			</table>
        <%@ include file="footernew.jsp" %>
   