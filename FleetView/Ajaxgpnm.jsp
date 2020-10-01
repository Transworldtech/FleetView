
<%@ page import="java.util.*" language="java" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="javax.swing.*" errorPage="" %>
<%@ include file="Connections/conn.jsp" %>
		<link rel="stylesheet" type="text/css" href="css/form.css" media="all">

<%!
Connection con1;
%>

<%
try {
	System.out.println("hey Ajax GROUP NMAE yeeeeee...");
	
	
	Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt1=con1.createStatement();
Statement stmt2=con1.createStatement();
Statement stmt3=con1.createStatement();
ResultSet rs1=null, rs2=null;
String sql1="", sql2="";


String gpnm=request.getParameter("gpnm");
//String gpnm1=gpnm.replace(gpnm.indexOf(0),"");
	String typeval = (String)session.getAttribute("TYPEVALUEUSER");
System.out.println(">>>gpnm>>>..."+gpnm);
String mobno="-",simno="-", holdby="", recby="",recbycust="",recbytech="",InstType="",swver="";
sql1="SELECT transporter,VehCode FROM db_gps.t_group 	WHERE vehregno = '"+typeval+"' AND gpname ='"+gpnm+"' ";

rs1=stmt1.executeQuery(sql1);
System.out.println("&&&sql1>>>."+sql1);
String userrole=(String)session.getAttribute("mainuser");



System.out.println(userrole);
String vehregno="",vhcode="";
int i=1;
String html="";
 html=html+"#<table><tr><td align='center'> <font size ='2'><b>Vehicles to be deleted for group "+gpnm+" </b></font></td>  <tr>  </table><table id='Section'  class='form_container1'  border='1px'  cellpadding='0'  cellspacing='0'  width='450px' align='center'  id='txv'>"+
  "<tr   >"+
  "<td><div align='center' > <b><b><input type=checkbox id='fst' onclick='checkbox1();' name='' value='' /> <br /> </b></div></td>"+
"<td><div align= 'center' ><b><font size='2'> VehicleregNo</font> </b></div></td>"+
"<td><div align= 'center' >   <font size='2'><b> Delete </b></font></div> </td>"+
"</tr>";
while(rs1.next())
{
	vehregno=rs1.getString("transporter");
	vhcode=rs1.getString("VehCode");
	
	
	//System.out.println(">>>>>>>.");
html=html+"<tr>"+
"<td><div align= 'center'  >  <input type='checkbox' name='chkbx' id='ab"+i+"'     type='checkbox'   value='"+vehregno+"'  /> <br /></div></td>"+
	"<td id='vh'  ><b> "+vehregno+" </b> <input type='hidden' id='vh1'   name='vh1' value='"+gpnm+"'> <input type='hidden' id='vhcd"+i+"'   name='vhcd"+i+"' value='"+vhcode+"'>     </td>"+
		
"<td align='center'> <img alt='Delete' src='newimages/Delete-Icon.png' onclick='removecity();' id='img1' align='top' >&nbsp;&nbsp;&nbsp;<font size='2'></font></td>"+
	
	"</tr>";
	
	i++;
	
	
//	if(Buffer=="" && Buffer1=="")
//	{
//		Buffer = vehiclecode;
	//	Buffer1 =instn;
//	}
//	else
//	{
//		Buffer = Buffer+","+vehiclecode;
//		Buffer1 =Buffer1+","+instn;
//	}
	
}
html=html+
"</table>";


System.out.println(html);
out.print(html);



System.out.println("in ajax page");
} catch(Exception e) {out.println(e);e.printStackTrace();}

finally
{
con1.close();
}

%>




