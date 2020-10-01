<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());

String filename=session.getAttribute("user").toString()+showdatex+"trip_st.xls";
    response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="Connections/conn.jsp" %>
  <%!
Connection conn, conn1;
Statement st,st1,st2,st3;
String aa,regno,sq,searchveh;
%>

<%
try{
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
	st2=conn.createStatement();	
	st3=conn1.createStatement();
	%>
	
	
			<table width="100%" border="1" align="center" class="sortable">
			<tr>
			<th> <b> Sr.No </b></th>
			<th> <b>VehicleRegNo</b></th>
			<th> <b>Transporter</b></th>
			<th> <b>OS Count</b></th>
			<th> <b>RA Count</b></th>
			<th> <b>RD Count</b></th>
			<th> <b>CD Count</b></th>
			<th> <b>ND Count</b></th>
			<th> <b>Stopages Count</b></th>
			</tr>		
		<%
		  	int oscount=0,rdcount=0,cdcount=0,ndcount=0,racount=0,stopcount=0;
			boolean flag=true;
			int i=1,ostot=0,rdtot=0,cdtot=0,ratot=0,stoptot=0,ndtot=0;
			String sql1="select * from t_vehicledetails where status = '-' order by ownername asc";
		    ResultSet rs1=st1.executeQuery(sql1);
		    while(rs1.next())
		    {
		    	String vehcode=rs1.getString("vehiclecode");
		    	String vehno=rs1.getString("vehicleregnumber");
		    	String owner=rs1.getString("ownername");
		    	String sql2="select count(*) from t_veh"+vehcode+"_overspeed where concat(FromDate,' ',Fromtime) between '2009-11-07 22:59:59' and '2009-11-08 05:00:00'";
		    	ResultSet rs2=st3.executeQuery(sql2);
				while(rs2.next())
				{
					oscount=rs2.getInt(1);
					ostot=ostot+oscount;
				}
				String sql3="select count(*) from t_veh"+vehcode+"_ra where concat(TheDate,' ',TheTime) between '2009-11-07 22:59:59' and '2009-11-08 05:00:00'";
		    	ResultSet rs3=st3.executeQuery(sql3);
				while(rs3.next())
				{
					racount=rs3.getInt(1);
					ratot=ratot+racount;
				}
				String sql4="select count(*) from t_veh"+vehcode+"_rd where concat(TheDate,' ',TheTime) between '2009-11-07 22:59:59' and '2009-11-08 05:00:00'";
		    	ResultSet rs4=st3.executeQuery(sql4);
				while(rs4.next())
				{
					rdcount=rs4.getInt(1);
					rdtot=rdtot+rdcount;
				}
				String sql5="select count(*) from t_veh"+vehcode+"_nd where concat(FromDate,' ',Fromtime) between '2009-11-07 22:59:59' and '2009-11-08 05:00:00'";
		    	ResultSet rs5=st3.executeQuery(sql5);
				while(rs5.next())
				{
					ndcount=rs5.getInt(1);
					ndtot=ndtot+ndcount;
				}
				String sql6="select count(*) from t_veh"+vehcode+"_stsp where concat(FromDate,' ',Fromtime) between '2009-11-07 22:59:59' and '2009-11-08 05:00:00'";
		    	ResultSet rs6=st3.executeQuery(sql6);
				while(rs6.next())
				{
					stopcount=rs6.getInt(1);
					stoptot=stoptot+stopcount;
				}
				String sql7="select count(*) from t_veh"+vehcode+"_cr where concat(FromDate,' ',Fromtime) between '2009-11-07 22:59:59' and '2009-11-08 05:00:00'";
		    	ResultSet rs7=st3.executeQuery(sql7);
				while(rs7.next())
				{
					cdcount=rs7.getInt(1);
					cdtot=cdtot+cdcount;
				}
			if( oscount==0 && rdcount==0 && cdcount==0 && ndcount==0 &&racount==0 &&stopcount==0)	
			{
				
			}
			else
			{ 
				
		%>	
			
			<tr>
			<td><%=i %></td>
			<td><%=vehno %></td>
			<td><%=owner %></td>
			<td><%=oscount %></td>
			<td><%=racount %></td>
			<td><%=rdcount %></td>
			<td><%=cdcount %></td>
			<td><%=ndcount %></td>
			<td><%=stopcount %></td>
			
			
			</tr>	
		<%
			i++;
			}
		    }
		%>	
			
			<tr class="sortbottom">
			<td colspan="3" class="hed"> Total :</td>
			<td class="hed"> <%=ostot %></td>
			<td class="hed"> <%=ratot %></td>
			<td class="hed"> <%=rdtot %></td>
			<td class="hed"> <%=cdtot %></td>
			<td class="hed"> <%=ndtot %></td>
			<td class="hed"> <%=stoptot %></td>
			
			</tr>	
			</table>
	<%
	
	}catch(Exception e)
	{
		out.print("Exception -->"+e);
	}
	finally
	{
		conn.close();
		conn1.close();
	}
	%>

		
			
			
        <%@ include file="footernew.jsp" %>
   
