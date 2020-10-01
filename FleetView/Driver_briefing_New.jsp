<%@ include file="headernew.jsp" %>
<%//System.out.println("---------check1111111 "); %> 
<%@page import="sun.util.resources.CalendarData_mk"%><jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<%//System.out.println("-check "); %>
<%!
Connection conn;
Statement st,st1,st12,st13, st2,st3,stmt4,stmt41,stmt1,stmt2,st121,st131;
%>
<script type="text/javascript">
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

function gotoExcel(elemId, frmFldId)  
{  	
	      var obj = document.getElementById(elemId);  
          var oFld = document.getElementById(frmFldId); 
          oFld.value = obj.innerHTML;  
          document.TrainerRun.action ="excel.jsp";
          document.forms["TrainerRun"].submit();
         
}

</script>
<%
	
try{	
	
		
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	
	st=conn.createStatement();
	st1 = conn.createStatement();
	
	st12 = conn.createStatement();
	st13 = conn.createStatement();
	st121 = conn.createStatement();
	st131 = conn.createStatement();
	st2=conn.createStatement();
	st3=conn.createStatement();
	stmt4=conn.createStatement();
	stmt41=conn.createStatement();
	stmt1=conn.createStatement();
	stmt2=conn.createStatement();
	int UType=0;
	final String UserTypeValue =(String) session.getAttribute("usertypevalue");
	System.out.println("UserTypeValue : "+UserTypeValue);
	String Pdate1="";
	int i=0;
	
	String vehfit="";
	String TrainerNm = "TrainerNm";
	//System.out.printf(date1+" : "+date2+" : "+TrainerNm);
	String ChType = "ChType",sql1="",DriverId="";
	String datenew1,datenew2, vehcode, vehregno,tbname,sql11="",owner,km,rating,from,to,ndcount,FrDate,ToDate;
	int os,ra,rd,cd,nd;
	String oscount,racount,osdur,rdcount,cdcount,FrDate2,ToDate2;
	String sql="",sql2="",sql3="",Transpo="",VehRegNo="";
		int i1=0,i2=0;
	 Calendar cal1=Calendar.getInstance();
	 String RejectStatus="",BrifingStatus="",Debrifstatus="",brifstatus="",DebriefingStatus="",BriefidN="",tripid="",brifdate="",startplace="",VehType="",endplace="",probenddate="",CleanerName="",CleanerId="",Transporter="",StatDrv="";
	 String S1= "";
	 
	 String TripStartDate="",TripEndDate="";
	 
		String DriverIdList="";
	
		
		
		
		////////////////////////////////////////////////
		
	%>	
	
	 
<form name="driverbriefingform" method="POST" action=""  >
	<input type="hidden" id="PageName" name="PageName" value="<%=PageName%>"/>  
	
		<table border="0" bgcolor="white" width="100%">
	<tr>
		<td>
		<table border="0" width="100%" class="stats">
			<tr>
				<td>
				<div align="center"><font size="2"> <B>
				Driver Briefing </B> </font></div>
				</td>
			</tr>
		</table>

		<%
			
		%>
		<table class="stats">
			
			<tr>
				<td>
					<div align="left"> <B> Search </B> &nbsp;&nbsp;&nbsp; 
						<input type="text" name="srchbx" id="srchbx" class="formElement"  /> &nbsp;&nbsp;&nbsp;
                         <input type="submit" value="Submit" name="btnSearch"  class="formElement" />
	                         	Please enter Driver Name or Driver Id. Matching values would come below in the table automatically .
		        	</div>
				</td>
				
			</tr>
		<tr>
				<td align="left"><div align="left">If you want to see all pending Briefing \ De-briefing <a href= "driver_briefing_open.jsp" target="_blank" >click here</a></div></td>
		</tr>
	
		</table>

		<table class="stats">

			<tr>
				<td>
				<div id="driverinfo"></div>
				</td>
			</tr>		</table>
		</td>
	</tr>
	</table>
</form>	<%
		
		String searchValue = request.getParameter("srchbx");
			
		if (null != searchValue) {
			
			searchValue = searchValue.replace(" ", "");
	
			int numRecords = 0;
		
			/* if(UserTypeValue.equalsIgnoreCase("ALL"))
			{		
			if(searchValue.length()>0)
			{
				sql="SELECT * FROM db_gps.t_drivers where  DriverID like '%"+searchValue+"%' or DriverName like '%"+searchValue+"%'  ORDER BY DriverName  ASC";
				
			}else{
			
			
			sql="SELECT * FROM db_gps.t_drivers  ORDER BY DriverName  ASC";
			}
			} */
		
			
			if(searchValue.length()>0)
			{
				sql="SELECT * FROM db_gps.t_drivers where (Owner='"+UserTypeValue+"' or GPNAME='"+UserTypeValue+"') and Activestatus='Active' and (DriverID like '%"+searchValue+"%' or DriverName like '%"+searchValue+"%') ORDER BY DriverName  ASC";		
				
			}else
			{
			sql="SELECT * FROM db_gps.t_drivers where (Owner='"+UserTypeValue+"' or GPNAME='"+UserTypeValue+"') and Activestatus='Active' ORDER BY DriverName  ASC";
			}
			
		
		
		ResultSet rst=st.executeQuery(sql);
		
		System.out.println("Driver Id Query : "+sql);		
		int l=0;
			
			
		%>
		
					 <table border="1"  class="sortable" width="100%"  style="text-align: center;">
             
            <tr>
        <th>Sr.No.</th>
		<th>Driver Name</th>
		<th>Driver Id</th>
		<th>Transporter</th>
		<th>Rejection</th>		
		<th>Status</th>	
			
		<th>Brief DT</th>
		<th>Brief ID</th>
		<th>Brief Trip ID</th>
		<th>Trip Start Date</th>
		<th>Trip End Date</th>			
							
		<th>De-Brief DT</th>
		<th>De-Brief ID</th>
		<th>De-Brief Trip ID</th> 
		<th>Trip Start Date</th>
		<th>Trip End Date</th>	
			</tr>			
		
		
		
		
		<%
		
		
		
		while(rst.next())
		{
		System.out.println(rst.getString("Owner"));
			%>

			
			<%

			TripStartDate="-";
			TripEndDate="-";
			
			int Msgid = 0;
			String sql31 = "select * from db_gps.t_usermessage where UserTypeValue  = '"+rst.getString("Owner")+"' ";
			System.out.println("sql31 : : "+sql31);
			ResultSet rs3 = stmt2.executeQuery(sql31);
		
			if(rs3.next())
			{
				Msgid = rs3.getInt("MessageID");
			}
			
			System.out.println("Msgid : : "+Msgid);
			 if(Msgid == 4)
			 {i++;
				 
				 %>
				 <tr>
				 <td style='text-align: right'><%=i%></td>
				 <td style='text-align: left'><%=rst.getString("DriverName")%></td>
				 <td style='text-align: right'><%=rst.getString("DriverID")%></td>
				
				  <td style='text-align: left'><%=rst.getString("Owner")%></td>
				  <td style='text-align: left' >Blocked</td>
				  <td  >-</td>
			  <td  >-</td>
			  <td  >-</td>
			  <td  >-</td>
			  <td  >-</td>
			  <td >-</td>
			  <td >-</td>
			    <td  >-</td>
			  <td  >-</td>
			  <td  >-</td>
			  <td  >-</td>
			
				  </tr>  
				 <%
			 }
			 else
			
			 {
				 
			
			
		sql1="SELECT Briefid,Status,DeBrifingStatus,brifstatus,Debrifstatus,probenddate,tripid,	brifdate,startplace,endplace,VehType,VehRegNo,Transporter,CleanerName,CleanerId FROM db_gps.t_briefing WHERE Driverid ='"+rst.getString("DriverID")+"' order by brifdate desc limit 1";
		ResultSet rst1=st1.executeQuery(sql1);
		System.out.println("sql1 : t_briefing : "+sql1);
		i1 = 1;
		if(rst1.next())
		{			
			i++;
			 S1="-";
				BrifingStatus="Open";
				DebriefingStatus="-";
				
			%>
	<tr>
		<td style='text-align: right'> <%=i%></td>
	
<%		
							try{
							
					BrifingStatus=rst1.getString("Status");
					DebriefingStatus=rst1.getString("DeBrifingStatus");
					brifstatus=rst1.getString("brifstatus");
					Debrifstatus=rst1.getString("Debrifstatus");
					probenddate=rst1.getString("probenddate");
					BriefidN=rst1.getString("Briefid");
					tripid=rst1.getString("tripid");
					brifdate=rst1.getString("brifdate");
					startplace=rst1.getString("startplace");
					endplace=rst1.getString("endplace");
					VehType=rst1.getString("VehType");

					VehRegNo=rst1.getString("VehRegNo");
					Transporter=rst1.getString("Transporter");
					CleanerName=rst1.getString("CleanerName");
					CleanerId=rst1.getString("CleanerId");
					
					
					String sql12="SELECT concat(StartDate,' ',StartTime) as StartDate FROM db_gps.t_startedjourney WHERE TripID='"+tripid+"' and  DriverCode ='"+rst.getString("DriverID")+"'";
					ResultSet rst12=st12.executeQuery(sql12);
					System.out.println("sql1 : t_briefing : "+sql12);
					if(rst12.next())
					{
						TripStartDate=rst12.getString("StartDate");
					}		
					
					String sql13="SELECT EndDate FROM db_gps.t_completedjourney WHERE TripID='"+tripid+"' and  DriverID ='"+rst.getString("DriverID")+"'";
					ResultSet rst13=st13.executeQuery(sql13);
					System.out.println("sql1 : t_briefing : "+sql13);
					if(rst13.next())
					{
						TripEndDate=rst13.getString("EndDate");
					}	
					       
					
					String sql121="SELECT concat(StartDate,' ',StartTime) as StartDate FROM db_gps.t_startedjourney WHERE TripID='"+tripid+"' and  DriverCode ='"+rst.getString("DriverID")+"'";
					ResultSet rst121=st121.executeQuery(sql121);
					System.out.println("sql1 : t_briefing : "+sql121);
					if(rst121.next())
					{
						TripStartDate=rst121.getString("StartDate");
					}		
					
					String sql131="SELECT EndDate FROM db_gps.t_completedjourney WHERE TripID='"+tripid+"' and  DriverID ='"+rst.getString("DriverID")+"'";
					ResultSet rst131=st131.executeQuery(sql131);
					System.out.println("sql1 : t_briefing : "+sql131);
					if(rst131.next())
					{
						TripEndDate=rst131.getString("EndDate");
					}
					
					
					
					
					}
					catch(Exception e)
					{
					e.printStackTrace();
					
					}

		RejectStatus="-";
		String sql41 = "SELECT Status FROM db_gps.t_reasonOfRejectionForDriver WHERE ReasoneForRejection='Driver Rejection'  and DriverId ='"+rst.getString("DriverID")+"' ORDER BY UpdatedDateTime DESC";
		ResultSet rs41= stmt41.executeQuery(sql41);
		System.out.println("Loop 1 :"+sql41);
		if(rs41.next()){
		if(rs41.getString("Status").equalsIgnoreCase("Yes"))
			{RejectStatus="Rejected";				
			}
		else 
			{
				RejectStatus="Pass";					
			}
		
			}else
			{
				RejectStatus="-";	
			}
		
		
		System.out.println("rst.getString(DriverID)"+rst.getString("DriverID"));
		System.out.println("rst.getString(Owner)"+rst.getString("Owner"));
		
		
		if(RejectStatus.equalsIgnoreCase("Rejected"))
		{		System.out.println("Test Reject :");
		%>
		<td style='text-align: left'>		
		<a href="#" onclick="javascript:window.open('driver_briefing_Driver_Reject.jsp?driverid=<%=rst.getString("DriverID")%>','','menubar=1,resizable=1,scrollbars=1,width=800,height=200');"><%=rst.getString("DriverName") %> </a>
		</td>
		
	<%	
		
		}
		else{
			
			System.out.println("Test Else  :");
		if(("briefed".equals(brifstatus)) && "not debriefed".equalsIgnoreCase(Debrifstatus) && "-".equalsIgnoreCase(DebriefingStatus)  && "-".equalsIgnoreCase(BrifingStatus))
		{		System.out.println("DeBriefed");
	
				%>
			<td style='text-align: left'><a target="_blank" href='BrifReg.jsp?driverid=<%=rst.getString("DriverID")%>&drivername=<%=rst.getString("DriverName")%>&trans=<%=rst.getString("Owner")%>'>
			<%=rst.getString("DriverName")%> </a></td>
			
		<%	
		S1="DeBriefed";
		%>
	
<%	
		}else if(("briefed".equals(brifstatus)) && ("not debriefed".equalsIgnoreCase(Debrifstatus)))
		{		System.out.println("Briefed");
			if(DebriefingStatus.equalsIgnoreCase("-") && BrifingStatus.equalsIgnoreCase("Close"))
			{	
%>
		<td style='text-align: left'><a target="_blank"  href="driver_debrifing_Reg_New.jsp?driverid=<%=rst.getString("DriverID")%>&drivername=<%=rst.getString("DriverName")%>&trans=<%=rst.getString("Owner")%>&briefid=<%=rst1.getString("Briefid") %>">
			<%=rst.getString("DriverName")%></a></td>
<%
			S1="Briefed";
			}
			else if(DebriefingStatus.equalsIgnoreCase("Open") && BrifingStatus.equalsIgnoreCase("Close"))			
			{			System.out.println("Open Debriefing :");		
			%>
			<td style='text-align: left'><a  target="_blank" href= "driver_debriefing_Update.jsp?driverid=<%=rst.getString("DriverID")%>&briefid=<%=BriefidN%>&drivername=<%=rst.getString("DriverName")%>&TripId=<%=tripid %>&PDate=<%=probenddate %>&veh=<%=VehRegNo %>&transporter=<%=Transporter %>" target="_blank" >
					<%=rst.getString("DriverName")%></a></td>
			<%
			S1="Open Debriefing";
			}
			else if(DebriefingStatus.equalsIgnoreCase("-") && BrifingStatus.equalsIgnoreCase("Open"))
			{		System.out.println("Open Briefing :");
				if(i==270)
				{System.out.println("asassas");}
				%>
				<td style='text-align: left'><a  target="_blank" href="briefing_page.jsp?driverid=<%=rst.getString("DriverID")%>&transporter=<%=rst.getString("Owner") %>&drivername=<%=rst.getString("DriverName")%>&trans=<%=rst.getString("Owner")%>&briefId=<%=BriefidN %>&TripId=<%=tripid %>&BrifDate=<%=brifdate %>&startP=<%=startplace %>&endP11=<%=endplace %>&veh=<%=VehRegNo %>&VehType=<%=VehType %>&CleanerId=<%=CleanerId %>&CleanerName=<%=CleanerName %>">	
						<%=rst.getString("DriverName")%></a></td>
						
						
			<%
			S1="Open Briefing";
			
			}else
			{
				System.out.println("Debried 2 :");
			
				%>
				<td style='text-align: left'><a  target="_blank" href='BrifReg.jsp?driverid=<%=rst.getString("DriverID")%>&drivername=<%=rst.getString("DriverName")%>&trans=<%=rst.getString("Owner")%>'>
				<%=rst.getString("DriverName")%> </a></td>
			<%	
			S1="DeBriefed";
						
		
		%>		
	<%}
			%>
			
			<%
			}
		else if(("debriefed".equalsIgnoreCase(Debrifstatus) || ("debrifed".equalsIgnoreCase(Debrifstatus)) ))
	{			System.out.println("Debriefin 3 :"+rst.getString("DriverName"));		%>
				<td style='text-align: left'><a  target="_blank" href='BrifReg.jsp?driverid=<%=rst.getString("DriverID")%>&drivername=<%=rst.getString("DriverName")%>&trans=<%=rst.getString("Owner")%>' target="_blank" >
				<%=rst.getString("DriverName")%> </a></td>
			<%	
			S1="DeBriefed";
			System.out.println("Debriefin 3 :");			
		
		%>
		
		
				
	<%
			
			}
		
				
		 }
		
				
		
%>
	
	
		<td style='text-align: right'><%=rst.getString("DriverID")%></td>
		<td style='text-align: left'><%=rst.getString("Owner")%></td>
				<td><%=RejectStatus %></td>
		
		
<%
		

RejectStatus="-";

%>
				<td style='text-align: left'><%=S1%></td>
			
<%			
		
		
			String Date11="",DebriefId11="",DebriTripId="";
			String sql111 = "SELECT Debriefdate,debriefid,tripid from db_gps.t_debriefing where driverid='"+rst.getString("DriverID")+"' order by Debriefdate desc limit 1 ";
			ResultSet rs= stmt1.executeQuery(sql111);
			if(rs.next())
				{
				try{
					Date11=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("Debriefdate")));
					}
					catch(Exception e)
					{
					e.printStackTrace();	
					Date11="-";
					}
				DebriefId11=rs.getString("debriefid");
				DebriTripId=rs.getString("tripid");
				
				}
			
			try{
				brifdate=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(brifdate));
				}
				catch(Exception e)
				{
				e.printStackTrace();	
				Date11="-";
				}
			
			try{
				TripStartDate=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(TripStartDate));
				}
				catch(Exception e)
				{
				e.printStackTrace();	
				TripStartDate="-";
				}
			
			try{
				TripEndDate=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(TripEndDate));
				}
				catch(Exception e)
				{
				e.printStackTrace();	
				TripEndDate="-";
				}
			    
			String DeTripStartDate="",DeTripEndDate="";
			
			
			String sql121="SELECT concat(StartDate,' ',StartTime) as StartDate FROM db_gps.t_startedjourney WHERE TripID='"+DebriTripId+"' and  DriverCode ='"+rst.getString("DriverID")+"'";
			ResultSet rst121=st121.executeQuery(sql121);
			System.out.println("sql1 : t_briefing : "+sql121);
			if(rst121.next())
			{
				DeTripStartDate=rst121.getString("StartDate");
			}		
			
			String sql131="SELECT EndDate FROM db_gps.t_completedjourney WHERE TripID='"+DebriTripId+"' and  DriverID ='"+rst.getString("DriverID")+"'";
			ResultSet rst131=st131.executeQuery(sql131);
			System.out.println("sql1 : t_briefing : "+sql131);
			if(rst131.next())
			{
				DeTripEndDate=rst131.getString("EndDate");
			}
			
			
			try{
				DeTripStartDate=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(DeTripStartDate));
				}
				catch(Exception e)
				{
				e.printStackTrace();	
				DeTripStartDate="-";
				}
			
			try{
				DeTripEndDate=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(DeTripEndDate));
				}
				catch(Exception e)
				{
				e.printStackTrace();	
				DeTripEndDate="-";
				}
			
			
			%>
			
					
			<td style='text-align: right;'><%=brifdate%></td>
			<td style='text-align: right;'><%=BriefidN%></td>
			<td style='text-align: right;'><%=tripid%></td>
			<td style='text-align: right;'><%=TripStartDate%></td>
		<td style='text-align: right;'><%=TripEndDate%></td>		
		<td style='text-align: right;'><%=Date11%></td>
			<td style='text-align: right;'><%=DebriefId11%></td>
			<td style='text-align: right;'><%=DebriTripId%></td>	
				
			<td style='text-align: right;'><%=DeTripStartDate%></td>
		<td style='text-align: right;'><%=DeTripEndDate%></td>		
			<%  
			
			
		
		%>
		
	<%
%>
	</tr>

<%
	
		 }
		else
		{i++;
			%> <tr>
			 <td style='text-align: right'><%=i%></td>
			 <td style='text-align: left'><a target="_blank"  href='BrifReg.jsp?driverid=<%=rst.getString("DriverID")%>&drivername=<%=rst.getString("DriverName")%>&trans=<%=rst.getString("Owner")%>' target="_blank" >
			<%=rst.getString("DriverName")%> </a></td>
			 <td style='text-align: right'><%=rst.getString("DriverID")%></td>
			
			  <td style='text-align: left'><%=rst.getString("Owner")%></td>
			  <td ><%=RejectStatus%></td>
			  
			  <td style='text-align: left' >No Record</td>
			  <td  >-</td>
			  <td  >-</td>
			  <td  >-</td>
			  <td  >-</td>
			  <td  >-</td>
			  <td >-</td>
			  <td  >-</td>
			  <td  >-</td>
			  <td  >-</td>
			  <td  >-</td>
			 
			  
			  
			  </tr>
<%			
		}
	
	
			 }
		}	
		
%>		

  

</table>
<%
}
		%>
		 <script type="text/javascript">
	       var txtBox = document.getElementById("srchbx");
	      try{ 
	    	  if (txtBox != null) {txtBox.focus();
	    	  	  }
	      }
	      catch(e)
	      {	    	  }
	    </script><%

}
	
	catch(Exception e)
	{
		out.print("Exception "+e);
	}
	finally
	{
		try
		{
		conn.close();
		} 
		catch(Exception e){}
	
	}	
%>

</jsp:useBean>
<br>
<%@ include file="footernew.jsp"%>
