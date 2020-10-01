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
	String GPName="",clenname="",cleanerid="",rid="",status="",clean="",clnid="",did="",address="",Gender="",dob="",mobno="",fatrhnm="";
	int r1=0;
	GPName=request.getParameter("GPName");
	clenname=request.getParameter("cleanername");
	clean=request.getParameter("clean");
    System.out.println("clean"+clean);

	did=request.getParameter("oldcleanid");
    System.out.println("did"+did);

	cleanerid=request.getParameter("cleanerid");
    System.out.println("insert"+cleanerid);


	status=request.getParameter("status");
	
	address=request.getParameter("address1");
	Gender=request.getParameter("gender");
	dob=request.getParameter("dob");
	mobno=request.getParameter("mobno");
	fatrhnm=request.getParameter("fathername");
	
	try{
		
		
		String sqlrid = "select * from db_gps.t_cleaners where Owner='"+username+"' and Cleanerid="+did+"";
		System.out.println("search rid   "+sqlrid);
		ResultSet rsrid = st.executeQuery(sqlrid);
		  if(rsrid.next())
		  {
			  rid=rsrid.getString("rid");

		  
		  }
		
			System.out.println("search   "+rid);

		
		
	String sqlck = "select Cleanerid from db_gps.t_cleaners where Owner='"+username+"' and Cleanerid="+cleanerid+"";
	System.out.println("search   "+sqlck);
	ResultSet rs = st.executeQuery(sqlck);
	  if(rs.next())
	  {
		  clnid=rs.getString("Cleanerid");
	  }
	  System.out.println(">>>>>>>"+clnid);
	  
	  
	  
	if(did.contains(clnid) || did==clnid)
	{
	    System.out.println("r1 is 222222222");

		r1=2;
	}
	else if(clnid != did || clnid==null)
	
	{
	    System.out.println("r1 is 111111111111");

		r1=1;
	}
	  
	}catch(Exception e)
	{
		e.printStackTrace();
	}
	
	
	
	  
	  if(r1==2)
	  {
		  
	
	sql="update db_gps.t_cleaners set Cleanerid='"+cleanerid.replaceAll("'"," ")+"',Cleanername='"+clenname.replaceAll("'"," ")+"',FatherNm='"+fatrhnm.replaceAll("'"," ")+"',Address1='"+address.replaceAll("'"," ")+"',Gender='"+Gender+"',DOB='"+dob+"',MobileNo='"+mobno.replaceAll("'"," ")+"',Status='"+status.replaceAll("'"," ")+"' where Rid='"+rid+"'";
	
	
	st1.executeUpdate(sql);
	
    System.out.println("update 1"+sql);


	sql1="insert into db_gps.t_cleanerhistory(Cleanerid,Cleanername,FatherNm,Address1,Gender,DOB,MobileNo,Owner,GPname,Status,Entryby,Action)values('"+cleanerid.replaceAll("'"," ")+"','"+clenname.replaceAll("'"," ")+"','"+fatrhnm.replaceAll("'"," ")+"','"+address.replaceAll("'"," ")+"','"+Gender+"','"+dob+"','"+mobno.replaceAll("'"," ")+"','"+username+"','"+GPName+"','Active','"+mainuser+"','Edited')";

	st1.executeUpdate(sql1);
    System.out.println("insert 2"+sql1);
    try{
if(clean.equalsIgnoreCase("true") || r1==2)
{
	 response.sendRedirect("Reportforcleaner.jsp?save=true");

}
    
    
    }catch(Exception e)
{
	e.printStackTrace();
}
	  }
	  
	  if(r1==1)
	  {
			 response.sendRedirect("cleaneredit.jsp?cktrip=true&id="+did+"&name="+clenname+"&add="+address+"&Gender="+Gender+"&dob="+dob+"&mobno="+mobno+"&fathernm="+fatrhnm+"&owner="+username+"&gpname="+GPName+"&status="+status+"&entryby="+mainuser+"&ridd="+rid);
 
	  }
	  
	  
	  
	  
	}catch(Exception e)
	{
		e.printStackTrace();
	}
	
	%>