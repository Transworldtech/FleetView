<%@ include file="header.jsp" %>
<%@ include file="headercallcenter.jsp" %>

<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*"  import="java.util.Date" errorPage="" %>

<%! 
Connection con1, con2;
Statement stmt1, stmt2;
%>

<%
try
{
	Class.forName(MM_dbConn_DRIVER);
	con1 = DriverManager.getConnection(MM_dbConn_STRING5,MM_dbConn_USERNAME5,MM_dbConn_PASSWORD5);
	con2 = DriverManager.getConnection(MM_dbConn_STRING6,MM_dbConn_USERNAME5,MM_dbConn_PASSWORD5);

	stmt1=con1.createStatement();
	stmt2=con2.createStatement();
	Statement stquery=con2.createStatement();
	
        String sql1="",sql2="";
        ResultSet rs2=null;
	String vehno="", cntr="", cabno="";
	int cntrint=0, vehcode=0;
	
	vehno=request.getParameter("vehno");
	cntr=request.getParameter("cntr");
		

	cabno=vehno.substring(vehno.indexOf('(')+1,vehno.indexOf(')'));
	//out.print(cabno);

	sql2="select * from t_vehicledetails where VehicleRegNumber='"+vehno+"' ";	
	rs2=stmt2.executeQuery(sql2);	
	if(rs2.next())
	{
		vehcode=rs2.getInt("VehicleCode");
	}

	

	cntrint=Integer.parseInt(cntr);
	//out.print(cntrint);	

	String[] dates = new String[cntrint];
	String[] kms = new String[cntrint];
	String[] noofemps = new String[cntrint];
	String[] dnd = new String[cntrint];	
	//Integer[] kmsint = new Integer[cntrint];
	//Integer[] noofempsint = new Integer[cntrint];	
	
	for(int i=0; i<cntrint; i++) 
        {
		dates[i]=request.getParameter("dates"+i);
		kms[i]=request.getParameter("kms"+i);
		noofemps[i]=request.getParameter("noofempskms"+i);
		dnd[i]=request.getParameter("dnd"+i);
		
	
		//out.print(dnd[i]);

		int total=Integer.parseInt(kms[i])+(Integer.parseInt(noofemps[i])*2);
				
		sql1="insert into t_kmdetails (CabNo, CabRegNo, vehicleCode, ondate, ApprovedKms, No_Emp, ApprovedTotal, DND) value ('"+cabno+"', '"+vehno+"', '"+vehcode+"', '"+dates[i]+"', '"+kms[i]+"', '"+noofemps[i]+"', '"+total+"', '"+dnd[i]+"' )";
		
/*Query to insert query in db_gps.t_sqlquery table*/
	String abcd=sql1.replace("'","#");
	abcd=abcd.replace(",","$");
	stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_callcenter','"+abcd+"')");
	
/*****************************/

		stmt1.executeUpdate(sql1);
	}
%>	
	<table border="0" width="100%">
		<tr>
			<td align="center"> <B>Succesfully Inserted </b></td>
		</tr>
		<tr>
			<td align="center"> <a href="exlkmdets.jsp"> Click here </a> <B>to Continue </B> </td>	
		</tr>

	</table>
<%	
}catch(Exception e)
{ 
	out.print("Exception -->"+e);
	
}
finally
{
	con1.close();
		con2.close();
	
}

		
%>
