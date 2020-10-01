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
	//String Rid=request.getParameter("Rid");
	String origin=request.getParameter("element_3_1");
	String via=request.getParameter("element_3_2");
	String via1=request.getParameter("mobileno1");
	String via2=request.getParameter("mobileno2");
	String via3=request.getParameter("mobileno3");
	String via4=request.getParameter("mobileno4");
	String via5=request.getParameter("mobileno5");
	String via6=request.getParameter("mobileno6");
	String via7=request.getParameter("mobileno7");
	String via8=request.getParameter("mobileno8");
	String Destination=request.getParameter("element_3_3");
	String StdKm=request.getParameter("element_3_4");
	String transitday=request.getParameter("element_3_5");
	String category=request.getParameter("element_3_6");
	
	String routecode="",finalroutecode="";
	String routecodenew[];
	//String FuelIssueCategory=request.getParameter("FuelIssueCategory");
	String finalvia=via+","+via1+","+via2+","+via3+","+via4+","+via5+","+via6+","+via7+","+via8;
	 routecode=origin+","+via+","+via1+","+via2+","+via3+","+via4+","+via5+","+via6+","+via7+","+via8+","+Destination;
	 System.out.println("routecode:-"+routecode);
	 try{
	 StringTokenizer stk = new StringTokenizer(routecode,",");
		 while (stk.hasMoreTokens()) {  
	         System.out.println(stk.countTokens());  
	         finalroutecode+=stk.nextToken().toString()+"-";
	         //al.add(st.nextToken().toString()+"-");
	     }
		//System.out.println("finalroutecode:-"+finalroutecode);
	  finalroutecode=finalroutecode.substring(0, finalroutecode.length()-1);
	 }catch(Exception e){
		 e.printStackTrace();
	 }
	  //System.out.println("finalroutecode:-"+finalroutecode);
	
	 //routecodenew[0];
	
	/* if(!(via.equals ("-"))){
	routecode=origin+"-"+via;
	   if(!(via1.equals("-")))
	   {
		   routecode=origin+"-"+via+"-"+via1;
		   if(!(via2.equals("-"))){
			   routecode=origin+"-"+via+"-"+via1+"-"+via2;
		   } 
	   }
	} */
	
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
	//System.out.println("loadcmnt:-"+loadcmnt);
	//System.out.println("Rid:-"+Ri d);
	//System.out.println("TripID:-"+TripID);
	
	////////////////////////////////////////////Tripid vehcode main query///////////////////////////////////////
	try{ 
		String updateTableSQL = "insert into db_gps.routeprofilemaster(origin,via,destination,stdkm,transitdays,Category,entyby,insertdate,routecode,owner) values(?,?,?,?,?,?,?,?,?,?)";
		System.out.println("updateTableSQL:-"+updateTableSQL);
		PreparedStatement preparedStatement = con1.prepareStatement(updateTableSQL);
		preparedStatement.setString(1, origin);
		preparedStatement.setString(2, finalvia);
		preparedStatement.setString(3, Destination);
		preparedStatement.setString(4, StdKm);
		preparedStatement.setString(5, transitday);
		preparedStatement.setString(6, category);
		preparedStatement.setString(7, user);
		preparedStatement.setString(8, insertdate);
		//r outecode
		preparedStatement.setString(9, finalroutecode);
		preparedStatement.setString(10, owner);
		cnt=preparedStatement.executeUpdate();
		
	}catch(Exception e)
	{e.printStackTrace();}
			
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	
	///////////////////////////////Default request number.........//////////////////////////////////////////////////////////
	/* String record9="select rid from db_gps.t_fuelissuemaster where FuelIssueCategory='Ad-hoc' order by  rid desc limit 1 ";
	PreparedStatement ps9=con1.prepareStatement(record9);
	ResultSet rs9=ps9.executeQuery();
    if(rs9.next()){
    	Requestno=rs9.getString("rid");
    	//cardvendor=rs9.getString("companyname");
     } */
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//if(cnt>=1){	
		
		
	if(cnt>=1)
	 {
	out.println("<script type='text/javascript'>alert('Route Added Sucessfully...');");
	out.println("location='MainRouteProfileMaster.jsp'");
	
	//out.println("window.close();");
	//out.println("window.opener.location.reload('RouteProfilemstr.jsp');");
	out.println("</script>");
	 }else{
		  out.println("<script type='text/javascript'>alert('Route Not Added...');");
			out.println("location='MainRouteProfileMaster.jsp'");
			//out.println("window.close();");
			//out.println("window.opener.location.reload('RouteProfilemstr.jsp');");
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
