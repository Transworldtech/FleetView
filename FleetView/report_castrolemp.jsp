<%@ include file="headernew.jsp" %> 
 <jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
  <%!
	Connection conn, conn1;
	Statement st1,st2,st,st3,st4,st5,stndck,st21,st15,stmain11,stmain2,stt,st7,stmain12,stmain1,stmain3,stmain4;
	//int cntos,cntra,cntrda,cntdt,cntst,cntcd,cntnd,cntfc,datadaystotal;
	String datex1,datex2,data1,data2;
	String vehregno,transporter,empname,empcode;
%>
<% 
	conn= fleetview.ReturnConnection();
	conn1= fleetview.ReturnConnection1();
	st1=conn.createStatement();
	st2=conn.createStatement();
	st3=conn.createStatement();
	st4=conn.createStatement();
	st5=conn1.createStatement();
%>
  
<script type="text/javascript">  
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
           
           document.Total_os.action ="excel.jsp";
           document.forms["Total_os"].submit();
         
  }  

</script>
  

  <%
    
  //code to get system date as data2 and yesterdays date as a data1.

  String ddx=request.getQueryString();
  if(ddx==null)
  {
	  datex1=datex2=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
  	  data1=data2=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
  }
  else
  {
	  System.out.println("\n\n in date00000");
	  data1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data")));
	  System.out.println(" data1 "+data1);
	  
	  data2=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data1")));
	  System.out.println(" data2 "+data2);
	  
	  datex1=request.getParameter("data");
	  datex2=request.getParameter("data1");
  }
  
  session.setAttribute("data1",data1);
  session.setAttribute("data2",data2);
  String user,usertypevalue;
  user=session.getAttribute("user").toString();
  usertypevalue=session.getAttribute("usertypevalue").toString();
  %>
  <table border="0" width="500" align="center" class="stats">
		  <tr><td colspan="5" align="center">
		<font face="Arial" color="black" size="3"><b>Custom Report For Full Fleet</b></font>
		</td></tr>
</table>

<input type="hidden" id="PageName" name="PageName" value="<%=PageName%>"/>  
<div style="margin-left: 30%;">
<table border="0" width=600 align="center">


<form action="" method="get" onsubmit="return validate();">

<tr><br></br><td align="right">
<font face="Arial" color="black" size="2">From</font>&nbsp;&nbsp;
<input type="text" id="data" name="data" value="<%=datex1 %>" size="15" readonly/>
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data",         // ID of the input field
      ifFormat    : "%d-%b-%Y",     // the date format
      button      : "data"       // ID of the button
    }
  );
</script></td>
<td align="right">
<font face="Arial" color="black" size="2">To</font>&nbsp;&nbsp;
  <input type="text" id="data1" name="data1" value="<%=datex2 %>"  size="15" readonly/>

<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data1",         // ID of the input field
      ifFormat    : "%d-%b-%Y",    // the date format
      button      : "data1"       // ID of the button
    }
  );
</script></td>
<td>&nbsp;&nbsp;<input type="submit" name="submit" id="submit" value="submit"></td></tr>

</form>

</table>  

</div>

<table border="0" width="100%" class="stats">
<tr>
<td colspan="3" align="center">
<%
java.util.Date ShowDate = new SimpleDateFormat("yyyy-MM-dd").parse(data1);
Format formatter = new SimpleDateFormat("dd-MMM-yyyy");
String showdate = formatter.format(ShowDate);

Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
String showdate1 = formatter.format(new SimpleDateFormat("yyyy-MM-dd").parse(data2));
//String type=request.getParameter("type");
//System.out.println(">>>>>>>>>>type:"+type);
 %>
</td>
</tr>
</table> 
<table border="0" width="30%" align="left"> 
<tr>
<td  class="sorttable_nosort"><b>
<!--<a href="report_castrolempNew.jsp?data=<%=showdate%>&data1=<%=showdate1%>&submit=Submit&fleettype11=all&fleettype=all">Full Fleet</a></b>
--><input type="hidden" name="type" id="type" value="More Info"/>	

<input type="hidden" name="fleettype" id="fleettype" value="<%=request.getParameter("fleettype")%>"/>	
<input type="hidden" name="fleettype11" id="fleettype11" value="<%=request.getParameter("fleettype11")%>"/>	
		
</td>
		<!--<td class="sorttable_nosort"><b><a href="report_castrolempNew.jsp?data=<%=showdate%>&data1=<%=showdate1%>&submit=Submit&fleettype11=yes&fleettype=zerokm">Zero KM</a></b></td>
		<td class="sorttable_nosort"><b><a href="report_castrolempNew.jsp?data=<%=showdate%>&data1=<%=showdate1%>&submit=Submit&fleettype11=yes&fleettype=zerogps">Zero GPS Violation</a></b></td>
		<td class="sorttable_nosort"><b><a href="report_castrolempNew.jsp?data=<%=showdate%>&data1=<%=showdate1%>&submit=Submit&fleettype11=yes&fleettype=morethan5">Violations >5</a></b></td>
 
 --></tr>
 </table>

<form id="Total_os" name="Total_os" action="" method="post">
 <div id="mytable">


<%
String  exportFileName=session.getAttribute("mainuser").toString()+"_custom_report.xls";
%>		

		<table width=60%>
			<tr>
				<td align="right"><input type="hidden" id="tableHTML" name="tableHTML" value="" /> 
				   <input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 
<a href="#"	style="font-weight: bold; color: black;" onclick="gotoPrint('mytable');"> <img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img> </a>
<a href="#" onclick="gotoExcel('mytable','tableHTML')" title="Export to Excel">
<img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;
					<%=fleetview.PrintDate() %></td>
			</tr>
		</table>


<table border="0" bgcolor="white" width="100%">
	<tr>		
		 
<font face="Arial" color="black" size="2">Individual stops > 10 mins and cumulative stops > 20 mins are considered as stoppage in Continuous Driving. 
</font>
<br>
<font face="Arial" color="black" size="3">Exception Analysis Report For AVL Mobile Eye 2000 for <%=usertypevalue %> For the Period : 
<%

out.print(showdate);
%> 00:00:00 am to <%

out.print(showdate1);
session.setAttribute("ShowDate",showdate+" 00:00:00");
session.setAttribute("ShowDate1",showdate1+" 23:59:00");

String tdydate = new SimpleDateFormat("yyyy-mm-dd").format(new java.util.Date());

%> 23:59:00 am

</font>




<table border="1" width="100%" bgcolor="#F5F5F5" class="sortable">
  <tr>
      <th colspan="3" class="sorttable_nosort">
      <div align="center">Parameters considered for the Report</div>
      </th>
  </tr>
    
  <tr>
      <td class="bodyText">
      <div align="left">1. OverSpeed :<%=session.getAttribute("overspeed").toString() %>
      </div>
      </td>
      <td class="bodyText">
      <div align="left">2. Rapid Acceleration :<%=session.getAttribute("racc").toString()%>
      </div>
      </td>
      <td class="bodyText" >
      <div align="left">3. Rapid Deceleration :<%=session.getAttribute("rdcc").toString()%>
      </div>
      </td>
  </tr>
  
  <tr>
       <td class="bodyText">
       <div align="left">4. Night Driving : <%=session.getAttribute("ndri").toString() %> 
       </div>
       </td>
       <td class="bodyText">
       <div align="left">5. Continuous Driving :><%=session.getAttribute("cdri").toString() %>
       </div>
       </td>
       <td  class="bodyText">
       <div align="left">6. Stoppages  :<%=session.getAttribute("stop").toString() %>
       </div>
       </td>
  </tr>
</table>





<table border="1" width="100%" class="sortable">
       <tr >
           <th>Sr.</th>
           <th>Vehicle No.</th>
           <th>Veh.Type</th>
           <th>Employee Name</th>
           <th>Employee Code</th>
           <th>Transporter</th>
           <th>Date</th>
           <th>Location </th>
           <th>Data Days</th>
           <th>OS</th>
           <th>OS Dur</th>
           <th>RA</th>
           <th>RD</th>
           <th>CD</th>
           <th>DT</th>
           <th>ND</th>
		   <th>ND Km</th>
		   
		</tr>
		<% 
		int  cntra=0, cntrda=0, cntdt=0, cntst=0, cntcd=0, cntnd=0,cntndk=0,disk=0, cntfc=0, cntdisconn=0,
		cntft = 0, cntfa = 0,counter=0;
		double cntrh=0.0;
		double cntavg=0.00;
		double cntosdur,cntavgos=0.0;
		double tot_dur=0.0;
		double stopdur=0, totstopdur=0, cntrating=0,cntavgra=0.0,cntavgrd=0.0,timevikram=0.0;
		String str_os = "("; 
		String str_os1= "("; 
		String str_os2= "("; 
		String str_os3= "("; 
		int temp = 1;
		int temp1= 1 ;
		int temp2= 1;
		int temp3= 1;
		int nd_pri=0;
		int datadaystotal=0;
		int cntndpost=0;
		int cntos=0;
		int cntnd2;
		cntnd2=0;
		cntra=0;
		cntrda=0;
		cntdt=0;
		cntst=0;
		cntrh=0.0;
		cntcd=0;
		
		cntfc=0;
		cntosdur = 0.0;
		
		int count123=0,  datadayscount=0;
		String vehtype="-";
		String vehList, sql, sql1, sql2, VehCode;	
		String fleettype=request.getParameter("fleettype");
		
		int vehcode=0, i=1;
%>		
<%
		String VehList=session.getAttribute("VehList").toString();
		VehList=VehList.replace("(","");
		VehList=VehList.replace(")","");
		System.out.println(" Vehicle list "+VehList);
		
	  	StringTokenizer tokniozeVehList= new StringTokenizer(VehList,",");
	    System.out.println("Count Vehicle list "+tokniozeVehList.countTokens());
		
	
try		
{
			
		String token[]=VehList.split(",");
		
		String qmark="";
		for(int j=1;j<=token.length; j++)
		{	
			qmark=qmark+"?,";
			  
		}	
		System.out.println(" lenght qmark "+qmark.length()+ "  "+qmark);	
		qmark=qmark.substring(0,(qmark.length()-1));
		
		//String sqlcount="select count(*) as count,VehCode, SUM(OSCount) as OSCount, sum(Osduration) as Osduration, SUM(RACount) as RACount,SUM(RDCount) as RDCount,SUM(CRCount) as CRCount,SUM(Distance) as DTCount,SUM(StopCount) , SUM(RDuration), SUM(FACount),SUM(FTCount),SUM(RDinSec),SUM(RDurationinHrs),sum(FTCount),sum(FACount),sum(FC),AVG(FAVG) as FAVG,sum(NDCount) as ND,Sec_To_Time(SUM(Time_To_Sec(NDDurationinHrs))),SUM(Time_To_Sec(NDDurationinHrs)),sum(NDKm) as NDKm,sum(NDIntimation),sum(NDReason),sum(DCCount),sum(NDDurationinHrs) from  db_gpsExceptions.t_vehall_ds where VehCode in  "+VehList+" and TheDate >='"+data1+"' AND TheDate <='"+data2+"'  and Location <> 'No Data' group by VehCode";
		String sqlcount="select  VehCode, SUM(OSCount) as OSCount, sum(Osduration) as Osduration, SUM(RACount) as RACount,SUM(RDCount) as RDCount,SUM(CRCount) as CRCount,SUM(Distance) as DTCount,SUM(StopCount) , SUM(RDuration), SUM(FACount),SUM(FTCount),SUM(RDinSec),SUM(RDurationinHrs),sum(FTCount),sum(FACount),sum(FC),AVG(FAVG) as FAVG,sum(NDCount) as ND,Sec_To_Time(SUM(Time_To_Sec(NDDurationinHrs))),SUM(Time_To_Sec(NDDurationinHrs)),sum(NDKm) as NDKm,sum(NDIntimation),sum(NDReason),sum(DCCount),sum(NDDurationinHrs) from  db_gpsExceptions.t_vehall_ds where VehCode in ("+qmark+") and TheDate >=?  AND TheDate <=? group by VehCode";
		System.out.println("sql 3 "+sqlcount);
		PreparedStatement prest = conn1.prepareStatement(sqlcount);
		
		System.out.println("lenght "+token.length);
		int j=1;
		for(j=1;j<=token.length; j++)
		{	
			  prest.setString(j,token[j-1]);
			  System.out.println(" j--> "+j+" "+ token[j-1]);
		}	
			  prest.setString(j,data1);
			  prest.setString(j+1,data2);
		
			 ResultSet rstcounts=prest.executeQuery();		
		 	 
		
		cntos=0;
		while(rstcounts.next())
		{
			VehCode=rstcounts.getString("VehCode");
			
			//String vehDetails="select  VehCode, vehregno, Location,  TheDate, VehType,EmpName, EmpCode,Transporter  from db_gpsExceptions.t_vehall_ds where VehCode="+VehCode+" and TheDate>='"+data1+"' and TheDate <= '"+data2+"'  order by TheDate desc limit 1"  ;
			String vehDetails="select  VehCode, vehregno, Location,  TheDate, VehType,EmpName, EmpCode,Transporter  from db_gpsExceptions.t_vehall_ds where VehCode=? and TheDate>=? and TheDate <=? order by TheDate desc limit 1"  ;
			System.out.println(" sql 1 "+vehDetails);
			
			PreparedStatement prest2 = conn.prepareStatement(vehDetails);
		  	
			  prest2.setString(1,VehCode);
			  prest2.setString(2,data1);
			  prest2.setString(3,data2);
			    
					
			ResultSet rst1=prest2.executeQuery();	
			while(rst1.next())
			{
				%>	<tr>
					<td style="text-align: right"><%=i++ %></td>
					<td style="text-align: left"><a href="customreport.jsp?vid=<%=rst1.getString("VehCode")%>&vehno=<%=rst1.getString("vehregno")%>"><%=rst1.getString("vehregno")%></a></td>
					<td style="text-align: left"><%=rst1.getString("VehType") %></td>
					<td style="text-align: left"><%= rst1.getString("EmpName") %></td>
					<td style="text-align: right"><%= rst1.getString("EmpCode") %></td>
					<td style="text-align: left"><%= rst1.getString("Transporter") %></td>
					<td style="text-align: left"><%= new SimpleDateFormat("dd-MMM-yyyy").format(rst1.getDate("TheDate")) %></td>
			 		<td><div align="left">
					<%
					String location="-",dttime="";
					String loc=rst1.getString("Location");
					loc=rst1.getString("Location");
					
					String TheDate=rst1.getString("TheDate");
					
					//System.out.println("loc===>"+loc);
					if(!loc.equalsIgnoreCase("No data") && !("-").equals(loc))
					{
						 dttime=loc.substring(0,19);
						 location=loc.substring(19);
					}
					else{
						
						location=loc;
						dttime=formatter.format(new SimpleDateFormat("yyyy-MM-dd").parse(data2));
						
					}
					if(location.equalsIgnoreCase("No data"))
					{
						out.print(location);
					}
					else
					{
						out.print(fleetview.ShowOnMapOnlyByLocation(location,VehCode,TheDate));
					}
					%>
					</div>
					</td>
		<%}// end location %>
		
		<%	
			String datadays="select count(*) as count from db_gpsExceptions.t_vehall_ds where VehCode=? and TheDate>=? and TheDate <=? and Location <> 'No Data'";
			System.out.println(" sql datadays  "+datadays);
			
			
			PreparedStatement prest3 = conn.prepareStatement(datadays);
		  	
			  prest3.setString(1,VehCode);
			  prest3.setString(2,data1);
			  prest3.setString(3,data2);
			    
					
			ResultSet datadaysrs=prest3.executeQuery();	
			//ResultSet datadaysrs=st3.executeQuery(datadays);
			if(datadaysrs.next())
			{
				datadayscount=datadaysrs.getInt("count");
				datadaystotal=datadaystotal+datadayscount;
			}
			
			
			
		  %>	
			<td style="text-align: right"><%=datadayscount %></td>
			<td><div align="right">	
			<%				
			
			int os=rstcounts.getInt("OSCount");
			cntos+=os;
			if(os >0)
			{
				if(temp==1)
				 {
					 str_os=VehCode;
					 temp++;
				 }
					 else
			    str_os=str_os+","+VehCode; 
				
				%>
				<a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=VehCode%>"> <%=os%> </a> 
				<%				
			}
			else
			{
				out.print(os);
			}
			
		%></div></td>
		
		<%
				double osavg =0.0;
				double osduration=0.0;
				osduration=rstcounts.getDouble("Osduration");
				System.out.println(" OS Duration--->"+osduration);	
				
				cntosdur= cntosdur + osduration;
			%>
		<td>
		<div align="right"><%=osduration%></div></td>
		 	
		<td><div align="right">	
			<%
				
				
				int ra=rstcounts.getInt("RACount");
				cntra+=ra;
				if(ra>0)
				{
					
					if(temp1==1)
					 {
						 str_os1=VehCode;
						 temp1++;
					 }
						 else
				    str_os1=str_os1+","+VehCode; 
					
					%>
					<a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=VehCode%>"> <%=ra%> </a> 
					<%
				}
				else
				{
					out.print(ra);
				}

			%></div></td>
		<td><div align="right">	
		<%
			
				int rd=rstcounts.getInt("RDCount");
				cntrda+=rd;
				if(rd>0)
				{
					if(temp2==1)
					 {
						 str_os2=VehCode;
						 temp2++;
					 }
						 else
				    str_os2=str_os2+","+VehCode; 
					
					%>
					<a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=VehCode%>"> <%=rd%> </a> 
					<%
				}
				else
				{
					out.print(rd);
				}
					
		%></div></td>
		<td><div align="right">
			<%
				
				int cd=rstcounts.getInt("CRCount");
				cntcd+=cd;
				if(cd>0)
				{
					%>
					<a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=VehCode%>"> <%=cd%> </a> 
					<%
				}
				else
				{
					out.print(cd);
				}
			%></div></td>
			
		<td><div align="right">	
			<%
				int dt=rstcounts.getInt("DTCount");
				cntdt+=dt;
				out.print(dt);
			%>
		</div></td>
		<td><div align="right">	
		<%
		cntnd=0;
		//fleetview.NightDrivingFormExceptionsForDateRange(aa,data1,data2);
		cntnd= rstcounts.getInt("ND");
		System.out.println("ND  -->"+cntnd);
		String time1 ="00:00:00";
		String time2="23:59:59";
		
		 
		if(cntnd>0)
		{
			cntnd=rstcounts.getInt("ND");
		}	
		
		if(cntnd>0)
		{
			cntnd2+=cntnd;
			System.out.println("ND count  -->"+cntnd2);
		%> 
			<a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=VehCode%>">
			<%=cntnd%> </a> 
		<%
		}
		else
		{
			out.print(0);
		}
		%></div></td>
		<td><div align="right">	
			<%
				
				int cntndKM=rstcounts.getInt("NDKm");
	
				if(cntndKM>0)
				{
					cntndk+=cntndKM;
				%>			
					<%=cntndKM %>
				<%
				}else
				{
					out.print(0);
				}	
			%></div></td>	 
		</tr>
<%				
		}//if
		
%>			
	<tr >
        <td colspan="8" class="hed"> <div align="left">Total</div></td>
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
					
        <%if(cntrda>0){ %>	       
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
        <div align="right"><%=cntdt %></div>
        </td>
		        
		<%
		NumberFormat nf1=NumberFormat.getInstance();
		nf1.setMaximumFractionDigits(2);
		nf1.setMinimumFractionDigits(2);
		%>
		
		
		<%if(cntnd2>0){ %>              
         <td class="hed">
          <div align="right"><a href="#"
onclick="javascript:window.open('total_nd.jsp?count=<%=cntnd2%>');"><%=cntnd2 %></a></div>
           </td>
           <%}else {%>
                   <td class="hed">
                   <div align="right"><%=cntnd2 %></div>
                   </td>
                   <%} %>
         <td class="hed">
         <div align="right"><%=cntndk %></div>
         </td>	
   </tr>



				
<%
}catch(Exception e)
{
	System.out.println("Exception "+e.getMessage());	
}
			
%>
		
	
 </table>  

  </tr>
  </table>
   </div>
</form>


</jsp:useBean>
<%@ include file="footernew.jsp" %>