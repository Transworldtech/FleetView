<%@page import="java.sql.ResultSet" 
		import="java.sql.Connection"
		import="java.sql.Statement" 
		import="java.text.SimpleDateFormat" 
%>
<%@ include file="Connections/conn.jsp" %>
<jsp:useBean id="fleetview" 
				 class="com.fleetview.beans.classes" 
				 scope="page"></jsp:useBean>

<%
	Connection conn=null;
	Statement st=null, st1=null;
	
	try{
		fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		conn=fleetview.ReturnConnection();
		st=conn.createStatement();
		st1=conn.createStatement();
		String searchveh;
		String sql;
		Object dateformat=session.getAttribute("dateformat");
		if(session.getAttribute("TypeofUser").toString().equals("SUBUSER"))
		{
		//	out.print("TypeofUser-----------------------------------------------------------------> " +session.getAttribute("TypeofUser").toString());

%>
	<table border="0" width="100%" align="center"> 
	<tr>
	<%
	String userexpress=session.getAttribute("usertypevalue").toString();
	//out.print("which userusertypevalue------------------------------------------------------------------> " +userexpress);
	if(userexpress.equalsIgnoreCase("ExpressRdys_All")|| userexpress=="ExpressRdys_All" )
	{
	%>
	<td align="center">
		<br/><font size='2'>You are viewing vehicles which are in 150 km. 
			Range from your location and vehicles which are going from your location and coming to your location.</font>
		<p></p>
	</td>
	
	<% 	
	}
	else
	{
	%>
	<td align="center">
		<br/><font size='2'>You are viewing vehicles which are in 10 km. 
			Range from your location and vehicles which are going from your location and coming to your location.</font>
		<p></p>
	</td>
	<%
	}
	%>
	</tr>
	</table>
			
<!--	<table class="stats">-->
<!--		<tr><th colspan="5">Search and add the vehicle in the list.</th></tr>-->
<!--		<tr><td class="bodyText" colspan="5">-->
<!--		<form name="searchform" action="" method="get">			-->
<!--		<div align="right">Vehicle is not in the list, please enter the Vehicle registration number to search.</div>-->
<!--		<div align="right"><input type="hidden" name="h" id="h" class="formElement">-->
<!--			<input type="text" name="searchveh" class="formElement" onChange="fun(this);">&nbsp;&nbsp;&nbsp;-->
<!--			<input type="submit" name="Search!" value="Search!" class="formElement"></div>-->
<!--		</form>-->
<!--		</td></tr>-->
<!--	</table>-->
<%
			searchveh=request.getParameter("searchveh");
			int count=1;	
			if(null!=searchveh)
			{			
				final String sql11=
					"SELECT * " + 
					"  FROM t_group "+ 
					" WHERE transporter like '%"+searchveh+"%' "+
					"   AND GPName='"+session.getAttribute("usertypevalue").toString()+
					"'  AND vehCode NOT IN "+session.getAttribute("VehList").toString();
				final ResultSet rstnew=st.executeQuery(sql11);		
%>
	<form name="addveh" method="get" action="addveh.jsp">
	<table class="stats">
		<tr><td class="bodyText" colspan="5">Please check Vehicle to add in the list</td></tr>
		<tr>
			<td class="hed">Check<input type="hidden" name="hh" value="<%=searchveh%>"></td>
			<td class="hed">Vehicle Reg. No</td>
			<td class="hed">Transporter</td>
			<td class="hed">Updated</td>
			<td class="hed">Location</td>
		</tr>	
<%
				while(rstnew.next())
				{
					sql="select * from t_onlinedata where VehicleCode='"+rstnew.getString("VehCode")+"'";
					final ResultSet rstnew1=st1.executeQuery(sql);
					if(rstnew1.next())
					{
%>
		<tr>
			<td><INPUT TYPE=CHECKBOX NAME="ch<%=count%>" value="<%=rstnew1.getString("VehicleCode")%>"></td>
			<td align="left"><%=rstnew1.getString("VehicleRegNo")%></td>
			<td align="left"><%=rstnew1.getString("Transporter")%></td>
			<td align="left"><%= new SimpleDateFormat(dateformat.toString()).format(rstnew1.getDate("TheDate"))%><%=rstnew1.getString("TheTime")%></td>
			<td align="left"><div align="left"><%=rstnew1.getString("Location")%> </div></td>
		</tr>			
<%
						count++;
					}
					rstnew1.close();				
				}
				rstnew.close();
%>
		<tr><td colspan="5" align="center"><input type="submit" value="Add Vehicle" Name="Add_Vehicle" class="formElement"></td></tr>
<%
			}
%>
	</table>
	<input type="hidden" name="count" value="<%=count%>">	
	</form>	
<%
		}
	}
	catch(Exception e){
		e.printStackTrace();
	} 
	finally{
		try{
			fleetview.closeConnection();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
%>