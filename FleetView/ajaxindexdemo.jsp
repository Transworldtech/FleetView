<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" errorPage="" %>
<%@ include file="Connections/conn.jsp" %>
<%!
Connection conn;
Statement st,st1;
String sql,result,vehlist,vehid,thedate,thetime,aa,location,LatitudePosition,LongitudePosition,vehregno,transporter;
%>
<%
try{
	result=null;
	vehlist=session.getAttribute("VehList").toString();
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st = conn.createStatement();
	st1 = conn.createStatement();
	sql="select * from t_onlinedata where VehicleCode in "+vehlist+" order by VehicleCode desc";
	ResultSet rst=st.executeQuery(sql);
	while(rst.next())
	{
		java.util.Date ShowDatex = new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("TheDate"));
		Format formatterx = new SimpleDateFormat("MMMM d, yyyy");
		String showdatex = formatterx.format(ShowDatex);
		if(null==result)
		{
			result=rst.getString("LatitudePosition")+"#*"+rst.getString("LongitudePosition")+"#*<b>"+rst.getString("VehicleRegNo")+"</b><br>"+rst.getString("TheDate")+"  "+rst.getString("TheTime")+"<br>"+rst.getString("Location")+"#*"+rst.getString("VehicleRegNo")+"#*"+showdatex+"#*"+rst.getString("VehicleCode");
		}
		else
		{
			result=result+"$"+rst.getString("LatitudePosition")+"#*"+rst.getString("LongitudePosition")+"#*<b>"+rst.getString("VehicleRegNo")+"</b><br>"+rst.getString("TheDate")+"  "+rst.getString("TheTime")+"<br>"+rst.getString("Location")+"#*"+rst.getString("VehicleRegNo")+"#*"+showdatex+"#*"+rst.getString("VehicleCode");
		}



	}

/*************************************************/

StringTokenizer stk= new StringTokenizer(vehlist,",");
	while(stk.hasMoreTokens())
	{
	aa=stk.nextElement().toString();
	aa=aa.replace(")","");
	aa=aa.replace("(","");
	if(!aa.equals("0"))
	{

	String sql01="SELECT * FROM t_onlinedata where vehiclecode='" + aa +"' order by vehiclecode";
	ResultSet rst01=st.executeQuery(sql01);
	if(rst01.next())
	{
		
	}
	else
	{	String sql02="select * from t_veh"+aa+" order by concat(TheFieldDataDate,TheFieldDataTime) desc limit 1";
		ResultSet rst02=st.executeQuery(sql02);
	if(rst02.next())
	{
		vehid= aa;
		thedate= rst02.getString("TheFieldDataDate");
		thetime = rst02.getString("TheFieldDataTime"); 
		location= rst02.getString("TheFieldSubject"); 
		if(session.getAttribute("usertypevalue").toString().equals("Om"))
		{
			LatitudePosition=rst02.getString("LatitudeDir");
			LongitudePosition=rst02.getString("LongitudeDir");
		}
		else
		{
			LatitudePosition=rst02.getString("LatinDec");
			LongitudePosition=rst02.getString("LonginDec");
		}
		String sql03="select * from t_vehicledetails where VehicleCode='"+aa+"'";
		ResultSet rst03=st1.executeQuery(sql03);
		if(rst03.next())
		{
		vehregno = rst03.getString("VehicleRegNumber"); 
		transporter = rst03.getString("OwnerName");
		}
	 	
java.util.Date ShowDatex1 = new SimpleDateFormat("yyyy-MM-dd").parse(thedate);
Format formatterx1 = new SimpleDateFormat("MMMM d, yyyy");
String showdatex1 = formatterx1.format(ShowDatex1);


result=result+"$"+LatitudePosition+"#*"+LongitudePosition+"#*<b>"+vehregno+"</b><br>"+thedate+"  "+thetime+"<br>"+location+"#*"+vehregno+"#*"+showdatex1+"#*"+vehid;


	}//end of if rst02.
	else
	{
	String sql04="select * from t_vehicledetails where VehicleCode='"+aa+"'";
		ResultSet rst04=st1.executeQuery(sql04);
		if(rst04.next())
		{
		vehid= aa;
		thedate=rst04.getString("InstalledDate");
		thetime = "10:00:00"; 
		location=rst04.getString("InstalledPlace"); 
		LatitudePosition="18.5357";
		LongitudePosition="73.8523";
		vehregno = rst04.getString("VehicleRegNumber"); 
		transporter = rst04.getString("OwnerName");
		}

	
java.util.Date ShowDatex2 = new SimpleDateFormat("yyyy-MM-dd").parse(thedate);
Format formatterx2 = new SimpleDateFormat("MMMM d, yyyy");
String showdatex2 = formatterx2.format(ShowDatex2);

result=result+"$"+LatitudePosition+"#*"+LongitudePosition+"#*<b>"+vehregno+"</b><br>"+thedate+"  "+thetime+"<br>"+location+"<font color='red'> Not Active</font>#*"+vehregno+"#*"+showdatex2+"#*"+vehid;

	}//end of else rst04.
	}//end of main else.
	}//end of 0 condition if.
	}//end of main while.
	
/**************************************************/

	out.print(result);

}catch(Exception e)
{
	out.print("Exception"+e);
}
finally
{
conn.close();
}
%>

