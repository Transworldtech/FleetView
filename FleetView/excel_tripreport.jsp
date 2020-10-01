

<%@ page language="java" import="java.sql.*" import="java.util.*" import="java.text.*" import="moreservlets.listeners.*" errorPage="" %>

<table border="0" width="100%" bgcolor="white">  
<tr>
<td  align="center">
<div align="left"><font size="3"><b></>Trips Report</b></font>
</div>
 </center>
</td>
</tr>
<tr>
<table border="1" width="100%">
<tr>
<th>Sr.</th>
<th>VehicleCode</th>
<th>VehicleRegNo</th>
<th>CastrolDistance</th>
<th>TotalDistance</th>
</tr>
<%
String VehicleCode=null, totaldist=null,VehicleRegNumber=null;
String datenew1=null,datenew2=null;
Connection conn=null,conn1=null;
Statement st=null,st1=null,st3=null;
String sql=null,sql1=null,sql2=null;
int i=1;
int castroldist=0;
boolean flag=true;
try{
Class.forName("org.gjt.mm.mysql.Driver");
				conn= DriverManager.getConnection("jdbc:mysql://localhost/db_gps","fleetview","1@flv");
				conn1= DriverManager.getConnection("jdbc:mysql://localhost/db_gpsExceptions","fleetview","1@flv");
	
	st=conn.createStatement();
	st1=conn.createStatement();
	st3=conn1.createStatement();
	sql="select VehicleCode,VehicleRegNumber from t_vehicledetails where OwnerName='RPAgencies' and Status='-'";
	ResultSet rst=st.executeQuery(sql);
	while(rst.next())
	{
		
		VehicleCode=rst.getString("VehicleCode");
		VehicleRegNumber=rst.getString("VehicleRegNumber");
		String tbname="t_veh"+VehicleCode+"_ds";
		sql1="select sum(KmTravelled) as CastrolDistance from t_completedjourney where Vehid='"+VehicleCode+"' and OwnerName='RPAgencies' and GPName='Castrol' and StartDate between '2010-02-01' and '2010-02-28'";
		ResultSet rst1=st1.executeQuery(sql1);
		
		if(rst1.next())
		{
			
			castroldist=rst1.getInt("CastrolDistance");	
			
			
		}
		sql2="select sum(Distance) as TotalDistance from "+tbname+" where TheDate between '2010-02-01' and '2010-02-28'";
		
		ResultSet rst2=st3.executeQuery(sql2);
		if(rst2.next())
		{
			
			totaldist=rst2.getString("TotalDistance");
		}
		
		%>
	<tr>
	<td><%=i%></td>
	<td><%=VehicleCode%></td>
	<td><%=VehicleRegNumber%></td>
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
<br>
<table border="1" width="100%" bgcolor="white">
<tr ><td bgcolor="white" class="copyright" width="100%" colspan="8">
<center><b>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</b></center>
</td></tr>
</table>
<P></P>
</body>
</html>
