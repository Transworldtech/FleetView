<%@ include file="headernew.jsp"%>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<%!Connection conn, conn1;
	Statement st1, st2, st;
%>
<%
try
{
       
		conn = fleetview.ReturnConnection();
		Statement st=null,st1=null;
		String sql=null;
		ResultSet rst=null;
		st=conn.createStatement();
		st1=conn.createStatement();
%>

<br></br>
<div style="font-size: 1.7em; text-align: center; margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em" align="center">
	JRM Report</div>
	<br>

<%
int i =1;
String ss=session.getAttribute("VehList").toString();
int totalcount = 0;
int JRMcount = 0;
sql = "select count(*) as cnt from db_gps.t_vehicledetails where vehiclecode in "+ss+"";
ResultSet rs = st.executeQuery(sql);
if(rs.next())
{
	totalcount = rs.getInt("cnt");
}

sql = "select * from db_gps.t_vehicledetails where vehiclecode in "+ss+"";
System.out.println("***   "+sql);
rs = st.executeQuery(sql);
while(rs.next())
{
	String sql1 = "Select Peripherals from db_gps.t_unitmaster where unitid = '"+rs.getString("unitid")+"' ";
	ResultSet rs1 = st1.executeQuery(sql1);
	if(rs1.next())
	{
		if(rs1.getString("Peripherals").contains("JRM"))
        {
		JRMcount++;
        }
	}
}

%>


<div style="text-align: center;">
<div align="center" style="text-align: center;">
Total Vehicles: <%=totalcount %> &nbsp;&nbsp;&nbsp;&nbsp;JRM Installed: <%=JRMcount %>
</div>
<table align="center" class="sortable"  style="text-align: center;width: 35%;margin-left: 32%;margin-right: 40%;">
<tr>
<th>SrNo</th>
<th>Vehicle Reg No</th>
<th>JRM Installed</th>
</tr>
<%
sql = "select * from db_gps.t_vehicledetails where vehiclecode in "+ss+"";
System.out.println("***   "+sql);
rs = st.executeQuery(sql);
while(rs.next())
{
	String sql1 = "Select Peripherals from db_gps.t_unitmaster where unitid = '"+rs.getString("unitid")+"' ";
	ResultSet rs1 = st1.executeQuery(sql1);
	if(rs1.next())
	{
		%>
		<tr>
		<td align="right"><div align="right"><%=i %></div></td>
		<td align="left"><div align="left"><%=rs.getString("VehicleRegNumber") %></div></td>
		<%
           if(rs1.getString("Peripherals").contains("JRM"))
           {
        	   %>
        	   <td align="left"><div align="left">Yes</div></td>
        	   <%
           }
           else
           {
        	   %>
        	   <td align="left"><div align="left">No</div></td>
        	   <%
           }
		%>
		</tr>
		<%
		i++;
	}
}
%>
</table>
</div>
<%
}
catch(Exception e)
{
	out.print("Please Select the Transporter");
	e.printStackTrace();
}
finally
{
	try
	{
		conn.close();
	}catch(Exception e)
	{e.printStackTrace();}
	try
	{
		fleetview.closeConnection();
	}catch(Exception e)
	{e.printStackTrace();}
}
%>
</html>
</jsp:useBean>
<%@ include file="footernew.jsp"%>