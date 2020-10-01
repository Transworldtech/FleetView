<%@ include file="Connections/conn.jsp" %>
<%!
Connection conn;
Statement st, st1,st2,st3;
String sql,qd,sql1,sql2,location,locationcode,vehlist,locationlist,mainuser;
int ds;
double Lat1,Lat2,Lon1, Lon2;
%>
<%
java.util.Date NewDate=new java.util.Date();
long dateMillis = NewDate.getTime();
long dayInMillis = 1000 * 60 * 60 *24;
dateMillis = dateMillis - dayInMillis;
NewDate.setTime(dateMillis);
Format NewFormatter = new SimpleDateFormat("yyyy-MM-dd");
String data1 = NewFormatter.format(NewDate);
mainuser=session.getAttribute("usertypevalue").toString();
try
{
Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=conn.createStatement();
st1=conn.createStatement();
st2=conn.createStatement();
vehlist="(0";
ds=10;
StringTokenizer s= new StringTokenizer(request.getParameter("location"),",");
	locationcode=s.nextElement().toString();
	location=s.nextElement().toString();
	session.setAttribute("Location",location);
	session.setAttribute("LocationCode",locationcode);
	locationlist="('"+locationcode+"'";
	sql1="select distinct(SubLocationCode) from t_masterlocation where MainLocationcode='"+locationcode+"' and OwnerName='Castrol'";
	//out.print(sql1);
	ResultSet rx=st1.executeQuery(sql1);
	while(rx.next())
	{
	locationlist=locationlist+",'"+rx.getString("SubLocationCode")+"'";
	}
	locationlist=locationlist+")";
	//out.print("<br>"+locationlist+"<br>");
	session.setAttribute("locationlist",locationlist);
	sql1="select * from t_warehousedata where WareHouseCode in"+locationlist;
	ResultSet rst1=st1.executeQuery(sql1);
	while(rst1.next())
	{
		Lat1=rst1.getDouble("Latitude");	
		Lon1=rst1.getDouble("Longitude");
		
		out.print(Lat1+"  "+Lon1+"<br>");
		
	sql2="select v.* from t_onlinedata v,t_group g where g.GPname='"+session.getAttribute("usertypevaluemain").toString()+"' and v.VehicleCode=g.VehCode and v.VehicleCode not in "+vehlist+") and v.TheDate >='"+data1+"' order by v.TheDate  desc";
	//out.print(sql2);
	ResultSet rst2=st2.executeQuery(sql2);
	while(rst2.next())
	{
	Lat2=rst2.getDouble("LatitudePosition");
	Lon2=rst2.getDouble("LongitudePosition");
	double theta = Lon1 - Lon2;
	double dist = Math.sin(Lat1* Math.PI / 180.0) * Math.sin(Lat2* Math.PI / 180.0) + Math.cos(Lat1* Math.PI / 180.0) * Math.cos(Lat2* Math.PI / 180.0) * Math.cos(theta* Math.PI / 180.0);
	dist = Math.acos(dist);
	dist = (dist* 180 / Math.PI);
	dist = dist * 60 * 1.1515;
	long dist1 = Math.round(dist * 1.609344);
	
	if(dist1<= ds)
		{
		out.print(dist1+"  "+rst2.getString("VehicleCode")+"<br>");
			vehlist=vehlist+","+rst2.getString("VehicleCode");
		}	
 	}
	}
	
	/********* code to add vehicles which are from started journey *******************/
	java.util.Date NewDate1 =new java.util.Date();
	//java.util.Date NewDate1 =new java.util.Date();
	long dateMillis1 = NewDate1.getTime();
	long dayInMillis1 = 10000 * 60 * 60 *24;
	dateMillis1 = dateMillis1 - dayInMillis1;
	NewDate1.setTime(dateMillis1);

	Format NewFormatter1 = new SimpleDateFormat("yyyy-MM-dd");
	String data2 = NewFormatter1.format(NewDate1);
	//out.print(data2);

	sql="select distinct(Vehid) from t_startedjourney where (StartCode in "+locationlist+" or  EndCode in "+locationlist+") and vehid not in "+vehlist+") and StartDate >='"+data2+"' and jstatus='Running' order by StartCode asc";
	//out.print(sql);
	ResultSet start_rst=st2.executeQuery(sql);
	while(start_rst.next())
	{
	//out.print(start_rst.getString("vehid")+"</br>");
	vehlist=vehlist+","+start_rst.getString("vehid");
	}
	/******************** End of code ************************************************/
	
vehlist=vehlist+")";
session.setAttribute("vehlistnew",vehlist);
session.setAttribute("VehList",vehlist);
//response.sendRedirect("currentlocation.jsp");
response.sendRedirect("currentposition.jsp");

}catch(Exception e)
{
	out.print("Exception "+e);
}
finally
{
	conn.close();
	
}
%>
<!-- footer start here -->
<table border="1" width="100%">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
<P></P>
</body>
</html>

