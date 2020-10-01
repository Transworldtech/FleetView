
<%@ page import="java.util.*" language="java" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="javax.swing.*" errorPage="" %>
<%@ include file="Connections/conn.jsp" %>
<%!
Connection con1;
%>

<%
try {
	System.out.println("hey Ajax [age yahooo...");
	
	
	
	
	
	Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt1=con1.createStatement();
Statement stmt2=con1.createStatement();
Statement stmt3=con1.createStatement();
ResultSet rs1=null, rs2=null;
String sql1="", sql2="";
String getunid=request.getParameter("unid");
System.out.println(">>>unitid>>>..."+getunid);
String mobno="-",simno="-", holdby="", recby="",recbycust="",recbytech="",InstType="",swver="",periphrl="";
sql1="select * from db_gps.t_unitmaster where UnitID='"+getunid+"' ";
System.out.println(sql1);
rs1=stmt1.executeQuery(sql1);
System.out.println(sql1);
String userrole=(String)session.getAttribute("mainuser");
System.out.println(userrole);
while(rs1.next())
{
	System.out.println("in loop");
	mobno=rs1.getString("MobNo");
	System.out.println(mobno);
	simno=rs1.getString("SimNo");
	System.out.println(simno);
	
	
	periphrl=rs1.getString("Peripherals");
	System.out.println(">>>%%phrl>>"+periphrl);
	holdby=rs1.getString("HoldBy");
	System.out.println(holdby);
	InstType=rs1.getString("InstType");
	swver=rs1.getString("SwVer");
	
	System.out.println(">>>%%%111>>..."+InstType);
	
	if(mobno!=null|| mobno.length()>0)
		out.println(mobno.trim()+"#");
	else
		out.println(mobno+"#");
	
	System.out.println(">>>%%%22>>...");
	
	if(simno!=null|| simno.length()>0)
		out.println(simno.trim()+"#");
	else
		out.println(simno+"#");
	
	
	
	
	
	if(InstType!=null|| InstType.length()>0)
		out.println(InstType.trim()+"#");
	else
		out.println(InstType+"#");
	recbycust=rs1.getString("RecByCust");
	recbytech=rs1.getString("RecByTech");
	holdby=rs1.getString("HoldBy");
	
	
	
	
	
	System.out.println(">>>%%%33>>...");
	
	if(recbytech.equals("Yes") || recbycust.equals("Yes"))
	{
	recby="YES";
	out.println(recby+"#");
	}
	else
	{
		recby="NO";
		out.println(recby+"#");
	}
	out.println(holdby+"#");
	out.println(swver+"#");
	
	
	
	System.out.println(">>>%%%44>>...");
	
	String CodeVersion ="";
	String sqlversion="select * from db_gps.t_ftplastdump where UnitID='"+getunid+"'";
	System.out.println(">>>%%%44>sqlversion>..."+sqlversion);
	ResultSet rsversion=stmt2.executeQuery(sqlversion);
	System.out.println(">>>%%%44>sqlversion>..."+sqlversion);
	if(rsversion.next()){
		CodeVersion=rsversion.getString("CodeVersion"); 
		if("AVL_VER_4.9.9_3S".equalsIgnoreCase(CodeVersion)||CodeVersion.equalsIgnoreCase("AVL_VER_4.9.9_3S")){
			String FTP="Yes";
			out.println(FTP+"#");
		}else{
			String FTP="No";
			out.println(FTP+"#");
		}
	}else{
		out.println("-"+"#");
	}
	System.out.println("m goin into loop");
	String sqlvehunit="select * from db_gps.t_vehicledetails where UnitID='"+getunid+"'";
	ResultSet rsveh=stmt3.executeQuery(sqlvehunit);
	System.out.println(">>>%%%44>sqlvehunit>..."+sqlvehunit);
	if(rsveh.next())
	{
		if(getunid.equalsIgnoreCase(rsveh.getString("UnitID")))
		{
			String available="Yes";
			out.println(available+"#");
		}else{
			String available="No";
			out.println(available+"#");
		}
	}else{
		String available="No";
		out.println(available+"#");
	}
	if(CodeVersion.contains("JRM")){
		String JRM="JRM";
		out.println(JRM+"#");
	}else{
		String JRM="No";
		out.println(JRM+"#");
	}
	String isCodeVerValid="No";
	
	System.out.println("CodeVersion>>>>>"+CodeVersion);
	
	
	String sqlutcodever="select * from db_CustomerComplaints.t_utcodever where codever='"+CodeVersion+"' and valid='Yes'";
	System.out.println(">>"+sqlutcodever);
	
	ResultSet rsutcodever=stmt3.executeQuery(sqlutcodever);
	if(rsutcodever.next()){
		isCodeVerValid="Yes";
		out.println(isCodeVerValid+"#");
	}else{
		isCodeVerValid="No";
		out.println(isCodeVerValid+"#");
	}
	
	
	if(periphrl!=null|| periphrl.length()>0)
		out.println(periphrl.trim()+"#");
	else
		out.println(periphrl+"#");
	
	
	/*if(userrole.equals("service"))
	{

	if(holdby!=null|| holdby.length()>0)
		out.println(holdby.trim()+"#");
	else
		out.println(holdby+"#");
	}*/
}

//if(userrole.equals("service"))
//{
/*sql2 = "select * from t_unitmasterhistory where UnitID='"+getunid+"' and Status in ('Dispatched','InterDisp' ) order by DispDate Desc limit 1";
rs2=stmt2.executeQuery(sql2);
if(rs2.next())
{
	recbycust=rs2.getString("RecByCust");
	recbytech=rs2.getString("RecByTech");
	holdby=rs2.getString("HoldBy");
	if(recbytech.equals("Yes") || recbycust.equals("Yes"))
	{
	recby="YES";
	out.println(recby+"#");
	}
	else
	{
		recby="NO";
		out.println(recby+"#");
	}
	out.println(holdby+"#");
} */
//}

System.out.println("in ajax page");
} catch(Exception e) {out.println(e);e.printStackTrace();}

finally
{
con1.close();
}

%>




