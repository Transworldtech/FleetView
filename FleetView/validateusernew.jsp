<%@ include file="Connections/conn.jsp" %>
<%!
Connection conn;
Statement st,st1,st2,st3,st91,st92,st99;
String sql,sql1,sdate,edate,sql3;
int ds;
double Lat1,Lat2,Lon1, Lon2;
String qd,sql2,location,locationcode,vehlist,locationlist;
%>
<%
java.util.Date NewDate=new java.util.Date();
long dateMillis = NewDate.getTime();
long dayInMillis = 1000 * 60 * 60 *24;
dateMillis = dateMillis - dayInMillis;
NewDate.setTime(dateMillis);
Format NewFormatter = new SimpleDateFormat("yyyy-MM-dd");
String data1 = NewFormatter.format(NewDate);
String userexpress=session.getAttribute("usertypevalue").toString();
out.print("which user11111111111------------------------------------------------------------------> " +userexpress);
//out.print("next----------------------> " +userexpress);
try{
vehlist="(0";
if(userexpress.equalsIgnoreCase("ExpressRdys_All")|| userexpress=="ExpressRdys_All" )
{
	ds=150;
}
else{
ds=10;
}
Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=conn.createStatement();
st1=conn.createStatement();
st2=conn.createStatement();
st3=conn.createStatement();
st91=conn.createStatement();
st92=conn.createStatement();
st99=conn.createStatement();
sql="select * from t_subuser where UserId='"+session.getAttribute("user").toString()+"'";
//out.print(sql);
ResultSet rst=st.executeQuery(sql);
if(rst.next())
{
	locationcode=rst.getString("LocationCode");
	location=rst.getString("Location");
	session.setAttribute("Location",location);
	session.setAttribute("LocationCode",locationcode);
	locationlist="('"+locationcode+"'";
sql1="select * from t_masterlocation where MainLocationcode='"+locationcode+"'";

ResultSet rx=st1.executeQuery(sql1);
while(rx.next())
{
	locationlist=locationlist+",'"+rx.getString("SubLocationCode")+"'";
}
locationlist=locationlist+")";
out.print("<br>"+locationlist+"<br>");
session.setAttribute("locationlist",locationlist);
sql1="select * from t_warehousedata where warehousecode='"+rst.getString("LocationCode")+"' and Owner='"+rst.getString("Transporter")+"'";

ResultSet rst1=st1.executeQuery(sql1);
	if(rst1.next())
	{
		Lat1=rst1.getDouble("Latitude");	
		Lon1=rst1.getDouble("Longitude");
	}
	else
	{
		Lat1=18.34567;	
		Lon1=73.45456;
	}
	sql2="select v.* from t_onlinedata v,t_group g where g.GPname='"+session.getAttribute("usertypevalue").toString()+"' and v.VehicleCode=g.VehCode and v.TheDate >='"+data1+"' order by v.TheDate  desc";
	
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
			vehlist=vehlist+","+rst2.getString("VehicleCode");
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

	sql="select distinct(Vehid) from t_startedjourney where (StartCode in "+locationlist+" or  EndCode in "+locationlist+") and vehid not in "+vehlist+") and  jstatus='Running' and GPName='"+session.getAttribute("usertypevalue").toString()+"' order by StartCode asc";
	//System.out.print(sql);
	ResultSet start_rst=st2.executeQuery(sql);
	while(start_rst.next())
	{
	out.print(start_rst.getString("vehid")+"</br>");
	vehlist=vehlist+","+start_rst.getString("vehid");
	}
	
	sql="select distinct(a.Vehid) as Vehid from t_startedjourney  a, t_vehicledetails b where a.vehid not in "+vehlist+") and  a.jstatus<>'Running' and a.GPName='"+session.getAttribute("usertypevalue").toString()+"' and b.Status='-' and a.vehid=b.vehiclecode order by StartCode asc";
	System.out.println(sql);
	start_rst=st2.executeQuery(sql);
	while(start_rst.next())
	{
		sql3="Select StartCode,EndCode from t_startedjourney where vehid="+start_rst.getInt("Vehid")+" order by StartDate desc limit 1";
		ResultSet rs3=st3.executeQuery(sql3);
		if(rs3.next())
		{
			String startcode1="'"+rs3.getString("StartCode")+"'";
			String endcode1="'"+rs3.getString("EndCode")+"'";
		if ((locationlist.contains(startcode1))||(locationlist.contains(endcode1)))
				{
			out.print(start_rst.getString("vehid")+"</br>");
			vehlist=vehlist+","+start_rst.getString("vehid");
				}
		}
		
	
		
	}
	/******************** End of code ************************************************/
	vehlist=vehlist+")";
	session.setAttribute("vehlistnew",vehlist);
	session.setAttribute("VehList",vehlist);
	out.print("vehlist:-"+vehlist);
	
	/************************** code for table created for user name *************************************************************/
	int tecount=0;
//System.out.println("Muser is:-------------------------"+Muser);
String UserID=session.getAttribute("UserID").toString();
System.out.println("UserID is:-------------------------"+UserID);

//String sql1 = "CREATE TABLE /*!32312 IF NOT EXISTS*/ t_"+UserID+"  (SrNo double NOT NULL auto_increment,VehList longtext,Key SrNo(SrNo)) ";
String sql1 = "CREATE TABLE IF NOT EXISTS t_"+UserID+"  (SrNo double NOT NULL auto_increment,VehList longtext,Key SrNo(SrNo)) ";
System.out.println("My query sql1:-----"+sql1);
//Statement st99=conn.createStatement();
 tecount=st99.executeUpdate(sql1);

 //if(tecount>1){
		String deluser="delete from db_gps.t_"+UserID+" ";
		out.println("My query deluser:-----"+deluser);
		//Statement st92=conn.createStatement();
		st92.executeUpdate(deluser);
		vehlist=vehlist.replace("(", "");
		vehlist=vehlist.replace(")", "");
		vehlist=vehlist.trim();
		String str123[]=vehlist.split(",");
		//Statement st91=conn.createStatement();
		for(int p=0;p<=str123.length;p++){
		String insrtmuser="insert into t_"+UserID+" (VehList) values('"+vehlist+"')";
		//System.out.println("My query insrtmuser:-----"+insrtmuser);
		
		st91.executeUpdate(insrtmuser);
	     }
//}

	
	
	
	/********Start code to create an array of transporter name hows vehicles are selected *********/
	out.print("owner list 123");
	vehlist="("+vehlist+")";
	sql="select Distinct(OwnerName) from t_vehicledetails where vehiclecode in "+vehlist+" order by OwnerName";
	out.print("owner list sql"+sql);
	ResultSet rst_owner=st2.executeQuery(sql);
	String ownerlist="(";
	while(rst_owner.next())
	{
		ownerlist=ownerlist+"'"+rst_owner.getString("OwnerName")+"',";
		//out.print("owner list sql"+ownerlist);
	}
	//out.print("owner list 123"+ownerlist);
	ownerlist=ownerlist.substring(0,ownerlist.length()-1);
	ownerlist=ownerlist+")";
	
	out.print("owner list"+ownerlist);
	session.setAttribute("ownerlist",ownerlist);
	
	/********End code to create an array of transporter name hows vehicles are selected *********/
try{
String sql11="select * from t_defaultvals where OwnerName='"+session.getAttribute("usertypevalue").toString()+"'";
ResultSet rstx=st1.executeQuery(sql11);
if(rstx.next())
{	
	sql11="select * from t_defaultvals where OwnerName='"+session.getAttribute("usertypevalue").toString()+"'";
}
else
{
	sql11="select * from t_defaultvals where OwnerName='Default'";
	
}
ResultSet rst11=st1.executeQuery(sql11);
if(rst11.next())
{
	session.setAttribute("overspeed",rst11.getString("Overspeedlimit")+" kmph/"+rst11.getString(3)+" Secs");
	session.setAttribute("racc",rst11.getString("AccelerationSpeedVarLimit")+" kmph/Secs"); 
	session.setAttribute("rdcc",rst11.getString("DecelerationSpeedVarLimit")+" kmph/Secs");
	session.setAttribute("ndri","Beyond "+rst11.getString("NightDrivingFromTime")+" To "+rst11.getString("NightDrivingToTime"));
	session.setAttribute("stoptime",rst11.getString("NightDrivingFromTime"));
	session.setAttribute("starttime",rst11.getString("NightDrivingToTime"));
	session.setAttribute("cdri","> "+rst11.getString("ContinuousRunHrsLimit")+" Mins With Stoppages < "+rst11.getString("StopMinsAllowedInContRun"));
	session.setAttribute("stop","> "+rst11.getString("StoppagesGreaterThanInMins")+"Mins");
	session.setAttribute("stop11",rst11.getString("StoppagesGreaterThanInMins"));
session.setAttribute("desconnected",rst11.getString("DisconnectedPeriod"));
session.setAttribute("distformat",rst11.getString("DistFormat"));
session.setAttribute("fuelformat",rst11.getString("FuelFormat"));
session.setAttribute("dateformat",rst11.getString("DateFormat"));
}

}catch(Exception e){
	e.printStackTrace();
}
if(session.getAttribute("usertypevalue").equals("Castrol EMP VEH"))
{
	response.sendRedirect("castrolempmain.jsp");
}
else
{	
response.sendRedirect("currentposition.jsp");
}
}
else
{
	//out.print("Hello");
}
}catch(Exception e)
{
	//out.print("Exception "+e);
	e.printStackTrace();
}
finally
{
	try
	{
		conn.close();	
	}catch(Exception e)
	{
		
	}
	
}
%>
