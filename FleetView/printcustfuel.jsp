<%@page import="javax.swing.text.NumberFormatter"%>
<%@page import="com.transworld.fleetview.framework.VehicleDao"
		import="com.transworld.fleetview.framework.VehicleRegistrationNumberList"
		import="com.transworld.fleetview.framework.TotalDistanceTraveled"
		import="com.transworld.fleetview.framework.FuelInfoVehicleList"
		import="com.transworld.fleetview.framework.Utilities" %>
		
		
<jsp:useBean id="vehicleDao"
	type="com.transworld.fleetview.framework.VehicleDao"
	scope="application"></jsp:useBean>
	
<%@ include file="headerprintnew.jsp" %>

<%!

String date1, date2,datenew1,datenew2,datef1,datef2, vehcode, vehregno,tbname,sql,owner,km,rating,from,to,ndcount;
String dateformat,vehicleCode="";
%>
<%
String vehno=request.getParameter("vehno");
owner=request.getParameter("owner");
date1=request.getParameter("data");
date2=request.getParameter("data1");
dateformat=session.getAttribute("dateformat").toString();
if(null==date1)
{
	date1=date2=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	datef1=new SimpleDateFormat("dd-MMM-yyyy ").format(new SimpleDateFormat("yyyy-MM-dd").parse(date1));
	datef2=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date2));
}
else
{
	
	datef1=new SimpleDateFormat("dd-MMM-yyyy ").format(new SimpleDateFormat("yyyy-MM-dd").parse(date1));
	datef2=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date2));
}
List<VehicleRegistrationNumberList> vehicleList = null;
%>
			
		<table width="100%">
			<tr>
			<td colspan="8" align="center">
			<font color="black" size="3">The Fuel Fill up Report of <%=owner%> from <%=datef1 %> to <%=datef2 %></font>
				&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="Print" value="Print" onclick="javascript:window.print();" class="formElement">
			</td>
			</tr>
			</table>
			<table width="100%" border="1" align="center" class="sortable">
			<tr>
				<th> <b> Sr. </b></th>
				<th> <b>VehicleRegno</b></th>
				<th> <b>Date-Time</b></th>
				<th> <b>Driver</b></th>
				<th> 
	      			<%
	      				if(session.getAttribute("fuelformat").toString().equalsIgnoreCase("Gal"))
						{
	    	  		%>
						 <b> Gallans: </b>
					<%	}else
					{%>
				
						 <b> Liters: </b>
					<%
					}%>
	      		</th>
				<th> <b>Odometer</b></th>
				<th> 
	       		<%
	     		 	if(session.getAttribute("fuelformat").toString().equalsIgnoreCase("Gal"))
					{
	    	 	%>
						<b> Gas Station:</b> 
				<%	}else{
				%>
					<b> Petrol Pump:</b> 
				<%
					}%>
	      		</th>
				<th> <b>Ent By</b></th>
			</tr>
			<%
			String trans="";
			double Avg=0.00;

				int i=1;
				int totdist=0;
				double fueladded=0,totfuel=0;
				String tabname="";
				List<FuelInfoVehicleList> list=null;
				try{
					int numRecords = 0;
					try {
						list = vehicleDao.getFuelInfoVehicleDetails(vehno
								,date1,date2);
						numRecords = list.size();
					} catch (Exception e) {
						e.printStackTrace();
					}
					if(numRecords>0)
					for (int counter = 0; counter < numRecords; counter++)
					{
					final FuelInfoVehicleList currentRecord = list.get(counter);
					System.out.println(currentRecord.getVehicleCode());
				//	System.out.println("##################Driver");
					System.out.println(currentRecord.getDriver());
					if(!(null==currentRecord.getVehicleCode()))
						vehicleCode=currentRecord.getVehicleCode();
					if(!("-").equalsIgnoreCase(currentRecord.getLiters()))
					{
						fueladded=Double.parseDouble(currentRecord.getLiters());
					totfuel+=fueladded;
%>		
			<tr>
				<td style="text-align: right"> <%=i++ %></td>
				<td style="text-align: left"> <%=vehno %></td>
<%
					String datef=new SimpleDateFormat(dateformat+" HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(currentRecord.getTheDateTime()));
%>
				<td style="text-align: left"> <%=datef %></td>
				<td style="text-align: left"> <%=currentRecord.getDriver() %></td>
				<td ><div align="right">
<%
					if(session.getAttribute("fuelformat").toString().equalsIgnoreCase("Gal"))
					{ 
%>
				 			<%=(int) (Double.parseDouble(currentRecord.getLiters())/3.78541178)%>
<%
					}else{ 
%>
				 			<%=currentRecord.getLiters()%>
<% 
					}
%>
				 </div></td>
				<td style="text-align: right"> <%=currentRecord.getOdodmeterReading()%></td>
				<td style="text-align: left"> <%=currentRecord.getPetrolPump() %></td>
				<td style="text-align: left"> <%=currentRecord.getEnteredBy()%></td>
			</tr>	
			
<%}
				}
%>
			<tr>
				<td colspan="4" align="center"><font size="2"><b>Total</b></font></td>	
				<td ><div align="right"><%=totfuel %></div></td>
				<td align="right">-</td>
				<td align="right">-</td>
				<td align="right">-</td>
			</tr>
			</table>
<%


try {
	vehicleList = vehicleDao.getVehicleRegistrationNumberList(owner);
	numRecords = vehicleList.size();
} catch (Exception e) {
	e.printStackTrace();
}

for (int counter = 0; counter < numRecords; counter++)
{
	String vehicleRegNo=vehicleList.get(counter).getVehicleRegistrationNumber();
	
	if(vehicleRegNo.equalsIgnoreCase(vehno))
	{
		vehicleCode=vehicleList.get(counter).getVehicleCode();
	}
}
			List<TotalDistanceTraveled> distanceTraveled=null;
			try {
				distanceTraveled = vehicleDao.getTotalDistanceTraveled(vehicleCode
						,date1,date2);
			} catch (Exception e) {
				e.printStackTrace();
			}
			totdist = Integer.parseInt(distanceTraveled.get(0).getTotalDistanceTraveled());
%>
			<table border="0" width="60%" align="right">
			<tr>
				<td align="left" colspan="8">
				       <font size="2"><b>Total Distance Travelled=<%=totdist%> 
<% 				   	   		if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
							{
%> 								Miles 
<%							}else
							{ 
%> 								KM
<%							}
%>
				</b></font></td>
			</tr>
			<tr>
				<td align="left" colspan="8">
				       <font size="2"><b>Total Fuel Added=<%=totfuel%> 
<% 			   	   		if(session.getAttribute("fuelformat").toString().equalsIgnoreCase("Gal"))
						{
%> 							Gallons		
<%						}else
						{ 
%>					 		Liters
<%						} 
%>
					</b></font>
				</td>
			</tr>
<%
				String avrg="NA";
				try
				{
				Avg=totdist/totfuel;
				NumberFormat nf= NumberFormat.getNumberInstance();
				nf.setMaximumFractionDigits(2);
				nf.setMinimumFractionDigits(2);
				avrg=nf.format(Avg);
				}
				catch(Exception e)
				{
 					//out.print("Exception::"+e);
				}
						
%>
			<tr>
				<td align="left" colspan="8">
				       <font size="2"><b>Average=(<%=totdist %>/<%=totfuel %>) = <%=avrg %></b></font>
				</td>
			</tr>
			</table>
<%
	}
	catch(Exception e)
	{
	}

%>
</body>
</html>
        <%@ include file="footernew.jsp" %>