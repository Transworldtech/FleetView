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
	
	String cardid=request.getParameter("element_3_1");
	//System.out.println("cardid*************************************************:-"+cardid);
	String Vendor=request.getParameter("element_3_2");
	//System.out.println("Vendor*************************************************:-"+Vendor);
	String id=request.getParameter("id");
	//System.out.println("id*************************************************:-"+id);
	String cardtype=request.getParameter("element_3_3");
	//System.out.println("cardtype*************************************************:-"+cardtype);
	String status=request.getParameter("element_3_4");
	//System.out.println("status*************************************************:-"+status);
	String driverid=request.getParameter("element_3_5");
	String Driverinfo[]=driverid.split("-");
	//System.out.println("Driverinfo[]*************************************************:-"+driverid);
	
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
	
	
	//////////////////////////////////////////Card holder and card id ///////////////////////////////////
			    
	//String record9="select cardno,companyname from db_gps.t_cardmaster where driverid='12345678' ";
	
     
	/////////////////  |  |  |   
	String defaultDate1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date()); 
	System.out.println("defaultDate1defaultDate1defaultDate1-----"+defaultDate1);
	
	try{
		
			    //String insrtmaster="update db_gps.t_cardmaster set status= '"+status+"',driverid='"+driverid+"',cardtype='"+cardtype+"',companyname='"+Vendor+"' where id= '"+id+"' and cardno='"+cardid+"' limit 1";
				String insrtmaster="update db_gps.t_cardmaster set status= '"+status+"',driverid='"+Driverinfo[1]+"',driver_name='"+Driverinfo[0]+"',cardtype='"+cardtype+"',companyname='"+Vendor+"' where id= '"+id+"' and cardno='"+cardid+"' limit 1";
			    System.out.println("fulmaster*************************************************:-"+insrtmaster);
				cnt=st15.executeUpdate(insrtmaster);
				
				
				if(cnt>=1)
				{
				String record9="select * from db_gps.t_cardmaster where id='"+id+"' ";
				PreparedStatement ps9=con1.prepareStatement(record9);
				ResultSet rs9=ps9.executeQuery();
			    if(rs9.next()){
			    	cardno=rs9.getString("cardno");
			    	System.out.println("cardno:-"+cardno);
			        companyid=rs9.getString("companyid");
			    	System.out.println("companyid:-"+companyid);
			    	companyname=rs9.getString("companyname");
			    	System.out.println("companyname:-"+companyname);
			    	customerid=rs9.getString("customerid");
			    	System.out.println("customerid:-"+customerid);
			    	accountno=rs9.getString("accountno");
			    	System.out.println("accountno:-"+accountno);
			    	dailylimit=rs9.getString("dailylimit");
			    	System.out.println("dailylimit:-"+dailylimit);
			    	monthlylimit=rs9.getString("monthlylimit");
			    	System.out.println("monthlylimit:-"+monthlylimit);
			    	owner=rs9.getString("owner");
			    	System.out.println("owner:-"+owner);
			    	issuedate=rs9.getString("issuedate");
			    	System.out.println("ownerissuedate:-"+issuedate);
			    	expirydate=rs9.getString("expirydate");
			    	System.out.println("ownerexpirydate:-"+expirydate);
			    	entryby=rs9.getString("entryby");
			    	System.out.println("owneentryby:-"+entryby);
// 			    	InsertDt=rs9.getString("InsertDt");
// 			    	System.out.println("InsertDt:-"+InsertDt);
			    	
			    }	
				
				String abc="insert into db_gps.t_cardmasterhistory(id,cardno,cardtype,companyid,companyname,accountno,dailylimit,monthlylimit,owner,status,issuedate,expirydate,entryby,driverid,InsertDt) values ('"+id+"','"+cardid+"','"+cardtype+"','"+companyid+"','"+companyname+"','"+accountno+"','"+dailylimit+"','"+monthlylimit+"','"+owner+"','"+status+"','"+issuedate+"','"+expirydate+"','"+entryby+"','"+driverid+"','"+defaultDate1+"')";
				
				cnt1=st16.executeUpdate(abc);
				System.out.println("abccccc*****:-"+abc);
		
					
				}
			    
			    }catch(Exception e)
		  {e.printStackTrace();}
		
	%>
	
		
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
 	out.println("<script type='text/javascript'>alert('Card Updated Sucessfully...');");
 	out.println("location='FuelCardMaster.jsp'");
 	out.println("</script>");
	
 	 }else{
 		  out.println("<script type='text/javascript'>alert('Card Not Updated...');");
 			out.println("location='FuelCardMaster.jsp'");
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