 <%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% response.setContentType("application/vnd.ms-excel");
    response.addHeader("Content-Disposition", "attachment;filename=\"odometerdetails.xls\"");
%>
<%@ include file="Connections/conn.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes"
	scope="page"></jsp:useBean>

	<html>
	<head>
	
	</head>


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
datenew1=request.getParameter("fromdate");
datenew2=request.getParameter("todate");
String vehregno=request.getParameter("vehregnumber");
dateformat=session.getAttribute("dateformat").toString();
String ownerNm =request.getParameter("ownername");

String employeeName=request.getParameter("employeeName");
String vehicleCode=request.getParameter("vehicleCode");
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
		
	</table>
	<table width="100%" border="1" align="center" class="sortable">
		<tr>
			<th><b> Sr. </b></th>
			<th><b>EmployeeName</b></th>
			<th><b>Veh.</b></th>
			<th><b>Date-Time</b></th>
			<th><b>Driver</b></th>
			<th><b>Odometer</b></th>
			
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
			//owner ="Penzoil1";
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
				driver=rs21.getString("Driver");
				if("Select".equalsIgnoreCase(driver)){
					driver="-";
				}
			%>
		<tr>
			<td style="text-align: right"><%=i++ %></td>
			<td style="text-align: right"><%=employeeName%></td>
			<td style="text-align: left"><%=rs21.getString("VehNo") %></td>
			<td style="text-align: left"><%=rs21.getString("TheDateTime") %></td>
			<td style="text-align: left"><%=driver %></td>
			<td style="text-align: right"><%=rs21.getString("Odometer")%></td>
			<td style="text-align: right"><%=rs21.getDouble("Litres")%></td>
			<td style="text-align: left"><%=rs21.getString("PetrolPump")%></td>
			<td style="text-align: left"><%=rs21.getString("EntBy") %></td>
			<td style="text-align: left"><%=rs21.getString("Remark")%></td>
		</tr>
		<%
		cnt++;
			}
			
			%>
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