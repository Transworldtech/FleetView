
<%@ include file="header.jsp" %>
<%@ include file="headercallcenter.jsp" %>

<%! 
Connection con1, con2;
Statement stmt1, stmt2;
%>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>

	
	<script language="javascript">
		function validate(ind)
		{
			
			if(ind=="0")
			{
				var cab=document.exlkm.cablist.value;
			
				if(cab=="Select")
				{
					alert("Please select a Cab");
					return false;
				}
				
				return datevalidate();
			}
			else
			{
				document.exlkm1.submit();
				return false;
			}	
			
		}

		
		function datevalidate()
		{ 
			var tdydate=document.exlkm.tdydate.value;
			var dte=document.exlkm.calender.value;
			var dte1=document.exlkm.calender1.value;
			
			var dm1,dd1,dy1,dm2,dd2,dy2,dm3,dd3,dy3;
			
			dy1=tdydate.substring(0,4);
			dy2=dte.substring(0,4);
			dy3=dte1.substring(0,4);
			dm1=tdydate.substring(5,7);
			dm2=dte.substring(5,7);
			dm3=dte1.substring(5,7);
			dd1=tdydate.substring(8,10);		
			dd2=dte.substring(8,10);
			dd3=dte1.substring(8,10);

			var date=new Date();
			var month=date.getMonth()+1;
			var day=date.getDate();
			var year=date.getFullYear(); 
			
			if(dy2>year || dy3>year)
			{
				alert("Selected year cannot be greater than present year");
				
				return false;
			}
			else if(year==dy2 && year==dy3)
			{
				  if(dm2>month || dm3>month)
				  {
					alert("Selected month cannot be greater than present month");
					return false;
				}
			}

			if(dm2==month && dm3==month)
			{
				if(dd2>day || dd3>day)
				{
					alert("Selected date cannot be greater than todays date");
					return false;
	
				}
			}

			if(year==dy2 && year==dy3) 
			{
				if(dm2>dm3)
				{
					alert("From date(month) should not be greater than To date (month)");
					return false;
				}
			}

			if(dm2==dm3) 
			{
				if(dd2 > dd3)
				{
					alert("From date should not be greater than To date");
					return false;
				}
			}


			
		document.exlkm.submit();	
		}	

	
	</script>


</head>
<body>
<form name="exlkm" method="get" action="" >

<!--- code start here ------>
<%
try
{
	Class.forName(MM_dbConn_DRIVER);
	con1 = DriverManager.getConnection(MM_dbConn_STRING5,MM_dbConn_USERNAME5,MM_dbConn_PASSWORD5);
con2 = DriverManager.getConnection(MM_dbConn_STRING6,MM_dbConn_USERNAME5,MM_dbConn_PASSWORD5);
	stmt1=con1.createStatement();
	stmt2=con2.createStatement();
	
        String sql1="", sql2="";
        ResultSet rs1=null, rs2=null;
	int i=0;
	String cabno="";

	java.util.Date tdydate = new java.util.Date();
	Format formatter = new SimpleDateFormat("yyyy-MM-dd");
	String dte=formatter.format(tdydate); 
%>
<input type="hidden" name="tdydate" value="<%=tdydate%>" />
<%
	sql1="select * from t_vehicledetails where OwnerName='EXL Services' order by VehicleRegNumber asc";
	rs1=stmt2.executeQuery(sql1);
%>
<table border="1" width="100%" bgcolor="white">
   <tr>
     <td align="center">	
	<table border="0" width="70%" >
	  <tr>
		<td align="center" colspan="3">  <font color="maroon"> <B> EXL Km Entry Form </B> </font>
		</td>
	  </tr>
	</table>
    </td>
   </tr>	
  <tr>
     <td align="center">	
	<table border="0" width="70%" >
	  <tr>
		<td> <div align="center"> <B> Cab No. </B> 
			<select name="cablist" class="formElement"> 
				<option value="Select">Select</option>	
			<%
				while(rs1.next())
				{ %>
					<option value="<%=rs1.getString("VehicleRegNumber")%>"><%=rs1.getString("VehicleRegNumber")%> </option>
			<%      } %>	
	        	 	</select> </div>
		</td>
		<td> <div align="center"> <B> From Date</B> 
			 <input type="text" id="calender" name="calender" size="13" value="<%=dte%>" class="formElement" readonly/> 
             <input type="button" name="trigger" id="trigger" value="Date" class="formElement">
             <script type="text/javascript">
             Calendar.setup(
             {
                 inputField  : "calender",         // ID of the input field
                 ifFormat    : "%Y-%m-%d",     // the date format
                 button      : "trigger"       // ID of the button
             }
                           );
             </script> </td>
		<td> <div align="center"> <B> To Date</B> 
			 <input type="text" id="calender1" name="calender1" size="13" value="<%=dte%>" class="formElement" readonly/> 
             <input type="button" name="trigger1" id="trigger1" value="Date" class="formElement">
             <script type="text/javascript">
             Calendar.setup(
             {
                 inputField  : "calender1",         // ID of the input field
                 ifFormat    : "%Y-%m-%d",     // the date format
                 button      : "trigger1"       // ID of the button
             }
                           );
             </script> </td>
		

		<td> <input type="submit" name="Submit" value="Submit" class="formElement" onClick="return validate(0);"    /> </td>
	  </tr>
	</table>

    </td>
  </tr>
  <tr>
  	<td>
		<%

	String date1=request.getParameter("calender");
	if(date1==null)
	{
	}
	else
	{ 
		
		int noofdays=0;

		date1=request.getParameter("calender");
		String date2=request.getParameter("calender1");
		cabno=request.getParameter("cablist");
	
		sql2="select (TO_DAYS('"+date2+"')-TO_DAYS('"+date1+"'))";
		rs2=stmt1.executeQuery(sql2);
		if(rs2.next())
		{
			noofdays=rs2.getInt(1);			
		}
		
%>
</form>

<form name="exlkm1" method="get" action="exlkmdetsinsrt.jsp" >

<table border="0" width="100%" bgcolor="white">
 
   <tr>
	<td align="center">
		<table border="1" width="70%" >
		  <tr>
			<td align="center" colspan="4"> <B> Enter details of <%=cabno %> for the Period <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date1))%> and <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date2))%> </B> </td>
		  </tr>	
		  <tr>	
			<td align="center"> <B> Date </B> </td>
			<td align="center"> <B> Kilometers </B></td>
			<td align="center"> <B> No. of Employees </B></td>
			<td align="center"> <B> DND </B></td>
		</tr>
	  
			<%
					String fromdate1=date1;
					java.util.Date newfrmtdet1=new SimpleDateFormat("yyyy-MM-dd").parse(fromdate1);
					long miliseconds=newfrmtdet1.getTime();
					miliseconds=miliseconds- 1000 * 60 * 60 *24;

					newfrmtdet1.setTime(miliseconds);	
				 	fromdate1= new SimpleDateFormat("yyyy-MM-dd").format(newfrmtdet1);			
				
				//String fromdate1=date1;
					
				for(i=0;i<=noofdays;i++)
				{
						
					newfrmtdet1=new SimpleDateFormat("yyyy-MM-dd").parse(fromdate1);
					miliseconds=newfrmtdet1.getTime();
					miliseconds=miliseconds+ 1000 * 60 * 60 *24;

					newfrmtdet1.setTime(miliseconds);	
				 	fromdate1= new SimpleDateFormat("yyyy-MM-dd").format(newfrmtdet1);			
					
%>
	
	<tr>
		<td align="center">  
			<input type="hidden" name="dates<%=i%>" value="<%=fromdate1%>" />
			<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate1))%>
		</td>
		<td align="center">
			<input type="text" name="kms<%=i%>" class="formElement" />
		</td>
		<td align="center">
			<input type="text" name="noofempskms<%=i%>" class="formElement" />
		</td>
		<td align="center">
			<select name="dnd<%=i%>" class="formElement">
<%
				for(int j=0;j<=20;j++)
				{ %>
					<option value="<%=j%>" > <%=j%> </option>
			<%	}	
			%>
				</select>
		</td>
	  </tr>	
				
		     	
<%				}
			%>
		
	<tr>
		<td colspan="4" align="center"> <input type="submit" name="submit" value="Submit" class="formElement" onClick="return validate(1)" /> </td>
	</tr>		
	</table>
	</td>
   </tr>		
</table>		
<%	}
%>

	</td>
  </tr>		
</table>

<input type="hidden" name="cntr" value="<%=i%>" />

<input type="hidden" name="vehno" value="<%=cabno%>" />


	
	
<%	
}catch(Exception e)
{
	out.print("Exception -->"+e);

}
finally
{
	con1.close();
}
%>


		
		
<!-- code end here --->
<table border="1" width="100%">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>


</form>
</body>
</html>

















