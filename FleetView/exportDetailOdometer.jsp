 <%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
 <%@ include file="Connections/conn.jsp" %>
<% response.setContentType("application/vnd.ms-excel");
    response.addHeader("Content-Disposition", "attachment;filename=\"detailodometer.xls\"");
%>

	

<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page"></jsp:useBean>
	

	<%
//classes fleetview=new classes();
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>

	<%@page import="com.fleetview.beans.classes"%>
	<%@page import="javax.swing.text.NumberFormatter"%><table
		width="100%" align="center" class="sortable">
		<tr>
			<td align="center" class="sorttable_nosort">
			<div align="left"><font color="block" size="3">Report
			No: 5.6</font></div>
			<font color="block" size="3"><b></>Detail Report</b></font></td>
		</tr>
		<%!
Connection conn, con1;
Statement st,st1,st2,st3,stveh1,stveh2;
String date1, date2,datenew1,datenew2, vehcode, vehregno,tbname,sql,owner,km,rating,from,to,ndcount;
String dateformat;
%>
		<%
datenew1=request.getParameter("data1");
//datenew1=request.getParameter("data1");
datenew2=request.getParameter("data2");
//datenew2=request.getParameter("todate");
String vehno=request.getParameter("vehs");
String vehregno=request.getParameter("vehregno");
dateformat=session.getAttribute("dateformat").toString();
//String owner=session.getAttribute("usertypevalue").toString();
String ownerNm =request.getParameter("Oname");
String odometerdiff=request.getParameter("odometer");
String employeeName=request.getParameter("employeeName");
String vehicleCode=request.getParameter("vehicleCode");
//System.out.println("vehicleCode=="+vehicleCode);
try
{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	con1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
	st3=con1.createStatement();
	stveh1 =conn.createStatement();
	stveh2=conn.createStatement();
%>
		<tr>
			<td class="sorttable_nosort">
			<div id="report_heding"><font color="brown" size="3">Detail
			Report <%=ownerNm %> from <%=datenew1 %> to <%=datenew2 %></font></div>
			Date :
			<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%>
			</div>
			</td>
		</tr>
	</table>
	<table width="100%" border="1" align="center" class="sortable">
		<tr>
			<th><b> Sr. </b></th>
			<th><b>EmployeeName</b></th>
			<th><b>Veh.</b></th>
			<th><b>Date-Time</b></th>
			<th><b>Driver</b></th>
			<th><b>Odometer</b></th>
			<th><b>GpsDiff</b></th>
			<th>
			<%
	     
	      			if(session.getAttribute("fuelformat").toString().equalsIgnoreCase("Gal"))
					{
	    	  	%> <b> Gallans: </b> <%	}
				else
				{%> <b> Liters: </b> <%
				}%>
			</th>

			<th>
			<%
	      if(session.getAttribute("fuelformat").toString().equalsIgnoreCase("Gal"))
				{
	    	  
	    	  %> <b> Gas Station:</b> <%	}
				else
				{%> <b> Petrol Pump:</b> <%
				}%>
			</th>
			<th><b>Ent By</b></th>
			<th><b>Remark</b></th>
		</tr>
		<%
			String trans="",remark="";
			int c=1;
			int i=1;
			double fueladded=0,totfuel=0,totalGpsDiff=0 ;
			double Avg=0.00;
			owner ="Penzoil1";
			Double odolast=0.00,odofirst=0.00,Odometer1=0.00;
			int cnt=0;
			String vehicle="",datetime="",driver="",odometer="",petrolpump="",entby="";
			double lits=0.0;
			String sql21="select * from t_fuelinfo where VehNo='"+vehregno+"' and TheDateTime between '"+datenew1+" 00:00:00' and '"+datenew2+" 23:59:59' order by TheDateTime";
			//System.out.println("detail====>"+sql21);
			ResultSet rsgps=st1.executeQuery(sql21);
			ResultSet rs21=st.executeQuery(sql21);
			while(rs21.next())
			{
				double odo=0.0;
				double gpsveh=0;
				
				double odo1=0.0;
				double gpsveh1=0;
				
				double odoDiff=0.0;
				double gpsDiff=0;
				
				String fuelDateTime="";
				String fieldDate="";
				String fieldTime="";
				
				String fuelDateTime1="";
				String fieldDate1="";
				String fieldTime1="";
				
				vehicle=rs21.getString("VehNo");
				datetime=rs21.getString("TheDateTime");
				driver=rs21.getString("Driver");
				if("Select".equalsIgnoreCase(driver)){
					driver="-";
				}
				odometer=rs21.getString("Odometer");
				lits=rs21.getDouble("Litres");
				petrolpump=rs21.getString("PetrolPump");
				entby=rs21.getString("EntBy");
				remark=rs21.getString("Remark");
				fueladded=fueladded+lits;
				if(cnt==0)
				{
					gpsDiff=0;
				}
				else{
				if(rsgps.next())
				{
				
					fuelDateTime=rsgps.getString("TheDateTime");
					
					try{
					if(rsgps.next())
					{
					
					fuelDateTime1=rsgps.getString("TheDateTime");
				//	out.println("\n"+fuelDateTime1);
					try{
						if(cnt>1)
						{
							String sqlgpsFirst="SELECT Distance, TheFieldDataDate, TheFieldDataTime,TheFieldDataDateTime " +
							"FROM t_veh"+vehicleCode+" " +
							"WHERE  TheFieldDataDateTime <= '"+fuelDateTime+"' " +
							"AND TheFiledTextFileName in ('SI','ON','OF') " +
							"ORDER BY TheFieldDataDateTime " +
							"DESC LIMIT 1";
						//	System.out.println("datechange <===>"+sqlgpsFirst);
							ResultSet rsveh1=stveh1.executeQuery(sqlgpsFirst);
							if(rsveh1.next()){
								fuelDateTime=rsveh1.getString("TheFieldDataDateTime");
							//	System.out.println("new date <===>"+sqlgpsFirst);
							}
						}
						String sqlgpsFirst="SELECT Distance, TheFieldDataDate, TheFieldDataTime " +
						"FROM t_veh"+vehicleCode+" " +
						"WHERE  TheFieldDataDateTime BETWEEN '"+fuelDateTime+"' AND '"+fuelDateTime1+"' " +
						"AND TheFiledTextFileName in ('SI','ON','OF') " +
						"ORDER BY TheFieldDataDateTime " +
						"LIMIT 1";
				//		System.out.println("1st=="+sqlgpsFirst);
						ResultSet rsveh1=stveh1.executeQuery(sqlgpsFirst);
						if(rsveh1.next()){
						fieldDate=rsveh1.getString("TheFieldDataDate");
						fieldTime=rsveh1.getString("TheFieldDataTime");
						gpsveh=Double.parseDouble(rsveh1.getString("Distance"));
				//		System.out.println("gpsveh="+gpsveh);
				}
				}
				catch(Exception e){
					e.printStackTrace();
				}
					try{
							String sqlgpsSecond="SELECT Distance, TheFieldDataDate, TheFieldDataTime " +
							"FROM t_veh"+vehicleCode+" " +
							"WHERE TheFieldDataDateTime BETWEEN '"+fuelDateTime+"' AND '"+fuelDateTime1+"'" +
							"AND TheFiledTextFileName in ('SI','ON','OF') " +
							"ORDER BY TheFieldDataDateTime DESC " +
							"LIMIT 1";
				//			System.out.println("2nd=="+sqlgpsSecond);
							ResultSet rsveh2=stveh2.executeQuery(sqlgpsSecond);
							if(rsveh2.next()){
							fieldDate1=rsveh2.getString("TheFieldDataDate");
							fieldTime1=rsveh2.getString("TheFieldDataTime");
							gpsveh1=Double.parseDouble(rsveh2.getString("Distance"));
						//	System.out.println("\ngpsveh1="+gpsveh1);
					}
					}
					catch(Exception e){
						e.printStackTrace();
					}
					
					}
					
				}catch(Exception e){
					e.printStackTrace();
				}
					gpsDiff=gpsveh1-gpsveh;
					totalGpsDiff=totalGpsDiff+gpsDiff;
					//System.out.println("\ngpdiff="+gpsDiff);
					rsgps.previous();
				}
				
				}				
				
			%>
		<tr>
			<td style="text-align: right"><%=i++ %></td>
			<td style="text-align: right"><%=employeeName%></td>
			<td style="text-align: left"><%=vehicle %></td>
			<td style="text-align: left"><%=datetime %></td>
			<td style="text-align: left"><%=driver %></td>
			<td style="text-align: right"><%=odometer%></td>
			<td style="text-align: right"><%=Double.valueOf(gpsDiff).intValue()%></td>
			<td style="text-align: right"><%=lits%></td>
			<td style="text-align: left"><%=petrolpump%></td>
			<td style="text-align: left"><%=entby %></td>
			<%
				//if(null==remark || "null".equalsIgnoreCase(remark) || "-".equalsIgnoreCase(remark)){
%>
			<td style="text-align: left"><%=remark%></td>
			<%
				//}
			//	else{
%>
			<!--<td style="text-align: left"><input type="hidden" id="i+< %=c %>" name="i+< %=c %>" value="< %=remark%>< %=c %>">
				< %=remark %>...
			<div id="sh< %=c %>" name="sh< %=c %>">
				<a href="#" ONMOUSEOVER="show(document.getElementById('i+< %=c %>'))" ; ONMOUSEOUT="kill()">Show Remark </a></div>
			</td>-->
			<%
				//	c=c+1;
			//	}
%>
		</tr>
		<%
		cnt++;
			}
			/*String sql2="select * from t_group where gpname='"+ownerNm+"'";
			ResultSet rs2=st.executeQuery(sql2);
			if(rs2.next())
			{
				trans=rs2.getString("vehregno");
			}
				int i=1;
				int dist=0,totdist=0;
				double fueladded=0,totfuel=0;
				String Vehcode="",tabname="";
				String sql1="select * from t_fuelinfo where Transporter='"+ownerNm+"' and TheDateTime >= '"+datenew1+" 00:00:00' and TheDateTime <='"+datenew2+" 23:59:59' and Transporter ='"+ownerNm+"' order by Thedatetime desc";
				//System.out.println(sql1);
				ResultSet rs1=st1.executeQuery(sql1);
				while(rs1.next())
				{
					 if(i==1)
					 {	
						 odofirst=rs1.getDouble("Odometer");
					 }
					//Vehcode=rs1.getString("vehcode");
					String sqlvehcode="select VehicleCode from db_gps.t_vehicledetails where VehicleRegNumber='"+rs1.getString("Vehno")+"' and status='-'";
					ResultSet rstcode=st.executeQuery(sqlvehcode);
					if(rstcode.next())
					{
						Vehcode=rstcode.getString("VehicleCode");
					}
					tabname="t_veh"+Vehcode+"_ds";
					fueladded=Double.parseDouble(rs1.getString("Litres"));
					totfuel=totfuel+fueladded;*/
			%>
		<!--<tr>
				<td style="text-align: right"> < %=i %></td>
				<td style="text-align: left"> < %=rs1.getString("VehNo") %></td>
				<%
					//String datef=new SimpleDateFormat(dateformat+" hh:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").parse(rs1.getString("TheDateTime")));
				%>
				<td style="text-align: left"> < %=datef %></td>
				<td style="text-align: left"> < %=rs1.getString("Driver") %></td>
				<td style="text-align: right">< %=rs1.getDouble("Odometer")%></td>
				 
				 <td ><div align="right">
				<%
					//if(session.getAttribute("fuelformat").toString().equalsIgnoreCase("Gal"))
					//{ 
				%>
				 			<%//=fleetview.Liter_To_Gallan(Integer.parseInt(rs1.getString("Litres"))) %>
				<%
					//}else{ 
				%>
				 			<%//=rs1.getString("Litres") %>
				<% //} %>
				 </div></td>
				<td style="text-align: left"> < %=rs1.getString("PetrolPump") %></td>
				<td style="text-align: left"> < %=rs1.getString("EntBy") %></td>
			</tr>-->

		<%
				/*i++;
				} if(rs1.last())
				{
					odolast=rs1.getDouble("Odometer");
				}
			
			 Odometer1= odolast-odofirst;*/
			if(i>1){
			 %>
		<tr>
			<td class="bodyText" colspan="5">
			<div align="right"><b>Total</b></div>
			</td>
			<td class="bodyText">
			<div align="right"><b><%=odometerdiff%></b></div>
			</td>
			<td class="bodyText">
			<div align="right"><b><%=totalGpsDiff%></b></div>
			</td>
			<td class="bodyText">
			<div align="right"><b><%=fueladded%></b></div>
			</td>
			<td class="bodyText" colspan="3">
			<div align="right"></div>
			</td>
		</tr>
		<%} %>
	</table>

	<%
			
}
catch(Exception e)
{
 //	out.print("Exception::"+e);
 	e.printStackTrace();
}
finally
{
	try{
		con1.close();
		}
	catch(Exception e)
	{}
	try{
		conn.close();
		}
	catch(Exception e)
	{}
	try{
		fleetview.closeConnection();
		}
	catch(Exception e)
	{}
}
%>
	<% //fleetview.closeConnection(); %>

	<%@ include file="footernew.jsp"%>

</html>