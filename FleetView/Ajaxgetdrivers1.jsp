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

//sql1="select * from t_drivers where Owner in(select distinct(VehRegNo) from t_group where GPName='Castrol') and (DriverName like '"+srchval+"%' or DriverID like '"+srchval+"%' )  order by  DriverName asc";
//sql1="select * from t_drivers where Owner in(select distinct(VehRegNo) from t_group where GPName='Castrol') and (DriverName like 'ram pra%' or DriverID like '"+srchval+"%' )  order by  DriverName asc";
//sql1="select *  from t_drivers where Owner in(select distinct(VehRegNo) from t_group where GPName='Castrol') and (replace(driverName,' ','' ) like '%"+srchval+"%' or DriverID like '%"+srchval+"%') order by  DriverName asc";
if(session.getValue("usertypevaluemain").toString().equals("Castrol"))
{
//sql1="select *  from t_drivers where Owner in(select distinct(VehRegNo) from t_group where GPName='Castrol') and (replace(driverName,' ','' ) like '%"+srchval+"%' or DriverID like '%"+srchval+"%') and GPNAME<>'BS' order by  DriverName asc";
sql1="select a.DriverName as DriverName,a.DriverID as DriverID from db_gps.t_drivers a inner JOIN (select distinct(VehRegNo) ownername from db_gps.t_group where GPName='Castrol') b  ON a.Owner = b.ownername "+
		 "and (replace(a.driverName,' ','') like '%"+srchval+"%' or a.DriverID like '%"+srchval+"%') and a.GPNAME<>'BS'  order by a.DriverName";
}
else
	if(session.getValue("usertypevaluemain").toString().equals("BS"))
	{
	sql1="select DriverName,DriverID  from t_drivers where GPName='BS' and (replace(driverName,' ','' ) like '%"+srchval+"%' or DriverID like '%"+srchval+"%') order by  DriverName asc";
	}	
	else
		if(session.getValue("usertypevaluemain").toString().equals("ALL"))
		{
		//sql1="select *  from t_drivers where Owner in(select distinct(VehRegNo) from t_group where GPName='BS' or GPName='Castrol') and (replace(driverName,' ','' ) like '%"+srchval+"%' or DriverID like '%"+srchval+"%') and (GPNAME='BS' or GPName='Castrol') order by  DriverName asc";
		sql1="select a.DriverName as DriverName,a.DriverID as DriverID from db_gps.t_drivers a inner JOIN (select distinct(VehRegNo) ownername from db_gps.t_group where GPName='BS' or  GPName='Castrol') b  ON a.Owner = b.ownername "+
		 "and (replace(a.driverName,' ','') like '%"+srchval+"%' or a.DriverID like '%"+srchval+"%') and  (a.GPNAME='BS' or a.GPName='Castrol')  order by a.DriverName";
		}
		else
		{
		sql1="select DriverName,DriverID  from t_drivers where Owner='"+session.getValue("usertypevaluemain").toString()+"' and (replace(driverName,' ','' ) like '%"+srchval+"%' or DriverID like '%"+srchval+"%') order by  DriverName asc";
		}


System.out.println(sql1);
rs1=stmt1.executeQuery(sql1);
if( !(  rs1.next() ) ){
    
    out.print("<center> <table border='1' width='50%'><tr> <th> Driver does not exist. </th> </tr>");
    // out.print("<center> <table border='1' width='50%'><tr> <th> <a href='addDriver.jsp' >    Please Click here to add the driver.  </a> </th> </tr>");

}else{
 out.print("<center> <table border='1' width='50%'><tr> <th> Sr.No.</th> <th> Driver Name</th> <th> Driver Id </th> <th> Transporter </th> </tr>");

System.out.println("in else");
ResultSet rs3 = stmt1.executeQuery(sql1);
while(rs3.next())
{
    System.out.println("in while");
	drivname=rs3.getString("DriverName");
	driverid=rs3.getString("DriverID");
	//trans=rs3.getString("Owner");
	trans="-";
	sql2="select * from t_startedjourney where DriverCode='"+driverid+"' order by StartDate Desc limit 1";
	ResultSet rs2=stmt2.executeQuery(sql2);
	if(rs2.next())
	{
		trans=rs2.getString("OwnerName");
	}
//System.out.println(driverid+"in while"+drivname);
	out.print("<input type='hidden' name='drivid"+i+"' id='drivid"+i+"' value='"+driverid+"'>");
	out.print("<input type='hidden' name='drvrname"+i+"' id='drvrname"+i+"' value='"+drivname+"'>");
		
	out.print("<tr> <td  style='text-align:right'>"); 
        
	
      /*  sql2 = "select * from t_driverbriefingquest where DriverId ="+driverid+"  ";
        ResultSet rs2=stmt2.executeQuery(sql2);
        if(rs2.next()){
            briefId = rs2.getString("SrNo");
        
        }
        */
        
        //out.print(i+"</td> <td> <a href='driverbriefhistory.jsp?briefId="+briefId+"&driverid="+driverid+"&drivername="+drivname+"&trans="+trans+"'> "+drivname+"</a> </td> <td>"+driverid+"</td> <td>"+trans+"</td> </tr>");
        out.print(i+"</td> <td  style='text-align:left'> <a href='driverbriefhistory.jsp?driverid="+driverid+"&drivername="+drivname+"&trans="+trans+"'> "+drivname+"</a> </td> <td  style='text-align:right'>"+driverid+"</td> <td  style='text-align:left'>"+trans+"</td> </tr>");
	i++;
}
}

out.print("</table>");

} catch(Exception e) { }
finally
{
  con1.close();
}
%>