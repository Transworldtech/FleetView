<%@ include file="Connections/conn.jsp" %>
<%!
Connection conn;
Statement st,st1;
String sql,sql1,username="",mainuser="";
%>
<%

	username=(String)session.getAttribute("usertypevalue");
	mainuser=(String)session.getAttribute("mainuser");


      String flag="true";
	try{
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
	Statement stquery=conn.createStatement();
	String GPName="",clenname="",cleanerid="",fathername="",address1="",address2="",gender="",maridstatus="",dob="",mobno=""; 
;
	
	GPName=request.getParameter("GPName");
	
	clenname=request.getParameter("cleanername");
	
	cleanerid=request.getParameter("cleanerid");
	
	
	
	fathername=request.getParameter("fathername");
	address1=request.getParameter("address1");
	address2=request.getParameter("address2");
	gender=request.getParameter("gender");
	maridstatus=request.getParameter("maridstatus");
	dob=request.getParameter("dob");
	mobno=request.getParameter("mobno"); 
	
	
	sql="insert into db_gps.t_cleaners(Cleanerid,Cleanername,FatherNm,Address1,Address2,Gender,Marital,DOB,MobileNo,Owner,GPname,Status,Entryby)values('"+cleanerid.replaceAll("'"," ")+"','"+clenname.replaceAll("'"," ")+"' ,	'"+fathername.replaceAll("'"," ")+"','"+address1.replaceAll("'"," ")+"','"+address2.replaceAll("'"," ")+"','"+gender+"','"+maridstatus+"','"+dob+"','"+mobno.replaceAll("'"," ")+"','"+username+"','"+GPName+"','Active','"+mainuser+"') ";
	
	
	st1.executeUpdate(sql);
	
    System.out.println("insert"+sql);

	sql1="insert into db_gps.t_cleanerhistory(Cleanerid,Cleanername,FatherNm,Address1,Address2,Gender,Marital,DOB,MobileNo,Owner,GPname,Status,Entryby,Action)values('"+cleanerid.replaceAll("'"," ")+"','"+clenname.replaceAll("'"," ")+"' ,	'"+fathername.replaceAll("'"," ")+"','"+address1.replaceAll("'"," ")+"','"+address2.replaceAll("'"," ")+"','"+gender+"','"+maridstatus+"','"+dob+"','"+mobno.replaceAll("'"," ")+"','"+username+"','"+GPName+"','Active','"+mainuser+"','Added')";
	
	
	st1.executeUpdate(sql1);
    System.out.println("insert2"+sql1);
response.sendRedirect("Reportforcleaner.jsp?save1=true");
	
	}catch(Exception e)
	{
		e.printStackTrace();
	}
	
	%>