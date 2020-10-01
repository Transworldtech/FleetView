<%@ include file="headernew.jsp" %>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/graph.js"></SCRIPT>
	
<%
  response.setHeader("Cache-Control","no-cache");
  response.setHeader("Pragma","no-cache");
  response.setDateHeader ("Expires", 0);
 %>
<%!
	Connection conn, conn1;
	Statement st0,st, st1, st2,st3,st4;
	String user,sql="",sql1,sql2,sql3;
	String data1, data2,showdate,showdate1;
	ResultSet rst, rst1;
	int total=0, count=0;
	String	VehicleRegNo="";
%>
	
<%
	NumberFormat nf = DecimalFormat.getInstance();
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2); 
	
	
		String sql1="", sql2="";
		String StartDate="",EndDate="",EndTime="",StartTime="",fromdate="",todate="",thedate="",thedate1="",MyFromDate="",MyToDate="";
		String fromdate1="",todate1="";
		if(!(null==request.getParameter("data")))
		{
			fromdate1=request.getParameter("data");
			fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(fromdate1));
				
			MyFromDate= fromdate;
			todate1=request.getParameter("data1");
			todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(todate1));
			MyToDate = todate;
				
		}	
		else
		{
		fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		todate=fromdate;
		fromdate1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
		todate1=fromdate1;
		//out.print(todate);
		}
	
%>

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
			var date2=document.getElementById("data1").value;
			var dm1,dd1,dy1,dm2,dd2,dy2;
			var dd11,yy11,mm1,mm2,mm11,dd22,yy22,mm22;

			dd11=date1.substring(0,2);
			dd22=date2.substring(0,2);

			mm1=date1.substring(3,6);
			mm2=date2.substring(3,6);

			mm11=dateformat(mm1);
			mm22=dateformat(mm2);
			
			yy11=date1.substring(7,11);
			yy22=date2.substring(7,11);
			
			var date=new Date();
			var month=date.getMonth()+1;
			var day=date.getDate();
			var year=date.getFullYear();
			
			if(yy11>year || yy22>year)
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
 </script>
	
	<!--Start of outer table -->
	<body>
	<form name="dateform" action="" method="get" onsubmit="return validate();">
	<table class="sortable_entry" border="10">
	
	<tr><td><b>From </b>&nbsp;&nbsp;
	<input type="text" id="data" name="data" value="<%=fromdate1%>"  size="15" readonly/>
	<script type="text/javascript">
	  Calendar.setup(
	    {
	      inputField  : "data",         // ID of the input field
	      ifFormat    : "%d-%b-%Y",      // the date format
	      button      : "data"       // ID of the button
	    }
	  );
	</script></td>
<!--	  </td><td align="left">-->
<!--	<input type="button" name="From Date" value="From Date" id="trigger" >-->
	
<!--	</td>-->
	<td>
	<b>To </b>&nbsp;&nbsp;
	<input type="text" id="data1" name="data1" value="<%=todate1%>" size="15" readonly/>
	<script type="text/javascript">
	  Calendar.setup(
	    {
	      inputField  : "data1",         // ID of the input field
	      ifFormat    : "%d-%b-%Y",     // the date format
	      button      : "data1"       // ID of the button
	    }
	  );
	</script>
<!--	</td><td align="left">-->
<!--	  <input type="button" name="To Date" value="To Date" id="trigger1" >-->
	
<!--	</td>-->
	<td><input type="submit" name="submit" id="submit" value="submit" ></td>
	</tr>
	</form>
	
	<tr><td colspan="5">
	<%
	
try{
		
		Class.forName(MM_dbConn_DRIVER); 
		conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		st=conn.createStatement();
		st0=conn.createStatement();
		st1=conn.createStatement();
		st2=conn.createStatement();

	
	String dd=request.getQueryString();
	if(dd==null)
	{
		out.print("<center class='bodyText'><b>Please select the dates to display the report</b></center>");
	}
	else
	{	
		data1=request.getParameter("data");
		data2=request.getParameter("data1");
		user=session.getAttribute("usertypevalue").toString();
	%>
	<table class="stats" border="10">
	<th colspan="4">Head Light On Off Report for <%=user%> transporters from date <%
	java.util.Date ShowDate = new SimpleDateFormat("dd-MMM-yyyy").parse(data1);
	Format formatter2 = new SimpleDateFormat("dd-MMM-yyyy");
	showdate = formatter2.format(ShowDate);
	out.print(showdate);
	%> to <%
	java.util.Date ShowDate1 = new SimpleDateFormat("dd-MMM-yyyy").parse(data2);
	Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
	showdate1 = formatter1.format(ShowDate1);
	out.print(showdate1);
	%>. <div align="right">
	<div align="right">
	<a href="#" onclick="javascript:window.open('HeadLightOnOf_print.jsp?userval=<%=user%>&data=<%=fromdate1%>&data1=<%=todate1%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; <a href="HeadLightOnOf_excel.jsp?userval=<%=user%>&data=<%=data1%>&data1=<%=data2%>&Total=<%=total%>"  title="Export to Excel">
	<img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;Date : 
	<%Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
	  String sdt = fmt.format(new java.util.Date());
	  out.print(sdt); 
	  String fromtime,totime;
	 // System.out.println("in hr tag total-------->" + total);
	%></div></th></tr>
	<tr>

	<td class="hed"><div class="bodyText"><b>Veh.</b></div></td>
	<td class="hed"><div class="bodyText"><b>ON Time</b></div></td>
	<td class="hed"><div class="bodyText"><b>OFF Time</b></div></td>
	<td class="hed"><div class="bodyText"><b>Duration (in Minutes)</b></div></td>
	</tr>
		<%
		fromdate=request.getParameter("data");
		todate=request.getParameter("data1");
		fromtime=request.getParameter("fromtime");
		totime=request.getParameter("totime");	
		//System.out.println("Table created----------------");
		
		
		try{
			
			String VehicleRegNo="",VehicleCode = "";
			String sql55 = "SELECT VehicleRegNumber, VehicleCode FROM t_vehicledetails where VehicleCode IN "+ session.getAttribute("VehList");
			
			//System.out.println("sql55------------------>" + sql55);
			rst=st0.executeQuery(sql55);
			
			//if(rst != null)
			//{	
				while(rst.next())
				{	
				 
				VehicleRegNo =rst.getString("VehicleRegNumber");
				
				VehicleCode = rst.getString("VehicleCode");
				
				 String str1= "select * from t_veh"+ VehicleCode+ " where TheFieldDataDate>='"+MyFromDate+ "' and TheFieldDataDate <='"+ MyToDate +"' and TheFiledTextFileName in ('HN') order by concat(TheFieldDataDate,' ',TheFieldDataTime) asc";
				
				 //System.out.println("str1----------------->" + str1);
				 rst1 = st1.executeQuery(str1);
				 ResultSet rst2=null;
				 java.util.Date dt1=null, dt2=null;
				 long mils3=00;
				 int i =1;
				
				 while(rst1.next())
				 {
					 if(rst1.getString("TheFiledTextFileName").equals("HN"))
						{	
							dt1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst1.getString("TheFieldDataDate")+" "+rst1.getString("TheFieldDataTime"));
							//System.out.println("dt1-------------------->"+ dt1);
							
							//String str2 ="SELECT * FROM t_veh"+ VehicleCode +" WHERE TheFieldDataDate>='"+MyFromDate+ "' and TheFieldDataDate <='"+ MyToDate +"' and TheFiledTextFileName LIKE 'HF' AND TheFieldDataDate > '"+ rst1.getString("TheFieldDataDate") + "' AND TheFieldDataTime > '"+ rst1.getString("TheFieldDataTime") + "' order by TheFieldDataDate asc LIMIT 1"; 
					 
					 		
					 		String str2 = "SELECT * FROM t_veh"+ VehicleCode + " WHERE concat(TheFieldDataDate,' ',TheFieldDataTime)> '"+ rst1.getString("TheFieldDataDate") + " " + rst1.getString("TheFieldDataTime") +"' AND TheFiledTextFileName IN ('HF','HN') order by concat(TheFieldDataDate,' ',TheFieldDataTime) asc LIMIT 1";
							
					 		
					 		//System.out.println("str2---------------->"+str2);
							rst2= st2.executeQuery(str2); 
					 		
					 		if(rst2.next())
							{
								//System.out.println("i got HF");
								//System.out.println("rst2.TheFiledTextFileName------------->" + rst2.getString("TheFiledTextFileName"));
								dt2=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst2.getString("TheFieldDataDate")+" "+rst2.getString("TheFieldDataTime"));
								//System.out.println("dt2------------------>" + dt2);	

								long mils1=dt1.getTime();
								//System.out.println("mils1----->" + mils1);
								long mils2=dt2.getTime();
								//System.out.println("mils2----->" + mils2);
								mils3=mils2-mils1;
								
								mils3=mils3/1000/60;
								//System.out.println("mils3---------------------------->" + mils3);
								
								if (mils3 > 0)
								{
								%>
								<tr>
								<td class="bodyText"><div align="left"><%=VehicleRegNo%></div></td> 
								<td style="text-align: left"><%= new SimpleDateFormat("dd-MMM-yyyy hh:mm:ss a").format(dt1) %></td>
								<td style="text-align: left"><%= new SimpleDateFormat("dd-MMM-yyyy hh:mm:ss a").format(dt2) %> </td>
								<td style="text-align: right"><%= mils3 %> </td>
								</tr>
								<%
								}
								dt1=null;dt2=null;
							}//end of if(rst2.next())
						
						//}//end of  if(rst1.getString("TheFiledTextFileName").equals("HN"))
							
							//i++;
						
				 	}	//end of  while(rst1.next())
				 		//break;
				}//outer while	
				
			} // end of if(rst2.next())	 	
					 	
		}catch(Exception e)
			{
			System.out.print("Exception "+e);
			}// end of catch(Exception e)
			
				
			%>	
		</div></td>
	</table>
	<!--end of outer table -->

	</td></tr>
	</form>
	</table>
	<!-- footer start here -->
	
	<%
	}//end of else
		
}
	catch(Exception e)
	{
		out.print("Exception "+e);
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
		conn1.close();
		}
		catch(Exception e){}
	}// end of final


	%>
</td>
</tr>
	</table>
<br><br>
<br><br>
<br><br>
<br><br>
<br><br>

<br><br>
<%@ include file="footernew.jsp"%>
