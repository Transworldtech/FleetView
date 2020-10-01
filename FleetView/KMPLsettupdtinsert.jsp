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
  	
  	 <%@ page import="java.io.*,java.util.*, javax.servlet.*" %>

<%!
Connection con1;
Statement st,st1,st2,st3,st4,st5,st15,st16;
%>

<%
   Date date = new Date();
   //out.print( "<h2 align=\"center\">" +date.toString()+"</h2>");
%>
<% 
try {
	int i=1;
	String owner=session.getAttribute("usertypevalue").toString();
	String user=session.getAttribute("mainuser").toString();
	
	String KMPL=request.getParameter("element_3_1");
	//System.out.println("cardid*************************************************:-"+cardid);
	String Vendor=request.getParameter("element_3_2");
	//System.out.println("Vendor*************************************************:-"+Vendor);
	String id=request.getParameter("id");
	//System.out.println("id*************************************************:-"+id);
	String cardtype=request.getParameter("element_3_3");
	//System.out.println("cardtype*************************************************:-"+cardtype);
	String status=request.getParameter("element_3_4");
	//System.out.println("status*************************************************:-"+status);
	
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
st15=con1.createStatement();
st16=con1.createStatement();
ResultSet rst=null;

	String cardno="",cardvendor="",Requestno="",companyid="",companyname="",customerid="",accountno="",
			
			dailylimit="",monthlylimit="",	issuedate="",expirydate="",entryby="",InsertDt=""	;
	int cnt=0,cnt1=0;
	int sqlst=0;
	
	String kmpl=request.getParameter("kmpl");
	System.out.println("kmpl------>"+kmpl);
	String OwnerName=request.getParameter("OwnerName");
	System.out.println("OwnerName------>"+OwnerName);
	String VehcleRegNumber=request.getParameter("VehcleRegNumber");
	System.out.println("VehcleRegNumber------>"+VehcleRegNumber);
	String VehicleCode=request.getParameter("VehicleCode");
	System.out.println("VehicleCode------>"+VehicleCode);
	
	
	//////////////////////////////////////////Card holder and card id ///////////////////////////////////
			    
	//String record9="select cardno,companyname from db_gps.t_cardmaster where driverid='12345678' ";
	
     
	/////////////////  |  |  |   
	String defaultDate1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date()); 
	System.out.println("defaultDate1defaultDate1defaultDate1-----"+defaultDate1);
	
	try{
			
			    String insrtmaster="update db_gps.t_vehicledetails set kmpl= '"+KMPL+"' where VehicleCode= '"+VehicleCode+"' and OwnerName='"+OwnerName+"' and VehicleRegNumber='"+VehcleRegNumber+"' limit 1";
				System.out.println("fulmaster*************************************************:-"+insrtmaster);
				cnt=st15.executeUpdate(insrtmaster);
				
				
				}catch(Exception e)
		  {e.printStackTrace();}
		
	%>
	
		
	<% 
	


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

 	 if(cnt>=1)
 	 {
 		 //cnt=0;
 	out.println("<script type='text/javascript'>alert('KMPL Updated Sucessfully...');");
 	out.println("location='KMPLFuelReport.jsp'");
 	out.println("</script>");
	
 	 }else{
 		  out.println("<script type='text/javascript'>alert('KMPL Not Updated...');");
 			out.println("location='KMPLFuelReport.jsp'");
 			out.println("</script>");
			 
 	 }
	
} catch(Exception e) { 
	out.print("NotDone");
	}


	finally
	{
		//st.close();
		//st1.close();
		//con1.close();
	}

%>