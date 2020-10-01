
<%@ page import="java.util.*" language="java" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="javax.swing.*" errorPage="" %>
<%@ include file="Connections/conn.jsp" %>
<%!
Connection con1;
%>

<%
try {
	System.out.println(" GROUP DELETE PAGE yeeeeee...");
	
	
	Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt1=con1.createStatement();
Statement stmt2=con1.createStatement();
Statement stmt3=con1.createStatement();
ResultSet rs1=null, rs2=null;
String sql1="", sql2="";
String vhreg=request.getParameter("a");

String gpname="",vhcode="";

gpname=request.getParameter("v1");

vhcode =request.getParameter("v2");

//gpname=gpname;

System.out.println(">>>vhreg..."+vhreg);


System.out.println(">>>gpname..."+gpname);
//String gpnm1=gpnm.replace(gpnm.indexOf(0),"");
String token[]=vhreg.split(",");

String token1[]=vhcode.split(",");

System.out.println(">>>token[1]>>..."+token[1]);

//System.out.println(">>>token[2]>>>..."+token[2]);

//System.out.println(">>>token1[1]>>..."+token1[1]);

//System.out.println(">>>token1[2]>>>..."+token1[2]);

String userrole=(String)session.getAttribute("mainuser");

String typeval = (String)session.getAttribute("TYPEVALUEUSER");
System.out.println(userrole);

String mobno="-",simno="-", holdby="", recby="",recbycust="",recbytech="",InstType="",swver="";

java.util.Date dte = new java.util.Date();
Format formatter = new SimpleDateFormat("yyyy-MM-dd");
String today = formatter.format(dte);

String ys="";

for(int a=1;a<token.length;a++)
{

sql1="update db_gps.t_group set gpname ='"+gpname+" del', vehregno = '"+typeval+" del' ,SepReport='No' ,Active='No'   WHERE vehregno = '"+typeval+"'  AND gpname ='"+gpname+"' and transporter ='"+token[a]+"' ";
//System.out.println("&&&sql1>>BEFORE>."+sql1); 
stmt2.executeUpdate(sql1);
System.out.println("&&&sql1>>>."+sql1);

sql2="insert into  db_gps.t_grouphistory (GPName,VehRegno,transporter,VehCode,Status,EntBy,InsertedFrom,UpdatedDate,Active)  values ('"+gpname+" del','"+typeval+" del','"+token[a]+"','"+token1[a]+"','Deleted','"+userrole+"','Add/Delete group','"+today+"','No' )  ";

//System.out.println("&&&sql2>>>."+sql2);
stmt2.executeUpdate(sql2);
System.out.println("&&&sql2>>>."+sql2);

ys="yes";
}

System.out.println("&&&END oF  &$&$&$^$& >>>.");

String vehregno="";
int i=1;



  response.sendRedirect("addltgrp.jsp?updt="+ys);





//System.out.println("in ajax page");
} catch(Exception e) {out.println(e);e.printStackTrace();}

finally
{
con1.close();
}

%>




