<%@ include file="headernew.jsp" %>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/graph.js"></SCRIPT>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

%>
<%!
Connection con1;
Statement st, st2, st3, st4, st5;
ResultSet rs1=null, rs2=null, rs3=null, rs4=null, rs5=null;
String sql1="", sql2="", sql3="", sql4="", sql5="";
 %>
 <form name="dateform" action="" method="get" onsubmit="validate();">
<%
try{
	Class.forName(MM_dbConn_DRIVER); 
	con1=fleetview.ReturnConnection();
	
	
	 st=con1.createStatement();
	 st2=con1.createStatement();
	 st3=con1.createStatement();
	 st4=con1.createStatement();
	 st5=con1.createStatement();
	 
	}
	catch(Exception e)
	{
		out.print("Exception "+e);
	}
java.util.Date defoultdate = new java.util.Date();
Format formatter = new SimpleDateFormat("dd-MMM-yyyy");
String fidDate = formatter.format(defoultdate);

String user=session.getValue("usertypevalue").toString();

%>
<table class="stats">
	
	<tr>
		<td colspan="4"> Vehicles in Trip: <select name="vehsinfixedtrip">
				<%=fleetview.getFixedLocTrips(user) %>
		 </select> 
		</td>
		<td colspan="3">
			<input type="submit" name="submit" id="submit" value="submit" >
		</td>
	</tr>
	</form>
	<tr>
		<td colspan="7">
			<%
				String dd=request.getQueryString();
				if(dd==null)
				{
					
				}
				else
				{
						String result[]=fleetview.getFixedLocId(request.getParameter("vehsinfixedtrip"),user);
						//out.print(result[1]);
						
						%>
					<tr>
						<th colspan="8">Trip Tracking of <%=request.getParameter("vehsinfixedtrip")%> (<%=result[0] %> - <%=result[1] %>; Started on <%=new SimpleDateFormat("dd-MMM-yyyy hh:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").parse(result[3])) %>)  <div align="right">
							<a href="#" onclick="javascript:window.open('');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; <a href=""  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;Date : <%
							Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
							String sdt = fmt.format(new java.util.Date());
 							out.print(sdt); %></div>
 						</th>
 					</tr>
					<tr>
					<td class="hed">Sr.</td>
						
						<td class="hed">
							<div class="bodyText"><b>Location</b></div>
						</td>
						<td class="hed">
							<div class="bodyText"><b>Scheduled Arrival Time</b></div>
						</td>
						<td class="hed">
							<div class="bodyText"><b>ETA</b></div>
						</td>
						<td class="hed">
							<div class="bodyText"><b>Reached</b></div>
						</td>
						<td class="hed">
							<div class="bodyText"><b>Actual Arrival Time</b></div>
						</td>
						<td class="hed">
							<div class="bodyText"><b>Status</b></div>
						</td>
						
					</tr>
					<%
					try{
						int i=0, j=0;
						String SchedArrDateTime=result[3];
						String[] AllStopResult=new String[100];
						
						String[] reachedarray=new String[100];
						String[] eta=new String[100];
						String[] stopdatetimearray=new String[100];
						
						sql1="select * from t_routeorderpoints where RCode='"+result[2]+"' and PointOrder <> '1' order by PointOrder asc";
						//out.print(sql1);
						rs1=st.executeQuery(sql1);
						while(rs1.next())
						{
							i++;
							String noofhours=rs1.getString("TimeDur");
							String statmsg="", stattimediffhours="", stattimediffmins="", stattimediffsecs="", stattimediff="";
							%>
							<tr>
								<td> <%=i %> </td>
								<td> <%=rs1.getString("Place") %> </td>
							<%
							String schstartdatetime=SchedArrDateTime;
							
		/* In SchedArrDateTime var (Initialzed by Trip Start Date-time), I am calculating Scheduled Time to be taken as per no of hours given in DB. */					
							
							SchedArrDateTime=fleetview.getAddingHourstoDate(schstartdatetime,noofhours);
							%>	
								<td> <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").parse(SchedArrDateTime)) %> </td>
								
							<%
								double lat=0, lon=0;
								sql4="select * from t_warehousedata where WareHouse='"+rs1.getString("Place")+"' and Owner='"+user+"' ";
								//out.print(sql4);
								rs4=st4.executeQuery(sql4);
								if(rs4.next())
								{
									lat=rs4.getDouble("Latitude");
									lon=rs4.getDouble("Longitude");
								}
						
				/* Here I am checking whether this vehicle was passed thru that specific Location.  
			Logic here for ETA is as: If Vehicle was passed thru that location, it will send reacheddatetime (which I am storing
			in 'stopdatetimearray' array var and status(reached or not) which I am storing in 'reachedarray' array var.
			When j > 0, then ETA logic will start, otherwise ETA will remain same for first record. 
			Now here I am checking, if the last status (reachedarray[j-1]) is false. If false, then current ETA will 
			be filled as Adding no of hours to previous ETA (eta[j-1]). If last status (reachedarray[j-1]) is true, that means
			it was reached to last location. So current eta will change accordinf to reached datetime. SO for current ETA 
			I am adding no of hours to last reached date time (eta[j]=getAddingHourstoDate(stopdatetimearray[j-1],noofhours)).
			
			*/
			
								String[] StopInfo=fleetview.getStopDateTime(lat,lon,result[3],result[4]);
								
								String stopdatetime=StopInfo[0];
								stopdatetimearray[j]=StopInfo[0];;
								String reached=StopInfo[1];
									
								reachedarray[j]=StopInfo[1];
								String reachedtodest="";
																								
						if(j==0)
						{
							eta[j]=SchedArrDateTime;
						}
						else
						{ 
							if(reachedarray[j-1].equals("false")) //if previous was Reached or not
							{ 
								//eta[j]=SchedArrDateTime;
								try{
									eta[j]=fleetview.getAddingHourstoDate(eta[j-1],noofhours);
								} catch(Exception e)
								{
									out.print("Exception====>"+e);
									//eta[j]=SchedArrDateTime;
									
								}
							}
							else  //if true
							{ 
								try{
									eta[j]=fleetview.getAddingHourstoDate(stopdatetimearray[j-1],noofhours);
									
							    	}catch(Exception e1)
								    {
									    //eta[j]=SchedArrDateTime;
									    //out.print("Exception---->?"+e1);
								    }
							}	
						}  
						
						/* Below code is for Last Status (i.e., whether it was delayed / on time or befroe time ) and also
						calculating time. 
						*/
								String[] statresult=new String[100];
						
								if(reached.equals("false"))
								{
									reachedtodest="No";
									statmsg="NA";
								}
								else
								{	
									try{
									
											AllStopResult[j]=stopdatetimearray[j-1];
											reachedtodest="Yes";
											statresult=fleetview.getTimeDiff(stopdatetimearray[j], eta[j]);
									
											statmsg=statresult[0];
											stattimediff=statresult[1];
									
											sql5="select HOUR(SEC_TO_TIME("+stattimediff+"/1000))";
											rs5=st5.executeQuery(sql5);
											if(rs5.next())
											{
												stattimediffhours=rs5.getString(1);	
											}
									
											sql5="select MINUTE(SEC_TO_TIME("+stattimediff+"/1000))";
											rs5=st5.executeQuery(sql5);
											if(rs5.next())
											{
												stattimediffmins=rs5.getString(1);	
											}
									
											sql5="select SECOND(SEC_TO_TIME("+stattimediff+"/1000))";
											rs5=st5.executeQuery(sql5);
											if(rs5.next())
											{
												stattimediffsecs=rs5.getString(1);	
											}
										}catch(Exception e2)
										{
																						
											AllStopResult[j]=stopdatetimearray[j];
											reachedtodest="Yes";
											
											statresult=fleetview.getTimeDiff(stopdatetimearray[j], eta[j]);
											
											statmsg=statresult[0];
											stattimediff=statresult[1];
									
											sql5="select HOUR(SEC_TO_TIME("+stattimediff+"/1000))";
											rs5=st5.executeQuery(sql5);
											if(rs5.next())
											{
												stattimediffhours=rs5.getString(1);	
											}
									
											sql5="select MINUTE(SEC_TO_TIME("+stattimediff+"/1000))";
											rs5=st5.executeQuery(sql5);
											if(rs5.next())
											{
												stattimediffmins=rs5.getString(1);	
											}
									
											sql5="select SECOND(SEC_TO_TIME("+stattimediff+"/1000))";
											rs5=st5.executeQuery(sql5);
											if(rs5.next())
											{
												stattimediffsecs=rs5.getString(1);	
											}
																				
											
									
										}
									}			
							
							%>	
								<td> <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").parse(eta[j])) %>   </td>
								
								<td> <%=reached %> </td>
								<td>
								<%
								 	try{
								%>				
									 <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").parse(stopdatetimearray[j])) %> 
								<%    }
									  catch(Exception e2)
									  { %>
									  	   <%=stopdatetimearray[j] %> 
									<%
									  }
									  %>
									  </td>
								<%
								if(reached.equals("false"))
								{
								%>	  
									<td> <%=statmsg %>   </td>
							<%  }
								else
								{	
								%>
										<td> <%=statmsg %>  <%=stattimediffhours %>:<%=stattimediffmins %>:<%=stattimediffsecs %> </td>
							<%  } %>				
																							
							</tr>	
						<% 	
							j++;
						}
	%>
					
					<!--end of outer table -->
					<%
					}catch(Exception e)
					{
						out.print("Exception "+e);
					}
					finally
					{
						con1.close();
						
					}
					
				}
				
%>

</form> 
</table>

</jsp:useBean>
<%@ include file="footernew.jsp" %>
