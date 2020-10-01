<%@ include file="headernew.jsp"%>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>	
<%!
String VehicleCode, totaldist;
String datenew1,datenew2;
Connection conn,conn1;
Statement st,st1,st3;
String sql,sql1,sql2;
int i=1;
int castroldist=0;
boolean flag=true;
%>
<table border="0" width="100%" bgcolor="white">  
<tr>
<td  align="center">
<div align="left"><font size="3"><b></>Trips Report</b></font>
<div class="bodyText" align="right">
<a href="#" onclick="javascript:window.open('excel_tripreport.jsp');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp;
<%=fleetview.PrintDate() %>
</div></div>
 </center>
</td>
</tr>
<tr>
<table border="1" width="100%">
<tr>
<th>Sr.</th>
<th>VehicleCode</th>
<th>CastrolDistance</th>
<th>TotalDistance</th>
</tr>




<%
try{
	conn = fleetview.ReturnConnection();
	conn1 = fleetview.ReturnConnection1();
	st=conn.createStatement();
	st1=conn.createStatement();
	st3=conn1.createStatement();
	sql="select VehicleCode from t_vehicledetails where OwnerName='RPAgencies' and Status='-'";
	ResultSet rst=st.executeQuery(sql);
	while(rst.next())
	{
		//System.out.println("Entered in while 1 loop");
		VehicleCode=rst.getString("VehicleCode");
		String tbname="t_veh"+VehicleCode+"_ds";
		sql1="select sum(KmTravelled) as CastrolDistance from t_completedjourney where Vehid='"+VehicleCode+"' and OwnerName='RPAgencies' and GPName='Castrol' and concat(StartDate,StartTime)>='2010-02-0100:00:00' and concat(StartDate,StartTime)<='2010-02-2823:59:59'";
		//sql1="select sum(KmTravelled) as CastrolDistance from t_completedjourney where Vehid='"+VehicleCode+"' and OwnerName='RPAgencies' and GPName='Castrol' and StartDate>='2010-02-01' and StartDate<='2010-02-28'";
		//System.out.println("sql1::>>"+sql1);
		ResultSet rst1=st1.executeQuery(sql1);
		//System.out.println("rst1::>>"+rst1);
		if(rst1.next())
		{
			out.println("Entered in while2 loop");
			castroldist=rst1.getInt("CastrolDistance");	
			//tripcount=tripcount+dist;
			//j++;
		}
		sql2="select sum(Distance) as TotalDistance from "+tbname+" where TheDate between '2010-02-01' and '2010-02-28'";
		out.println("sql2::>>"+sql2);
		ResultSet rst2=st3.executeQuery(sql2);
		if(rst2.next())
		{
			//System.out.println("Entered in if loop");
			totaldist=rst2.getString("TotalDistance");
		}
		//System.out.println("i:::>"+i);
		//System.out.println("Vehcode:::>"+VehicleCode);
		//System.out.println("CastrolDist:::>"+castroldist);
		//System.out.println("TotalDist:::>"+totaldist);
		%>
	<tr>
	<td><%=i%></td>
	<td><%=VehicleCode%></td>
	<td><%=castroldist%></td>
	<td><%=totaldist%></td>
	</tr>
		<%
		i++;
		
	}
%>
</table>
</tr>
</table>
<%
}catch(Exception e)
{
	out.print("Exception "+e);
}
finally
{
	conn.close();
	conn1.close();
}
%>
<% fleetview.closeConnection(); %>
</jsp:useBean>
<%@ include file="footernew.jsp" %>


