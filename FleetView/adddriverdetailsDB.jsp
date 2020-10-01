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
        String drvId  = request.getParameter("passId");
        String fatherName  = request.getParameter("fatherName");
        String DOB11=request.getParameter("DOB");

        String DOB  =new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(DOB11));
        
        String LicenseNo  = request.getParameter("LicenseNo");
        String PassportNo  = request.getParameter("PassportNo");
        //String drvMobNo  = request.getParameter("drvMobNo");
        String transporterName  = request.getParameter("transpName");
       // String licnNo  = request.getParameter("licnNo");
        String sqlInsert = "";String sql2;
        String existedDriver = "";
        String msg = "";
        String fromPage = (String)request.getParameter("fromPage");
        
        
try{           

Class.forName(MM_dbConn_DRIVER);
con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt=con.createStatement();
Statement stmt1=con.createStatement();
Statement stmtinsert=con.createStatement();
Statement stmtinsert1=con.createStatement();
Statement stmtinsert2=con.createStatement();
/*
String sqlChk = "select * from irtedriver where DriverID = '"+drvId+"' ";
ResultSet rs = stmt.executeQuery(sqlChk);
if(rs.next()){
 existedDriver = rs.getString("DriverID");
 msg = "F";
}else{
*/
String groupName="";
groupName=session.getAttribute("usertypevalue").toString();
String username = "";
username = session.getValue("user").toString();
 msg = "S";

	System.out.println("In the Paassport id not null::");

	String sqlChk = "select * from t_irtedriver where PassportID = '"+drvId+"' ";
	ResultSet rs = stmt.executeQuery(sqlChk);
	if(rs.next()){
	 
	}else{
	sqlInsert = "Insert into t_irtedriver(PassportID,DriverName,fatherName,DOB,LicenseNo,Owner,GPNAME,entryBy) values('"+drvId+"','"+drvName+"','"+fatherName+"','"+DOB+"','"+LicenseNo+"','"+transporterName+"','Castrol','"+username+"')"; 
	System.out.println("sqlInsert::"+sqlInsert);
	 stmt.executeUpdate(sqlInsert);
		System.out.println("sqlInsert below::"+sqlInsert);

	 String abcd=sqlInsert.replace("'","#");	
		abcd=abcd.replace(",","$");								
		stmtinsert1.executeUpdate("Insert into t_sqlquery (dbname,query) values ('db_gps','"+abcd+"')");
String sqltraining="Insert into t_drivertraining(dcode,DriverName,DriverFatherName,DOB,Transporter,licenceno,Basic,Module1,Module2,Module3,Module4,Module5,MedicalExam,remark,Education,FTTraining,LastTraining,PreTest40MM,PreTestper,PostTest40MM,PostTestper,Typeofvehicle,educationgrade,LicenseType,vendor) values('"+drvId+"','"+drvName+"','"+fatherName+"','"+DOB+"','"+transporterName+"','"+LicenseNo+"','-','-','-','-','-','-','','','','','','','','','','','','','')";
stmt.executeUpdate(sqltraining);



	}
		String sqlChk1 = "select * from t_drivers where DriverID = '"+drvId+"' ";
		ResultSet rs1 = stmt.executeQuery(sqlChk1);
		if(rs1.next()){
		 
		}else{
	 sql2="Insert into t_drivers(DriverID,DriverName,Owner,GPNAME,EntryBy) values('"+drvId+"','"+drvName+"','"+transporterName+"','Castrol','"+username+"')"; 
	 stmt1.executeUpdate(sql2);
		System.out.println("sqlInsert2 below::"+sql2);

	 String abcd1=sql2.replace("'","#");	
		abcd1=abcd1.replace(",","$");								
		stmtinsert2.executeUpdate("Insert into t_sqlquery (dbname,query) values ('db_gps','"+abcd1+"')");
		}

//}

        //if(fromPage.equals("deBrief")){
      //  response.sendRedirect("debrifsbmt.jsp?briefId="+briefId+"&driverid="+drvId+"&drivername="+drvName+"&trans="+transporterName+"");
      //  }else{
//response.sendRedirect("brifsbmt.jsp?briefId="+briefId+"&driverid="+drvId+"&drivername="+drvName+"&trans="+transporterName+"");
//}//response.sendRedirect("addDriver.jsp?msg="+msg+"");

response.sendRedirect("adddriverdetails.jsp?msg=true");
}catch(Exception e){
out.println( "Exception ::"+e );
}
        
        
//sqlInsert = "Insert into t_drivers ( DriverID = '"+drvId+"', DriverName = '"+drvName+"', Owner = '"+transporterName+"', GPNAME = 'Castrol') "; 

        %>
        
 

