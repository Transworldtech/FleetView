<%@ include file="headernew.jsp"%>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
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
	}

	function gotoPrint(divName)  
	{  
		  var printContents = document.getElementById(divName).innerHTML; 
		  var originalContents = document.body.innerHTML; 
		  document.body.innerHTML = printContents;  
		  window.print();
		  document.body.innerHTML = originalContents;  
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
	return true;
  	//return datevalidate();
  	
  }
  
  function datevalidate()
  {	
	  
	var date1=document.getElementById("data").value; //from date
  	var date2=document.getElementById("data1").value; //to date
  	var dm1,dd1,dy1,dm2,dd2,dy2,dm11,dm22;
  	
  	dy1=date1.substring(0,2);
  	dy2=date2.substring(0,2);
  	dm1=date1.substring(3,6);
  	dm2=date2.substring(3,6);

  	dm11=dateformat(dm1);
  	dm22=dateformat(dm2);	
  	dd1=date1.substring(7,11);
  	dd2=date2.substring(7,11);
  	var date=new Date();
  	var month=date.getMonth()+1;
  	//var month1=date2.getMonth();
  	var day=date.getDate();
  	var year=date.getFullYear();
  	
  	
  	
  	
  	if(dd1>dd2)
  	{  
  		alert("From date year is should not be greater than to date year");
  		//document.getElementById("data").value="";
  		//document.getElementById("data1").value="";
  		document.getElementById("data").focus;
  		return false;
  		
  	}
  	
  	else if(year==dd1 && year==dd2) if(dm11>dm22)
  	{
  		
  		alert("From date month is should not be greater than to date month ");
  		//document.getElementById("data").value="";
  		//document.getElementById("data1").value="";
  		document.getElementById("data").focus;
  		return false;
  	}
  	 if(dm1==dm2 && dd1==dd2) 
  	 {
  	if(dy1 > dy2)
  	{
  		alert("From date should not be greater than to date");
  		//document.getElementById("data").value="";
  		//document.getElementById("data1").value="";
  		document.getElementById("data").focus;
  		return false;
  	}
  	}
  	return true;
  }
  
  function showhide1()
  {
	  //alert("In Fun");
	  var counter=document.getElementById("countermore").value;
	  //alert(counter);
	  var tdx=document.getElementById("tdx").value;
	  var ta,tb,tc,td,te,tf,tg,th,ti,tj,tk,tl,taa,tbb,tcc;
	  if(tdx=="More Info")
	  {
	    taa=document.getElementById("taa");
		taa.style.display="";
		tbb=document.getElementById("tbb");
		tbb.style.display="";
		tcc=document.getElementById("tcc");
		tcc.style.display="";
	    for(i=1;i<=counter;i++)
		{	
		    document.getElementById("ta"+i).style.display="";
		    document.getElementById("tb"+i).style.display="";
		    document.getElementById("tc"+i).style.display="";
		    document.getElementById("type").value="More Info";
			document.getElementById("tdx").value="Hide Info";
		}
	  }
	  else
	  {
		  //alert("in else");
		    taa=document.getElementById("taa");
			taa.style.display="none";
			tbb=document.getElementById("tbb");
			tbb.style.display="none";
			tcc=document.getElementById("tcc");
			tcc.style.display="none";
		    for(i=1;i<=counter;i++)
			{	
			    document.getElementById("ta"+i).style.display="none";
			    document.getElementById("tb"+i).style.display="none";
			    document.getElementById("tc"+i).style.display="none";
				document.getElementById("tdx").value="More Info";
				document.getElementById("type").value="Hide Info";
			}
		  
	  }
  }
  function showExcel()
  {
	  var tdx=document.getElementById("tdx").value;
      if(tdx=="More Info")
      {
          tdx="More";
      }
      else
      {
          tdx="Hide";
      }	

	  window.open("exporttoexcel.jsp?type="+tdx);
  }
  </script>
	<%!
	
	Connection conn, conn1;
	Statement st1, st2, st, st3, st4, st5, st15,stmain11,st21,stt,st7,stmain1,stmt;
	int cntos, cntra, cntrda, cntdt, cntst, cntcd, cntdv,cntnd,cntndk,datadaystotal,disk, cntfc, cntdisconn,
			cntft = 0, cntfa = 0,counter=0;
	double cntrh, cntavgos, cntavgra, cntavgrd;
	int cntosdur;
	double stopdur, totstopdur, cntrating;
	double cntavg = 0.00,timevalue=0.0;
	String vehregno, transporter;
	String datex1, datex2, data1, data2;
	String dateformat;%>
	<%
	
	
	String str_os="("; 
	String str_os1="("; 
	String str_os2="("; 
	String str_os3="("; 
	 int temp=1;
	 int temp1=1;
	 int temp2=1;
	 int temp3=1;
	 int nd_pri=0;
	 int cntndpost=0;
	 double timevikram=0.0;
	
	 datadaystotal=0;
  cntdisconn=0;
  cntrating=0;
  cntos=0;
  cntra=0;
  cntrda=0;
  cntdt=0;
  cntst=0;
  cntrh=0.0;
  cntcd=0;
  cntdv=0;
  cntnd=0;
  cntndk=0;
  disk=0;
  cntfc=0;
  cntosdur=0;
  stopdur=0.0;
  totstopdur=0.00;
  cntavgos=0.0;
  cntavgra=0.0;
  cntavgrd =0.0; //code to get system date as data2 and yesterdays date as a data1.
  cntft=0;
  cntfa=0;
  cntavg=0.0;
  
  String ddx=request.getQueryString();
  /* datex1=request.getParameter("data");
 // date1_new = datex1;
  System.out.println("--datex1------>>>"+datex1);

  datex2=request.getParameter("data1");
 //  date2_new = datex2;
  System.out.println("--datex2------>>>"+datex2);
 */

  double tot_dur=0.0;
  if(ddx==null)
  {
	  datex1=datex2=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
  	  data1=data2=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
  }
  else
  {
	  data1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data")));
	  data2=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data1")));
	  datex1=request.getParameter("data");
	  datex2=request.getParameter("data1");
  }
  
  session.setAttribute("data1",data1);
  session.setAttribute("data2",data2);
  String user,usertypevalue;
  user=session.getAttribute("user").toString();
  usertypevalue=session.getAttribute("usertypevalue").toString();
  dateformat = session.getAttribute("dateformat").toString();
  %>
	<table border="0" width=600 align="center" class="stats">
		<tr>
			<td colspan="5" align="center">
			<!-- <div align="left"><font size="3">Report No:7.0</font></div>-->
			<font face="Arial" color="black" size="3"><b>Custom Report For Full Fleet</b></font></td>
		</tr>
		</table>
		<div style="margin-left: 25%;">
		<table border="0" width=600 align="center">
		<form action="" method="get" onsubmit="return validate();">
		<input type="hidden" id="PageName" name="PageName" value="<%=PageName%>"/>  
		<br></br>
		<tr>
			<td align="right"><font face="Arial" color="black" size="2"><b>From : </b></font>&nbsp;&nbsp; 
			<input type="text" id="data" name="data" value="<%=datex1 %>" size="15" readonly />
			<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data",         // ID of the input field
      ifFormat    : "%d-%b-%Y",     // the date format
      button      : "data"       // ID of the button
    }
  );
</script></td>

			<td align="right"><font face="Aril" color="black" size="2"><b>To : </b></font>&nbsp;&nbsp; <input type="text"
				id="data1" name="data1" value="<%=datex2 %>" size="15" readonly />
			<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data1",         // ID of the input field
      ifFormat    : "%d-%b-%Y",    // the date format
      button      : "data1"       // ID of the button
    }
  );
</script></td>
			<td>&nbsp;&nbsp;<input type="submit" name="submit" id="submit"value="submit"></td>
		</tr>
		</form>
	</table></div>
	
	<form name="custreport" id="custreport">
	<table border="0" width="100%">
		<tr>
			<td>
			<%
try
	{
String dd=request.getQueryString();
if(dd==null)
{
out.println("<center ><font size='2' color='blue'>Please select the dates to display the report.</font></center>");
}
else
{
//database connectivity to get the transporter wise report.

	
	conn = fleetview.ReturnConnection();
	conn1 = fleetview.ReturnConnection1();
	st=conn.createStatement();
	st=conn.createStatement();
	st2=conn1.createStatement();
	st3=conn1.createStatement();
	st4=conn1.createStatement();
	st5=conn.createStatement();
	st21=conn.createStatement();
	st15=conn1.createStatement();
	stmain11 = conn1.createStatement();
	stt = conn1.createStatement();
	st7= conn1.createStatement();
	stmain1= conn1.createStatement();
	stmt= conn1.createStatement();
session.setAttribute("reportno","Report No:6.0");
session.setAttribute("reportname","Custom Report For Full Fleet");
%>

			<table border="0" width="100%" class="stats">
				<tr>
				
					<td colspan="3" align="center">
					<input type="hidden" name="type" id="type" value="More Info"/><font face="Arial" color="black" size="3">Exception
					Analysis Report For AVL Mobile Eye 2000 for <%=usertypevalue %> For
					the Period : <%
java.util.Date ShowDate = new SimpleDateFormat("yyyy-MM-dd").parse(data1);
Format formatter = new SimpleDateFormat("dd-MMM-yyyy");
String showdate = formatter.format(ShowDate);
out.print(showdate);
%> 00:00 AM to <%
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
java.util.Date showdate1 = new SimpleDateFormat("yyyy-MM-dd").parse(data2);
String showdate2=formatter.format(showdate1);
out.print(showdate2);
%> 23:59 PM <%
session.setAttribute("ShowDate",showdate+" 00:00:00");
session.setAttribute("ShowDate1",showdate2+" 23:59:00");

String tdydate = new SimpleDateFormat("yyyy-mm-dd").format(new java.util.Date());
String tdydate1 = new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date());
String type=request.getParameter("type");
System.out.println(">>>>>>>>>>type:"+type);
%></font>
			<div class="bodyText" align="right"> <a href="#" style="font-weight: bold; color: black; " onclick="gotoPrint('mytable');">    
 			<img src="images/print.jpg"  width="15px" height="15px" style="border-style: none"></img></a>
 			
						<a href="#" onclick="showExcel()" title="Export to Excel"><img
						src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;
					<%=tdydate1 %></div>
					</td>
				</tr>
			</table>

			<table border="1" width="100%" bgcolor="#F5F5F5" class="sortable">
				<tr>
					<th colspan="3" class="sorttable_nosort">
					<div align="center">Parameters considered for the Report</div>
					</th>
				</tr>
				<tr>
					<td class="bodyText">
					<div align="left">1. OverSpeed : <%=session.getAttribute("overspeed").toString() %>
					</div>
					</td>
					<td class="bodyText">
					<div align="left">2. Rapid Acceleration :<%=session.getAttribute("racc").toString()%></div>
					</td>
					<td class="bodyText">
					<div align="left">3. Rapid Deceleration :<%=session.getAttribute("rdcc").toString()%></div>
					</td>
				</tr>
				<tr>
					<td class="bodyText">
					<div align="left">4. Night Driving : <%=session.getAttribute("ndri").toString() %>
					</div><br>
					<div align="left"> Night Driving Pre-Authorised: Green Color
					</div><br>
					<div align="left"> Night Driving Not Pre-Authorised: Yellow Color
					</div>
					</td>
					<td class="bodyText">
					<div align="left">5. Continuous Driving :><%=session.getAttribute("cdri").toString() %></div>
					</td>
					<td class="bodyText">
					<div align="left">6. Stoppages :<%=session.getAttribute("stop").toString() %></div>
					</td>
				</tr>
			</table>
            <br>
            <font face="Arial" size="2" color="black">Note:'Yes' in Average Speed Considered Column indicates Average speed is considered in calculation of Run hrs</font> 	<input type="button" value="More Info" onclick="showhide1();" class="formElement" id="tdx" name="tdx" style="border: thin;border-style: solid;">&nbsp;&nbsp;
            
            </br>
            
			<p></p>
			<div id="mytable">
			<table border="1" width="100%" class="sortable">
			
				<tr>
					<th>Sr.</th>
					<th>Vehicle No.</th>
					<th>Vehicle Type</th>
					<th>Transporter</th>
					<th>Date</th>
					<th>Location</th>
					<th>Data Days</th>
					<th>OS</th>
					<th>OS Dur</th>
					<th>RA</th>
					<th>RD</th>
					<th>CD</th>
					<th>DV</th>
					<th>DT</th>
					<th colspan="1">Rating</th>
					<th id="taa" style="display: none;">Avg OS Dur/100km</th>
					<th id="tbb" style="display: none;">Avg RA/100km</th>
					<th id="tcc" style="display: none;">Avg RD/100km</th>
					<th>FT</th>
					<th>FA</th>
					<th>FC</th>
					<th>AVG</th>
					<th>Stops</th>
					<th>Run Hrs.</th>
					<th>AVG Speed</th>
					<th>ND</th>
					<th>ND Dur(Hrs)</th>
					<th>ND Km</th>
					<th>ND Int</th>
					<th>ND Reason</th>
					<th>DayStop <br>(Hrs)</th>
					<th>DC</th>
					<th>Total DC Km</th>
					
				</tr>
				<!-- Get The Data From the Database and show it -->

				<%	
				String bgcolor="";
	String ss=session.getAttribute("VehList").toString();
	StringTokenizer s= new StringTokenizer(ss,",");
	String aa,tbname;
	String vehtype="";
	int i=1;
	while(s.hasMoreTokens())
	{
	aa=s.nextElement().toString();
	aa=aa.replace(")","");
	aa=aa.replace("(","");
	tbname="t_vehall_ds";
	
	if(!aa.equals("0"))
	{
	String sql="select * from t_vehicledetails where vehicleCode='"+aa+"'";
	ResultSet rst=st.executeQuery(sql);
		if(rst.next())
		{
			vehregno=rst.getString("VehicleRegNumber");
			transporter=rst.getString("OwnerName");
			vehtype=rst.getString("vehtype");
		}
		int datadayscount=0;
		if(fleetview.checkUserBlocked(transporter).equals("Yes"))
		{
			%>
				<tr>
					<td style="text-align: right"><%=i %></td>
					<td style="text-align: left"><%=vehregno %></td>
					<td style="text-align: left"><%=vehtype %></td>
					<td style="text-align: left"><%=transporter%></td>
					<td style="text-align: left">Blocked</td>
					<td style="text-align: left">Access denied for <%=transporter%></td>
					<td style="text-align: right"><%=datadayscount%></td>
		
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td id="ta<%=i %>" style="display: none;">-</td>
					<td id="tb<%=i %>" style="display: none;">-</td>
					<td id="tc<%=i %>" style="display: none;">-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
				</tr>
				<%
			i++;	
				counter=counter+i;
		}
		else
		{
			
			String datadays="select count(*) as count from db_gpsExceptions.t_vehall_ds where VehCode='"+aa+"' and TheDate>='"+data1+"' and TheDate <= '"+data2+"' and Location <> 'No Data'";
			ResultSet datadaysrs=st21.executeQuery(datadays);
			if(datadaysrs.next())
			{
				datadayscount=datadaysrs.getInt("count");
				System.out.println("DataDaysCount====>>>>>"+datadayscount);
				datadaystotal=datadaystotal+datadayscount;
			}
			
			String dttime="",location="-",loc="-";
			java.util.Date today=new java.util.Date();
			String todaydt=new SimpleDateFormat("yyyy-MM-dd").format(today);
			java.util.Date today1=new SimpleDateFormat("yyyy-MM-dd").parse(todaydt);
			
			
			System.out.println("today1===>"+today1);
			java.util.Date enddate =new SimpleDateFormat("yyyy-MM-dd").parse(new SimpleDateFormat("yyyy-MM-dd").format(showdate1));
			System.out.println("showdate1===>"+showdate1);
			System.out.println("enddate===>"+enddate);
			//tbname=t_veh"+aa+"_ds
			
			
			sql="select * from "+tbname+" where VehCode='"+aa+"' and TheDate <='"+data2+"' and TheDate >='"+data1+"' order by TheDate desc";
			
			System.out.println("==================>"+sql);
			ResultSet rst1=st2.executeQuery(sql);
			if(rst1.next())
			{
			
			 loc=rst1.getString("Location");
			 System.out.println("loc===>"+loc);
			 
			 
			if(!loc.equalsIgnoreCase("No data") && !("-").equals(loc))
			{
				 dttime=loc.substring(0,15);
				 location=loc.substring(19);
			}
			else
			{
				
				location=loc;
				dttime=formatter.format(new SimpleDateFormat("yyyy-MM-dd").parse(data2));
			}
			
			
			/// ND Count Reamining 
			
			int cntnd1=fleetview.NightDrivingFormExceptionsForDateRange(aa,data1,data2);
			if(cntnd1>0){
			String sqlNdcolor="select *  from db_gpsExceptions.t_veh"+aa+"_nd where FromDate>='"+data1+"' and FromDate <='"+data2+"' and NDPreAuthorised ='Yes' order by fromdate asc";
			ResultSet rsndcolor = stmain11.executeQuery(sqlNdcolor);
			if(rsndcolor.next())
			{
				bgcolor="background-color:#66CC00";
			}
			else
			{
				bgcolor="background-color:#FFFF66";
			}
			}
			else
			{
				bgcolor="";
			}
			
		%>
				<tr>
                    <% System.out.println(">>>>>>>>>>>First TR<<<<<<<<<<<<<<<<<<"); %>
                    
					<td style="<%=bgcolor%>;text-align: right"><%=i %></td>
					<td style="<%=bgcolor%>;text-align: left"><a
						href="customreport.jsp?vid=<%=aa%>&vehno=<%=vehregno%>"><%=vehregno %></a></td>
					<td style="<%=bgcolor%>;text-align: left"><%=vehtype %></td>	
					<td style="<%=bgcolor%>;text-align: left"><%=transporter %></td>
					<td style="<%=bgcolor%>;text-align: right"><%=dttime %></td>
					<td style="<%=bgcolor%>">
					<div align="left">
					<%
	
					System.out.println(">>>>>>>>>>>@@@@@@@@@@<<<<<<<<<<<<<<<<<<");
		if(location.equalsIgnoreCase("No data"))
		{
			out.print(location);
		}
		else
		{
			out.print(fleetview.ShowOnMapOnlyByLocation(location,aa,rst1.getString("TheDate")));
		}
	
		%>
					</div>
					</td>
					<td style="<%=bgcolor%>;text-align: right"><%=datadayscount%></td>
		
					<%
					
					String sqlcount="select SUM(OSCount),SUM(RACount),SUM(RDCount),SUM(CRCount),SUM(Distance),SUM(StopCount), SUM(RDuration), SUM(FACount),SUM(FTCount),SUM(RDinSec),SUM(RDurationinHrs),sum(Osduration),sum(FTCount),sum(FACount),sum(FC),AVG(FAVG) as FAVG,sum(NDCount),Sec_To_Time(SUM(Time_To_Sec(NDDurationinHrs))),SUM(Time_To_Sec(NDDurationinHrs)),sum(NDKm),sum(NDIntimation),sum(NDReason),sum(DCCount) from t_vehall_ds where VehCode='"+aa+"' and TheDate >='"+data1+"' AND TheDate <='"+data2+"'";
					//17 18
					
		          ResultSet rstcounts=stmain1.executeQuery(sqlcount);
		          System.out.println("sqlcount==>"+sqlcount);
		          
			fleetview.GetOS_RA_RD_CR_DT_ST_DURATION_CountFromExceptionDBForDateRange(aa,data1,data2);
			
		if(rstcounts.next())
		{
		%>
					<td style="<%=bgcolor%>">
					<div align="right">
					<%
		int os=rstcounts.getInt(1);
		cntos+=os;
		try
		{
		if(os >0)
		{
			 if(temp==1)
			 {
				 str_os=aa;
				 temp++;
			 }
				 else
		    str_os=str_os+","+aa; 
			
			%> <a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>"> <%=os%>
					</a> <%				
		}
		else
		{
			out.print(0);
		}
		}
		catch(Exception e)
		{
			System.out.println("OS======>Ecxeption");
			e.printStackTrace();
		}
		%>
					</div>
					</td>
					<%
					
					
					
				//OS Duration calculation 	
					
					
		double osavg =0.00;
		double osduration=0.00;
		int osduration1=0;
		try
		{
		//String sqlos="SELECT sum(Duration)as duration FROM t_veh"+aa+"_overspeed  where concat(FromDate,' ',FromTime) >='"+data1+" 00:00:00' and ToDate <='"+data2+" 23:59:59' order by concat(FromDate,' ',FromTime)";
		//System.out.println("sqlos--->"+sqlos);
		//ResultSet rstos=st4.executeQuery(sqlos);
		//if(rstos.next())
		//{
			osduration=rstcounts.getDouble(12);
			osduration1=rstcounts.getInt(12);
			System.out.println(" OS Duration--->"+osduration);
		//}
		}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.println("Exception>>>>>>>>>>>>>1111:");
		}
		cntosdur= cntosdur + osduration1;
		System.out.println("CNTOSDUR====="+cntosdur);
		%>
					<td style="<%=bgcolor%>">
					<div align="right"><%=osduration1%></div></td>
					
					
					
					
					<td style="<%=bgcolor%>">
					<div align="right">
					<%
		int ra=rstcounts.getInt(2);
		int dccount=rstcounts.getInt(23);
		System.out.println("dccount---------"+dccount);
		cntra+=ra;
		System.out.println("CNTRA======"+cntra);
		if(ra>0)
		{ 
			if(temp1==1)
			 {
				 str_os1=aa;
				 temp1++;
			 }
				 else
		    str_os1=str_os1+","+aa; 
			
			%> <a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>">
					<%=ra%> </a> <%
		}
		else
		{
			out.print(ra);
		}
		
		%>
					</div>
					</td>
					<td style="<%=bgcolor%>">
					<div align="right">
					<%
		int rd=rstcounts.getInt(3);
		cntrda+=rd;
		System.out.println("CNTRDA====="+cntrda);
		if(rd>0)
		{
			if(temp2==1)
			 {
				 str_os2=aa;
				 temp2++;
			 }
				 else
		    str_os2=str_os2+","+aa; 
			
			%> <a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>">
					<%=rd%> </a> <%
		}
		else
		{
			out.print(rd);
		}
		
		%>
					</div>
					</td>
					<td style="<%=bgcolor%>">
					<div align="right">
					<%
		int cd=rstcounts.getInt(4);
		cntcd+=cd;
		if(cd>0)
		{
			%> <a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>">
					<%=cd%> </a> <%
		}
		else
		{
			out.print(cd);
		}
		
		%>
					</div>
					</td>
					
	<% //logic for DV
	int dv=0;
	String sqldv ="select count(*) as dvcount from db_gpsExceptions.t_vehall_dv where  VehCode='"+aa+"' and FromDateTime >='"+data1+"' AND ToDateTime <='"+data2+"'";
			ResultSet rsdv=stmt.executeQuery(sqldv);
			if(rsdv.next()){
				dv=rsdv.getInt(1);
			}
	
	%> 				
					
					<td style="<%=bgcolor%>">
					<div align="right">
					<%
		 
		cntdv+=dv;
		if(dv>0)
		{
			%> <a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>">
					<%=dv%> </a> <%
		}
		else
		{
			out.print(dv);
		}
		
		%>
					</div>
					</td>
					
					<td style="<%=bgcolor%>">
					<div align="right">
					<%
		
					System.out.println("dt=prev=>");
					
					double dt=0.00;
					int dt1=0;
					
					try
					{
					 dt=rstcounts.getDouble(5);
					 dt1=rstcounts.getInt(5);
					}
					catch(Exception e)
					{
						e.printStackTrace();
						System.out.println("Exception= in distance=>"+e);	
						dt=0.00;
						dt1=0;
					}
					
					
					System.out.println("dt==>"+dt);
					System.out.println("dt1==>"+dt1);
		cntdt+=dt;
		System.out.println("CNTDT====="+cntdt);
		out.print(dt1);
		%>
					</div>
					</td>

					<td style="<%=bgcolor%>">
					<div align="right">
					<%
					NumberFormat nfrating=NumberFormat.getInstance();
					nfrating.setMaximumFractionDigits(2);
					nfrating.setMinimumFractionDigits(2);			
		double rating=0.0;
		double RD=0;
		double RA=0;
		double OS=0;
	  	if(dt>0.0)
	  	{
	  		try{	
	  		try
	  		{
	  			RD=((rd/dt)*100);
	  		}
	  		catch(Exception e)
	  		{
	  			e.printStackTrace();
	  			RD=0;
	  		}
	  		try
	  		{
	  	RA=((ra/dt)*100);
	  		}
	  		catch(Exception e)
	  		{
	  			e.printStackTrace();
	  			RA=0;
	  		}
	  	try
	  	{
	  	OS=((osduration/10/dt)*100);
	  	}
	  	catch(Exception e)
	  	{
	  		e.printStackTrace();
	  		OS=0;
	  	}
	  	if(dt>0)
	  	{
	  	rating=RA+RD+OS;
	  	}
	  	else
	  	{
	  		out.print("-");
	  	}
	  		}
	  	catch(Exception e)
		{
			System.out.println("RA+RD+OS=====>");
	  		e.printStackTrace();
		}
	  	out.print(nfrating.format(rating));
	  	}
	  	else{
	  		out.print(0.00);
	  	}
	  	cntrating=rating+cntrating;
		
		
		
	  	%>
					</div>
					</td>

					<td  id="ta<%=i %>" style="display: none;<%=bgcolor%>" >
					<div align="right">
					<%
			System.out.println("IN OS Avg");
					
			NumberFormat nfos=NumberFormat.getInstance();
			nfos.setMaximumFractionDigits(2);
			nfos.setMinimumFractionDigits(2);
			
			//int osduration=fleetview.getOSDurationforDateRange(aa,data1,data2);
				
				if(osduration> 0.0 && dt >0.0)
				{
					try
					{
				
					
					System.out.println("distance --->"+dt);
					try
					{
					osavg=(osduration*10)/dt;
					}
					catch(Exception e)
					{
						e.printStackTrace();
						osavg=0;
					}
					System.out.println("OS avg--->"+osavg);
					out.print(nfos.format(osavg));
					//out.print(osavg);
					//out.print(osavg);
					
					}
					catch(Exception e)
					{
						System.out.println("Osduration=====>");
						e.printStackTrace();
					}
				}
				else{
					osavg=0.0;
					out.print(nfos.format(osavg));
					//out.print(osavg);
				}
				cntavgos+=osavg;
			
				
			%>
					</div>
					</td>
					<td  id="tb<%=i %>" style="display: none;<%=bgcolor%>">
					<div align="right">
					<% 
		NumberFormat nfra=NumberFormat.getInstance();
		nfra.setMaximumFractionDigits(2);
		nfra.setMinimumFractionDigits(2);
		double raavg =0.0;
		
		
		if(ra>0 && dt>0.0 )
		{
			try
			{
				
			
			System.out.println("RA --->"+ra);
			System.out.println("dccount---------"+dccount);
			try
			{
			raavg= (ra/dt)*100;
			}
			catch(Exception e)
			{
				e.printStackTrace();
				raavg=0;
			}
			System.out.println("RA avg--->"+raavg);
			out.print(nfra.format(raavg));
			//out.print(raavg);
			}
			catch(Exception e)
			{
				System.out.println("RAavg=====>");
				e.printStackTrace();
				
			}
		}
		else  //if(dt==0.0 && ra>0 ||ra==0) 
		{ 
			raavg= 0.0;
			out.print(nfra.format(raavg));
		}
		cntavgra+=raavg;
		
		%>
					</div>
					</td>
					<td id="tc<%=i %>" style="display: none;<%=bgcolor%>">
					<div align="right">
					<% 
		NumberFormat nfrd=NumberFormat.getInstance();
		nfrd.setMaximumFractionDigits(2);
		nfrd.setMinimumFractionDigits(2);
		double rdavg =0.0;
		
		if(rd>0 && dt>0.0)
		{
			
			try
			{
			System.out.println("RD -->"+rd);
			try
			{
				rdavg= (rd/dt)*100;
			}
			catch(Exception e)
			{
				e.printStackTrace();
				rdavg=0;
			}
			System.out.println("RD avg--->"+rdavg);
			out.print(nfrd.format(rdavg));
			//out.print(rdavg);
			}
			catch(Exception e)
			{
				rdavg=0;
				System.out.println("RDavg=====>");
				e.printStackTrace();
			}
			
		}
		else //if(dt==0.0 && rd>0 ||rd==0 )
		{
			rdavg= 0.00;
			out.print(nfrd.format(rdavg));
			//cntavgrd+=rdavg;
		}
		cntavgrd+=rdavg;
		
		%>
					</div>
					</td>









					<td style="<%=bgcolor%>">
					<div align="right">
					<%
					
					
					
					
					
		int ft=0;
		//try{
			//String sql4="select count(*) as fcnt from t_vehft where vehcode like '"+aa+"' and Thedate>='"+data1+"' and TheDate <='"+data2+"' order by concat(TheDate,TheTime) desc";
			//ResultSet rs4= st2.executeQuery(sql4);
			//if(rs4.next())
			//{  
				ft=rstcounts.getInt(13);
				if(ft==0)
				{
					ft=0;
				}
				
			//}
			////}catch (Exception e) {
				//System.out.print("Exception--->"+e);
			//}
		//int ft=rstcounts.getInt(9);
		cntft+=ft;
		if(ft >0)
		{
			%> <a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>">
					<%=ft%> </a> <%				
		}
		else
		{
			out.print(0);
		}
		%>
					</div>
					</td>


					<td style="<%=bgcolor%>">
					<div align="right">
					<%
		int fa=0;
		//try{
			//String sql4="select count(*) as fcnt from t_vehfa where vehcode like '"+aa+"' and Thedate>='"+data1+"' and TheDate <='"+data2+"' order by concat(TheDate,TheTime) desc";
			//ResultSet rs4= st2.executeQuery(sql4);
			//if(rs4.next())
			//{  
				fa=rstcounts.getInt(14);
				
				if(fa==0)
				{
					fa=0;
				}
				
				
				
			//}
			//else{
				//out.print(0);
			//}
			//}catch (Exception e) {
			//	System.out.print("Exception--->"+e);
			//}
		//int fa=rstcounts.getInt(8);
		cntfa+=fa;
		if(fa >0)
		{
			%> <a
						href="showfueladd.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>">
					<%=fa%> </a> <%				
		}
		else
		{
			out.print(0);
		}
		%>
					</div>
					</td>




					<%
					

					
					
					
					
		if(fleetview.getUnitDescription(aa).equals("FUELFLOW"))
		{
			%>
					<td style="<%=bgcolor%>">
					<div align="right">
					<%
				
				int fcval=rstcounts.getInt(15);
				cntfc=cntfc+fcval;
				out.print(fcval);
			%>
					</div>
					</td>
					
					
					
					
					
					
					
					
					<td style="<%=bgcolor%>">
					<div align="right">
					<%
			NumberFormat nf=NumberFormat.getInstance();
			nf.setMaximumFractionDigits(2);
			nf.setMinimumFractionDigits(2);
			
			Double favgval=0.00;
			String favgval1=Double.toString(favgval);
				if(rstcounts.getDouble("FAVG") >0)
				{
					favgval1=rstcounts.getString("FAVG");
				}
				else
				{
					favgval1="-";
				}
			
			
				//fleetview.getFuelAVGForDateRange(aa,data1,data2);
			cntavg=cntavg+favgval;
			out.print("-");
			
			
			
			%>
					</div>
					</td>
					<%
		}
					
					
					
		else
		{
			%>
					<td style="<%=bgcolor%>">
					<div align="right">-</div>
					</td>
					<td style="<%=bgcolor%>">
					<div align="right">-</div>
					</td>
					<%
		}
		%>
		
		
					<td style="<%=bgcolor%>">
					<div align="right">
					<%
			System.out.println("IN stop");
		int stsp=rstcounts.getInt(6);
		cntst+=stsp;
		if(stsp>0)
		{
			if(temp3==1)
			 {
				 str_os3=aa;
				 temp3++;
			 }
				 else
		    str_os3=str_os3+","+aa; 
			
			
			%> <a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>"> <%=stsp%>
					</a> <%
		}
		else
		{
			out.print(0);
		}
		
		
		%>
					</div>
					</td>




					<td style="<%=bgcolor%>">
					<div align="right">
					<%
					NumberFormat nf = DecimalFormat.getNumberInstance();
					nf.setMaximumFractionDigits(2);
					nf.setMinimumFractionDigits(2);	
					nf.setGroupingUsed(false);
					double d=0.00;
					d=rstcounts.getDouble(11);
					 
						String runhrs =  nf.format(d);
						cntrh+= d;
						out.print(runhrs);
		%>
					</div>
					</td>
					
					
					
										<td style="<%=bgcolor%>">
					<div align="left">
					<%
		 
					
		try{
						
						
						String avgspeed="Select * from db_gpsExceptions.t_vehall_ds where vehcode='"+aa+"' and TheDate <='"+data2+"'  and  TheDate >='"+data1+"' and AvgSpeedConsidered='Yes' ";
						System.out.println("avgspeed==>"+avgspeed);
						ResultSet rstavg=st3.executeQuery(avgspeed);
						if(rstavg.next())
						{
							
								out.print("Yes");
						}
							else{
								System.out.println("in NO");
								out.print("No");
							}
						
						}
					catch(Exception ea)
					{
							ea.printStackTrace();
							System.out.println("Avg speed exception"+ea);
					}
						
		%>
					</div>
					</td>
					
					
					
					
					
					<td style="<%=bgcolor%>;text-align: right">
					<%
					
					
					
	//////////////////////////////////////////////////////  Done  /////////////////////////////////////////////////////			
					
					
					
					
					
					
					
					
					
					
					
					String time1 ="00:00";
					String time2="23:59";
			int cntnd11=0;
			if(rstcounts.getInt(17)>0)
			{
				cntnd11=rstcounts.getInt(17);
			}
			
				
				
				//fleetview.NightDrivingFormExceptionsForDateRange(aa,data1,data2);
			if(cntnd11>0)
		{
			cntnd+=cntnd11;
			%> <a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>">
					<%=cntnd11%> </a> <%
		}
		else
		{
			out.print(0);
		}
		%>
					</td>
					
				
					<td style="<%=bgcolor%>;text-align: right">
					<%
					int count1=0;
					String Time="00:00:00";
					try
					{
						//String sql1="select Sec_To_Time(SUM(Time_To_Sec(Duration))),SUM(Time_To_Sec(Duration)) from t_veh"+aa+"_nd where  FromDate between '"+data1+"' and '"+data2+"' order by fromdate asc";
						//System.out.println(">>>>>>>>>>>>>>>>sql1:"+sql1);
						//ResultSet rst11=stmain11.executeQuery(sql1);
						//if(rst11.next())
						//{
							
								//count=rst11.getInt("cnt");
								Time=rstcounts.getString(18);
							   // System.out.println(">>>>>>>>>>>>>>>>Time:"+Time);
							    tot_dur=tot_dur+rstcounts.getDouble(19);
							   // System.out.println(">>>>>>>>>>>>>>>>tot_dur:"+tot_dur);
						//}
					}
					catch (Exception e) 
					{
						e.printStackTrace();
						System.out.println("Exception-->"+e);
						
					}
					if(Time==null||Time==" ")
					{
						Time="00:00:00";
					}
					try
					{
						StringTokenizer str=new StringTokenizer(Time,":");
	                     while(str.hasMoreTokens())
	                     {
	                    	 String test=str.nextToken();
	                    	 String test1=str.nextToken();
	                    	 Time=test+"."+test1;
	                    	 String test2=str.nextToken();
	                     }
	                     
	                     timevikram=timevikram+Double.valueOf(Time.trim()).doubleValue();
	                     
	                     System.out.println(" Total ND hr time is " +timevikram);
	                     

					}
					catch(Exception e)
					{
						e.printStackTrace();
						System.out.println(">>>>>>>exception:"+e);
					}
					 System.out.println("Last total time is " +Time);

					%>
					<%=Time %>
					</td>
					
		<% 			
		int cntnd12=rstcounts.getInt(20);
		%>
		<td style="<%=bgcolor%>;text-align: right">
		<%
		if(cntnd12>0)
		{
			cntndk+=cntnd12;
		%>			
			<%=cntnd12 %>
		<%
		}else
		{
			out.print(0);
		}
		%>
				
					</td>
					
					
					
					
					<td style="<%=bgcolor%>;text-align: right">
					<%
					
					int count=0;
					try
					{
						//String sql1="select count(*) as cnt from db_gpsExceptions.t_veh"+aa+"_nd where  NDPreAuthorised='Yes' and FromDate>='"+data1+"' and FromDate <='"+data2+"' order by fromdate asc";
						//ResultSet rst11=stmain11.executeQuery(sql1);
						//if(rst11.next())
						//{
						//	if(rst11.getInt("cnt")>0)
						//	{
								count=rstcounts.getInt(21);
								nd_pri=nd_pri+count;
							//}
						//}
					}
					catch (Exception e) 
					{
						
						e.printStackTrace();
						System.out.println("Exception-->>>>>>>>>>>"+e);
						
					}
					
					%>
					<%=count %>
					</td>
					
					
					
					
				 <td style="<%=bgcolor%>">
                                <div align="right">
                                <% 
                                try{
                                                           
                                        //String sqlpost="select count(*) as Reason from db_gpsExceptions.t_ndpostintimation where NdStartDateTime between '"+data1+" "+time1+"' and '"+data2+" "+time2+"' and VehRegNo='"+vehregno+"'";
                                
                               // ResultSet rsndpost=st7.executeQuery(sqlpost);
                    
                    //if(rsndpost.next())
                        //{ 
                    	if(rstcounts.getInt(22)>0)
                                {  %>
                                                                            
                            
                         <!--    <a href="reason_details.jsp?vid=<%=aa%>&vehno=<%=vehregno%>&data1=<%=data1+' '+time1 %>&data2=<%=data2+' '+time2 %>" > </a> --><%=rstcounts.getInt(22)%> 
                                        <%
                                }
                                else{
                                        out.print(0);
                                }
                        //}
                        //else
                        //{
                          //      out.print(0);
                       // }//
                        
                    cntndpost=cntndpost+rstcounts.getInt(22);
                       
                                }catch(Exception ee)
                                {

                                		ee.printStackTrace();
                                		System.out.println("Exception in ND post intimation"+ee);
                                }
          /////////////////////////////////////////////////////////////////////////////////////////////////////////////////                      
                               %>
                         </div>
                                </td>
				
					<td style="<%=bgcolor%>">
					<div align="right">
					<%
		
		String sqlstop="select sum(DayStopDurationinHrs) as stopduration from "+tbname+" where VehCode='"+aa+"' and TheDate <='"+data2+"' and TheDate >='"+data1+"' order by TheDate desc";
		ResultSet rststop=st3.executeQuery(sqlstop);
		try
		{
		if(rststop.next())
		{
			stopdur=rststop.getDouble("stopduration");
			totstopdur=totstopdur+rststop.getDouble("stopduration");
			%> <%=stopdur%> <%
		}
		else
		{
			out.print("0.00");
			
		}
		}
		
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.println("stopduration=====>");
		}
		%>
					</div>
					</td>
<%
					
			try{		
		//String sqldisconn="Select count(*) as cnt from db_gps.t_disconnectionData where vehicleCode='"+aa+"' and  OffTimeFrom >='"+data1+" 00:00:00' and  OffTimeTo <='"+data2+" 23:59:59' and Reason = 'Disconnection' and ignoredstamp='No' and Duration >= '0:30'";
		//ResultSet rstdisconn=st5.executeQuery(sqldisconn);
		%>
		<td style="<%=bgcolor%>">
					<div align="right">
		<%
		//if(rstdisconn.next())
		//{
			System.out.println("rstcounts.getInt(23)>="+rstcounts.getInt(23));
			if(rstcounts.getInt(23)>0)
			{
				
				%>
				<!--  <a href="disconnectedDetailsReport.jsp?vehicleCode=<%=aa%>&VehicleRegNo=<%=vehregno%>&ownerName=<%=transporter%>&fromDateTime=<%=data1+" "+time1%>&toDateTime=<%=data2+" "+time2%>"> -->
				<a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>"><%=rstcounts.getInt("sum(DCCount)")%> </a> 
				<%
			}
			else{
				out.println(0);
			}
			
		//}
		//else 
		//{
		//	out.print(0);
		//}
		
		cntdisconn=cntdisconn+rstcounts.getInt(23);
		System.out.println("DCcount"+cntdisconn);
		%>
		</div></td>
		<%

		// count total km of diss
		String sqldisconn="Select SUM(Distance) as Distance  from db_gps.t_disconnectionData where vehicleCode='"+aa+"' and  OffTimeTo <='"+data2+" 23:59:59' and  OffTimeFrom >='"+data1+" 00:00:00' and Reason = 'Disconnection' and ignoredstamp='No' and Duration >= '0:30'";
		
		ResultSet rstdis=st5.executeQuery(sqldisconn);
		
		System.out.println("Distance of disconnection query is " +sqldisconn);
		
		int diskm=0;
		while(rstdis.next())
		{
		  diskm=diskm+rstdis.getInt("Distance");
		  System.out.println("DISKM====="+diskm);
		}
		%>
		<td style="<%=bgcolor%>">
					<div align="right">
		<%
		
		if(diskm>0)
		{
			disk+=diskm;
			
			System.out.println("DISK========>"+disk);
			%>
		<a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>">	<%=diskm %></a>
		<%
		}
		else
		{
			//disk=0;
			out.println(0);
		}
		
		//... end of total km
		
		%>
		</div>
		</td>
		<%
		
		
		}
		catch(Exception ee)
		{
			//disk=0;
			ee.printStackTrace();
			System.out.println("Exception disconnection "+ee);
		}
		System.out.println("out of Disconnection");
		
					%>
				</tr>
				<%
		i++;
				counter=counter+i;
				///System.out.println("value of i"+i);	
		}
		System.out.println("While");	
		}
		else
		{
			%>
				<tr>
					<td style="text-align: right"><%=i %></td>
					<td style="text-align: left"><%=vehregno %></td>
					<td style="text-align: left"><%=vehtype %></td>
					<td style="text-align: left">No DATA</td>
					<td style="text-align: left">No DATA</td>
					<td><div align="right">No DATA</div></td>
					<td style="text-align: right"><%=datadayscount%></td>
					<td><div align="right">0</div></td>
					<td><div align="right">0</div></td>
					<td><div align="right">0</div></td>
					<td><div align="right">0</div></td>
					<td><div align="right">0</div></td>
					<td><div align="right">0</div></td>
					<td><div align="right">0</div></td>
					<td id="ta<%=i %>" style="display: none;"><div align="right">0</div></td>
					<td id="tb<%=i %>" style="display: none;"><div align="right">0</div></td>
					<td id="tc<%=i %>" style="display: none;"><div align="right">0</div></td>
					<td><div align="right">0.00</div></td>
					<td style="text-align:right">0</td>
					<td><div align="right">0</div></td>
					<td><div align="right">-</div></td>
					<td><div align="right">-</div></td>
					<td><div align="right">0</div></td>
					<td><div align="right">0.00</div></td>
					<td><div align="left">No</div></td>
					<td><div align="right">0</div></td>
					<td><div align="right">00.00</div></td>
					<td><div align="right">0</div></td>
					<td><div align="right">0</div></td>
					<td><div align="right">0</div></td>
					<td><div align="right">0.00</div></td>
					<td><div align="right">0</div></td>
					<td><div align="right">0</div></td>
				</tr>
				<%
			i++;
				counter=counter+i;
		}
			
			
			
	}
	}
	}
session.setAttribute("Str_os",str_os);
session.setAttribute("Str_os1",str_os1);
session.setAttribute("Str_os2",str_os2);
session.setAttribute("Str_os3",str_os3);

NumberFormat nf1=NumberFormat.getInstance();
nf1.setMaximumFractionDigits(2);
nf1.setMinimumFractionDigits(2);

NumberFormat nf2=NumberFormat.getInstance();
nf2.setMaximumFractionDigits(4);
nf2.setMinimumIntegerDigits(4);
	

float tot1=0.00F;
float tot2=0.00F;
float tot3=0.00F;
 String tot=" ";
 String total=" ";
try
{
		 tot1=Float.parseFloat(String.valueOf(nf1.format(((cntra/cntdt)*100))));
}
catch(Exception e)
{
	e.printStackTrace();
}
try{
		tot2=Float.parseFloat(String.valueOf(nf1.format(((cntrda/cntdt)*100))));
}
catch(Exception e)
{
	e.printStackTrace();
}
		
try
	{
			
		tot3=Float.parseFloat(String.valueOf(nf1.format(((cntosdur/10/cntdt)*100))));
		tot=String.valueOf(tot1+tot2+tot3);
		
		
	
	}
		catch(Exception e)
		{
			e.printStackTrace();
		}
try
{
		
total=nf1.format(tot);
System.out.println("Total-------"+total);
}
catch(Exception e)

{	
	total="0.00";
	e.printStackTrace();
}


String tt="0";
System.out.println("TOTAL:::::::::>>");
%>
				<tr class="sortbottom">
				<%try{ %>
					<td align="left" colspan="6" class="hed"><div align="left">Total</div></td>
					 <td class="hed">
	    			<div align="right"><%=datadaystotal %></div>
					</td>
					<%if(cntos>0){ %>	
					<td class="hed">									
					<div align="right"><a href="#" onclick="javascript:window.open('total_os.jsp?count=<%=cntos%>');"><%=cntos %></a></div>
					</td>
					<%}else {%>
					<td class="hed">
					<div align="right"><%=cntos %></div>
					</td>
					<%} %>
										
					
					<td class="hed">
					<div align="right"><%=cntosdur %></div>
					</td>
					<%if(cntra>0){ %>	
					<td class="hed">									
					<div align="right"><a href="#" onclick="javascript:window.open('total_ra.jsp?count=<%=cntra%>');"><%=cntra %></a></div>
					</td>
					<%}else {%>
					<td class="hed">
					<div align="right"><%=cntra %></div>
					</td>
					<%} %>
					
					
					<%if(cntrda>0)
					{ %>	
					<td class="hed">									
					<div align="right"><a href="#" onclick="javascript:window.open('total_rd.jsp?count=<%=cntrda%>');"><%=cntrda %></a></div>
					</td>
					<%}else {%>
					<td class="hed">
					<div align="right"><%=cntrda %></div>
					</td>
					<%} %>
					
					<%if(cntcd>0){ %>	       
			        <td class="hed">
			        <div align="right"><a href="#" onclick="javascript:window.open('total_cd.jsp?count=<%=cntcd%>');"><%=cntcd %></a></div>
			        </td>
			        <%}else {%>
					<td class="hed">
					<div align="right"><%=cntcd %></div>
					</td>
					<%} %>
					<td class="hed">
					<div align="right"><%=cntdv %></div>
					</td>
					<td class="hed">
					<div align="right"><%=cntdt %></div>
					</td>
					<td class="hed">
					<div align="right"><%=total%></div>
					</td> 
					<%-- <td class="hed">
					<div align="right"><%=nf1.format(cntrating)%></div>
					</td> --%>
					<td class="hed" id="ta<%=i %>" style="display: none;">
					<div align="right"><%=nf1.format(cntavgos) %></div>
					</td>
					<%-- <td class="hed" id="tb<%=i %>" style="display: none;">
					<div align="right"><%=nf1.format(cntavgra) %></div>
					</td>
					<td class="hed" id="tc<%=i %>" style="display: none;">
					<div align="right"><%=nf1.format(cntavgrd) %></div>
					</td> --%>
					<td class="hed" >
					<div align="right"><%=cntft %></div>
					</td>
					<td class="hed" >
					<div align="right"><%=cntfa %></div>
					</td>
					<td class="hed" >
					<div align="right"><%=cntfc %></div>
					</td>
					<td class="hed" >
					<div align="right"><%=nf1.format(cntavg) %></div>
					</td>
					<%if(cntst>0){ %>	
					<td class="hed">									
					<div align="right"><a href="#" onclick="javascript:window.open('total_stops.jsp?count=<%=cntst%>');"><%=cntst %></a></div>
					</td>
					<%}else {%>
					<td class="hed">
					<div align="right"><%=cntst %></div>
					</td>
					<%} %>
					<td class="hed">
					<div align="right"><%=nf1.format(cntrh) %></div>
					</td>
					<td class="hed">
					<div align="right"><b>-</b></div>
					</td>
					<%if(cntnd>0){ %>	       
        			<td class="hed">
       				 <div align="right"><a href="#" onclick="javascript:window.open('total_nd.jsp?count=<%=cntnd%>');"><%=cntnd %></a></div>
        			</td>
        			<%}else {%>
					<td class="hed">
					<div align="right"><%=cntnd %></div>
					</td>
					<%} %>
					<td class="hed">
					<div align="right"><%=nf1.format(timevikram) %></div>
					</td>
					<td class="hed">
					<div align="right"><%=cntndk %></div>
					</td>
					<td class="hed">
					<div align="right"><%=nd_pri %></div>
					</td>
						
					<td class="hed">
					<div align="right"><%=cntndpost %></div>
					</td>			
					<td class="hed">
					<div align="right"><%=nf1.format(totstopdur) %></div>
					</td>
					<td class="hed">
					<div align="right"><%=cntdisconn%></div>
					</td>
					
					<td class="hed">
					<div align="right"><%=disk %></div>
					</td>
					<%
					}
					catch(Exception e)
					{
						
					//	out.println(0);
						e.printStackTrace();
						System.out.println(" Before Finally Exception");
					}
					%>
					
			</tr>
			
		</table>
		</div>
		
			<input type="hidden" name="countermore" id="countermore" value="<%=i %>"/>
		</td>
		</tr>
	</table>
	
	</form>

	<%
}
}catch(Exception e)
{	
	
	e.printStackTrace();
	System.out.println("Finally Exception");
}
finally
{
		try
		{
			stmain11.close();
			conn.close();
		}catch(Exception e)
		
		{
			e.printStackTrace();
		}
		try
		{
			conn1.close();
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		try
		{
			fleetview.closeConnection1();
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		try
		{
			fleetview.closeConnection();
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
	
}
%>
	<%
//fleetview.closeConnection1();
//fleetview.closeConnection();
%>
</jsp:useBean>
<%@ include file="footernew.jsp"%>