<%@ include file="Connections/conn.jsp" %>

<%@page import="java.util.Date"%>
<%@ page import="java.util.List" %>
   <%@ page import="java.util.Iterator" %>
   <%@ page import="java.io.File" %>
   <%@ page import="java.io.*" %>
   <%@ page import="java.util.Properties,javax.mail.*,javax.mail.internet.*"%>
   <%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
   <%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
   <%@ page import="org.apache.commons.fileupload.*"%>
   <%@ page import="java.sql.*" %>

  	<%@ page import = "java.io.FileNotFoundException"%>
  	<%@ page import = "java.io.FileOutputStream"%>
  	<%@ page import = "java.io.IOException"%>
  	<%@ page import="javax.activation.*" %>
  	<%@page import="java.io.BufferedReader" import="java.io.InputStreamReader" import="java.net.URL" %>
  	<%@page import="java.net.URLEncoder" import="java.net.URLConnection"%>
  	
  	 

<%!
Connection con1;
Statement st,st1,st2,st3,st4,st5;
%>
<% 
try {
	int i=1;
	String owner=session.getAttribute("usertypevalue").toString();
	String user=session.getAttribute("mainuser").toString();
	String Rid=request.getParameter("Rid");
	String TripID=request.getParameter("TripID123");
	//String date1=request.getParameter("date1");
	String loadcmnt=request.getParameter("loadcmnt");
	
	String FuelIssueCategory=request.getParameter("FuelIssueCategory");
	
	
	Format fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	Format fmt1 = new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat sdfIn = new SimpleDateFormat("dd-MMM-yyyy");
	 SimpleDateFormat sdfOut = new SimpleDateFormat("yyyy-MM-dd");
	 
	 
		String insertdate = fmt.format(new java.util.Date());
		//out.println("here"+insertdate);
	
	
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=con1.createStatement();
st1=con1.createStatement();

ResultSet rst=null;

	
	String day="";
	String cardno="",cardvendor="",Requestno="";
	int cnt=0;
	System.out.println("insertdate:-"+insertdate);
	System.out.println("loadcmnt:-"+loadcmnt);
	System.out.println("Rid:-"+Rid);
	System.out.println("TripID:-"+TripID);
	
	////////////////////////////////////////////Tripid vehcode main query///////////////////////////////////////
	try{ 
		String updateTableSQL = "UPDATE db_gps.t_fuelissuemaster SET Status = ?,Day= ?,reason=? WHERE Rid= ? and TripID=? ";
		System.out.println("updateTableSQL:-"+updateTableSQL);
		PreparedStatement preparedStatement = con1.prepareStatement(updateTableSQL);
		preparedStatement.setString(1, "Pending");
		preparedStatement.setString(2, insertdate);
		preparedStatement.setString(3, loadcmnt);
		preparedStatement.setString(4, Rid);
		preparedStatement.setString(5, TripID);

		cnt=preparedStatement.executeUpdate();
		
	}catch(Exception e)
	{e.printStackTrace();}
			
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	
	///////////////////////////////Default request number.........//////////////////////////////////////////////////////////
	String record9="select rid from db_gps.t_fuelissuemaster where FuelIssueCategory='Ad-hoc' order by  rid desc limit 1 ";
	PreparedStatement ps9=con1.prepareStatement(record9);
	ResultSet rs9=ps9.executeQuery();
    if(rs9.next()){
    	Requestno=rs9.getString("rid");
    	//cardvendor=rs9.getString("companyname");
     }
	
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//if(cnt>=1){	
		
		
	if(cnt>=1)
	 {
		 //cnt=0;
	out.println("<script type='text/javascript'>alert('Request "+Requestno+" Processed Sucessfully...');");
	out.println("location='Ad-hocRequest.jsp'");
	out.println("</script>");
	
	 }else{
		  out.println("<script type='text/javascript'>alert('Request Not Procced...');");
			out.println("location='Ad-hocRequest.jsp'");
			out.println("</script>");
			 
	 }
	%>
	
	<!-- <div align="center">
	<br>
	<br>
	<font size="2" color="red">Request Updated Sucessfully...</font>
	<br>
	
	<br>
	<font size="2" color="red">Wait for Page redirection........</font>
	</div>
	 --> 
	 <%-- <% }%> --%> 
	<!-- <script type="text/javascript">
		try{
	    setTimeout("self.close()", 1500 );
	//	alert("Trip ended Successfully");
		//window.close();
		window.opener.location.reload("Ad-hocRequest.jsp");
		}
		catch(e)
		{
			alert(e);
		}
		</script>
	 -->
	 <% 
	
	

} catch(Exception e) { 
	out.print("NotDone");
	}
	finally
	{
		//st.close();
		//st1.close();
		con1.close();
	}

%>
