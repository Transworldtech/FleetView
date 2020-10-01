
<%@ page import="java.util.*" language="java" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="javax.swing.*" errorPage="" %>
<%@ include file="Connections/conn.jsp" %>
<%!
Connection con1;
%>

<%
try {
	System.out.println(" GROUP ADDD INSERT yeeeeee...");
	
	
	Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt1=con1.createStatement();
Statement stmt2=con1.createStatement();
Statement stmt3=con1.createStatement();
ResultSet rs1=null, rs2=null;
String sql1="", sql2="",sql3="";
String[] vhreg=request.getParameterValues("assigned1");

String gpname="",vhcode="";

 gpname=request.getParameter("grpname");

//vhcode =request.getParameter("v2");

//gpname=gpname;

//System.out.println(">>>vhreg..."+vhreg);


System.out.println(">>>gpname..."+gpname);
//String gpnm1=gpnm.replace(gpnm.indexOf(0),"");
//String token[]=vhreg.split(",");

//String token1[]=vhcode.split(",");

  for( int cnt=0;cnt< vhreg.length;cnt++)
{
 
	  System.out.println(">>>token[1]>>..."+vhreg[cnt]);
}
//System.out.println(">>>token[2]>>>..."+token[2]);

//System.out.println(">>>token1[1]>>..."+token1[1]);

//System.out.println(">>>token1[2]>>>..."+token1[2]);

String userrole=(String)session.getAttribute("mainuser");
System.out.println(userrole);

String typeval = (String)session.getAttribute("TYPEVALUEUSER");



String mobno="-",simno="-", holdby="", recby="",recbycust="",recbytech="",InstType="",swver="";

java.util.Date dte = new java.util.Date();
Format formatter = new SimpleDateFormat("yyyy-MM-dd");
String today = formatter.format(dte);

String ys="",vhcd="",tct="";

for(int a=0;a<vhreg.length;a++)
{
sql1=" select * from db_gps.t_vehicledetails where VehicleRegNumber ='"+vhreg[a]+"'  ";
rs1=stmt1.executeQuery(sql1);
System.out.println("&&&sql1>>BEFORE>."+sql1);
if(rs1.next())
{
	vhcd=vhcd+","+rs1.getString("VehicleCode");	
	tct=tct+","+rs1.getString("TicketID");
	
}
}
System.out.println("&&&sql1>>vhcd>>>"+vhcd);
System.out.println("&&&sql1>>tct>>>"+tct);

String token[]=vhcd.split(",");
String token1[]=tct.split(",");

for(int a=1;a<token.length;a++)
{
	
	System.out.println("&&&sql1>>token>>"+token[a]);
	
}
int p=0,q=1;
for(int a=0;a<vhreg.length;a++)
{

sql2="insert into  db_gps.t_group (TicketID,GPName,VehRegno,transporter,VehCode,SepReport,Active,LastTripDate,EntryBy)  values ('"+token1[q]+"','"+gpname+"','"+typeval+"','"+vhreg[p]+"','"+token[q]+"','Yes','Yes','2000-01-01','"+userrole+"' )  ";
//System.out.println("&&&sql1>>BEFORE>."+sql2); 
stmt2.executeUpdate(sql2);
System.out.println("&&&sql1>>after>."+sql2);

sql3="insert into  db_gps.t_grouphistory (GPName,VehRegno,transporter,VehCode,Status,EntBy,InsertedFrom,UpdatedDate,Active)  values ('"+gpname+"','"+typeval+"','"+vhreg[p]+"','"+token[q]+"','Added','"+userrole+"','Add group','"+today+"','Yes' )  ";

//System.out.println("&&&sql3>>>."+sql3);
stmt3.executeUpdate(sql3);
System.out.println("&&&sql3>>>>>after>."+sql3);
p++;
q++;
ys="yes";
}

System.out.println("&&&END oF  &$&$&$^$& >>>.");

String vehregno="";
int i=1;



  response.sendRedirect("addgrp.jsp?updt="+ys+"&grpname="+gpname);





//System.out.println("in ajax page");
} catch(Exception e) {out.println(e);e.printStackTrace();}

finally
{
con1.close();
}

%>




