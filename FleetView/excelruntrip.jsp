<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());

String filename=session.getAttribute("user").toString()+showdatex+"runtrips.xls";
response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="Connections/conn.jsp" %>
				<%!
		Connection conn, con1;
		Statement st,st1,st2, st3, st4,st5;
		String sql, sql1, sql2,sql3;
		ResultSet rs2=null;
		String today,lastweek, lastmonth,startDate,startCode,startTime,endCode,TransTime,updatedTm,scheTmDt,updtetime="",DisDate;
		int km1,km2,km3,km4,km5,km6,km7,km8,km9, kmrun1, kmrun2, kmrundist, totKm,remKm,todaysdist;
		long diffDays,tTime;
		java.util.Date dt1 = null;
		//String tempUpDate;
	 %>
	<form name="kmanalysis" method="get" action="">
	 <%
	try{
		String dateformat="dd-MMM-yyy";
		dateformat=session.getAttribute("dateformat").toString();
		//System.out.println("======1========");
		today=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		String currenttime=new SimpleDateFormat("HH:mm:ss").format(new java.util.Date());

		Class.forName(MM_dbConn_DRIVER); 
		conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		con1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		st=conn.createStatement();
		st1=conn.createStatement();
		st2=conn.createStatement();
		st3=con1.createStatement();
		st4=con1.createStatement();
		st5=conn.createStatement();
	
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
	
		sql="select DATE_SUB(NOW(), INTERVAL (DAYOFWEEK(NOW())-2) DAY) as d1";
		//System.out.println("==lastweek===sql===> "+sql);
		ResultSet rstd1=st.executeQuery(sql);
		if(rstd1.next())
		{
			lastweek=new SimpleDateFormat("yyyy-MM-dd").format(rstd1.getDate("d1"));
			//System.out.println("==lastweek==> "+lastweek);
		} 
		
		sql="select DATE_SUB(NOW(), INTERVAL (DAY(NOW())-1) DAY) as d2";
		//System.out.println("==lastmonth===sql===> "+sql);
		ResultSet rstd2=st.executeQuery(sql);
		if(rstd2.next())
		{
			lastmonth=new SimpleDateFormat("yyyy-MM-dd").format(rstd2.getDate("d2"));
			//System.out.println("==lastmonth==> "+lastmonth);
		} 
	 
	 %>
		 
	<table border="1" align="center" align="top" width="100%" bgcolor="white" class="stats">
	<tr>
	<td  valign="top">
	<table class="stats">
	<tr>
	<td colspan="16"><b>
	<font color="brown" size="2">KM Analysis Report for Open Trips</font></b>
	<div align="left"> <a href="#" onClick="ShowAll();" title="Click to show all hidden columns"> <img src="images/plus.jpg" width="15px" height="13px">  </a>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	
	<a href="#" onclick="javascript:window.open('printruntrips.jsp');" title="Print Report">
			<img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
			<a href="excelruntrip.jsp" title="Export to Excel">
			<img src="images/excel.jpg" width="15px" height="15px">
			</a>
	&nbsp;&nbsp;&nbsp;&nbsp;<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%></div>
	
	</td>
	</tr>
	</table>
	<table class="sortable">
	<tr>
	<th class="head" valign="top"> Sr </th>
	<th  class="hed" id="vehcol" valign="top"> <a href="#" onClick="hide('veh');" title="Click to hide TripId,Driver,StartDate,StartPlace,EndPlace Cols"><img id="img11" src="images/sub.jpg" width="13px" height="10px" border="0"> </a> <br> <B>Vehicle</B></th> 
	<th class="hed" id="tripcol" valign="top">  <br> <B> TripID</B></th>
	<th class="hed" id="drivcol" valign="top">  <br> <B> Driver</B></th>
	<th class="hed" id="stdatecol" valign="top">  <br> <B>Start Date-Time</B></th>
		<th class="hed" id="" valign="top"> <br> <B> Transporter</B></th>
	
	<th class="hed" id="stplacecol" valign="top"> <br> <B> Start Place</B></th>
	<th class="hed" id="endplacecol" valign="top">  <br> <B> End Place</B></th>
	<th class="hed" id="updtetmecol" valign="top"> <br> <B>Updated Dat-Time</B></th>
	<th class="hed" id="curposcol" valign="top"> <br> <B>Current Position</B></th>
	<th class="hed" id="FixedTimecol" valign="top"> <br> <B>FixedTime</B></th>
	<th class="hed" id="FixedKmcol" valign="top"> <br> <B>FixedKm</B></th>
  	<!--<th class="hed" id="kmsruncol" valign="top"> <a href="#" onClick="hide('kmsrun');" title="Click to hide KmsToRun,ETA Cols"> <img src="images/sub.jpg" id="img2" width="13px" height="10px" border="0"></a> <br><B>Kms run</B></th>-->
  	<th class="hed" id="kmsruncol" valign="top"><br><B>Kms run</B></th>
 	<th class="hed" id="kmstoruncol" valign="top">  <br><B>Kms to run</B></th>  
	<th class="hed" id="etacol" valign="top">  <br> <B>Scheduled Date-Time To Arrival</B></th>
<!-- 	<td class="hed" id="fuelconscol" valign="top"> <a href="#" onClick="hide('fuelcons');" title="Click to hide LoadingDelay,TransitTime"> <img src="images/sub.jpg" id="img3" width="13px" height="10px" border="0"></a> <br> <B>Fuel Consumption</td>
	<td class="hed" id="loaddelcol" valign="top">   <br> <B>Loading Delay</td> 
	<td class="hed" id="trantmecol" valign="top">  <br><B>Transit Time</td> 
-->	</tr>
	<%
	sql="select * from t_startedjourney where Jstatus='Running' and Vehid in"+session.getAttribute("VehList").toString()+" order by StartDate desc";
	ResultSet rsttrips=st.executeQuery(sql);
	int j=1;
	while(rsttrips.next())
	{
		String curpos="",  lat="", lon="";
		kmrundist=0;
		String vehno=rsttrips.getString("VehRegNo");
		sql="select * from t_onlinedata where VehicleCode='"+rsttrips.getString("VehId")+"'";
		//out.print(sql);
		ResultSet rs1=st1.executeQuery(sql);
		
		try{
			if(rs1.next())
			{
				curpos=rs1.getString("Location");
				updtetime=new SimpleDateFormat(dateformat).format(new SimpleDateFormat("yyyy-MM-dd").parse(rs1.getString("TheDate")))+" "+new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rs1.getString("TheTime")));
				lat=rs1.getString("LatitudePosition");
				lon=rs1.getString("LongitudePosition");
			}
			// tempUpDate=updtetime;
			
		  }catch(Exception exc)
		  {
				//System.out.print("--i am in exception 5==");
				exc.printStackTrace();
	      }
		
		try{
				//sql="select Distance from t_veh"+rsttrips.getString("VehId")+" where TheFieldDataDate ='"+today+"'  and TheFiledTextFileName='SI' order by TheFieldDataTime asc limit 1";
				//out.println("\nsql ==6==="+sql);
				sql="select Distance from t_veh"+rsttrips.getString("VehId")+" where TheFieldDataDateTime >='"+rsttrips.getString("StartDate")+" "+rsttrips.getString("StartTime")+"' and TheFiledTextFileName='SI' order by TheFieldDataDateTime asc limit 1";
				ResultSet rstkmrun1=st1.executeQuery(sql);
				if(rstkmrun1.next())
				{
					kmrun1=rstkmrun1.getInt("Distance");
				}
		  }catch(Exception e)
			{
				//System.out.println("---I am in exception--rstkmrun1-");
				e.printStackTrace();
			}

		  try{
				sql="select Distance from t_veh"+rsttrips.getString("VehId")+" where TheFieldDataDateTime <='"+today+" "+currenttime+"' and TheFieldDataDateTime >= '"+rsttrips.getString("StartDate")+" "+rsttrips.getString("StartTime")+"'  and TheFiledTextFileName='SI' order by TheFieldDataDateTime desc limit 1";
				//out.print("sql ====7===="+sql);
				ResultSet rstkmrun2=st1.executeQuery(sql);
			if(rstkmrun2.next())
			{
				kmrun2=rstkmrun2.getInt("Distance");
				//out.println("kmrun2----->"+kmrun2);
			}
		}catch(Exception e1)
		{
			//System.out.println("---I am in exception--rstkmrun2-");
			e1.printStackTrace();
		}
		
	try{
		long myMilisec;
		tTime=0;
		//sql="select sum(Distance) as kmrundist from t_veh"+rsttrips.getString("VehId")+"_ds where TheDate>='"+rsttrips.getDate("StartDate")+"'and TheTime>='"+rsttrips.getTime("StartTime")+"' and startCode>='"+rsttrips.getString("StartCode")+"' and endCode>='"+rsttrips.getString("EndCode")+"' ";
		sql="select * from db_gps.t_startedjourney where StartDate='"+rsttrips.getDate("StartDate")+"'and StartTime='"+rsttrips.getTime("StartTime")+"' and StartCode='"+rsttrips.getString("StartCode")+"' and EndCode='"+rsttrips.getString("EndCode")+"' and Vehid="+rsttrips.getString("VehId")+"";
		///System.out.println(":::---SQL----:::"+sql);
		ResultSet rstTotKm=st3.executeQuery(sql);
		if(rstTotKm.next())
		{
			sql3="select * from db_gps.t_castrolroutes where StartPlace = '"+rsttrips.getString("StartPlace")+"' and EndPlace = '"+rsttrips.getString("EndPlace")+"' || EndPlace = '"+rsttrips.getString("StartPlace")+"' and StartPlace = '"+rsttrips.getString("EndPlace")+"' limit 1 ";
			//System.out.println(":::---SQL2----:::"+sql3);
			ResultSet rst123=st4.executeQuery(sql3);
				if(rst123.next())
				{
					totKm=rst123.getInt("Km");
				    tTime=rst123.getInt("TTime");
				}
		}
		kmrundist=kmrun2-kmrun1;  //Finding tot run km by vehicle after trip started.
		remKm=totKm-kmrundist;  // Adding todays km also
		
		myMilisec=(tTime*60*60*1000);
		if(myMilisec!=0)
		{
		//System.out.println(":::::-myMilisec-::::"+myMilisec);
      	java.util.Date resultdate = new java.util.Date();
      	java.util.Date startDtTm=rsttrips.getDate("StartDate");
      	
		//System.out.println(":::::-startDtTmOriginal-::::"+startDtTm);
		long start=startDtTm.getTime();
		long totdate= start+myMilisec;
		resultdate.setTime(totdate);
        DisDate=new SimpleDateFormat(dateformat+" HH:mm").format(resultdate);
		//System.out.println(":::::-startDtTmAftAdd-::::"+DisDate);
		}
		else{
			DisDate="NA";
		}
	}catch(Exception e11)
	{
		//System.out.println("---I am in exception--kmrundist-");
		e11.printStackTrace();
	}
	%>
	<tr>
	<td style="text-align: right"><%=j%></td>
	<td id="vehcol<%=j%>" style="text-align: left"><b><div align="left">  <%=rsttrips.getString("VehRegNo")%> </div></b></td>
	<td id="tripcol<%=j%>" style="text-align: right"><font size="2"><%=rsttrips.getString("TripId")%></font></td>
	<td align="left" id="drivcol<%=j%>"><div align="left"><%=rsttrips.getString("DriverName")+"("+rsttrips.getString("DriverCode")+")"%></div></td>
	<td id="stdatecol<%=j%>" style="text-align: right">
	<%//String sttime=
	String sttime=new SimpleDateFormat("HH:mm").format(rsttrips.getTime("StartTime"));
	String stdate=new SimpleDateFormat(dateformat).format(rsttrips.getDate("StartDate"))+" "+sttime;

	%> 
	<%=stdate	%></td>
		<td align="left" ><div align="left"><%=rsttrips.getString("OwnerName")%></div></td>
	
	<td  align="left" id="stplacecol<%=j%>"><div align="left"><%=rsttrips.getString("StartPlace")%></div></td>
	<td  align="left" id="endplacecol<%=j%>"><div align="left"><%=rsttrips.getString("EndPlace")%></div></td>
	<td  align="right" id="updtetmecol<%=j%>"><div align="left"><%=updtetime%> </div></td>
	<td  align="left" id="curposcol<%=j%>"><div align="left"><%=curpos%> </div></td>
	
	<%
		if(DisDate.equalsIgnoreCase("NA"))
		{
			%>
				<td  align="right" id="FixedTimecol<%=j%>"> <br> NA</td>
				<td  align="right" id="FixedKmcol<%=j%>"> <br>NA</td>
				
			<%
		}
		else
		{
			%>
				<td  align="right" id="FixedTimecol<%=j%>"> <br> <%=tTime%></td>
				<td  align="right" id="FixedKmcol<%=j%>"> <br> <%=totKm %></td>
				
			<%
		}
	
	%>
	
	<td align="right" id="kmsruncol<%=j%>"> <div align="right"><%=kmrundist%></div></td>  
	<%
		if(DisDate.equalsIgnoreCase("NA"))
		{
			%>
				
				<td align="right" id="kmstoruncol<%=j%>"><div align="left">NA</div></td>
			<%
		}
		else
		{
			%>
				
				<td align="right" id="kmstoruncol<%=j%>"><div align="left"><%=remKm%></div></td>
			<%
		}
	
	%>
 	
	<td align="right" id="etacol<%=j%>"><div align="left"><%=DisDate%> </div></td>
	
	</tr>
	<%
	j++;
	}
	//out.println("===end of 1st table===");
	%>
	</table>
	<p></p>
	</td>
	</tr>
	<%
	}catch(Exception ee)
	{
		//System.out.println("===HI 222 ===");
		out.print("Exception---->"+ee);
	}	
	finally
	{
		try{
			conn.close();
			con1.close();	
		}
		catch(Exception e)
		{
			
		}
		
	}
	%>
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
	</form>
	    </body>
	</html>

</jsp:useBean>
