<%@ include file="Connections/conn.jsp" %>

<%!
Connection con1;
int id= 0;
%>
<%

try
{
	System.out.println("***********22");
	Class.forName(MM_dbConn_DRIVER);
	con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement st=con1.createStatement();
	Statement st1=con1.createStatement();
	
	id= Integer.parseInt(request.getParameter("id"));
	System.out.println("*********  "+id);
	String username =(String)session.getAttribute("mainuser");
    String Entdatetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
	
	
	String html = session.getAttribute("html"+id).toString();
    String[] token = html.split("%");
    for(int m=0; m<token.length; m++)
	{
		System.out.println("*****    "+m+"  ********     "+token[m]);
	}
    
   String sql = "insert into db_gps.t_VehMsthistory "
		+"(VehId,VehRegn,Chassisno,Engno,Gearno,Mnfdate,body,Regowner,Address1,Address2,Address3,OSrNo,Model,Color,Class,NoOfTyres,"
		+"NoofCyl,SeatingCap,StandingCap,Fuel,UnladenWt,VinNo,RLW,GVS,Company,RTO,RTOState,RCBookNo,State,City,RegDate,MnfName,Length,Breadth,Width,EntBy,EntDateTime,Pincode,"
		+"VehicleType,VehUsage,Status) values"+
		
		"('"+token[37]+"','"+token[0]+"','"+token[20]+"','"+token[19]+"','"+token[21]+"','"+token[14]+"','"+token[27]+"','"+token[3]+"','"+token[6]+"','"+token[7]+"','"+token[8]+"','"+token[4]+"','"+token[13]+"','"+token[35]+"','"+token[26]+"','"+token[33]+"',"
		+"'"+token[34]+"','"+token[31]+"','"+token[32]+"','"+token[36]+"','"+token[23]+"','"+token[22]+"','"+token[24]+"','"+token[25]+"','"+token[5]+"','"+token[15]+"','"+token[16]+"','"+token[18]+"',"
		+"'"+token[9]+"','"+token[10]+"','"+token[17] +"','"+token[12]+"','"+token[28] +"','"+token[29] +"','"+token[30] +"','"+username+"','"+Entdatetime+"','"+token[11]+"','"+token[1]+"','"+token[2]+"','Inactive')";
	System.out.println("&&&&&&   "+sql);
	st.execute(sql);
	
	sql = "update db_gps.t_VehMst set Status = 'Inactive' where VehRegn = '"+token[0]+"' and VehId = '"+token[37]+"'";
	st.execute(sql);
	
	response.sendRedirect("VehMasterReport.jsp?Msg=1");
}

catch(Exception e)
{
	System.out.println("RRRRRRRRRRR  "+e);
	response.sendRedirect("VehMasterReport.jsp?Msg=2");
	e.printStackTrace();
}
finally
{
	try
	{
		con1.close();		
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	
}
%>