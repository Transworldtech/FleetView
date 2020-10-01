<%@page import="java.sql.ResultSet" 
		import="java.sql.Connection"
		import="java.sql.Statement" 
		import="java.text.SimpleDateFormat" 
%>

<%@ include file="Connections/conn.jsp" %>
<jsp:useBean id="fleetview" 
				 class="com.fleetview.beans.classes" 
				 scope="page"></jsp:useBean>

<%!
	private static final String CASTROL="Castrol";
    private static final String GROUP="GROUP";    
%>
<%
	Connection conn=null;
	Statement st=null;

	final String TypeOfUser=session.getAttribute("TypeofUser").toString();
	final String userTypeValue=session.getAttribute("usertypevalue").toString();
	try{		
		fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		conn=fleetview.ReturnConnection();
		st=conn.createStatement();
		final String query = " " + 
			"SELECT GPName from t_group " + 
			" WHERE VehRegNo LIKE '%" +  userTypeValue + "%' AND GPName='" + CASTROL + "'";
		final ResultSet rs = st.executeQuery(query);
%>


	<div style="width: 40%;text-align: left;">			
			<font color="green" size="4"><B> <I> </I> </B><a href="#" 
				onclick="javascript:window.open('generateSecurityCode.jsp','','menubar=1,resizable=1,width=550,height=350,location=no');">
				<font style="font-size: 0.6em;"> Security Code 
			</font></a> 
		</font>
<%
		if(rs.next())
		{
 %>
 		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 		<blink>
		<font color="green" size="4"><a href="#" 
			onclick="javascript:window.open('trainerfeedback.jsp','','menubar=1,resizable=1,width=550,height=350,location=no');"> 
			<font style="font-size: 0.6em;">DMC Feedback.</font> 
			</a></font>
		</blink>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 		
		<!--<font color="green" size="4"><a href="#" 
			onclick="javascript:window.open('specialComment.jsp','','menubar=1,resizable=1,width=550,height=350,location=no');"> 
			<font size="2"><u>Special Comment.</u></font> 
			</a></font>-->
		
		
 		<font color="green" size="4"><a href="#" 
			onclick="javascript:window.open('images/ND_SMS_Intimation_Template1.pdf','','menubar=1,resizable=1,width=550,height=350,location=no');"> 
			<font style="font-size: 0.6em;">Night Driving Intimation</font> </a> 
		</font>
<%
		}
		rs.close();
%>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
<%
  if(userTypeValue == "Eicher Motors" || userTypeValue.equalsIgnoreCase("Eicher Motors"))
  {
%>
<!--			<font color="green" size="4"><a href="EicherJRM.jsp" > -->
<!--			<font style="font-size: 0.6em;">View JRM</font> -->
<!--			</a></font>-->
		
		<%
  }
		%>
</div>
<div align="center" style="margin-top: -1%;"><font style="font-size: 1.2em;"><b>Current Position Of Vehicles </b></font></div>

	 	<br>
<%
	}catch(Exception e){
		e.printStackTrace();
	}
	finally {
		try{
			st.close();
		} catch(Exception e){
			e.printStackTrace();
		}
		try{			
			fleetview.closeConnection();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
%>