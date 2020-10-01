<%@ include file="airtelheader.jsp"%> 
<%@page import="java.util.Date"%>
<style>
.popup {
background-color: #98AFC7;
position: absolute;
visibility: hidden;

.popupnew {
background-color: #98AFC7;
position: absolute;
visibility: visible;

.popupx {
background-color: #98AFC7;
position: absolute;
visibility: hidden;
}
</style>
       <table border="0" bgcolor="white">
		<tr>
			<td><a href="airtelcurrentposition.jsp" title="Home"><img src="images/home.jpg" border="0"></a></td>
			<td><a href="javascript:history.go(-1)"> <img src="images/back.jpg" border="0"></a></td>
			<td><a href="logout.jsp" title="Logout"><img src="images/logout.jpeg" border="0"></a></td>
		</tr>
</table>
	
<table border="0" width="95%" bgcolor="white">  
<tr align="center">
<td>
<!-- <div align="left"><font size="3"><b>Report No:1.5</b></font></div>-->

 <div align="center"><font size="3"><b>Report For New GenSets<b></font></div>
</td>
</tr>
</table>
<%!
Connection con;
Statement stmt;
ResultSet rs;
%>
<table width="100%" border="1" align="center" class="sortable">
			<tr>
					<th id="tdp0" > <b>Sr.No</b></th>
					
					<th id="tdp0" > <b>SiteID</b></th>
					<th id="tdp0" > <b>GenSet ID</b></th>
					<th id="tdp0" > <b>Make</b></th>
					<th id="tdp0" > <b>Capacity</b></th>
					<th id="tdp0" > <b>Refuel Level</b></th>
					<th id="tdp0" > <b>Min. Battery Voltage </b></th>
					<th id="tdp0" > <b>Temp. Range</b></th>
					<th id="tdp0" > <b>Battery Make</b></th>
					<th id="tdp0" > <b>Next Maintenance Date</b></th>
					<th id="tdp0" > <b>Transfer Switch Position</b></th>
					<th id="tdp0" > <b>Remote Start/Stop</b></th>
					<th id="tdp0" > <b>Oil Level</b></th>
					<th id="tdp0" > <b></b></th>
					</tr>
<%
String sql1="", make="", bmake="", mdate="", tpos="", strstp="";
int siteid=0, gensetid=0, capacity=0,rlevel=0, trange=0, olevel=0, sr_no=1;
float bvolt;
	try
	{
		Class.forName("org.gjt.mm.mysql.Driver"); 
		con=DriverManager.getConnection("jdbc:mysql://localhost/TestDemo","fleetview","1@flv");
		stmt=con.createStatement();
		sql1="select * from TestDemo.NewGensetEntry";
		rs=stmt.executeQuery(sql1);
		while(rs.next())
		{
			siteid=rs.getInt("siteid");
			gensetid=rs.getInt("gensetid");
			make=rs.getString("make");
			capacity=rs.getInt("capacity");
			rlevel=rs.getInt("refuel_level");
			bvolt=rs.getFloat("bat_voltage");
			trange=rs.getInt("trange");
			bmake=rs.getString("bmake");
			mdate=rs.getString("m_date");
			tpos=rs.getString("t_position");
			strstp=rs.getString("r_start");
			olevel=rs.getInt("oil_level");
		//	out.println("siteid"+siteid+",capacity"+capacity+",relevel"+rlevel+",oillevel"+olevel+",temprange"+trange+",make"+make+",switchp1"+tpos+",srtstp1"+strstp+",batvolt"+bvolt+",btrmake"+bmake);
			 %>
	            <tr>
				<td align="left"><%=sr_no%></td>
				<td align="left"><%=siteid%></td>
				<td align="left"><%=gensetid%></td>
				<td align="left"><%=make%></td>
				<td align="left"><%=capacity%></td>
				<td align="left"><%=rlevel%></td>
				<td align="left"><%=bvolt%></td>
				<td align="left"><%=trange%></td>
				<td align="left"><%=bmake%></td>
				<td align="left"><%=mdate%></td>
				<td align="left"><%=tpos%></td>
				<td align="left"><%=strstp%></td>
				<td align="left"><%=olevel%></td>
				<td align="left"><a href="newGensetEditReport.jsp?siteid=<%=siteid%>&gensetid1=<%=gensetid%>&make=<%=make%>&capacity=<%=capacity%>&rlevel=<%=rlevel%>&bvolt=<%=bvolt%>&trange=<%=trange%>&bmake=<%=bmake%>&tpos=<%=tpos%>&strstp=<%=strstp%>&olevel=<%=olevel%>">Edit</a></td>
				</tr> 			
		    <% 
		 		sr_no++;
		    
		}
	}
    catch(Exception e)
    {
    	System.out.println(e);
    }
%>
</table>
<%@ include file="footernew.jsp" %>