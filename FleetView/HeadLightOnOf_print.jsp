<%@ include file="Connections/conn.jsp" %>
<link href="css/css.css" rel="StyleSheet" type="text/css">
<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/graph.js"></SCRIPT>
<%!
	Connection conn, conn1;
	Statement st0,st, st1, st2,st3,st4;
	String user,sql="",sql1,sql2,sql3;
	String data1, data2,showdate,showdate1;
	ResultSet rst, rst1;
	int total=0, count=0;
	String	VehicleRegNo="";
	String StartDate="",EndDate="",EndTime="",StartTime="",fromdate="",todate="",thedate="",thedate1="",MyFromDate="",MyToDate="";
	String fromdate1="",todate1="";
%>

<%
data1=request.getParameter("data");
//System.out.println("data1----------------->" + data1);
data2=request.getParameter("data1");
//System.out.println("data2----------------->" + data2);
user=session.getAttribute("usertypevalue").toString();
%>

	<table class="stats" border="10">
	<th colspan="4">Head Light On Off Report for <%=user%> transporters from date
	<% java.util.Date ShowDate = new SimpleDateFormat("dd-MMM-yyyy").parse(data1);
	Format formatter2 = new SimpleDateFormat("dd-MMM-yyyy");
	showdate = formatter2.format(ShowDate);
	out.print(showdate);
	%> to 
	<%
	java.util.Date ShowDate1 = new SimpleDateFormat("dd-MMM-yyyy").parse(data2);
	Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
	showdate1 = formatter1.format(ShowDate1);
	out.print(showdate1);
	%>
	. <div align="right">
	
	Date : 
	
	<%
	Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
	  String sdt = fmt.format(new java.util.Date());
	  out.print(sdt); 
	  String fromtime,totime;
	
	%>
	</div></th></tr>
	<tr>

	<td class="hed"><div class="bodyText"><b>Vehicle Registration Number</b></div></td>
	<td class="hed"><div class="bodyText"><b>ON Time</b></div></td>
	<td class="hed"><div class="bodyText"><b>OFF Time</b></div></td>
	<td class="hed"><div class="bodyText"><b>Duration (in Minutes)</b></div></td>
	</tr>
<%

//System.out.println("ok i am here");
	
	
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st0=conn.createStatement();
	st1=conn.createStatement();
	st2=conn.createStatement();
	
	if(!(null==request.getParameter("data")))
	{
		fromdate1=request.getParameter("data");
		fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(fromdate1));
		MyFromDate= fromdate;
		//System.out.println("MyFromDate------------------>" + MyFromDate);
		
		todate1=request.getParameter("data1");
		todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(todate1));
		MyToDate = todate;
		//System.out.println("MyToDate------------------>" + MyToDate);	
	}	
	else
	{
	fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	todate=fromdate;
	fromdate1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	todate1=fromdate1;
	//out.print(todate);
	}

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
						<td class="bodyText"><div align="center"><%=VehicleRegNo%></div></td> 
						<td><%= new SimpleDateFormat("dd-MMM-yyyy hh:mm:ss a").format(dt1) %></td>
						<td><%= new SimpleDateFormat("dd-MMM-yyyy hh:mm:ss a").format(dt2) %> </td>
						<td align="center"><%= mils3 %> </td>
						</tr>
						<%
						}
						dt1=null;dt2=null;
					}//end of if(rst2.next())
				
				}//end of  if(rst1.getString("TheFiledTextFileName").equals("HN"))
					
					//i++;
				
		 	}	//end of  while(rst1.next())
		 		//break;
		}//outer while	
		

			 	

					 	
		}catch(Exception e)
			{
			System.out.print("Exception "+e);
			}// end of catch(Exception e)
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
</div></td>
</table>
</div>
</table>
</body>

</html>