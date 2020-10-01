<%-- 
    Document   : addDriverDb
    Created on : Apr 15, 2009, 11:36:18 AM
    Author     : yogesh
--%>
   
<%@ include file="Connections/conndriver.jsp" %>
<%! 
Connection con ;
%>
        <%
       // System.out.println("add driver page");
        String drvName = request.getParameter("drvName");
        String drvId  = request.getParameter("drvId");
        //String drvMobNo  = request.getParameter("drvMobNo");
        String transporterName  = request.getParameter("transpName");
       // String licnNo  = request.getParameter("licnNo");
        String sqlInsert = "";
        String existedDriver = "";
        String msg = "";
        String fromPage = (String)request.getParameter("fromPage");
        
        
try{           
Class.forName(MM_dbConn_DRIVER);
con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt=con.createStatement();
Statement stquery=con.createStatement();

String sqlChk = "select * from t_drivers where DriverID = '"+drvId+"' ";
ResultSet rs = stmt.executeQuery(sqlChk);
if(rs.next()){
 existedDriver = rs.getString("DriverID");
 msg = "F";
}else{

 msg = "S";
 String groupName=session.getAttribute("usertypevalue").toString();
 String username = session.getValue("user").toString();

 sqlInsert = "Insert into t_drivers ( DriverID,DriverName,Owner,GPNAME,EntryBy) values('"+drvId+"','"+drvName+"','"+transporterName+"','"+groupName+"','"+username+"')"; 
 /*Query to insert query in db_gps.t_sqlquery table*/
stmt.executeUpdate(sqlInsert);	
 String abcd=sqlInsert.replace("'","#");
	abcd=abcd.replace(",","$");
	stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
	
	String sqlInsert1 = "Insert into t_irtedriver( PassportID,DriverName,Owner,GPNAME,entryBy) values('"+drvId+"','"+drvName+"','"+transporterName+"','"+groupName+"','"+username+"')"; 
	//System.out.println("sqlInsert::"+sqlInsert1);
	 stmt.executeUpdate(sqlInsert1);
	 String abcd1=sqlInsert1.replace("'","#");	
		abcd1=abcd1.replace(",","$");								
		stquery.executeUpdate("Insert into t_sqlquery (dbname,query) values ('db_gps','"+abcd1+"')");
/*****************************/
 
}


String sql2 = "select * from t_driverbriefingquest where DriverId ="+drvId+"  ";
String briefId = "";
        ResultSet rs2=stmt.executeQuery(sql2);
        if(rs2.next()){
            briefId = rs2.getString("SrNo");
        
        }

        if(fromPage.equals("deBrief")){
        response.sendRedirect("debrifsbmt.jsp?briefId="+briefId+"&driverid="+drvId+"&drivername="+drvName+"&trans="+transporterName+"");
        }else{
response.sendRedirect("brifsbmt.jsp?briefId="+briefId+"&driverid="+drvId+"&drivername="+drvName+"&trans="+transporterName+"");
}//response.sendRedirect("addDriver.jsp?msg="+msg+"");


}catch(Exception e){
out.println( "Exception ::"+e );
}finally
{
	try
	{
		con.close();
	}catch(Exception e)
	{
		
	}
}
%>