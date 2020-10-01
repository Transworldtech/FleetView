
<%@ page import="java.util.*" language="java" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="javax.swing.*" errorPage="" %>
<%@ include file="Connections/conn.jsp" %>
<%!
Connection con1;
%>

<%
try {
	
	
	System.out.println(" INSIDE TRANSPORTER LIMIT>>>>>>>");
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt1=con1.createStatement();
Statement stmt2=con1.createStatement();

ResultSet rs1=null, rs2=null;
String sql1="",sql2="";
int limit=0;
String vehregno=request.getParameter("vehregno");
String mobno="-",simno="-", holdby="", recby="",recbycust="",recbytech="";

String vhregno="",duplctentry="";

//System.out.println(">>>$$$$$ehregno  >"+vehregno);
vehregno =vehregno.replaceAll(" ","");

//System.out.println(">>>$$$$$ehregno &&&&&&& -1111==>"+vehregno);
//vehregno =vehregno.replaceAll("\.","");

//System.out.println(">>>$$$$$ehregno &&&&&&& >"+vehregno);


String vhrg="select VehicleRegNumber from   db_gps.t_vehicledetails where Replace(Replace(VehicleRegNumber,'.',''),' ','') ='"+vehregno+"' ";

//System.out.println(">>>2222  vhregno=Before query=>"+vhrg);
ResultSet vh=stmt1.executeQuery(vhrg);
//System.out.println(">>>2222  vhregno=inajax query=>"+vhrg);
if(vh.next() )
{
	vhregno=vh.getString("VehicleRegNumber");
	
}
//System.out.println(">>>2222  vhregno=inajax query=>"+vhregno);

if(vhregno!=null)
{
	System.out.println(">>>2222  LENGTH8888788=>"+vhregno.length());
	
	
	vhregno=vhregno.replace(" ","");
	vehregno=vehregno.replace(" ","");
	
	//System.out.println(">>>2222  1111111111111111=>"+vhregno);
	//System.out.println(">>>2222  2222222222222>"+vehregno);
	if(vhregno.equalsIgnoreCase(vehregno.trim()) || vhregno==vehregno)
	{
		//System.out.println(">>>2222  inside if 8888788=>");
		
		out.println("Yes"+"#");
		
		
	}
	
	
	
}else{
	System.out.println(">>>2222  inside else=>");
	out.println("No"+"#");
	
}










}catch(Exception e)
		{
			e.printStackTrace();
		}
%>
