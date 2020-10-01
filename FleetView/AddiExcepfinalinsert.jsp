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
	
	String vehiclenumber=request.getParameter("vehiclenumber");
	String Drivername=request.getParameter("Drivername");
	String Driverinfo[]=Drivername.split("-");
	String cardnumber=request.getParameter("cardnumber");
	String km=request.getParameter("km");
	String kmpl=request.getParameter("kmpl");
	String Diselqnty=request.getParameter("Diselqnty");
	String defaultfuelrate=request.getParameter("defaultfuelrate");
	String fuelamnt=request.getParameter("fuelamnt");
	String reason=request.getParameter("reason");
	
	
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

	String cardno="",cardvendor="",Requestno="";
	int cnt=0;
	int sqlst=0;
	
	
	//////////////////////////////////////////Card holder and card id ///////////////////////////////////
			    
	//String record9="select cardno,companyname from db_gps.t_cardmaster where driverid='12345678' ";
	String record9="select cardno,companyname from db_gps.t_cardmaster where driverid='"+Driverinfo[1]+"' ";
	PreparedStatement ps9=con1.prepareStatement(record9);
	ResultSet rs9=ps9.executeQuery();
    if(rs9.next()){
    	cardno=rs9.getString("cardno");
    	cardvendor=rs9.getString("companyname");
     }
	/////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	try{
			
			    String insrtmaster="insert into db_gps.t_fuelissuemaster(Owner,FuelIssueCategory,Day,FuelQuantity,Rate,Amount,Currency,Status,EntryBy,InsertDt,driver_id,drivername,vehregno,card_id,cardvendor,reason) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				System.out.println("fulmaster*************************************************:-"+insrtmaster);
				PreparedStatement ps1=con1.prepareStatement(insrtmaster);
				//out.println("fulmaster*************************************************:-"+insrtmaster);
				ps1.setString(1, owner);
				ps1.setString(2, "Ad-hoc");
				ps1.setString(3, insertdate);
				ps1.setString(4, Diselqnty);
				ps1.setString(5, defaultfuelrate);
				ps1.setString(6, fuelamnt);
				ps1.setString(7, "Rs");
				ps1.setString(8, "Pending");
				ps1.setString(9, user);
				ps1.setString(10, insertdate);
				ps1.setString(11, Driverinfo[1]);
				ps1.setString(12, Driverinfo[0]);
				ps1.setString(13, vehiclenumber);
				ps1.setString(14, cardnumber);
				ps1.setString(15, cardvendor);
				ps1.setString(16, reason);
				cnt=ps1.executeUpdate();
					
		}catch(Exception e)
		  {e.printStackTrace();}
		
	%>
	<%-- <div align="center">
	<br>
	<br>
	<font size="2" color="red">Request Genrated Sucessfully...</font>
	<br>
	<font size="2" color="red">Your Request Number is :-<%=TripID+"_"+insertdate%></font>
	<br>
	<font size="2" color="red">Wait for Page redirection........</font>
	</div> --%>
	
		<!-- try{
	     setTimeout("self.close()", 500 );
	          
		 //window.close();
         
		//window.opener.location.reload("AdditionalExcep.jsp");
	     //window.location.reload("AdditionalExcep.jsp");
		}
		catch(e)
		{
			alert(e);
		} -->
		
	<% 
	
///////////////////////////////Default request number.........//////////////////////////////////////////////////////////
String record10="select rid from db_gps.t_fuelissuemaster where FuelIssueCategory='Ad-hoc' order by  rid desc limit 1 ";
PreparedStatement ps10=con1.prepareStatement(record10);
ResultSet rs10=ps10.executeQuery();
if(rs10.next()){
Requestno=rs10.getString("rid");
//cardvendor=rs9.getString("companyname");
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	 if(cnt>=1)
	 {
		 //cnt=0;
	out.println("<script type='text/javascript'>alert('Request "+Requestno+" Genrated Sucessfully...');");
	out.println("location='AdditionalExcep.jsp'");
	out.println("</script>");
	
	 }else{
		  out.println("<script type='text/javascript'>alert('Request Not Genrated...');");
			out.println("location='AdditionalExcep.jsp'");
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
