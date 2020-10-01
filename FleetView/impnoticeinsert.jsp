<%@ include file="Connections/helpconn.jsp" %>
<%@page import="java.util.Date"%>

<%
try
{
	 ResultSet rs2=null;
	 Statement st = null,st1 = null;
	 System.out.println("*********    ");
	 st = getDattabase.createStatement();
	 st1 = getDattabase.createStatement();
	 String user=request.getParameter("user");
	 String pass=request.getParameter("Password");
	 String option = request.getParameter("opt");
	 String todaydate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
	String typevalue=  "",typeofuser = "",fname = "",lname = "",email = "";
	 String sql = "select * from db_gps.t_security where username  = '"+user+"' and Password = '"+pass+"' ";
	rs2 = st.executeQuery(sql);
	 if(rs2.next())
	 {
		 typevalue = rs2.getString("TypeValue");
		 typeofuser = rs2.getString("TypeofUser");
	 }
	 
	 sql = "select * from db_gps.t_userdetails where username  = '"+user+"' limit 1";
		rs2 = st.executeQuery(sql);
		 if(rs2.next())
		 {
			 fname = rs2.getString("FirstName");
			 lname = rs2.getString("LastName");
			email = rs2.getString("Email");
		 }
	 
	 
	 sql = "select * from db_gps.t_captureopt where username = '"+user+"' ";
	rs2 = st.executeQuery(sql);
	if(rs2.next())
	{
		String sql1 = "Update db_gps.t_captureopt set optionentered = '"+option+"',UpdatedDateTime = '"+todaydate+"'  where username = '"+user+"' ";
		st1.executeUpdate(sql1);
	}
	else
	{
		String sql1 = "insert into db_gps.t_captureopt (UserName,FirstName,LastName,TypeofUser,TypeValue,optionentered,UpdatedDateTime) values ('"+user+"','"+fname+"','"+lname+"','"+typeofuser+"','"+typevalue+"','"+option+"','"+todaydate+"')";
		st1.executeUpdate(sql1);
	}
	
	System.out.println("*********    "+option);
	
	if(option == "opt2" || option.equalsIgnoreCase("opt2"))
	{
		String html = "<html><body><div><font size=2 face=Arial><b>Request for Google Map</b><br><br>Following user has selected the google map for FleetView and their details are as given below: <br><br>UserName: "+user+"<br>Name: "+fname+" "+lname+
								" <br>TypeValue: "+typevalue+" <br>UserType: "+typeofuser+" <br><br>Please contact the above user.<br><br>Thanks and Regards,<br>Transworld Team <br>020-41214444/09762007125<br>avlsupport@Mobile-Eye.in </font></font></div></body>";
		String subject = "Request for Google map access from Fleetview.";						
		String mailname = "Request for Google Map";			
		String toid = "n_kallurwar@transworld-compressor.com,sales@transworld-compressor.com,r_maner@transworld-compressor.com";
		String tocc = "";
		String[] tokens = user.split("@");
		String[] tokens1 = email.split("@");
		
	    if(tokens.length == 2 && tokens[1].contains("."))
	    {
	    	tocc = user;
	    }
	    else
	    	if(tokens1.length == 2 && tokens1[1].contains("."))
	    	{
	    		tocc = email;
	        }
	  
		
		String sql1 = "insert into db_gps.t_allpendingmailtable(MailName,Description,MailBody,subjectline,Toid,Tocc,EntryDateTime,MailStatus,SendDateTime,SenderName)values('"+mailname+
								"','-','"+html+"','"+subject+"','"+toid+"','"+tocc+"','"+todaydate+"','Pending','"+todaydate+"','Transworld')";
		st1.executeUpdate(sql1);
		System.out.println("*********    "+sql1);
	}
	
	response.sendRedirect("userinfo.jsp?user="+user+"&Password="+pass);
	
}
catch(Exception e)
{
	 System.out.println(e);
}
finally
{
	try
	{
		getStatement.close();
		
	}catch(Exception e)
	{
		
	}
	try
	{
		getDattabase.close();
	}catch(Exception e)
	{
		
	}
	
}
%>