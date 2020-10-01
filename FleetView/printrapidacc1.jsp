<%@ include file="headerprintnew.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

String data1,data2,tripid,vehno,sdate,edate,showdate,showdate1;
String vid;
	
	sdate=request.getParameter("data1");
	//out.print(sdate);
	//String sdate1=
	edate=request.getParameter("data2");
	tripid=request.getParameter("tripid");
	vid=request.getParameter("vcode");
	//System.out.println("Vid:::"+vid);
	//vehno=request.getParameter("vehno");
	//System.out.println("Vregno:::"+vehno);
	String tbname="t_veh"+vid+"_ra";
	//out.println(tbname);

	
	
%>
<table border="0" width="100%">
<tr><td>
<table border="0" width="100%"">
<tr><td colspan="2" align="center">


</td></tr>
<tr bgcolor=""><td align="center"colspan="2"><font size="3"><b>RAPID ACCELERATION for Trip <%=tripid%>
</b></font>
<div class="bodyText" align="right">
<a href="javascript:window.print();"><img src="images/print.jpg" width="15px" height="15px"></a>
Date : <%= new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date()) %>

</div>
	 </td></tr>
</table>
<P></P>
<table border="1" width="100%" bgcolor="#F5FFFA" class="sortable">
<tr>
<th>Sr.</th>
<th>Date-Time</th>
<th>Speed From</th>
<th>Speed To</th>
<th>Location</th>
</tr>
<%!
Connection conn;
 %>
 <%
 
 //	String data1,data2,vid,vehno,sdate,edate;
 //	vid=session.getAttribute("vid").toString();
 	//System.out.println("Vid:::"+vid);
	//vehno=session.getAttribute("vehno").toString();
	//System.out.println("Vregno:::"+vehno);
	//String tbname="t_veh"+vid+"_ra";
	//out.println(tbname);
	
	try{
		
		conn = fleetview.ReturnConnection1();
		Statement st=conn.createStatement();
		String sql="select * from "+tbname+" where concat(TheDate,' ',TheTime)>='"+sdate+"' and concat(TheDate,' ',TheTime)<='"+edate+"' ";
		//System.out.print(sql);
		int i=1;
		//out.print(vid);
		ResultSet rst=st.executeQuery(sql);
		while(rst.next())
		{
			%>
		
		<tr>
		<td><%=i %></td>
		<td> <%=rst.getString(2)+"<br> "+rst.getString(3) %></td>
		<td><%=rst.getString(4) %></td>
		<td><%=rst.getString(5) %></td>
		<td><div align="left"><%=fleetview.ShowOnMapOnlyByDateTime(vid,rst.getString(2),rst.getString(3)) %></div></td>
		
		</tr>
			<%
			i++;
		}
		}catch(Exception e)
		{
			System.out.print("Exception"+e);
		}
		finally
		{	
			try{
				conn.close();
			}
			catch(Exception e)
			{
				
			}
			try{
				fleetview.closeConnection1();
				fleetview.closeConnection();
			}
			catch(Exception e)
			{
				
			}
		}
	 %>
		
	
	
	


</table>
</td></tr></table>

<%

%>
</jsp:useBean>
<%@ include file="footernew.jsp"%>