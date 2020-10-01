<%@page import="org.apache.poi.hssf.record.formula.functions.Replace"%><%@ include file="Connections/conn.jsp" %>

<%!
Connection con1;
Statement st;
%>
<% 
try {
	System.out.println("-------------on AjxGetVehicle---------");
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=con1.createStatement();
ResultSet rst=null;
String sql="";
System.out.println("-------------on AjxGetVehicle Conn Made---------");
String trans = request.getParameter("trans").toString();
System.out.println("vehlist>>>>>>>>>>>>>>>>     "+trans);
String vehicle=request.getParameter("Vehicle");
System.out.println("Vehicle>>>>>>>>>>>>>>>>     "+vehicle);
//vehicle=vehicle.replace(".","").replace(" ","").replace("-","").replace("_","");
//System.out.println("^^^^^^^^ "+vehicle);
String A=request.getParameter("limitcount");
System.out.println(">>>>>>>>>>>>>>>>     "+A);
int limitcnt=0;
limitcnt=Integer.parseInt(A);
if(limitcnt==0)
{
	sql = "select VehicleRegNumber  from db_gps.t_vehicledetails where OwnerName='"+trans+"' and status='-' and VehicleRegNumber like '%"+vehicle+"%' order by VehicleRegNumber";
}
else
{
   sql = "select VehicleRegNumber  from db_gps.t_vehicledetails where OwnerName='"+trans+"' and status='-' and VehicleRegNumber like '%"+vehicle+"%' order by VehicleRegNumber limit 0,"+limitcnt+"";
}
//System.out.println("$$$    "+sql);
String buffer="<table style='display: block';>";
int i=1;
rst = st.executeQuery(sql);
while(rst.next())
{
	 String vehicle1=rst.getString("VehicleRegNumber");
	 buffer+="<tr><td><div align='left'><a style='color: black;' href='#' onclick='getVehicleDetails(\""+vehicle1+"\");'>"+vehicle1.replaceAll("(?i)"+vehicle,"<font color=blue><u>"+vehicle.toUpperCase()+"</u></font>")+"</a></div></tr></td>";
     i++;
}

if(limitcnt!=0 && i>20)
{ 
	   buffer+="<tr><td align='right'><h3><a href='#' onclick='getVehicles(2);' >more..</a></h3></td></tr>";
      // buffer+="<tr><td><input type='hidden'  name='element'  id='element'  value='"+limitcnt+"'/></td></tr>";

}else{  
	  //System.out.println("BUFFER HAS TO GO BLANK>>>>>>>>>>>>> .  ");
	   buffer+="<tr><td></td></tr>";
	      
}

buffer+="</table></div>";
out.println(buffer);

}
catch(Exception e)
{
	e.printStackTrace();
	System.out.println("Exception AjxGetVehicle----->>"+e);
}
finally
{
	st.close();
	con1.close();
}
%>