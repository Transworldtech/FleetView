<%@ include file="headernew.jsp" %>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/graph.js"></SCRIPT>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

%>


	<%
  response.setHeader("Cache-Control","no-cache");
  response.setHeader("Pragma","no-cache");
  response.setDateHeader ("Expires", 0);
  %>
	<script language="javascript">
	
	var renderStart = new Date().getTime();
	window.onload=function() { 
	var renderEnd=new Date().getTime();
	var elapsed = new Date().getTime()-renderStart;   
	var PageName = document.getElementById("PageName").value;
		try{var ajaxRequest;
		try{ajaxRequest = new XMLHttpRequest();	}
			catch (e)
			{
			try
			{ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");}
			catch (e)
			{try
			{ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");}
			catch (e)
			{alert("Your browser broke!");
			return false;
			}}}
			ajaxRequest.onreadystatechange = function()
			{if(ajaxRequest.readyState == 4)
			{try
			{var reslt=ajaxRequest.responseText;
			var result1;
			result1=reslt;
			result1=result1.replace(/^\s+|\s+$/g,'');
			if(result1=="Updated")
			{}
			}catch(e)
			{alert(e);
			}}};		 
			var queryString = "?PageName="+PageName+"&renderStart="+renderStart+"&renderEnd="+renderEnd+"&elapsed="+elapsed+"";
			ajaxRequest.open("GET","Ajax_PageLoadingTime.jsp" + queryString, true);
			ajaxRequest.send(null); 
			}
			   catch(e)
			{
				alert(e);
			}  
	};

	
	 function gotoPrint(divName)  
     {  
	  
	      var printContents = document.getElementById(divName).innerHTML; 
	      var originalContents = document.body.innerHTML; 
	      
	      document.body.innerHTML = printContents;  
	      window.print();
	      document.body.innerHTML = originalContents;  
     }

    function gotoExcel(elemId, frmFldId)  
     {  
	      
         var obj = document.getElementById(elemId);  
         var oFld = document.getElementById(frmFldId); 
         
         oFld.value = obj.innerHTML;  
         document.DriverRatingReport.action ="excel.jsp";
         document.forms["DriverRatingReport"].submit();
     } 
	</script>
	<%
	//String fromdate11,todate11;
	NumberFormat nf = DecimalFormat.getInstance();
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2); 
	%>
	
	<%!
	Connection connnew=null;
	Statement st, st1, st2,st3,st4;
	String user,sql,sql1,sql2;
	String data1, data2,showdate1,showdate,DriverName,Owner,datenew1,datenew2,transporter;
	int OScount, RAcount, RDcount,Distance,DisconnectedCount,DisconnectedKm,osinred,osinyellow,osingreen;
	double Rating;
	double rating1=0.00,rating=0.00;
	 %>
	<%
	try{
	transporter=request.getParameter("Oname");
	data1=request.getParameter("data1");
	data2=request.getParameter("data2");
	user=session.getAttribute("user").toString();
	System.out.println("user--->"+user);
	//out.println("Oname--->"+transporter);
	//out.println("data1---->"+data1);
	System.out.println("transporter--->"+transporter);
	datenew1=request.getParameter("data1");
	datenew2=request.getParameter("data2");
	
	String Transporter=session.getAttribute("usertypevalue").toString();
	String GPName=session.getAttribute("TypeofUser").toString();
	
	//out.println("transporter--->"+transporter);
	System.out.println("Transporter "+Transporter);
	System.out.println("GPName "+GPName);
	
	//	Class.forName(MM_dbConn_DRIVER); 
		connnew = fleetview.ReturnConnection();
		//conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		st=connnew.createStatement();
		st1=connnew.createStatement();
		st2=connnew.createStatement();
		st3=connnew.createStatement(); 
		st4=connnew.createStatement();
	%>
	<%
      String exportFileName=session.getAttribute("user").toString()+"_DriverRatingReport.xls";  
    %> 
    <table border="1" width="100%" class="stats">
    <tr><td>
	<form id="DriverRatingReport" name="DriverRatingReport" action="" method="post" >
    <div id="table1">
	<table border="0" width="100%" bgcolor="white" >
	<tr><td colspan="14" align="center"><font size="2"><b>Driver Rating Report for <%=transporter%> from date
	<%= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(datenew1))%> to <%= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(datenew2))%>. </b></font>
	<div align="right">
	<input type="hidden" id="tableHTML" name="tableHTML" value="" />  
    <input type="hidden" id="fileName" name="fileName" value="<%= exportFileName %>" /> 
	
	<a href="#" style="font-weight: bold; color: black; " onclick="gotoPrint('table1');">
    <img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img></a> 
      
    <a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('table1','tableHTML');">
    <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img></a>;
    Date : 
	<%= new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date()) %></div></td></tr>
	</table>
	<p></p>
	<table border="0" width="100%" bgcolor="white" class="sortable">
	<tr>
	<td class="hed">SR.</td>
	<td class="hed">Driver Name</td>
	<td class="hed">Driver Code</td>
	<td class="hed">Transporter</td>
	<td class="hed">OS Duration<br>(in Sec)</td>
	<td class="hed">OS Duration<br>In Red Zone<br>(in Sec)</td>
	<td class="hed">OS Duration<br>In Yellow Zone<br>(in Sec)</td>
	<td class="hed">OS Duration<br>In Green Zone<br>(in Sec)</td>
	<td class="hed">RA Count</td>
	<td class="hed">RD Count</td>
	<td class="hed">Distance</td>
	<td class="hed">Disconnected<br>Count</td>
	<td class="hed">Disconnected<br>Km</td>
	<td class="hed">Rating</td>
	</tr>
	<%
	int JCode,VehCode,RAcount,RDcount,distance,OSduration,RAcnt=0,RDcnt=0,OScnt=0,Distcnt=0,Disconncnt=0,DisconnKmcnt=0,osinred1=0,osinyellow1=0,osingreen1=0;;
	double rating;
	//double a,b,c;
	double ctr=0.0;
	double d=0.0;
	String DriverID,DriverName;
	String ll="";
	try
	{
		//sql="SELECT sum( RACount ) AS RAcount, sum( RDCount ) AS RDcount, sum( OSDuration ) AS OSDuration,sum(OSDurationInRedZone) as osinredzone,sum(OSDurationInYellowZone) as osinyellowzone,sum(OSDurationInGreenZone) as osingreenzone, DriverID, DriverName, OwnerName, Sum( KmTravelled ) AS Distance,sum(DisconnectionCount) as 'Disconnected Count',sum(DisconnectionKm) as 'Disconnected DT' FROM t_completedjourney WHERE StartDate >= '"+data1+"' AND EndDate <= '"+data2+"' AND (OwnerName LIKE 'Castrol' OR GPName LIKE 'Castrol') and OwnerName = '"+transporter+" 'GROUP BY DriverID, DriverName, OwnerName ORDER BY DriverName ASC"; 
		sql="SELECT sum( RACount ) AS RAcount, sum( RDCount ) AS RDcount, sum( OSDuration ) AS OSDuration,sum(OSDurationInRedZone) as osinredzone,sum(OSDurationInYellowZone) as osinyellowzone,sum(OSDurationInGreenZone) as osingreenzone, DriverID, DriverName, OwnerName, Sum( KmTravelled ) AS Distance,sum(DisconnectionCount) as 'Disconnected Count',sum(DisconnectionKm) as 'Disconnected DT' FROM t_completedjourney WHERE StartDate >= '"+data1+"' AND EndDate <= '"+data2+"' AND (OwnerName like '"+session.getAttribute("usertypevalue").toString()+"'  OR GPName like '"+session.getAttribute("usertypevalue").toString()+"') and OwnerName = '"+transporter+"' GROUP BY DriverID, DriverName, OwnerName ORDER BY DriverName ASC"; 
	System.out.print(sql);
//	out.println("SQL:::"+sql);
	//sql="select distinct(Dcode), avg(Rating) as Rating ,sum(Distance) as Distance from t_driver_ds where TheDate >='"+data1+"' and TheDate <='"+data2+"' and distance > 0 and Jcode <>'-' group by Dcode order by Rating,Distance desc";
	ResultSet rst=st2.executeQuery(sql);
	int i=1;
	while(rst.next())
	{
		//VehCode=rst.getInt("Vehid");
		RAcount=rst.getInt("RAcount");
		//System.out.println("RACount::"+RAcount);
		RDcount=rst.getInt("RDCount");
		//System.out.println("RDCount::"+RDcount);
		OSduration=rst.getInt("OSDuration");
		//System.out.println("OSDuration::"+OSduration);
		DriverID=rst.getString("DriverID");
		//System.out.println("DriverCode::"+DriverID);
		DriverName=rst.getString("DriverName");
		//System.out.println("DriverName::"+DriverName);
		Transporter=rst.getString("OwnerName");
		//System.out.println("Transporter::"+Transporter);
		//rating=rst.getDouble("Rating");
		distance=rst.getInt("Distance");
		System.out.println(distance);
		//System.out.println("Distance::"+distance);
		DisconnectedCount=rst.getInt("Disconnected Count");
		DisconnectedKm=rst.getInt("Disconnected DT");
		
		osinred=rst.getInt("osinredzone");
		osinyellow=rst.getInt("osinyellowzone");
		osingreen=rst.getInt("osingreenzone");
		//a=((Double.valueOf(RAcount)/distance)*100);
		//System.out.println("A::::"+a);
		//b=((Double.valueOf(RDcount)/distance)*100);
		//System.out.println("B::::"+b);
		//c=((Double.valueOf(OSduration)/10/distance)*100);
		//System.out.println("C::::"+c);
		
		%>
		<tr>
		<td class="bodyText"><div align="right"><%=i%></div></td>
		<td class="bodyText"><div align="left"><a href="trip_driver.jsp?DriverID=<%=rst.getString("DriverID")%>&DriverName=<%=rst.getString("DriverName")%>&data1=<%=data1%>&data2=<%=data2%>&Transporter=<%=rst.getString("OwnerName")%>"><%=DriverName%></a></div></td>
		<td class="bodyText"><div align="right"><%=DriverID%></div></td>
		<td class="bodyText"><div align="left"><%=Transporter%></div></td>
		<td class="bodyText"><div align="right"><%=OSduration%></div></td>
		<td class="bodyText"><div align="right"><%=osinred%></div></td>
		<td class="bodyText"><div align="right"><%=osinyellow%></div></td>
		<td class="bodyText"><div align="right"><%=osingreen%></div></td>
		<td class="bodyText"><div align="right"><%=RAcount%></div></td>
		<td class="bodyText"><div align="right"><%=RDcount%></div></td>
		<td class="bodyText"><div align="right"><%=distance%></div></td>
		<td class="bodyText"><div align="right"><%=DisconnectedCount%></div></td>
		<td class="bodyText"><div align="right"><%=DisconnectedKm%></div></td>
		<%rating=0.00;
		if(distance ==0)
		{
		//	out.print("NA");
		}
		else
		{
			rating=(((Double.valueOf(RAcount)/distance)*100)+((Double.valueOf(RDcount)/distance)*100)+((Double.valueOf(OSduration)/10/distance)*100));
			//System.out.println("RatingBeforeSubstring::"+rating);
			//ll=""+rating;
			///if(ll.length() >5)
			//{
				//ll=ll.substring(0,5);
			//}
			//out.print(ll);
			//d=Double.valueOf(ll);
			//System.out.println("RatingAfterSubstring::::"+d);
		}
		if(distance!=0)
		{
		%>
		<td class="bodyText"><div align="right"><%=nf.format(rating)%></div></td>
		<%
		}else{
		%>
		<td class="bodyText"><div align="right"><%="NA"%></div></td>
		<%	
		}
		%>
		</tr>
		<%
		i++;
		RAcnt=RAcnt+RAcount;
		//System.out.println("RACnt::::"+RAcnt);
		RDcnt=RDcnt+RDcount;
		//System.out.println("RDCnt::::"+RDcnt);
		OScnt=OScnt+OSduration;
		//System.out.println("OSCnt::::"+OScnt);
		Distcnt=Distcnt+distance;
		Disconncnt=Disconncnt+DisconnectedCount;
		DisconnKmcnt=DisconnKmcnt+DisconnectedKm;
		osinred1=osinred1+osinred;
		osinyellow1=osinyellow1+osinyellow;
		osingreen1=osingreen1+osingreen;
		//System.out.println("Distcnt::::"+Distcnt);
		//ctr=ctr+d;
		//cntrate=cntrate+rating;
		}
	if(Distcnt!=0.00)
	{
	    rating1=(((Double.valueOf(RAcnt)/Distcnt)*100)+((Double.valueOf(RDcnt)/Distcnt)*100)+((Double.valueOf(OScnt)/10/Distcnt)*100));
	}
	else{
		rating1=0;
	}
		%>
		<tr>
		<td class="bodyText" colspan="4"><div align="right"><b>Total</b></div></td>
		<td class="bodyText"><div align="right"><b><%=OScnt%></b></div></td>
		<td class="bodyText"><div align="right"><b><%=osinred1%></b></div></td>
		<td class="bodyText"><div align="right"><b><%=osinyellow1%></b></div></td>
		<td class="bodyText"><div align="right"><b><%=osingreen1%></b></div></td>	
		<td class="bodyText"><div align="right"><b><%=RAcnt%></b></div></td>
		<td class="bodyText"><div align="right"><b><%=RDcnt%></b></div></td>
		<td class="bodyText"><div align="right"><b><%=Distcnt%></b></div></td>
	    <td class="bodyText"><div align="right"><b><%=Disconncnt%></b></div></td>
	    <td class="bodyText"><div align="right"><b><%=DisconnKmcnt%></b></div></td>
		<%//rating1=0.00;
		//String  ss=""+ctr;
		//if(ss.length() >5)
		//{
			//ss=ss.substring(0,5);
		//}
		//out.print(ss);
		if(rating1!=0)
			{
			%>
				<td class="bodyText"><div align="right"><b><%=nf.format(rating1)%></b></div></td>
					
			<%}else{%>
			
				<td class="bodyText"><div align="right"><b><%="NA"%></b></div></td>
			<%		
				}
		%>
		
		</tr>
	</table>
	</div>
	</form>
	<%
	}catch(Exception e)
	{
		out.print("Exception -->"+ e);
	}
	finally
	{
		try{
			connnew.close();
		}
		catch(Exception e)
		{
			
		}
		
	}
	}catch(Exception e)
	{
		out.print("Exception -->"+ e);
	}
	finally
	{
		try
		{fleetview.closeConnection();}
		catch(Exception e)
		{}
		
	}
	%>
	<!-- code end here -->
	</td></tr>
	</table>
</jsp:useBean>	
	<%@ include file="footernew.jsp" %>
