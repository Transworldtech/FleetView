	<%@ include file="headernew.jsp" %>
	<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
	<script LANGUAGE="JavaScript1.2" SRC="js/graph.js"></script>
	<%
	fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	%>
	<%
    response.setHeader("Cache-Control","no-cache");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader ("Expires", 0);
    %>
	
	<%!Connection conn=null;
	Statement st0, st, st1, st2, st3, st4;%>
	<%
	String user,sql="",sql1=null,sql2=null,sql3=null,transporter=null,ndcnt=null;
	String fidDate=null, data1=null, data2=null,showdate=null,showdate1=null,trips=null,counDriveYesNo=null,ntDriveYesNo=null;
	int oscount=0, racount=0,rdcount=0, ndcount=0, stcount=0,cdcount=0, runDuration=0,osduration=0,osduration1=0,tpcount=0,tpcount1=0,dcount=0,dcount1=0,vcount=0, vcount1=0,mydtcount=0,mydtcount1=0,disconnectionCount=0,disconnectionKm=0;
	int oscount1=0, racount1=0,rdcount1=0, ndcount1=0, stcount1=0,cdcount1=0,transportercount=0,runDuration1=0,disconnectionCount1=0,disconnectionKm1=0;
	int osinred=0,osinred1=0,osinyellow=0,osinyellow1=0,osingreen=0,osingreen1=0;
	double rtcount=0.00,dtcount=0.00, dtcount1=0.00;
	String ss="", vv="",ownerNm="",DriverName="";
	double Accelaration1=0.00,Decelaration1=0.00,OverSpeed1=0.00;
	double rating1=0.00,rating=0.00;
	int cntos=0, cntra=0, cntrd=0, cntcr=0, cntnd=0, cntst=0,cntd=0,cntdt=0;
	NumberFormat nf = DecimalFormat.getInstance();
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2); 
	
	ss="";
	vv="";
	try
	{
		
        cntos=0;
	    cntra=0;
	    cntrd=0;
	    cntdt=0;
	    transportercount=0;
		tpcount1=0;
		oscount1=0;
		racount1=0;
		rdcount1=0;
		ndcount1=0;
		stcount1=0;
		cdcount1=0;
		runDuration1=0;
		rtcount=0.0;
		osduration1=0;
		dcount1=0;
		vcount1=0;
		mydtcount=0;
		mydtcount1=0;
		disconnectionCount=0;
		disconnectionCount1=0;
		disconnectionKm=0;
		disconnectionKm1=0;
		osinred=0;
		osinred1=0;
		osinyellow=0;
		osinyellow1=0;
		osingreen=0;
		osingreen1=0;
		
		
	 }
	 catch(Exception e)
	 {
		out.print("Exception "+e);
	 }
	String StartDate="",EndDate="",EndTime="",StartTime="",fromdate="",todate="",thedate="",thedate1="";
	String fromdate1="",todate1="";
	if(!(null==request.getParameter("data")))
	{
		fromdate1=request.getParameter("data");
		fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(fromdate1));
		todate1=request.getParameter("data1");
		todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(todate1));
		//out.print(fromdate);
	}
	else
	{
		fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		todate=fromdate;
		fromdate1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
		todate1=fromdate1;
		//out.print(todate);
	}
	
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
	          
	          document.tripReport.action ="excel.jsp";
	          document.forms["tripReport"].submit();
	      } 
 		 function validate()
  		  {
  			if(document.getElementById("data").value=="")
  			 {
  			  	alert("Please select the from date");
  				return false;
  			 }
  			if(document.getElementById("data1").value=="")
  			 {
			  	alert("Please select the to date");
  				return false;
  			 }
  			 return datevalidate();
  		  }

		 function dateformat(days)
		  {
			 if(days=='Jan')
				return(1);
			 else
				if(days=='Feb')
					return(2);
				else
					if(days=='Mar')
						return(3);
					else
						if(days=='Apr')
							return(4);
						else
							if(days=='May')
								return(5);
							else
								if(days=='Jun')
									return(6);
								else
									if(days=='Jul')
										return(7);
									else
										if(days=='Aug')
											return(8);
										else
											if(days=='Sep')
												return(9);
											else
												if(days=='Oct')
													return(10);
												else
													if(days=='Nov')
														return(11);
													else
														if(days=='Dec')
															return(12);
		   }
 		  		  
  		 function datevalidate()
		 {
		 	var date1=document.getElementById("data").value;
			var date2=document.getElementById("data1").value;
			var dm1,dd1,dy1,dm2,dd2,dy2;
			var dd11,yy11,mm1,mm2,mm11,dd22,yy22,mm22;
			dd11=date1.substring(0,2);
			dd22=date2.substring(0,2);
			mm1=date1.substring(3,6);
			mm2=date2.substring(3,6);
			mm11=dateformat(mm1);
			mm22=dateformat(mm2);
			yy11=date1.substring(7,11);
			yy22=date2.substring(7,11);
			var date=new Date();
			var month=date.getMonth()+1;
			var day=date.getDate();
			var year=date.getFullYear();
			if(yy11>year || yy22>year)
			{
				alert("selected date should not be greater than todays date");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			else if(year==yy11 && year==yy22)
			{
	  			if(mm11>month || mm22>month)
				{
					alert("selected date should not be greater than todays date");
					document.getElementById("data").value="";
					document.getElementById("data1").value="";
					document.getElementById("data").focus;
					return false;
				}
			}
			if(mm11==month && mm22==month)
			{
				if(dd11>day || dd22>day)
				{
					alert("selected date should not be greater than todays date");
					document.getElementById("data").value="";
					document.getElementById("data1").value="";
					document.getElementById("data").focus;
					return false;
				}
			}

			if(yy11 > yy22)
			{
				alert("From date year should not be greater than to date year");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			else if(year==yy11 && year==yy22)
			{
				 if(mm11>mm22)
			{
				alert("From date month should not be greater than to date month");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			}
			if(mm11==month && mm22==month) 
			{
				if(yy11==yy22)
				{
				if(dd11 > dd22)
				{
					alert("From date should not be greater than to date");
					document.getElementById("data").value="";
					document.getElementById("data1").value="";
					document.getElementById("data").focus;
					return false;
				}
				}
			}
			else
				if(yy11<yy22)
				{
					return true;
				}
			else
				if(dd11 > dd22)
			{
					if(mm11<mm22)
					{
						return true;
					}
					
				alert("From date should not be greater than to date");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			
			return true;
		}
 		</script>
	<table border="0" width="100%" >
	
	<tr><td>
	<!--Start of outer table -->
	<table class="sortable_entry">
	<form name="dateform" action="" method="get" onsubmit="return validate();">
	<tr><td><b>From</b>&nbsp;&nbsp;
	<input type="text" id="data" name="data" value="<%=fromdate1%>"  size="15" readonly/>
	 <script type="text/javascript">
	  Calendar.setup(
	    {
	      inputField  : "data",         // ID of the input field
	      ifFormat    : "%d-%b-%Y",      // the date format
	      button      : "data"       // ID of the button
	    }
	  );
	</script>
<!--	  </td><td align="left">-->
<!--	<input type="button" name="From Date" value="From Date" id="trigger" >-->
<!--	-->
<!--	</td>-->
	<td>
	<b>To</b>&nbsp;&nbsp;
	<input type="text" id="data1" name="data1" value="<%=todate1%>" size="15" readonly/>
	<script type="text/javascript">
	  Calendar.setup(
	    {
	      inputField  : "data1",         // ID of the input field
	      ifFormat    : "%d-%b-%Y",     // the date format
	      button      : "data1"       // ID of the button
	    }
	  );
	</script>
	</td>
<!--	<td align="left">-->
<!--	  <input type="button" name="To Date" value="To Date" id="trigger1" >-->
	
<!--	</td>-->
	<td><input type="submit" name="submit" id="submit" value="submit" ></td>
	</tr>
	</form>
	</table>
	<%
	String dd=request.getQueryString();
	if(dd==null)
	{
	out.print("<center class='bodyText'><b>Please select the dates to display the report</b></center>");
	}
	else
	{
	data1=request.getParameter("data");
	data2=request.getParameter("data1");
	
	user=session.getAttribute("usertypevaluemain").toString();
	%>
	
	<form id="tripReport" name="tripReport" action="" method="post" >
    <div id="table1">
	<table class="stats">
	<tr>
	<th colspan="17"><font size="2"><b>Exception Report for <%=user%> transporters from date <%
	java.util.Date ShowDate = new SimpleDateFormat("dd-MMM-yyyy").parse(data1);
	Format formatter2 = new SimpleDateFormat("dd-MMM-yyyy");
	showdate = formatter2.format(ShowDate);
	out.print(showdate);
	%> to <%
	java.util.Date ShowDate1 = new SimpleDateFormat("dd-MMM-yyyy").parse(data2);
	Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
	showdate1 = formatter1.format(ShowDate1);
	out.print(showdate1);
	%>.</b></font>
	<%
      String exportFileName=session.getAttribute("user").toString()+"_tripReport.xls";  
     %> 
   
	<div align="right">
	<input type="hidden" id="tableHTML" name="tableHTML" value="" />  
    <input type="hidden" id="fileName" name="fileName" value="<%= exportFileName %>" /> 
	
	<a href="#" style="font-weight: bold; color: black; " onclick="gotoPrint('table1');">
    <img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img></a> 
      
    <a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('table1','tableHTML');">
    <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img></a>
	<%
	  Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
	  String sdt = fmt.format(new java.util.Date());
	  out.print(sdt); 
	%></div></th></tr>
	<p></p>
	<p></p>
	</tr>
	</table>
	<table class="sortable">
	<tr>
    <td class="hed"><div ><b>SR</b></div></td>
	<td class="hed"><div ><b>Customer Name</b></div></td>
	<td class="hed"><div ><b>Trips</b></div></td>
	<td class="hed"><div ><b>Drivers</b></div></td>
	<td class="hed"><div ><b>Veh.</b></div></td>
	<td class="hed"><div ><b>OS Duration</b><br><b>(in Sec)</b></div></td>
	<td class="hed"><div ><b>OS Duration</b><br><b>In Red Zone</b><br><b>(in Sec)</b></div></td>
	<td class="hed"><div ><b>OS Duration</b><br><b>In Yellow Zone</b><br><b>(in Sec)</b></div></td>
	<td class="hed"><div ><b>OS Duration</b><br><b>In Green Zone</b><br><b>(in Sec)</b></div></td>
	<td class="hed"><div ><b>RA</b></div></td>
	<td class="hed"><div ><b>RD</b></div></td>
	<td class="hed"><div ><b>DT</b></div></td>
	<td class="hed"><div ><b>CD</b></div></td>
	<td class="hed"><div ><b>ND</b></div></td>
	<td class="hed"><div ><b>Disconnected<br>Count</b></div></td>
	<td class="hed"><div ><b>Disconnected<br>Km</b></div></td>
	<td class="hed"><div ><b>Rating</b></div></td>
	
	</tr>
		<%int i=0;
		try{
			
			//Class.forName(MM_dbConn_DRIVER); 
			conn = fleetview.ReturnConnection();
			
			st=conn.createStatement();
			st0=conn.createStatement();
			st1=conn.createStatement();
			
			
			sql="select OwnerName,DriverID,DriverName,count(distinct(TripId)) as tpcount,DriverName, count(distinct(VehId)) as vcount ,count(distinct(DriverId)) as dcount, sum(OSDuration) as osduration,sum(OSDurationInRedZone) as osinredzone,sum(OSDurationInYellowZone) as osinyellowzone,sum(OSDurationInGreenZone) as osingreenzone, sum(RACount) as racount,sum(RDCount) as rdcount ,sum(KmTravelled) as dist, NDCount as ndcount ,CRCount as crcount,sum(DisconnectionCount) as 'Disconnection Count',sum(DisconnectionKm) as 'Disconnection DT' from t_completedjourney where (OwnerName like '"+session.getAttribute("usertypevalue").toString()+"'  OR GPName like '"+session.getAttribute("usertypevalue").toString()+"' ) and StartDate between '"+fromdate+"' and '"+todate+"'  group by Ownername  " ;
			//out.println(sql);
			ResultSet rst=st0.executeQuery(sql);
				while(rst.next())
				{
					//System.out.println("===In rst==");
					racount=rst.getInt("racount");
					racount1+=rst.getInt("racount");
					DriverName=rst.getString("DriverName");
					
					rdcount=rst.getInt("rdcount");
					rdcount1+=rst.getInt("rdcount");
					
					counDriveYesNo=rst.getString("crcount");
					
					ntDriveYesNo=rst.getString("ndcount");
					
					mydtcount=rst.getInt("dist");
					
					mydtcount1+=rst.getInt("dist");
					
					tpcount=rst.getInt("tpcount");
					tpcount1+=rst.getInt("tpcount");
					
					dcount=rst.getInt("dcount");
					dcount1+=rst.getInt("dcount");
					
					vcount=rst.getInt("vcount");
					vcount1+=rst.getInt("vcount");
					
					osduration=rst.getInt("osduration");
					osduration1+=rst.getInt("osduration");
					
					osinred=rst.getInt("osinredzone");
					osinred1+=rst.getInt("osinredzone");
					
					osinyellow=rst.getInt("osinyellowzone");
					osinyellow1+=rst.getInt("osinyellowzone");
					
					osingreen=rst.getInt("osingreenzone");
					osingreen1+=rst.getInt("osingreenzone");
					
					ownerNm=rst.getString("OwnerName");
					
					String drivId=rst.getString("DriverID");
				String	DriverNm=rst.getString("DriverName");
				
				disconnectionCount=rst.getInt("Disconnection Count");
				disconnectionCount1+=rst.getInt("Disconnection Count");
				
				disconnectionKm=rst.getInt("Disconnection DT");
				disconnectionKm1+=rst.getInt("Disconnection DT");
				i++;
				int ss5=rst.getInt("NDCount");
				cntnd+=rst.getInt("NDCount");
					
			%>
			<tr>
		<td ><div align="right"><%=i%></div></td>
			<!--<td ><div align="left"><%//=ownerNm%></div></td>--> 
			 <td ><div align="left"><a href="trip_driver_transporter.jsp?data1=<%=fromdate%>&data2=<%=todate%>&Oname=<%=rst.getString("OwnerName")%>"><%=ownerNm%></a></div></td> 
			<td ><div align="right"><%=tpcount%></div></td>
			<td ><div align="right"><%=dcount%></div></td>
			<td ><div align="right"><%=vcount%></div></td>
			<td ><div align="right"><%=osduration%></div></td>
			<td ><div align="right"><%=osinred%></div></td>
			<td ><div align="right"><%=osinyellow%></div></td>
			<td ><div align="right"><%=osingreen%></div></td>
			<td ><div align="right"><%=racount%></div></td>
			<td ><div align="right"><%=rdcount%></div></td>
			<td ><div align="right"><%=mydtcount%></div></td>
			
			<td ><div align="right">
			<%
			
			String ss2=rst.getString("CRCount");
			if(ss2.equals("Yes"))
			{
				cntra=cntra++;
				out.print(""+ss2);
			}
			else
			{
				out.print(""+ss2);
			}
			%>
	</div></td>
			
			<td ><div align="right"><%=ss5%>	
			<%/*
				int ss5=rst.getInt("NDCount");
				//if(ss5.equals("Yes"))
				if(ss5>0)
				{	cntnd=cntnd+1;
					out.print(ss5);
				}
				else
				{
					out.print(ss5);
				}*/
			%> 
   </div></td>
            <td ><div align="right"><%=disconnectionCount%></div></td>
			<td ><div align="right"><%=disconnectionKm%></div></td>
			<%	
			/************ code for rating calculation ****************/
			 dtcount = Double.valueOf(mydtcount);
			 rating=0.00;
			if(dtcount!=0.00)
			{
				//rating=((racount/dtcount)*100)+((rdcount/dtcount)*100)+((osduration/10/dtcount)*100);
				rating=(((Double.valueOf(racount)/dtcount)*100)+((Double.valueOf(rdcount)/dtcount)*100)+((Double.valueOf(osduration)/10/dtcount)*100));
				//System.out.println("=====rating===dtcount!=0=="+rating);
			}
			else 
			{
				rating=0;
				//System.out.println("=====rating===dtcount=0=="+rating);
			}
			if(dtcount!=0.00)
			{
			%>
			<td ><div align="right"><%=nf.format(rating)%>
			<%
			}else{
			%>
			<td ><div align="right"><%="NA"%>
			<%	
			}//ss+=ownerNm+",";
			 %>
			</div></td>
			
			</tr>
			<%
			} //end of rst while
				//i++;
		
				//i++;
				
			%>
			<tr>
			<td><div  align="right"></div></td>
			<td><div  align="right">Total</div></td>
			<td><div  align="right"><%=tpcount1%></div></td>
			<td><div  align="right"><%=dcount1%></div></td>
			<td><div  align="right"><%=vcount1%></div></td>
			<td><div  align="right"><%=osduration1%></div></td>
			<td><div  align="right"><%=osinred1%></div></td>
			<td><div  align="right"><%=osinyellow1%></div></td>
			<td><div  align="right"><%=osingreen1%></div></td>
			<td><div  align="right"><%=racount1%></div></td>
			<td><div  align="right"><%=rdcount1%></div></td>
			<td><div  align="right"><%=mydtcount1%></div></td>
			<td><div  align="right">
			<%	Accelaration1=0;
			Decelaration1=0;
			OverSpeed1=0;
			
				if((racount1 != 0) && (mydtcount1 > 0))
				{
					//out.print("in acc Accelaration1===>");
				Accelaration1=((double)racount1/(double)mydtcount1)*100;
				//out.print("Accelaration1===>"+Accelaration1);
				}
				if((rdcount1 != 0) && (mydtcount1 > 0))
				{
				//out.print("in acc Decelaration1===>");
				Decelaration1=((double)rdcount1/(double)mydtcount1)*100;
				//out.print("Decelaration1===>"+Decelaration1);
				}
				if((osduration1 != 0) && (mydtcount1> 0))
				{
					//out.print("in acc osduration1===>");
				OverSpeed1 =(((double)osduration1/10)/(double)mydtcount1)*100;
				//out.print("OverSpeed1===>"+OverSpeed1);
				}
			//	Rating1=Accelaration1+Decelaration1+OverSpeed1;
				
				if(cntcr>0)
				{
					out.print("Yes");
				}
				else
				{
					out.print("No");
				}
			%>
			 </div></td>
			<td><div  align="right"><%=cntnd%></div></td>
			<%

				/*if(cntnd>0)
				{
					out.print("Yes");
				}
				else
				{
					out.print("No");
				}*/
			%>
			</div></td>
			<td><div  align="right"><%=disconnectionCount1%></div></td>
		    <td><div  align="right"><%=disconnectionKm1%></div></td>
				<%
				 dtcount1 = Double.valueOf(mydtcount1);
					/************ code for rating calculation ****************/
			 rating1=0.00;
			if(dtcount1!=0.00)
			{
				//rating1=((racount1/dtcount1)*100)+((rdcount1/dtcount1)*100)+((osduration1/10/dtcount1)*100);
				rating1=(((Double.valueOf(racount1)/dtcount1)*100)+((Double.valueOf(rdcount1)/dtcount1)*100)+((Double.valueOf(osduration1)/10/dtcount1)*100));
				
				//System.out.println("=====rating===dtcount!=0=="+rating);
			}
			else 
			{
				rating1=0;
				//System.out.println("=====rating===dtcount=0=="+rating);
			}
			
			if(dtcount1!=0.00)
			{
			%>
				<td><div align="right"><%=nf.format(rating1)%>
					
			<%}else{%>
			
				<td ><div align="left"><%="NA"%>
			<%		
				}
			String str=""+rating1;
				ss+=ownerNm+",";
			 	vv+=str+",";
			 %>
		
		</div></td>
		
					
			</tr>
			<%
	if(vv.length()>=2)
	{
		vv=vv.substring(0,vv.length()-1);
	}
	else
	{
		vv="-";
	}
	if(ss.length()>=2)
	{
		ss=ss.substring(0,ss.length()-1);
	}
	else
	{
		ss="-";
	}
	
			}catch(Exception e)
			{
			out.print("Exception "+e);
			}
			finally
			{	try{conn.close();}
				catch(Exception e)
				{}
			try
			{
			fleetview.closeConnection();
			}catch(Exception e)
			{
			}

			}
		
			%>
	</table>
	
	
	</td></tr>
	
	</table>
	<!--Start Code for the Graph -->
	<tr><td >
	<table border="0" width="100%">
	<tr><td valign="top" colspan="2">
	<SCRIPT LANGUAGE="JavaScript">
	if(parseInt(navigator.appVersion) >= 4) {
	var q = new Graph(200,200);
	q.scale = 1;
	q.title = "Average Rating for all transporter";
	q.yLabel = "Exceptions";
	q.xLabel = "<%=showdate%> to <%=showdate1%>";
	q.setXScale("",1);
	<%
	String osp,rax,rdx,rat;
	osp=""+OverSpeed1;
	//out.print("OverSpeed1---osp--->"+osp);
	
	rax=""+Accelaration1;
	//out.print("Accelaration1---rax--->"+rax);
	
	rdx=""+Decelaration1;
	//out.print("Decelaration1--rdx--->"+rdx);
	
	rat=""+rating1;
	//out.print("rating1---rat--->"+rat);
	
	if(osp.length() >5)
	{
	osp=osp.substring(0,5);
	}
	if(rax.length() >5)
	{
	rax=rax.substring(0,5);
	}
	if(rdx.length() >5)
	{
	rdx=rdx.substring(0,5);
	}
	if(rat.length() >5)
	{
	rat=rat.substring(0,5);
	}
	%>
	q.setLegend('Over Speed (<%=osp%>)','Rapid Accelaration (<%=rax%>)','Rapid Decelaration (<%=rdx%>)','Rating (<%=rat%>)');
	q.addRow(<%=OverSpeed1%>);
	q.addRow(<%=Accelaration1%>);
	q.addRow(<%=Decelaration1%>);
	q.addRow(<%=rating1%>);
	q.build();
	} else {
	  document.writeln("<IMG ALT=\"Upgrade to Communicator!\" SRC=\"exb4.gif\">");
	}
	
	</SCRIPT>
	</td></tr><tr>
	<td  valign="top">
	<SCRIPT LANGUAGE="JavaScript">
	
	//if(parseInt(navigator.appVersion) >= 4) {
	//var a = new Graph(250,200);
	//a.scale = 2;
	//a.title = "Rating Graph";
	//a.yLabel = "Rating";
	//a.xLabel = "Transporters";
	//a.setXScale("",1);
	//a.setLegend("Rating");
	//a.addRow(<%//=vv%>);
	//a.build();
	//} else {
	  //document.writeln("<IMG ALT=\"Upgrade to Communicator!\" SRC=\"exb5.gif\">");
	//}
	</SCRIPT>
	
	</td>
	<td  valign="bottom" >
	<BLOCKQUOTE>
	
	<SCRIPT LANGUAGE="JavaScript">
	if(parseInt(navigator.appVersion) >= 4) {
	var str="<%=ss%>";
	
	var str1="<%=vv%>";
	
	//var vv=str1.split(",");
	//var ss=str.split(",");
	
	//document.writeln("<b>Transporters</b><br>");
	//for(i=0; i< ss.length; i++)
	//{
	//document.writeln(i +". "+ss[i]+" ("+vv[i]+")<br>");
	//}
	}
	</SCRIPT>
	
	</BLOCKQUOTE>
	</td>
	</tr></table>
	<!--End Code for the Graph -->
	
	<!--end of outer table -->
	<%
	
	}
	
	%>
	</td></tr>

	</jsp:useBean>
<%@ include file="footernew.jsp" %>
