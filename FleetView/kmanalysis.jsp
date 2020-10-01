	<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
		<script language="javascript">
	function hide(id)
	{ 
		var cnt=document.kmanalysis.totrec.value;
		if(id=="veh")
		{
			
			/*document.getElementById("vehcol").style.display='none';	
			for(var i=1;i<=cnt;i++)
			{
				document.getElementById("vehcol"+i).style.display='none';
			} */
	
			if(document.getElementById("tripcol").style.display=="") //if sign is minus
			{
				document.getElementById("tripcol").style.display='none';
				for(var i=1;i<=cnt;i++)
				{
					document.getElementById("tripcol"+i).style.display='none';
				}
		
				document.getElementById("drivcol").style.display='none';
	
				for(var i=1;i<=cnt;i++)
				{
					document.getElementById("drivcol"+i).style.display='none';
				}
	
				document.getElementById("stdatecol").style.display='none';
			
				for(var i=1;i<=cnt;i++)
				{
					document.getElementById("stdatecol"+i).style.display='none';
				}
		
				document.getElementById("stplacecol").style.display='none';
		
				for(var i=1;i<=cnt;i++)
				{
					document.getElementById("stplacecol"+i).style.display='none';
				}
		
				document.getElementById("endplacecol").style.display='none';
		
				for(var i=1;i<=cnt;i++)
				{
					document.getElementById("endplacecol"+i).style.display='none';
				}
	
				document.getElementById("img11").src='images/plus.jpg';
			}
			else
			{
				document.getElementById("tripcol").style.display="";
				for(var i=1;i<=cnt;i++)
				{
					document.getElementById("tripcol"+i).style.display="";
				}
	
				document.getElementById("drivcol").style.display="";
	
				for(var i=1;i<=cnt;i++)
				{
					document.getElementById("drivcol"+i).style.display="";
				}
	
				document.getElementById("stdatecol").style.display="";
			
				for(var i=1;i<=cnt;i++)
				{
					document.getElementById("stdatecol"+i).style.display="";
				}
		
				document.getElementById("stplacecol").style.display="";
		
				for(var i=1;i<=cnt;i++)
				{
					document.getElementById("stplacecol"+i).style.display="";
				}
		
				document.getElementById("endplacecol").style.display="";
		
				for(var i=1;i<=cnt;i++)
				{
					document.getElementById("endplacecol"+i).style.display="";
				}
	
				document.getElementById("img11").src='images/sub.jpg';
			}
		}
	
		if(id=="trip")
		{
			 document.getElementById("tripcol").style.display='none';
			for(var i=1;i<=cnt;i++)
			{
				document.getElementById("tripcol"+i).style.display='none';
			} 
				
			
		}	
	
		if(id=="driv")
		{
			document.getElementById("drivcol").style.display='none';
	
			for(var i=1;i<=cnt;i++)
			{
				document.getElementById("drivcol"+i).style.display='none';
			}
		}
	
		if(id=="stdate")
		{
			document.getElementById("stdatecol").style.display='none';
	
			for(var i=1;i<=cnt;i++)
			{
				document.getElementById("stdatecol"+i).style.display='none';
			}
		}
		
		if(id=="stplace")
		{
			document.getElementById("stplacecol").style.display='none';
	
			for(var i=1;i<=cnt;i++)
			{
				document.getElementById("stplacecol"+i).style.display='none';
			}
		}
	
		
		if(id=="endplace")
		{
			document.getElementById("endplacecol").style.display='none';
	
			for(var i=1;i<=cnt;i++)
			{
				document.getElementById("endplacecol"+i).style.display='none';
			}
		}
	
		if(id=="eta")
		{
			document.getElementById("etacol").style.display='none';
			for(var i=1;i<=cnt;i++)
			{
				document.getElementById("etacol"+i).style.display='none';
			}
	
			
		}
	
		if(id=="fuelcons")
		{
			/*document.getElementById("fuelconscol").style.display='none';
			for(var i=1;i<=cnt;i++)
			{
				document.getElementById("fuelconscol"+i).style.display='none';
			} */
	
			if(document.getElementById("loaddelcol").style.display=="")
			{
				document.getElementById("loaddelcol").style.display='none';
		
				for(var i=1;i<=cnt;i++)
				{
					document.getElementById("loaddelcol"+i).style.display='none';
				}
	
				document.getElementById("trantmecol").style.display='none';
		
				for(var i=1;i<=cnt;i++)
				{
					document.getElementById("trantmecol"+i).style.display='none';
				}
			
				document.getElementById("img3").src='images/plus.jpg';
			}
			else
			{
				document.getElementById("loaddelcol").style.display="";
		
				for(var i=1;i<=cnt;i++)
				{
					document.getElementById("loaddelcol"+i).style.display="";
				}
	
				document.getElementById("trantmecol").style.display="";
		
				for(var i=1;i<=cnt;i++)
				{
					document.getElementById("trantmecol"+i).style.display="";
				}
			
				document.getElementById("img3").src='images/sub.jpg';
			}
	
			
		}
	
		if(id=="kmstorun")
		{
			document.getElementById("kmstoruncol").style.display='none';
	
			for(var i=1;i<=cnt;i++)
			{
				document.getElementById("kmstoruncol"+i).style.display='none';
			}
		}
		
		if(id=="kmsrun")
		{ 
			/*document.getElementById("kmsruncol").style.display='none';
			for(var i=1;i<=cnt;i++)
			{
				document.getElementById("kmsruncol"+i).style.display='none';
			} */
	
			if(document.getElementById("kmstoruncol").style.display=="")
			{
				document.getElementById("kmstoruncol").style.display='none';
	
				for(var i=1;i<=cnt;i++)
				{
					document.getElementById("kmstoruncol"+i).style.display='none';
				}
		
				document.getElementById("etacol").style.display='none';
		
				for(var i=1;i<=cnt;i++)
				{
					document.getElementById("etacol"+i).style.display='none';
				}
			
				document.getElementById("img2").src='images/plus.jpg';
			}
			else
			{
				document.getElementById("kmstoruncol").style.display="";
	
				for(var i=1;i<=cnt;i++)
				{
					document.getElementById("kmstoruncol"+i).style.display="";
				}
		
				document.getElementById("etacol").style.display="";
		
				for(var i=1;i<=cnt;i++)
				{
					document.getElementById("etacol"+i).style.display="";
				}
					
				document.getElementById("img2").src='images/sub.jpg';
			}
		}
	
		if(id=="loaddel")
		{
			document.getElementById("loaddelcol").style.display='none';
		
			for(var i=1;i<=cnt;i++)
			{
				document.getElementById("loaddelcol"+i).style.display='none';
			}
		}
	
		if(id=="curpos")
		{
			document.getElementById("curposcol").style.display='none';
	
			for(var i=1;i<=cnt;i++)
			{
				document.getElementById("curposcol"+i).style.display='none';
			}
		}
	
		if(id=="updtetme")
		{
			document.getElementById("updtetmecol").style.display='none';
	
			for(var i=1;i<=cnt;i++)
			{
				document.getElementById("updtetmecol"+i).style.display='none';
			}
		}
	
		if(id=="trantme")
		{
			document.getElementById("trantmecol").style.display='none';
	
			for(var i=1;i<=cnt;i++)
			{
				document.getElementById("trantmecol"+i).style.display='none';
			}
		}
	}
	
	function ShowAll()
	{ 
		var cnt=document.kmanalysis.totrec.value;
	
		document.getElementById("vehcol").style.display="";	
		for(var i=1;i<=cnt;i++)
		{
			document.getElementById("vehcol"+i).style.display="";
		}	
	
		document.getElementById("tripcol").style.display="";
		for(var i=1;i<=cnt;i++)
		{
			document.getElementById("tripcol"+i).style.display="";
		}
	
		document.getElementById("drivcol").style.display="";
		for(var i=1;i<=cnt;i++)
		{
			document.getElementById("drivcol"+i).style.display="";
		}
	
		document.getElementById("stdatecol").style.display="";
		for(var i=1;i<=cnt;i++)
		{
			document.getElementById("stdatecol"+i).style.display="";
		}
	
		document.getElementById("stplacecol").style.display="";
		for(var i=1;i<=cnt;i++)
		{
			document.getElementById("stplacecol"+i).style.display="";
		}
	
		document.getElementById("endplacecol").style.display="";
		for(var i=1;i<=cnt;i++)
		{
			document.getElementById("endplacecol"+i).style.display="";
		}
	
		document.getElementById("etacol").style.display="";
		for(var i=1;i<=cnt;i++)
		{
			document.getElementById("etacol"+i).style.display="";
		}
	
		document.getElementById("fuelconscol").style.display="";
		for(var i=1;i<=cnt;i++)
		{
			document.getElementById("fuelconscol"+i).style.display="";
		}
	
		document.getElementById("kmstoruncol").style.display="";
		for(var i=1;i<=cnt;i++)
		{
			document.getElementById("kmstoruncol"+i).style.display="";
		}
	
		document.getElementById("kmsruncol").style.display="";
		for(var i=1;i<=cnt;i++)
		{
			document.getElementById("kmsruncol"+i).style.display="";
		}
	
		document.getElementById("loaddelcol").style.display="";
		for(var i=1;i<=cnt;i++)
		{
			document.getElementById("loaddelcol"+i).style.display="";
		}
	
		document.getElementById("curposcol").style.display="";
		for(var i=1;i<=cnt;i++)
		{
			document.getElementById("curposcol"+i).style.display="";
		}
	
		document.getElementById("updtetmecol").style.display="";
		for(var i=1;i<=cnt;i++)
		{
			document.getElementById("updtetmecol"+i).style.display="";
		}
	
		document.getElementById("trantmecol").style.display="";
		for(var i=1;i<=cnt;i++)
		{
			document.getElementById("trantmecol"+i).style.display="";
		}
	
		document.getElementById("img11").src='images/sub.jpg';
		document.getElementById("img2").src='images/sub.jpg';
		document.getElementById("img3").src='images/sub.jpg';	
	}
	</script>
	
	<html>
	<head>
	<title>Vehicle Tracking System</title>
	</head>
	<body bgcolor="lightyellow">
	<table border="0" cellspacing="0" cellpadding="0" width="100%">
	        <tr>
	         <td width="1%" height="2"> <img src="images/fboxtopleft.gif" width="20" height="12" alt="bk"/> </td>
	        	  <td class="fboxtop">  <img src="images/spacer.gif" width="2" height="2" alt=" " /></td>
	           <td width="1%" height="2"><img src="images/fboxtopright.gif" width="20" height="12" alt="bk"/></td> 
	        </tr> 
	        <tr>
	       
	        <td width="1%" class="fboxleft"><img src="images/spacer.gif" width="2" height="2" alt=" "/></td>
	
	           <td width="98%" class="featureboxbg">
				<!-- header file -->
				<%@ include file="headernew.jsp" %> 
				<!-- header file -->
	          </td>
	          <td width="1%" class="fboxright" ><img src="images/spacer.gif" width="2" height="2" alt=" "/></td>
	        </tr>
	<!--   <tr>
	            <td width="1%" class="featureboxbg"><img src="images/fboxmiddleleft.gif" width="20" height="5" alt="bk" /></td>
	             <td width="98%" class="fboxmiddle"><img src="images/spacer.gif" width="2" height="2" alt=" " />  </td>
	          <td width="1%" class="featureboxbg"> <img src="images/fboxmiddleright.gif" width="20" height="5" alt="bk" /> </td>
	        </tr>
	        
	-->
	        <tr>
	         <td class="fboxlowleft">&nbsp;</td> 
	          <td>
				<!-- body part come here -->
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
		//out.println(today);
		//out.println("currenttime---->"+currenttime);
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
		 
	<table border="0" align="center" align="top" width="100%">
	<tr>
	<td  valign="top">
	<table class="stats">
	<tr>
	<td colspan="16"><b>
	<font face="Arial" color="black" size="3">KM Analysis Report for Open Trips</font></b>
	<div align="left"> <a href="#" onClick="hide('veh');" title="Click to hide TripId,Driver,StartDate,StartPlace,EndPlace Cols"><img id="img11" src="images/sub.jpg" width="13px" height="10px" border="0"> </a> Hide Columns
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
	</div><div align="right">
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
	<th> Sr </th>
	<th id="vehcol"><B>Vehicle</B></th> 
	<th id="tripcol">  <br> <B> TripID</B></th>
	<th id="drivcol">  <br> <B> Driver</B></th>
	<th id="stdatecol" >  <br> <B>Start Date-Time</B></th>
		<th id="" > <br> <B> Transporter</B></th>
	
	<th id="stplacecol" > <br> <B> Start Place</B></th>
	<th id="endplacecol">  <br> <B> End Place</B></th>
	<th id="updtetmecol"> <br> <B>Updated Dat-Time</B></th>
	<th id="curposcol" > <br> <B>Current Position</B></th>
	<th id="FixedTimecol"> <br> <B>FixedTime</B></th>
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
				
				updtetime=new SimpleDateFormat(dateformat).format(new SimpleDateFormat("yyyy-MM-dd").parse(rs1.getString("TheDate")))+" "+new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rs1.getString("TheTime"))); //rs1.getString("TheTime");
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
		  //45044
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
			
		//	System.out.println(":::---SQL2----:::"+sql3);
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
	<td id="vehcol<%=j%>" style="text-align: left"><div align="left">  <%=rsttrips.getString("VehRegNo")%> </div></td>
	<td id="tripcol<%=j%>" style="text-align: right"><font face="Arial" size="2"><%=rsttrips.getString("TripId")%></font></td>
	<td id="drivcol<%=j%>"><div align="left"><%=rsttrips.getString("DriverName")+"("+rsttrips.getString("DriverCode")+")"%></div></td>
	<%//String sttime=
	String sttime=new SimpleDateFormat("HH:mm").format(rsttrips.getTime("StartTime"));
	String stdate=new SimpleDateFormat(dateformat).format(rsttrips.getDate("StartDate"))+" "+sttime;
	%>
	<td id="stdatecol<%=j%>" style="text-align: right;"><%=stdate %>
	</td>
	<td><div align="left"><%=rsttrips.getString("OwnerName")%></div></td>
	<td id="stplacecol<%=j%>"><div align="left"><%=rsttrips.getString("StartPlace")%></div></td>
	<td id="endplacecol<%=j%>"><div align="left"><%=rsttrips.getString("EndPlace")%></div></td>
	<td id="updtetmecol<%=j%>"><div align="right"><%=updtetime%> </div></td>
	<td id="curposcol<%=j%>"><div align="left"> 
	<a href="shownewmap.jsp?lat=<%=lat%>&long=<%=lon%>&discription=<%="<b>" + vehno + "</b><br>"%><%=curpos%>" onclick="popWin = open('shownewmap.jsp?lat=<%=lat%>&long=<%=lon%>&discription=<%="<b>" + vehno + "</b><br>"%><%=curpos%>','myWin','width=500,height=500');popWin.focus();return false">
	<%=curpos%> </div></td>
	<%
		if(DisDate.equalsIgnoreCase("NA"))
		{
			%>
				<td id="FixedTimecol<%=j%>" align="left"><div align="right"> <br> NA</div></td>
				<td id="FixedKmcol<%=j%>" align="left"><div align="right"> <br>NA</div></td>
				
			<%
		}
		else
		{
			%>
				<td id="FixedTimecol<%=j%>" align="right"><div align="right"> <br> <%=tTime%></div></td>
				<td id="FixedKmcol<%=j%>" align="right"> <div align="right"><br> <%=totKm %></div></td>
				
			<%
		}
	
	%>
	
	<td id="kmsruncol<%=j%>"> <div align="right"><%=kmrundist%></div></td>  
	<%
		if(DisDate.equalsIgnoreCase("NA"))
		{
			%>
				
				<td id="kmstoruncol<%=j%>"><div align="right">NA</div></td>
			<%
		}
		else
		{
			%>
				
				<td id="kmstoruncol<%=j%>"><div align="right"><%=remKm%></div></td>
			<%
		}
	
	%>
 	
	<td id="etacol<%=j%>"><div align="right"><%=DisDate%> </div></td>
	
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
	<tr><td>
	<table class="" align="center" align="top" width="100%" >
	<br></br>
	<tr>

	<td colspan="15"><b><font face="Arial" color="black" size="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The Kilometer Analysis Report</font></b></td></tr><tr><td>
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	
	<div align="right">
	<a href="#" onclick="javascript:window.open('printkmanalysis.jsp');" title="Print Report">
			<img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
			<a href="excelkmanalysis.jsp" title="Export to Excel">
			<img src="images/excel.jpg" width="15px" height="15px">
			</a>
	&nbsp;&nbsp;&nbsp;&nbsp;<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%></div>  
	</td>
	</tr>
	</table>
	<table class="sortable">
	<tr>
	<td class="hed">Sr</td>
	<td class="hed">Vehicle</td>
		<td class="hed">Transporter</td>
	
	<td class="hed">
	<% 
		if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
		{
	%> 		<br>Miles Today</br> (<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(today))%>)
	<%		}else
	{ 
		%>	<br>Km. Today</br>  (<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(today))%>)
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
	 		<br>Miles This Month <br> (<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(lastmonth))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(today))%>)
	<%		}else
	{ 
		%>	Km. This Month <br> (<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(lastmonth))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(today))%>) 
	<% } %>

	</td>
	</tr>
	<%
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
		//System.out.println("---vehcode--->"+vehcode);
	%>
		<tr>
		<td style="text-align: right"><%=i%></td>
		<td><div align="left"><%=rst.getString("VehicleRegNumber")%></font></td>
				<td><div align="left"><%=rst.getString("OwnerName")%></font></td>
		
		<td style="text-align: right"><div>
		<% 
		//System.out.println("vehicle code===>"+rst.getString("VehicleCode"));
		//report for today
		try{
			sql="select Distance from t_veh"+rst.getString("VehicleCode")+" where TheFieldDataDate ='"+today+"'  and TheFiledTextFileName='SI' order by TheFieldDataTime asc limit 1";
			//System.out.println("---2---sql--->"+sql);
			ResultSet rstkm1=st1.executeQuery(sql);
			//System.out.println("---3---");
			if(rstkm1.next())
			{
				//System.out.println("---4---");
				km1=rstkm1.getInt("Distance");
			}
			//System.out.println("---5---");
			sql="select Distance from t_veh"+rst.getString("VehicleCode")+" where TheFieldDataDate ='"+today+"'  and TheFiledTextFileName='SI' order by TheFieldDataTime desc limit 1";
			//System.out.println("---6---sql--->"+sql);
			ResultSet rstkm2=st5.executeQuery(sql);
			//System.out.println("---7---");
			if(rstkm2.next())
			{
				//System.out.println("---8---");
				km2=rstkm2.getInt("Distance");
				//System.out.print("---====km2--->"+km2);
			}
			//System.out.println("---9---");
			km3=km3+(km2-km1); 
			
			todaysdist=km2-km1;
			//System.out.println("---10---");
		%>
		<%
		if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
		{%>
			<%= (int)fleetview.KM_TO_MILES1(todaysdist) %>
		<% 
		}else
			{
		%>
			<%= todaysdist %>
		<%
			}
		%>
		</div> </td>
		<% 
		}catch(Exception ee1){
			//System.out.println("----I am in today---");
			ee1.printStackTrace();
		}%>
		<td><div align="right">
		<% 
			////report for week
		try{
			Format formatter = new SimpleDateFormat("yyyy-MM-dd");
			java.util.Date tdydte1 = new java.util.Date();
			long ms=tdydte1.getTime();
			ms=ms-1000 * 60 * 60 *24;
			tdydte1.setTime(ms);
			String onedaybfre = formatter.format(tdydte1);
			sql2="select sum(Distance) as distlastweek from t_veh"+vehcode+"_ds where TheDate between '"+lastweek+"' and '"+onedaybfre+"' ";
			//sql2="select sum(Distance) from t_veh"+vehcode+"_ds where TheDate between '"+lastweek+"' and '"+onedaybfre+"' order by concat(TheFieldDataDate, TheFieldDataTime) desc limit 1";
			//System.out.print("---=in week===sql2--->"+sql2);
			rs2=st3.executeQuery(sql2);	
			if(rs2.next())
			{
				km4=rs2.getInt("distlastweek");
				//System.out.println("\nKm4===>"+km4);
			}
			km4=km4+(km2-km1);// Adding todays km also
			//System.out.println("\nKm4=after addiing==>"+km4);
				if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
			{
				out.print((int)fleetview.KM_TO_MILES1(km4));
			}
			else
			{
				out.print(km4);
			}
			km6=km6+km4; // adding total kms
		%>
		</div></td>
		
		<td>
	<div align="right">
		<% //report for month
			sql="select sum(Distance) as distlastmnth from t_veh"+vehcode+"_ds where TheDate between '"+lastmonth+"' and '"+onedaybfre+"' ";
			//out.print("sql===km7==distlastweek=>"+sql);
			ResultSet rstkm7=st4.executeQuery(sql);
			if(rstkm7.next())
			{
				km7=rstkm7.getInt("distlastmnth");
				//System.out.println("-km7==distlastmnth---->"+km7);
			}
				km7=km7+(km2-km1);// Adding todays km also
				if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
				{
					out.print((int)fleetview.KM_TO_MILES1(km7));
				}
				else
				{
					out.print(km7);
				}
				//System.out.println("  ==== km7=km7+(km2-km1)===> "+km7);
				km9=km9+km7; //adding total kms
		%>
		</div></td>	
		</tr>	
		<%
		}catch(Exception ee1){
			//System.out.println("----I am in week and mon loop---");
			ee1.printStackTrace();
			out.print("Exception---->"+ee1);
		}	
		i++;
		}
		%>
		
	<tr>
	<td colspan="3" ><div align="left">Total:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></div></td>
	<%
	//System.out.println("session.getAttribute(distformat)----->" + session.getAttribute("distformat"));
	if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
	{%>
	<td  width="100"><div align="right"><b><%=(int)fleetview.KM_TO_MILES1(km3) %>;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></div></td>
	<td ><div align="right"><b><%=(int)fleetview.KM_TO_MILES1(km6)%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></div></td>
	<td ><div align="right"><b><%=(int)fleetview.KM_TO_MILES1(km9)%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></div></td>
	<%}else{ %>
	
	<td ><div align="right"><%= km3 %></div></td>
	<td ><div align="right"><%= km6%></div></td>
	<td ><div align="right"><%= km9%></div></td>
	<% } %>
	</tr>	
	</table>
	</td>
	</tr>
	</table>
	<input type="hidden" name="totrec" value="<%=j-1%>" />
	<%
	}catch(Exception ee)
	{
		//System.out.println("===HI 222 ===");
		out.print("Exception---->"+ee);
	}	
	finally
	{
		try
		{
			conn.close();
		}catch(Exception e)
		{}
		try
		{
			con1.close();
		}catch(Exception e)
		{}
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
