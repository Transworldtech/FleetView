<%@ include file="Connections/conn.jsp" %>

<%!
Connection con1;
%>

<% 
try {
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt1=con1.createStatement(), stmt2=con1.createStatement();
ResultSet rs1=null;
String sql1="";String sql2 ="";
String srchval=request.getParameter("srchval");
srchval = srchval.replace(" ", "");
int i=1;
String drivname="", driverid="", trans="";
String briefId = "";
out.print("<center> <table border='1' width='50%'><tr> <th> Sr.No.</th> <th> Driver Name</th> <th> Driver Id </th> <th> Transporter </th> </tr>");

//sql1="select * from t_drivers where Owner in(select distinct(VehRegNo) from t_group where GPName='Castrol') and (DriverName like '"+srchval+"%' or DriverID like '"+srchval+"%' )  order by  DriverName asc";
//sql1="select * from t_drivers where Owner in(select distinct(VehRegNo) from t_group where GPName='Castrol') and (DriverName like 'ram pra%' or DriverID like '"+srchval+"%' )  order by  DriverName asc";
//sql1="select *  from t_drivers where Owner in(select distinct(VehRegNo) from t_group where GPName='Castrol') and (replace(driverName,' ','' ) like '%"+srchval+"%' or DriverID like '%"+srchval+"%') order by  DriverName asc";
sql1="select a.DriverName as DriverName,a.DriverID as DriverID,a.Owner as Owner from db_gps.t_drivers a inner JOIN (select distinct(VehRegNo) ownername from db_gps.t_group where GPName='Castrol') b  ON a.Owner = b.ownername and (replace(a.driverName,' ','') like '%"+srchval+"%' or "+
		  "a.DriverID like '%"+srchval+"%')   order by a.DriverName";

//System.out.println(sql1);
rs1=stmt1.executeQuery(sql1);

ResultSet rs3 = stmt1.executeQuery(sql1);
while(rs3.next())
{
    
   // System.out.println("in while");
	drivname=rs3.getString("DriverName");
	driverid=rs3.getString("DriverID");
	trans=rs3.getString("Owner");
	//System.out.println(driverid+"in while"+drivname);
	out.print("<input type='hidden' name='drivid"+i+"' id='drivid"+i+"' value='"+driverid+"'>");
	out.print("<input type='hidden' name='drvrname"+i+"' id='drvrname"+i+"' value='"+drivname+"'>");
		
	out.print("<tr> <td>"); 
        
       
        
        
        out.print(i+"</td> <td> <a href='brifsbmt.jsp?driverid="+driverid+"&drivername="+drivname+"&trans="+trans+"'> "+drivname+"</a> </td> <td>"+driverid+"</td> <td>"+trans+"</td> </tr>");

	i++;
}


if(   i<=1  ){
    
    out.print("<center> <table border='1' width='50%'><tr> <th> Driver Name does not exist in Database. </th> </tr>");
 //    out.print("<center> <table border='1' width='50%'><tr> <th> <a href='addDriver.jsp' >    Please Click here to add the driver.  </a> </th> </tr>");

}


out.print("</table>");

} catch(Exception e) { }
finally
{
  con1.close();
}
%>
