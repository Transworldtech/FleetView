<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<html>
<head>
<title>Vehicle Tracking System</title>
</head>
<body>
<table border="0" cellspacing="0" cellpadding="0" width="100%">
        <tr>
          <td width="1%" height="2"><img src="images/fboxtopleft.gif" width="20" height="12" alt="bk"/></td>
          <td class="fboxtop"><img src="images/spacer.gif" width="2" height="2" alt=" " /></td>
          <td width="1%" height="2"><img src="images/fboxtopright.gif" width="20" height="12" alt="bk"/></td>
        </tr>
        <tr>
          <td width="1%" class="fboxleft"><img src="images/spacer.gif" width="2" height="2" alt=" "/></td>

          <td width="98%" class="featureboxbg">
			<!-- header file -->
			<%@ include file="headerprintreport.jsp" %> 
			<%@ include file="Connections/conn.jsp" %>       
         <!-- header file -->
          </td>
          <td width="1%" class="fboxright" ><img src="images/spacer.gif" width="2" height="2" alt=" "/></td>
        </tr>
      
       <!-- <tr>
          <td width="1%" class="featureboxbg"><img src="images/fboxmiddleleft.gif" width="20" height="5" alt="bk" /></td>
          <td width="98%" class="fboxmiddle"><img src="images/spacer.gif" width="2" height="2" alt=" " /></td>
          <td width="1%" class="featureboxbg"><img src="images/fboxmiddleright.gif" width="20" height="5" alt="bk" /></td>
        </tr>
-->
        <tr>
          <td class="fboxlowleft">&nbsp;</td>
          <td>
			<!-- body part come here -->
	<link href="css/css.css" rel="StyleSheet" type="text/css">
<%!
	Connection conn, con1;
	Statement st,st1,st2,st3,st4;
	ResultSet rs2=null;
	String sql, sql1, sql2;
	String today,lastweek, lastmonth;
	int km1,km2,km3,km4,km5,km6,km7,km8,km9;
	String dateformat;
 %>
<table border="0" align="center" width="100%" bgcolor="white">
<tr><td>
<table class="stats">
<tr>
<td colspan="5"><b><font color="brown" size="2">The Kilometer Analysis Report.</font></b>
<div align="right">
</td>
</tr>
<tr>
<td class="hed">Sr</td>
<td class="hed">Vehicle</td>
<td class="hed">
	<% 
		if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
		{
	%> 		<br>Miles Today</br> 
	<%		}else
	{ 
		%>	<br>Km. Today</br> 
	<% } %>

	</td>
	
	<td class="hed">
	<% 
		if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
		{
	%> 		<br>Miles This Week <br>(Mon-Sun)
	<%		}else
	{ 
		%>	<br>Km. This Week <br>(Mon-Sun) 
	<% } %>

	</td>
	<td class="hed">
	<% 
	if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
	{
	%>
	 		<br>Miles This Month <br> 
	<%		}else
	{ 
		%>	Km. This Month <br>  
	<% } %>

	</td>

</tr>
<%
try{
	today=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	con1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
	st2=conn.createStatement();
	st3=con1.createStatement();
	st4=con1.createStatement();
	dateformat=session.getAttribute("dateformat").toString();
	
	int noofdays=0;
	sql="select WEEKDAY('"+today+"')";
	ResultSet rstd11=st.executeQuery(sql);
	if(rstd11.next())
	{
		noofdays=rstd11.getInt(1);
	}

	sql="select SUBDATE('"+today+"', INTERVAL "+noofdays+" DAY)";
	ResultSet rstd12=st.executeQuery(sql);
	if(rstd12.next())
	{
		lastweek=rstd12.getString(1);
	}
	
	sql="select DATE_SUB(NOW(), INTERVAL (DAY(NOW())-1) DAY) as d2";
	ResultSet rstd2=st.executeQuery(sql);
	if(rstd2.next())
	{
		lastmonth=new SimpleDateFormat("yyyy-MM-dd").format(rstd2.getDate("d2"));
	}
	
	sql="select * from t_vehicledetails where VehicleCode in "+session.getAttribute("VehList").toString()+" order by VehicleCode";
	ResultSet rst=st.executeQuery(sql);
	int i=1;	
	km3=0;
	km6=0;
	km9=0;
	while(rst.next())
	{
	km1=0;
	km2=0;
	km4=0;
	km5=0;
	km7=0;
	km8=0;
	String vehcode=rst.getString("VehicleCode");
	%>
	<tr>
	<td><%=i%></td>
	<td><div align="left"><b><%=rst.getString("VehicleRegNumber")%></b></font></td>
	<td><div align="right">
	<% 
		sql="select Distance from t_veh"+rst.getString("VehicleCode")+" where TheFieldDataDate ='"+today+"'  and TheFiledTextFileName='SI' order by TheFieldDataTime asc limit 1";
		ResultSet rstkm1=st1.executeQuery(sql);
		if(rstkm1.next())
		{
			km1=rstkm1.getInt("Distance");
		}
		sql="select Distance from t_veh"+rst.getString("VehicleCode")+" where TheFieldDataDate ='"+today+"'  and TheFiledTextFileName='SI' order by TheFieldDataTime desc limit 1";
		ResultSet rstkm2=st1.executeQuery(sql);
		if(rstkm2.next())
		{
			km2=rstkm2.getInt("Distance");
		}
		km3=km3+km2-km1;
		if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
		{
			out.print((int)fleetview.KM_TO_MILES1(km2-km1));
		}else{
			out.print(km2-km1);
		}
		
	%>
	</div>
	</td>
	<td>
<div align="right">
	<% 
		Format formatter = new SimpleDateFormat("yyyy-MM-dd");

		java.util.Date tdydte1 = new java.util.Date();
		long ms=tdydte1.getTime();
		ms=ms-1000 * 60 * 60 *24;
		tdydte1.setTime(ms);
		String onedaybfre = formatter.format(tdydte1);

		sql2="select sum(Distance) as distlastweek from t_veh"+vehcode+"_ds where TheDate between '"+lastweek+"' and '"+onedaybfre+"' ";
		//out.print(sql2);
		rs2=st3.executeQuery(sql2);	
		if(rs2.next())
		{
			km4=rs2.getInt("distlastweek");
		}
		km4=km4+(km2-km1);
		if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
		{
			out.print((int)fleetview.KM_TO_MILES1(km4));
		}else{
			out.print(km4);
		}
		
		km6=km6+km4; // adding total kms

	%>
	</div>	
	
	</td>
	<td>
<div align="right">
	<% 
		sql="select sum(Distance) as distlastmnth from t_veh"+vehcode+"_ds where TheDate between '"+lastmonth+"' and '"+onedaybfre+"' ";
		//out.print(sql);
		ResultSet rstkm7=st4.executeQuery(sql);
		if(rstkm7.next())
		{
			km7=rstkm7.getInt("distlastmnth");
		}

			km7=km7+(km2-km1);
			
			if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
			{
				out.print((int)fleetview.KM_TO_MILES1(km7));
			}
			else{
				
				out.print(km7);
			}
			km9=km9+km7; //adding total kms
	%>
	</div>	
	
	</td>	
	</tr>	
	<%
	i++;
	}
	%>
<tr>
<td colspan="2" class="hed"><div align="right"><b>Total :</b></div></td>
	<%
		if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
		{
	%>
			
			<td class="hed"><div align="right"><b><%=(int)fleetview.KM_TO_MILES1(km3)%></b></div></td>
			<td class="hed"><div align="right"><b><%=(int)fleetview.KM_TO_MILES1(km6)%></b></div></td>
			<td class="hed"><div align="right"><b><%=(int)fleetview.KM_TO_MILES1(km9)%></b></div></td>
	<%
		}else{ 
	%>
			<td class="hed"><div align="right"><b><%=km3%></b></div></td>
			<td class="hed"><div align="right"><b><%=km6%></b></div></td>
			<td class="hed"><div align="right"><b><%=km9%></b></div></td>		
	<%
		}
	%>
	</tr>	
	<% 
	}
		catch(Exception ee)
		{
			out.print("Exception---->"+ee);
		}	
		finally
		{
			try{
				con1.close();
				
			}
			catch(Exception e)
			{}
			try{
				
				conn.close();
			}
			catch(Exception e)
			{}
			
		}
%>

</table>
</td></tr>
</table>
			<!-- body part come here -->
				
			</td>
    <td class="fboxlowright">&nbsp;</td>
    
    <tr>
       <td width="1%"><img src="images/fboxbottomleft.gif" width="20" height="20" alt="bk" /></td>
       <td width="98%" class="fboxbottom"><img src="images/spacer.gif" width="2" height="2" alt=" " /></td>
       <td width="1%"><img src="images/fboxbottomright.gif" width="20" height="20" alt="bk" /></td>
    </tr>
    </table>
      <%@ include file="footernew.jsp" %>
    </body>
</html>
</jsp:useBean>