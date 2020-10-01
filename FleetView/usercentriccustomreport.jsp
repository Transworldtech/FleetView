<%@ include file="headernew.jsp"%>

<%@page import="com.transworld.fleetview.framework.VehicleDao"
		import="com.transworld.fleetview.framework.ExceptionAnalysisReportData"
		import="com.transworld.fleetview.framework.Utilities" %>

<jsp:useBean id="vehicleDao"
	type="com.transworld.fleetview.framework.VehicleDao"
	scope="application"></jsp:useBean>
	
	<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
	
	<script type="text/javascript">  
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
          document.Total_os.action ="excel.jsp";
          document.forms["Total_os"].submit();
 }  
</script>

<%!
	Connection conn, conn1;
Statement st1,st2,st,st3,st4,st5,st6;
%>

<%
try{
	
	conn = fleetview.ReturnConnection();
	conn1 = fleetview.ReturnConnection1();
	st=conn.createStatement();
	st1=conn.createStatement();
	st3=conn.createStatement();
	st2=conn1.createStatement();
	st4=conn1.createStatement();
	st5 = conn1.createStatement();
	st6 = conn1.createStatement();
	
	
	String data1=session.getAttribute("data1").toString();
	String data2=session.getAttribute("data2").toString();
	final String user=session.getAttribute("user").toString();
	final String empname = request.getParameter("empname");
	String vehid= request.getParameter("vehid");
	String vehno= request.getParameter("vehregno");
	final NumberFormat nf=NumberFormat.getInstance();
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
	String exportFileName="customreport.jsp";
	
	%>
	<form id="Total_os" name="Total_os" action="" method="post">

	<table border="0" width="100%" class="stats">
		<tr>
			<td>
	<div id="mytable">
	<table border="0" width="100%" >
	<tr>
		<td>
		<table border="0" width="100%" class="stats">
			<tr>
			<td align="center"><font size="3"><b> Exception
				Analysis Report For AVL Mobile Eye 2000 For <%=empname.toUpperCase() %> 
			    For The Period : <%=session.getAttribute("ShowDate").toString()%>
				to <%=session.getAttribute("ShowDate1").toString()%></b></font>
				<div class="bodyText" align="right">&nbsp;&nbsp;&nbsp; <input type="hidden" id="tableHTML"
					name="tableHTML" value="" /> <input type="hidden" id="fileName"
					name="fileName" value="<%= exportFileName%>" /> <a href="#"
					style="font-weight: bold; color: black;"
					onclick="gotoPrint('mytable');"> <img src="images/print.jpg"
					width="15px" height="15px" style="border-style: none"></img> </a> <a
					href="#" style="font-weight: bold; color: black;"
					onclick="gotoExcel('mytable', 'tableHTML');"> <img
					src="images/excel.jpg" width="15px" height="15px"
					style="border-style: none"></img> </a><%=Utilities.printDate() %>
				</div>
				</td>
			</tr>
		</table>
		<P></P>
	
	<%
	
	int totalOverSpeedCount=0, totalRapidAccelerationCount=0;
	int totalRapidDecelerationCount=0, totalContinuousDrivingHours=0;
	int totalNightDrivingCounts=0, totalStops=0;
	Double totalFuelCount=0.00,totalDistanceTravelled=0.0,totalFuelAverage=0.0;
	int j = 0;
	int i = 1;
	List<ExceptionAnalysisReportData> data = null;
	int numRecords = 0;
	
	
	%>
	
	<table bgcolor="#F5F5F5" width="100%" class="sortable" border="1">
			<tr>
				<th>Sr.</th>
				<th>VehRegNo</th>
				<th>Date</th>
				<th>OS</th>
				<th>RA</th>
				<th>RD</th>
				<th>CD</th>
				<th>ND</th>
				<th>DT</th>
				<th>FC</th>
				<th>AVG</th>
				<th>Stops</th>
				<th>Location</th>
			</tr>
<%		
			String data3 = "";
			String sql1 = "select * from db_gps.t_empAllocationHistory where empname = '"+empname+"' and AllocationDate = '"+data1+"'";
			ResultSet rs1 = st1.executeQuery(sql1);
			if(rs1.next())
			{
				data3 = data1;
			}
			else
			{
				String sql2 = "select * from db_gps.t_empAllocationHistory where empname = '"+empname+"' and AllocationDate <= '"+data1+"'  order by Allocationdate desc limit 1";
				ResultSet rs2 = st2.executeQuery(sql2);
				if(rs2.next())
				{
					data3 = rs2.getString("AllocationDate");
				}
				else
				{
					data3 = data1;
				}
			}

			String sql = "select * from db_gps.t_empAllocationHistory where empname = '"+empname+"' and AllocationDate >= '"+data3+"' and  AllocationDate  < '"+data2+"' order by Allocationdate";
			ResultSet rs = st.executeQuery(sql);
			System.out.println("****  "+sql);
			while(rs.next())
			{
				j++;
				 String fromdate = "",todate = "";
	    		   String vehcode= "";
	    		   fromdate = rs.getString("AllocationDate");
	    		   java.util.Date fromdate1 = new SimpleDateFormat("yyyy-MM-dd").parse(fromdate);
	    		   java.util.Date fromdate2 = new SimpleDateFormat("yyyy-MM-dd").parse(data1);
	    		   
	    		   if(fromdate1.before(fromdate2))
	    		   {
	    			   fromdate = data1;
	    		   }
	    		   
	    		   System.out.println("fromdate   "+fromdate);
	    		   vehcode = rs.getString("VehicleCode");
	    		   String vehregno = rs.getString("VehNo");
	    		   if(rs.next())
	     		  {
	    			   todate = rs.getString("AllocationDate");
	        		   System.out.println("Todate   "+todate);
	        		   if(fromdate == todate || fromdate.equals(todate))
	        		   {
	        			   
	        		   }
	        		   else
	        		   {
	        			   java.util.Date todate1 = new SimpleDateFormat("yyyy-MM-dd").parse(todate);
	            		   long mil = todate1.getTime();
	            		   mil = mil - 1000 * 60 * 60 *24;
	            		   todate1.setTime(mil);
	            		   todate = new SimpleDateFormat("yyyy-MM-dd").format(todate1);
	            		   
	            		   try {
	            				data = vehicleDao.getExceptionAnalysisData(vehcode,fromdate,todate);
	            				System.out.println("\nstep 3--->>data"+data.isEmpty());
	            				    numRecords = data.size();
	            				} catch (Exception e) {
	            						e.printStackTrace();
	            				}
	            				try
	            				{
	            					System.out.println("\nstep 4:-->>"+numRecords);
	            					for (int counter = 0; counter < numRecords; counter++)
	            					{
	            						System.out.println("\n\non dATA");
	            						final ExceptionAnalysisReportData currentRecord = data.get(counter);
	            						%>
	            						<tr>
	            						<td style="text-align: right"><%=i%></td>
	            						<td style="text-align: right"><%=vehregno%></td>
	            						<td style="text-align: left"><%=new SimpleDateFormat("dd-MMM-yyyy")
	            						.format((new SimpleDateFormat("yyyy-MM-dd")).parse(currentRecord.getDate())) %>
										</td>
										<td>
					 					<div align="right">
					 					<%
					 					try{
											int overSpeedCount = Integer.parseInt(currentRecord.getOverSpeedCount());
											totalOverSpeedCount += overSpeedCount;
										   }catch(Exception e){					
										   }
					 					out.print(currentRecord.getOverSpeedCount());
					 					%>
					 					</div>
					 					</td>
					 					<td>
 	              	 					<div align="right">
 	              	 					<%
 	              	 				try
 	              	 					{
 	       							int rapidAcceleration = Integer.parseInt(currentRecord.getRapidAcceleration());
 	       							totalRapidAccelerationCount += rapidAcceleration;
 	              	 				} catch (Exception e) {					
 	       						}
 	              	 			out.print(currentRecord.getRapidAcceleration());
 	              	 					%>
 	              	 					 </div>
										</td>
										<td>
				  						 <div align="right">
				  						 <%
				  						try{
											int rapidDeceleration = Integer.parseInt(currentRecord.getRapidDeaccelaration());
											totalRapidDecelerationCount += rapidDeceleration;
				  						} catch (Exception e) {					
										}
				  						out.print(currentRecord.getRapidDeaccelaration());
				  						 %>
				  						  </div>
				    </td>
					<td>
 				  	 <div align="right">
 				  	 <%
 				  	try{
						int continuousDriving = Integer.parseInt(currentRecord.getContinuousDriving());
						totalContinuousDrivingHours += continuousDriving;
 				  	} catch (Exception e) {					
					}
 				  	out.print(currentRecord.getContinuousDriving());
 				  	 %>
 				  	 </div>
				    </td>
					<td>
				  	 <div align="left">
				  	 <%
				  	if("Yes".equalsIgnoreCase(currentRecord.getNightDrivingStatus())){
						
						totalNightDrivingCounts++;
					}
				  	 
				  	out.print(currentRecord.getNightDrivingStatus());
				  	 %>
				  	 	 </div>
					</td>
					<td>
				 	  <div align="right">
				 	  <% 
				 	 try{
							double distanceTravelled = Double.parseDouble(currentRecord.getDistanceTravelled());
							totalDistanceTravelled += distanceTravelled;
				 	} catch (Exception e) {
					}				
					out.print(currentRecord.getDistanceTravelled());
				 	  %>
				 	 </div>
					</td>
					<td>
					 <div align="right">
					 <%
					 String fuelInfo = "";
						try{
							double fuelCount = Double.parseDouble(currentRecord.getFuelCount());
							totalFuelCount += fuelCount;
							fuelInfo = nf.format(fuelCount);
						} catch (Exception e) {					
						}
						out.print(fuelInfo);
					 %>
					  </div>
					</td>
					<td>
					 <div align="right">
					 <%
						String averageFuelInfo = "";
						try{
							double averageFuel = Double.parseDouble(currentRecord.getAverageFuel());
							averageFuelInfo = nf.format(averageFuel);
						} catch (Exception e) {							
						}						
						out.print(averageFuelInfo);
					 %>
					  </div>
					</td>
					<td>
					 <div align="right">
					 <%
					 try{
							int numberOfStops = Integer.parseInt(currentRecord.getStops());
							totalStops += numberOfStops;
					 } catch (Exception e) {					
						}
					 out.print(currentRecord.getStops());
					 %>
					  </div>
					</td>
					<td>
					 <div align="left">
					 <%
					 out.println(currentRecord.getLocation());
					 %>
					 </div>
					</td>
	            						 </tr>
	            						<%
	            						i++;
	            					}
	            				}
	            				catch(Exception e)
	            				{
	            						e.printStackTrace();				
	            				}
	            				
	        		   }
	     		  }
	    		   rs.previous();
	    		   
	    		
			}
			
			 if(j>0)
	    	   {
	    		   if(rs.last())
	    		   {
	    			   String fromdate = "",todate = "";
	        		   String vehcode= "";
	        		   fromdate = rs.getString("AllocationDate");
	        		   
	        		   java.util.Date fromdate1 = new SimpleDateFormat("yyyy-MM-dd").parse(fromdate);
	        		   java.util.Date fromdate2 = new SimpleDateFormat("yyyy-MM-dd").parse(data1);
	        		   
	        		   if(fromdate1.before(fromdate2))
	        		   {
	        			   fromdate = data1;
	        		   }
	        		   vehcode = rs.getString("VehicleCode");
	        		   todate = data2;
	        		   String vehregno = rs.getString("VehNo");
	        		   

        			   java.util.Date todate1 = new SimpleDateFormat("yyyy-MM-dd").parse(todate);
            		   long mil = todate1.getTime();
            		   mil = mil - 1000 * 60 * 60 *24;
            		   todate1.setTime(mil);
            		   todate = new SimpleDateFormat("yyyy-MM-dd").format(todate1);
            		   
            		   try {
            				data = vehicleDao.getExceptionAnalysisData(vehcode,fromdate,todate);
            				System.out.println("\nstep 3--->>data"+data.isEmpty());
            				    numRecords = data.size();
            				} catch (Exception e) {
            						e.printStackTrace();
            				}
            				try
            				{
            					System.out.println("\nstep 4:-->>"+numRecords);
            					for (int counter = 0; counter < numRecords; counter++)
            					{
            						System.out.println("\n\non dATA");
            						final ExceptionAnalysisReportData currentRecord = data.get(counter);
            						%>
            						<tr>
            						<td style="text-align: right"><%=i%></td>
            						<td style="text-align: right"><%=vehregno%></td>
            						<td style="text-align: left"><%=new SimpleDateFormat("dd-MMM-yyyy")
            						.format((new SimpleDateFormat("yyyy-MM-dd")).parse(currentRecord.getDate())) %>
									</td>
									<td>
				 					<div align="right">
				 					<%
				 					try{
										int overSpeedCount = Integer.parseInt(currentRecord.getOverSpeedCount());
										totalOverSpeedCount += overSpeedCount;
									   }catch(Exception e){					
									   }
				 					out.print(currentRecord.getOverSpeedCount());
				 					%>
				 					</div>
				 					</td>
				 					<td>
	              	 					<div align="right">
	              	 					<%
	              	 				try
	              	 					{
	       							int rapidAcceleration = Integer.parseInt(currentRecord.getRapidAcceleration());
	       							totalRapidAccelerationCount += rapidAcceleration;
	              	 				} catch (Exception e) {					
	       						}
	              	 			out.print(currentRecord.getRapidAcceleration());
	              	 					%>
	              	 					 </div>
									</td>
									<td>
			  						 <div align="right">
			  						 <%
			  						try{
										int rapidDeceleration = Integer.parseInt(currentRecord.getRapidDeaccelaration());
										totalRapidDecelerationCount += rapidDeceleration;
			  						} catch (Exception e) {					
									}
			  						out.print(currentRecord.getRapidDeaccelaration());
			  						 %>
			  						  </div>
			    </td>
				<td>
				  	 <div align="right">
				  	 <%
				  	try{
					int continuousDriving = Integer.parseInt(currentRecord.getContinuousDriving());
					totalContinuousDrivingHours += continuousDriving;
				  	} catch (Exception e) {					
				}
				  	out.print(currentRecord.getContinuousDriving());
				  	 %>
				  	 </div>
			    </td>
				<td>
			  	 <div align="left">
			  	 <%
			  	if("Yes".equalsIgnoreCase(currentRecord.getNightDrivingStatus())){
					
					totalNightDrivingCounts++;
				}
			  	 
			  	out.print(currentRecord.getNightDrivingStatus());
			  	 %>
			  	 	 </div>
				</td>
				<td>
			 	  <div align="right">
			 	  <% 
			 	 try{
						double distanceTravelled = Double.parseDouble(currentRecord.getDistanceTravelled());
						totalDistanceTravelled += distanceTravelled;
			 	} catch (Exception e) {
				}				
				out.print(currentRecord.getDistanceTravelled());
			 	  %>
			 	 </div>
				</td>
				<td>
				 <div align="right">
				 <%
				 String fuelInfo = "";
					try{
						double fuelCount = Double.parseDouble(currentRecord.getFuelCount());
						totalFuelCount += fuelCount;
						fuelInfo = nf.format(fuelCount);
					} catch (Exception e) {					
					}
					out.print(fuelInfo);
				 %>
				  </div>
				</td>
				<td>
				 <div align="right">
				 <%
					String averageFuelInfo = "";
					try{
						double averageFuel = Double.parseDouble(currentRecord.getAverageFuel());
						averageFuelInfo = nf.format(averageFuel);
					} catch (Exception e) {							
					}						
					out.print(averageFuelInfo);
				 %>
				  </div>
				</td>
				<td>
				 <div align="right">
				 <%
				 try{
						int numberOfStops = Integer.parseInt(currentRecord.getStops());
						totalStops += numberOfStops;
				 } catch (Exception e) {					
					}
				 out.print(currentRecord.getStops());
				 %>
				  </div>
				</td>
				<td>
				 <div align="left">
				 <%
				 out.println(currentRecord.getLocation());
				 %>
				 </div>
				</td>
            						 </tr>
            						<%
            						i++;
            					}
            				}
            				catch(Exception e)
            				{
            						e.printStackTrace();				
            				}
            	
	    		   }
	    	   }
			 else
			 {

      		   try {
      				data = vehicleDao.getExceptionAnalysisData(vehid,data1,data2);
      				System.out.println("\nstep 3--->>data"+data.isEmpty());
      				    numRecords = data.size();
      				} catch (Exception e) {
      						e.printStackTrace();
      				}
      				try
      				{
      					System.out.println("\nstep 4:-->>"+numRecords);
      					for (int counter = 0; counter < numRecords; counter++)
      					{
      						System.out.println("\n\non dATA");
      						final ExceptionAnalysisReportData currentRecord = data.get(counter);
      						%>
      						<tr>
      						<td style="text-align: right"><%=i%></td>
      						<td style="text-align: right"><%=vehno%></td>
      						<td style="text-align: left"><%=new SimpleDateFormat("dd-MMM-yyyy")
      						.format((new SimpleDateFormat("yyyy-MM-dd")).parse(currentRecord.getDate())) %>
								</td>
								<td>
			 					<div align="right">
			 					<%
			 					try{
									int overSpeedCount = Integer.parseInt(currentRecord.getOverSpeedCount());
									totalOverSpeedCount += overSpeedCount;
								   }catch(Exception e){					
								   }
			 					out.print(currentRecord.getOverSpeedCount());
			 					%>
			 					</div>
			 					</td>
			 					<td>
            	 					<div align="right">
            	 					<%
            	 				try
            	 					{
     							int rapidAcceleration = Integer.parseInt(currentRecord.getRapidAcceleration());
     							totalRapidAccelerationCount += rapidAcceleration;
            	 				} catch (Exception e) {					
     						}
            	 			out.print(currentRecord.getRapidAcceleration());
            	 					%>
            	 					 </div>
								</td>
								<td>
		  						 <div align="right">
		  						 <%
		  						try{
									int rapidDeceleration = Integer.parseInt(currentRecord.getRapidDeaccelaration());
									totalRapidDecelerationCount += rapidDeceleration;
		  						} catch (Exception e) {					
								}
		  						out.print(currentRecord.getRapidDeaccelaration());
		  						 %>
		  						  </div>
		    </td>
			<td>
			  	 <div align="right">
			  	 <%
			  	try{
				int continuousDriving = Integer.parseInt(currentRecord.getContinuousDriving());
				totalContinuousDrivingHours += continuousDriving;
			  	} catch (Exception e) {					
			}
			  	out.print(currentRecord.getContinuousDriving());
			  	 %>
			  	 </div>
		    </td>
			<td>
		  	 <div align="left">
		  	 <%
		  	if("Yes".equalsIgnoreCase(currentRecord.getNightDrivingStatus())){
				
				totalNightDrivingCounts++;
			}
		  	 
		  	out.print(currentRecord.getNightDrivingStatus());
		  	 %>
		  	 	 </div>
			</td>
			<td>
		 	  <div align="right">
		 	  <% 
		 	 try{
					double distanceTravelled = Double.parseDouble(currentRecord.getDistanceTravelled());
					totalDistanceTravelled += distanceTravelled;
		 	} catch (Exception e) {
			}				
			out.print(currentRecord.getDistanceTravelled());
		 	  %>
		 	 </div>
			</td>
			<td>
			 <div align="right">
			 <%
			 String fuelInfo = "";
				try{
					double fuelCount = Double.parseDouble(currentRecord.getFuelCount());
					totalFuelCount += fuelCount;
					fuelInfo = nf.format(fuelCount);
				} catch (Exception e) {					
				}
				out.print(fuelInfo);
			 %>
			  </div>
			</td>
			<td>
			 <div align="right">
			 <%
				String averageFuelInfo = "";
				try{
					double averageFuel = Double.parseDouble(currentRecord.getAverageFuel());
					averageFuelInfo = nf.format(averageFuel);
				} catch (Exception e) {							
				}						
				out.print(averageFuelInfo);
			 %>
			  </div>
			</td>
			<td>
			 <div align="right">
			 <%
			 try{
					int numberOfStops = Integer.parseInt(currentRecord.getStops());
					totalStops += numberOfStops;
			 } catch (Exception e) {					
				}
			 out.print(currentRecord.getStops());
			 %>
			  </div>
			</td>
			<td>
			 <div align="left">
			 <%
			 out.println(currentRecord.getLocation());
			 %>
			 </div>
			</td>
      						 </tr>
      						<%
      						i++;
      					}
      				}
      				catch(Exception e)
      				{
      						e.printStackTrace();				
      				}
      				
  		
			 }
			 
			 if(totalFuelCount>0){
			     	totalFuelAverage=totalDistanceTravelled/totalFuelCount;
				 }
			 %>
				<tr class="sortbottom">
					<td class="hed" colspan="3">Total</td>
					<td class="hed">
					 <div align="right"><%=totalOverSpeedCount%></div>
					</td>
					<td class="hed">
					 <div align="right"><%=totalRapidAccelerationCount%></div>
					</td>
					<td class="hed">
					 <div align="right"><%=totalRapidDecelerationCount%></div>
					</td>
					<td class="hed">
					 <div align="right"><%=totalContinuousDrivingHours%></div>
					</td>
					<td class="hed">
					 <div align="right"><%=totalNightDrivingCounts%></div>
					</td>
					<td class="hed">
					 <div align="right"><%=totalDistanceTravelled%></div>
					</td>
					<td class="hed">
					 <div align="right"><%=totalFuelCount%></div>
					</td> 
					<td class="hed">
					 <div align="right">		
						 <%=nf.format(totalFuelAverage) %></div>
					</td>
					<td class="hed">
			 		 <div align="right"><%=totalStops%></div>  
					</td>
					<td class="hed">
					 <div align="right">-</div>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	</div>
	</td>
	</tr>
	</table>
	</form>
	<%
}
catch(Exception e)
{
	System.out.println("Exception   " +e);
}
finally
{
		conn.close();
		conn1.close();
	
}


fleetview.closeConnection1();
fleetview.closeConnection();
			%>
			
			</jsp:useBean>
			 <%@ include file="footernew.jsp" %>