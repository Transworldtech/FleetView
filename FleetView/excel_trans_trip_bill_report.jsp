<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());

String filename=session.getAttribute("user").toString()+showdatex+"_trip_bill_report.xls";
    response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>

<%@ include file="Connections/conn.jsp" %>
<%!
Connection conn,conn1;
Statement st,st1,st2,st3;
String fromdate, todate,sql,sql1,transporter,mainuser,trans,trans1,trans2;
%>
<%
mainuser=session.getAttribute("usertypevaluemain").toString();

try{

		Class.forName(MM_dbConn_DRIVER); 
		conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		st=conn.createStatement();
		st1=conn.createStatement();
		st2=conn1.createStatement();
		st3=conn1.createStatement();
		if(!(null==request.getQueryString()))
		{
			fromdate=request.getParameter("data1");
			todate=request.getParameter("data2");
			trans1=request.getParameter("trans");
			trans2=trans1;
			//if(trans1.equals("All"))
			//{
			//	trans1=" All Transporters ";
			//	sql="select Distinct(VehRegNo) as trans from t_group where GPName='"+session.getAttribute("usertypevaluemain").toString()+"' order by trans ";
			//	ResultSet rsttrans1=st.executeQuery(sql);
			//	trans="(";
			//	while(rsttrans1.next())
			//	{
			//	trans=trans+"'"+rsttrans1.getString("trans")+"',";
			//	}
			//	trans=trans.substring(0,trans.length()-1);
			//	trans=trans+")";
			//}
			//else
			//{
				
				trans="('"+trans1+"')";
			//}
		}
		else
		{
			fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
			todate=fromdate;
		}
		
}
catch(Exception e)
{
	out.print("Exception -->"+e);
}
%>
<table border="0" bgcolor="white" width="100%">
		<tr>
			<td>
				<table border="0" class="stats">
					<tr>
						<td>
							<%
							if(!(null==request.getQueryString()))
							{
								try
									{
									%>
									<table border="0" width="100%" >
										<tr>
											<td colspan="11">
												
												<font color="brown" size="2">Trip Billing Report for <%=trans1%> from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate))%></font>
												<div align="right">&nbsp;&nbsp;&nbsp;
		 										<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%></div>		
											</td>
										</tr>	
									</table>
									<table border="2" class="sortable" width="100%">
										<tr>
											<td class="hed"><b>Sr.</b></td>
											<td class="hed"><b>Trip ID</b></td>
											<td class="hed"><b>Driver</td>
											<td class="hed"><b>Vehicle-No.</td>
											<td class="hed"><b>Transporter</td>
											<td class="hed"><b>Start Date</b></td>
											<td class="hed"><b>Origin</b></td>
											<td class="hed"><b>End Date</b></td>
											<td class="hed"><b>Destination</b></td>
											<td class="hed"><b>Dist. Km</b></td>
											<td class="hed"><b>Run. Time</b></td>
											<td class="hed"><b>Loading Delay Hrs.</b></td>
											<td class="hed"><b>Un Loading Delay Hrs.</b></td>
										</tr>
											<%
											sql="select * from t_completedjourney where JDCode <>'-' and GPName='Castrol' and StartDate >='"+fromdate+"' and StartDate <='"+todate+"' and OwnerName = '"+trans1+"' and DATE(StartDate) <> DATE(EndDate) and KmTravelled > 1";
											//sql="select * from t_completedjourney where JDCode <>'-' and GPName='"+mainuser+"' and StartDate >='"+fromdate+"' and StartDate <='"+todate+"' and OwnerName in "+trans+" and DATE(StartDate) <> DATE(EndDate) and KmTravelled > 1";
											//sql="select * from t_completedjourney where JDCode <>'-' and GPName='Castrol' and StartDate >='"+fromdate+"' and StartDate <='"+todate+"' and OwnerName = '"+trans1+"' and DATE(StartDate) <> DATE(EndDate) and KmTravelled > 1";
											//System.out.println("excelsql::>>"+sql);
											ResultSet rst=st.executeQuery(sql);
											int i=1;
											while(rst.next())
											{
												%>
										<tr>
											<td class="bodyText"><%=i%></td>
											<td><%=rst.getString("TripId")%></td>
											<td><div align="left"><%=rst.getString("DriverName")%><%="("+rst.getString("DriverID")+")"%></div></td>
											<td><div align="left"><%=rst.getString("VehRegNo")%></div></td>
											<td><div align="left"><%=rst.getString("OwnerName")%></div></td>
											<td><%
												try
												{	
													out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StartDate"))));
												}catch(Exception ee)
												{
													out.print(rst.getString("StartDate"));
												}
												%>
											</td>
											<td><div align="left"><%=rst.getString("StartPlace")%></div></td>
											<td>
												<%
												try
													{	
														out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("EndDate"))));
													}catch(Exception ee)
													{
														out.print(rst.getString("EndDate"));
													}
												%>	
											</td>
											<td><div align="left"><%=rst.getString("EndPlace")%></div></td>
											<td><div align="right"><%=rst.getString("KmTravelled")%></div></td>
											<td><div align="left"><%=rst.getString("TripDuration")%></div></td>
											<td><div align="right"><%=rst.getString("WaitingBefor")%></div></td>
											<td><div align="right"><%=rst.getString("WaitingAfter")%></div></td>
										</tr>
										<%
										i++;
										}
										%>		
									</table>
										<%	
									}catch(Exception e)
									{
										out.print("Exception -->"+e);
									}
									finally
									{
										conn.close();
										conn1.close();
									}
								}
								%>
						</td>
					</tr>
			</table>
	</td>
</tr>
<tr><td align="center">
<input type="button" name="Print" value="Print"  class="formElement" onclick="javascript:window.print();">
</td></tr>
</table>
<!-- footer start here -->
<table border="1" width="100%" bgcolor="white">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
<P></P>
</body>
</html>