<%@ include file="headernew.jsp" %>
<!-- 	<link rel="stylesheet" type="text/css" href="css/form.css" media="all"> -->

<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<html>
<head>
<script language="javascript" type="text/javascript" src="js/calendar.js"></script>
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
function FillSubCategory()
{
	try{
		var b=0;
		var category=document.getElementById("trNm").value;
		 
		var ajaxRequest;  // The variable that makes Ajax possible!
		try{// Opera 8.0+, Firefox, Safari
			ajaxRequest = new XMLHttpRequest();	}  
		catch (e)
		{// Internet Explorer Browsers
			try{ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");} 
			catch (e)
			{try{ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");} 
				catch (e)
				{// Something went wrong
					alert("Your browser broke!");return false;}}}
		 
		ajaxRequest.onreadystatechange = function()
		{	if(ajaxRequest.readyState == 4)
			{try{	
				var reslt=ajaxRequest.responseText;
				//alert(reslt);
				reslt=reslt.replace(/^\s+|\s+$/g,'');
				var respo=reslt.split("~");
				//alert(respo);
				if(respo[0]=="Not"){
												
					 
					}else 
					{
						
					
						var anOption = document.createElement("trNm1");
					
					}
					
				var select = document.getElementById("trNm1");
					select.options.length = 0;
				
				var select = document.getElementById("trNm1");
				for(index in respo) {
					
					select.options[select.options.length] = new Option(respo[index], respo[index]);
					}				
						
				
				}catch(e)
				{alert(e);}}};
			
		var queryString = "?&category="+category+"";
		
		ajaxRequest.open("POST", "trainerhistoryAjax.jsp" + queryString, true);
		ajaxRequest.send(null); 
		}
		
	    catch(e)
		{
			alert(e);
		}
}

</script>
</script>
</head>
<body>
<form action="" method="get" name="trainerhistory" onSubmit="return validate('data','data1');">
<input type="hidden" id="PageName" name="PageName" value="<%=PageName%>"/>
<%!
Connection conn=null;
Statement st,st1, stmt1,dbst;
String date1, date2,datenew1,datenew2, vehcode, vehregno,tbname,sql,owner,km,rating,from,to,ndcount;
int os,ra,rd,cd,nd,osdur;
String oscount,racount,rdcount,cdcount;
String pagefrom="";
%>
<%
String QryStr="",QryStr1="";
String trname=request.getParameter("trNm");
String trname1=request.getParameter("trNm1");

if(trname1==null||trname1.equalsIgnoreCase("null"))
{}
else{
if(trname1.equalsIgnoreCase("All"))
{QryStr="";	
}
else{
	 QryStr="and DriverName='"+trname1+"'";
	 QryStr1="and a.DriverName='"+trname1+"'";
}}


System.out.println("QryStr: "+QryStr+" QryStr1: "+QryStr1);


String brfDate = "";
String trainername = "";
String brStatus = "";
String tripid=request.getParameter("tripid");

pagefrom=request.getParameter("rdpassport");
datenew1=request.getParameter("data") ;
datenew2=request.getParameter("data1");


NumberFormat nf1 = DecimalFormat.getNumberInstance();
nf1.setMaximumFractionDigits(2);
nf1.setMinimumFractionDigits(2);	
nf1.setGroupingUsed(false);


if(null==datenew1)
{
	datenew1=datenew2=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	date1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datenew1));
	date2=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datenew1));

}
else
{
	date1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datenew1));
	date2=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datenew2));

}
//out.print(tbname);
try
{
	//Class.forName(MM_dbConn_DRIVER);
	conn = fleetview.ReturnConnection();
	st=conn.createStatement();
	st1=conn.createStatement();
	dbst=conn.createStatement();
%>
<table width="100%" align="center" class="" border="0">
<tr>
<td width="100%" align="center">
	<font face="Arial" size="2" color="blue"><b>&nbsp;&nbsp;&nbsp; Trainer History Report </b></font>
</td>
</tr>
</table>

	<table  width="100%" align="center"><br></br>
	
		<tr>
			<td><font face="Arial" size="2" color="">Trainer Name :</font> &nbsp;&nbsp;
					<input type="hidden" name="pgFrom" id="pgFrom" value="<%=pagefrom%>">
					<select name="trNm" id="trNm" class="element select medium" style="width: 200px" onchange="javascript:FillSubCategory()">
					<option value="ALL">All</option>			
					<%
					Calendar cal1 = Calendar.getInstance();
					cal1.setTime(new java.util.Date());
					cal1.add(Calendar.MONTH, -6);
					java.util.Date d = cal1.getTime();
					String d1 = new SimpleDateFormat("yyyy-MM-dd").format(d);
					
					
					sql="select TrainerName from t_briefing where brifdate >= '"+d1+"' group by TrainerName";
					//sql="select Distinct(Username) as TrainerName from t_security where (TypeofUser like '%SUBUSER%' and TypeValue like '%Castrol%') and Username like '%@%' order by Username Asc";
					 
					ResultSet rsttrainer=st.executeQuery(sql);
					while(rsttrainer.next())
					{try{
					
					if(trname.equalsIgnoreCase(rsttrainer.getString("TrainerName")))
					{	%>
					
					<option value="<%=rsttrainer.getString("TrainerName")%>" selected="selected"><%=rsttrainer.getString("TrainerName")%></option>				
					<%
					}else{
					%>
					
					<option value="<%=rsttrainer.getString("TrainerName")%>"><%=rsttrainer.getString("TrainerName")%></option>				
					<%}
					}catch(Exception e)
					{
						e.printStackTrace();
						
					}
					}						
					%>
					</select>
			</td>
			<td><font face="Arial" size="2" color="">Driver Name :</font> &nbsp;&nbsp;
					<input type="hidden" name="pgFrom1" id="pgFrom1" value="<%=pagefrom%>">
					<select name="trNm1" id="trNm1" class="element select medium" style="width: 200px" >
					<option value="ALL">All</option>	
					<%
					//sql="select DriverName from db_gps.t_briefing where TrainerName Not like '%he_india%' group by DriverName";
					sql="select DriverName from db_gps.t_briefing where brifdate >= '"+d1+"' group by DriverName";
					
					//sql="select Distinct(Username) as TrainerName from t_security where (TypeofUser like '%SUBUSER%' and TypeValue like '%Castrol%') and Username like '%@%' order by Username Asc";
					 
					ResultSet rstDriver=st.executeQuery(sql);
					while(rstDriver.next())
					{try{
						if(trname1.equalsIgnoreCase(rstDriver.getString("DriverName")))
						{
					%>
					<option value="<%=rstDriver.getString("DriverName")%>" selected="selected"><%=rstDriver.getString("DriverName")%></option>				
					<%}else{
						%>
						<option value="<%=rstDriver.getString("DriverName")%>"><%=rstDriver.getString("DriverName")%></option>				
						<%
					}}catch(Exception e)
					{
						e.printStackTrace(); 
					}
					}						
					%>	
					
					</select> 
			</td>
			
			<td>
			<font face="Arial" size="2" color="">Category :</font> &nbsp;&nbsp;
			<select name="rdpassport" id="rdpassport" class="element select medium" style="width: 120px">
					<option value="both">All</option>					
					<option value="brif">Briefing History</option>		
					<option value="debrif">Debriefing History</option>		
					</select>
						
						
			</td>
		
			<td><font face="Arial" size="2" color="">From Date :</font> &nbsp;&nbsp;			
					<input type="text" id="data" name="data" class="element text medium" value="<%=datenew1%>"  size="15" readonly/>
					<script type="text/javascript">
  					Calendar.setup(
    				{
      				inputField  : "data",         // ID of the input field
      				ifFormat    : "%d-%b-%Y",     // the date format
      				button      : "data"       // ID of the button
    				}
  					);
					</script>
			</td>
			<td>			<font face="Arial" size="2" color="">To Date :</font> &nbsp;&nbsp;
					<input type="text" id="data1" name="data1" class="element text medium" value="<%=datenew2%>" size="15" readonly/>
					<script type="text/javascript">
  					Calendar.setup(
    				{
      				inputField  : "data1",         // ID of the input field
      				ifFormat    : "%d-%b-%Y",    // the date format
      				button      : "data1"       // ID of the button
    				}
  					);
					</script>
			</td>
		
			<td>
			
					<input type="submit" name="submit" id="submit" style="border-style: outset; border-color: black" value="submit">
			</td>					
		</tr>	
	</table>  
	</form>  

 <%
 if(!(null==request.getParameter("submit")))
 {
 %> 
<table width="100%" align="center" class="stats">
<tr>
<td  class="sorttable_nosort">
         <div id="report_heding" align="center"><b><font color="brown" size="2"><% if(pagefrom.equals("brif")) {out.print(" Briefing ");}else if(pagefrom.equals("debrif")){ out.print(" Debriefing ");}else{out.print(" Briefing Debriefing  ");} %> Report for Trainer <%=trname %> and Driver <%=trname1 %> from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date1))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date2))%></font></b></div>
         <div align="right">
         <a href="#" onclick="javascript:window.print();" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; <a href="excel_brif_trinerbrifsum.jsp?data=<%=date1%>&data1=<%=date2%>&trNm=<%=trname%>&trNm1=<%=trname1%>&pgFrom=<%=pagefrom%>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;
		 <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())%>
		 </div>
</td>
</tr>
</table>
<table width="100%" border="0" align="center" class="sortable" >
<tr>
	<th  rowspan="2" align="center" > Sr.</th>
		<%
		if(trname.equals("ALL") && pagefrom.equals("brif") || trname.equals("ALL") && pagefrom.equals("debrif") )
		{
		%>
			<th  rowspan="2" align="center" > Trainer</th>
		<%
		}
				
		if(pagefrom.equals("brif"))
		{
		%>
			<th class="sorttable_sorted" rowspan="2" colspan="3" align="center" > Briefing Date</th>
			<th class="sorttable_sorted" rowspan="2" colspan="3" align="center" > Briefing Id</th>
		<%
		}
		else if((pagefrom.equals("debrif")))
		{
		%>
			<th class="sorttable_sorted" rowspan="2" colspan="3" align="center" > Debriefing Date</th>
			<th class="sorttable_sorted" rowspan="2" colspan="3" align="center" > Debriefing Id</th>
		<%
		}
		else
		{
		%>
			<th class="sorttable_sorted" rowspan="2" colspan="3" align="center" > Briefing Date</th>
			<th class="sorttable_sorted" rowspan="2"  colspan="3" align="center"> Debriefing Date</th>
			<th class="hed" rowspan="2" colspan="3" align="center" > Briefing Id</th>
			<th class="hed" rowspan="2" colspan="3" align="center" > Debriefing Id</th>	
		<%	
		}
		%>
		<%
		if(pagefrom.equals("both"))
		{
		%>
				<th class="hed" rowspan="2" colspan="3" align="center">Briefing Trainer</th>
				<th class="hed" rowspan="2" colspan="3" align="center">Debriefing Trainer</th>
		<%
		}
		%>
			<th class="hed" rowspan="2" align="center" style="width: 120px;">VehicleRegistration NO.</th>
			<th class="hed" rowspan="2" align="center">Trip id</th>
			<th class="hed" colspan="2" align="center">Driver</th>
			<th class="hed" rowspan="2" align="center">Transporter</th>
			<th class="hed" colspan="2" align="center">Trip</th>
			<%
			if(pagefrom.equals("brif")||pagefrom.equals("both"))
				{
				%>
				<th class="hed" colspan="7" align="center">Briefing</th>
								
				<%}
			
			if(pagefrom.equals("debrif")||pagefrom.equals("both"))
			{
			%>
			<th class="hed" colspan="8" align="center">De Briefing</th>
							
			<%} 	
				
				
				%>
				
		
			<th class="hed" colspan="7" align="center">Violations</th>
			<%
			if(pagefrom.equals("brif"))
				{
				%>
				<th class="hed"  align="center">Score</th>
				<%	}
			if(pagefrom.equals("debrif"))
			{
			%>
			<th class="hed" colspan="2" align="center">Score</th>
			<%	}
			
			if(pagefrom.equals("both"))
			{
			%>
			<th class="hed" colspan="3" align="center">Score</th>
			<%	}
			
			
		%>
			</tr>
			
			<tr>
			<th></th>
			<th></th>
				<th></th>
			<th></th>
			<th></th>
			<th></th>
			<th></th>
			<th></th>
			<th></th>
			<th></th>
			<th></th>
			<th></th>
			<th></th>
			
			<th></th>
			<th></th>
			<th></th>
			<th></th>
			<th></th>
			<th></th>
			<th></th>
			<th></th>
			
			
			
			
			
				
				<th class="hed" align="center" style="width: 40%">Name</th>
				<th class="hed" align="center">Driver Id</th>
				<th>
				</th>
				<th class="hed" align="center">Origin</th>
				<th class="hed" align="center">Destination</th>
				
				<%
			if(pagefrom.equals("brif")||pagefrom.equals("both"))
				{
				
				
				%>
				<th class="hed"  align="center">Incident</th>
				<th class="hed"  align="center">DMC</th>
				<th class="hed"  align="center">Goals</th>
<!-- 				<th class="hed"  align="center">JRM Brif</th> -->
				<th class="hed"  align="center">JRM Percent</th>
				<th class="hed" align="center">JRM Reason</th>
				<th class="hed" align="center">ProbCD</th>
				<th class="hed" align="center">ProbND</th>
				
				
								
				<%} %>
		
		<%
			if(pagefrom.equals("debrif")||pagefrom.equals("both"))
				{
				%>
				<th class="hed"  align="center">AdhJRM</th>
				<th class="hed"  align="center">JRM Reason</th>
				<th class="hed"  align="center">AdhJourney</th>
				<th class="hed"  align="center">JRN Reason</th>
				<th class="hed"  align="center">Feedback</th>
				<th class="hed"  align="center">Goals Achived</th>
				<th class="hed"  align="center">Near Miss</th>
				<th class="hed"  align="center">NMDescription</th>
				
				
								
				<%} %>
		
				
				<th class="hed" align="center">OS</th>
				<th class="hed" align="center">OS Dur.</th>
				<th class="hed" align="center">RA</th>
				<th class="hed" align="center">RD</th>
				<th class="hed" align="center">CD</th>
				<th class="hed" align="center">ND</th>
				<th class="hed" align="center">Rating</th>
				
				<%
			if(pagefrom.equals("brif")||pagefrom.equals("both"))
				{  
				%>
				<th class="hed" align="center">Max Score</th>
				<%	}
				
			if(pagefrom.equals("debrif")||pagefrom.equals("both"))
				{  
				%>
				<th class="hed" align="center">Auto Score</th>
				<th class="hed" align="center">Councillor Score </th>
				<%	}
			
		%>
				
			</tr>
			<%
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DATE, -3);
			String twodaysback = dateFormat.format(cal.getTime()); 
			//prevDayDate = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(yesrtday));
			
			if(pagefrom.equals("brif"))
			{
				if(trname.equals("ALL"))
				{
					sql="select * from t_briefing where brifdate>='"+date1+" 00:00:00' and brifdate<='"+date2+" 23:59:59' "+QryStr+"  order by brifdate desc";	
				}
				else
				{	
					sql="select * from t_briefing where trainername ='"+trname+"' and  brifdate>='"+date1+" 00:00:00' and brifdate<='"+date2+" 23:59:59' "+QryStr+" order by brifdate desc";
				}
			}
			
			else if(pagefrom.equals("debrif"))
			{
				if(trname.equals("ALL"))
				{
					sql="select * from t_debriefing where Debriefdate>='"+date1+" 00:00:00' and Debriefdate<='"+date2+" 23:59:59' "+QryStr+" order by Debriefdate desc";				}
				else
				{	
					sql="select * from t_debriefing where Trainername ='"+trname+"'  and  Debriefdate>='"+date1+" 00:00:00' and Debriefdate<='"+date2+" 23:59:59' "+QryStr+" order by Debriefdate desc";
				}
			}
			else
			{
				if(trname.equals("ALL")) 
				{
					
					//sql="select a.briefid as Briefid,b.debriefid as debriefid,a.brifdate ,a.tripid,a.drivername,a.driverid,b.debriefdate,a.gpsdata,a.jrm,a.remark as BriefingRemark,b.trainername as dbtrainer,a.trainername as btrainer,b.remark as DebriefingRemark,a.* from t_briefing a,t_debriefing b where a.debrifstatus in ('debrifed','debriefed') and (a.briefid=b.briefid) and (a.brifdate>='"+date1+" 00:00:00' and a.brifdate<='"+date2+" 23:59:59') "+QryStr1+" order by a.brifdate desc";
					sql="select a.Transporter as Transporter,b.AdhJRM as AdhJRM,b.AdhJRMReason as AdhJRMReason,b.AdhJourney as AdhJourney,b.AdhJourneyReason as AdhJourneyReason,b.FeedBack as FeedBack,b.GoalsAchived as GoalsAchived,a.Incident as Incident,a.Dmc as Dmc,a.GoalsToBeAchieved as GoalsToBeAchieved,a.JRM as JRM,a.JrmPersent as JrmPersent,a.JrmReason as JrmReason,a.probableCD as probableCD,a.probableND as probableND,a.startplace as startplace,a.endplace as endplace,a.TrainerName as TrainerName,a.VehRegNo as VehRegNo,a.scr_N_DH,a.scr_N_ND,a.scr_N_CD,a.scr_N_DVI,a.scr_N_Adh,a.briefid as Briefid,b.debriefid as debriefid,a.brifdate as brifdate,a.tripid as tripid,a.drivername as drivername,a.driverid as driverid,b.debriefdate as debriefdate,a.gpsdata as gpsdata,a.jrm as jrm,a.remark as BriefingRemark,b.trainername as dbtrainer,a.trainername as btrainer,b.remark as DebriefingRemark  from  t_briefing a left outer join t_debriefing b on a.tripid=b.tripid where ((a.brifdate>='"+date1+" 00:00:00' and a.brifdate<='"+date2+" 23:59:59') or (b.Debriefdate>='"+date1+" 00:00:00' and b.Debriefdate<='"+date2+" 23:59:59')) "+QryStr1+" order by a.brifdate desc";
				}
				else
				{
					//sql="select a.briefid as Briefid,b.debriefid as debriefid,a.brifdate,a.tripid,a.drivername,a.driverid,b.debriefdate,a.gpsdata,a.jrm,a.remark as BriefingRemark,b.trainername as dbtrainer,a.trainername as btrainer,b.remark as DebriefingRemark,a.* from t_briefing a,t_debriefing b where (a.trainername like '"+trname+"') and a.debrifstatus in ('debrifed','debriefed') and (a.briefid=b.briefid) and (a.brifdate>='"+date1+" 00:00:00' and a.brifdate<='"+date2+" 23:59:59') "+QryStr1+" order by a.brifdate desc";
					sql="select a.Transporter as Transporter, b.AdhJRM as AdhJRM,b.AdhJRMReason as AdhJRMReason,b.AdhJourney as AdhJourney,b.AdhJourneyReason as AdhJourneyReason,b.FeedBack as FeedBack,b.GoalsAchived as GoalsAchived,a.Incident as Incident,a.Dmc as Dmc,a.GoalsToBeAchieved as GoalsToBeAchieved,a.JRM as JRM,a.JrmPersent as JrmPersent,a.JrmReason as JrmReason,a.probableCD as probableCD,a.probableND as probableND,a.startplace as startplace,a.endplace as endplace,a.TrainerName as TrainerName,a.VehRegNo as VehRegNo,a.scr_N_DH,a.scr_N_ND,a.scr_N_CD,a.scr_N_DVI,a.scr_N_Adh,a.briefid as Briefid,b.debriefid as debriefid,a.brifdate as brifdate,a.tripid as tripid,a.drivername as drivername,a.driverid as driverid,b.debriefdate as debriefdate,a.gpsdata as gpsdata,a.jrm as jrm,a.remark as BriefingRemark,b.trainername as dbtrainer,a.trainername as btrainer,b.remark as DebriefingRemark ,b.NearMiss as NearMiss,b.NMDescription as NMDescription from  t_briefing a left outer join t_debriefing b on a.tripid=b.tripid where (a.trainername ='"+trname+"') and ((a.brifdate>='"+date1+" 00:00:00' and a.brifdate<='"+date2+" 23:59:59') or (b.Debriefdate>='"+date1+" 00:00:00' and b.Debriefdate<='"+date2+" 23:59:59')) "+QryStr1+" order by a.brifdate desc";
				}
			}
			System.out.println("sql2 : "+sql);		
			ResultSet rst=st.executeQuery(sql);
			int i=1;
			while(rst.next())
			{
				int scr_N_DH=0,scr_N_ND=0,scr_N_CD=0,scr_N_DVI=0,scr_N_Adh=0,scr_DH=0,scr_ND=0,scr_CD=0,scr_DVI=0,scr_Adh=0,Total_Scr=0,scr_C_DH=0,scr_C_ND=0,scr_C_CD=0,scr_C_DVI=0,scr_C_Adh=0,Total_C_Scr=0;		
				
				
				String tripidnew="";
				String brifdate="-",debrifdate="-",Debrisql="";
				String brifDebrifDate;
				tripidnew = rst.getString("tripid");
				
				//sql="select * from t_completedjourney where date(startdate)<='"+rst.getDate("brifdate")+"' and driverid='"+rst.getString("DriverId")+"' order by StartDate desc limit 1";
				sql="select * from t_completedjourney where tripid='"+tripidnew+"' and driverid='"+rst.getString("DriverId")+"' ";
				
				ResultSet rsttrip=st1.executeQuery(sql);
				System.out.println("sql : "+sql);

			vehregno="-";
			vehregno="-";
			owner="-";
			
			km="-";
			double rating=0.0;
			from="-";
			to="-";
			
			oscount="-";
			racount="-";
			rdcount="-";
			cdcount="-";
			ndcount="-";
			osdur=0;
			
			
			if(pagefrom.equals("brif"))
			{
			
			scr_N_DH=rst.getInt("scr_N_DH");
			scr_N_ND=rst.getInt("scr_N_ND");
			scr_N_CD=rst.getInt("scr_N_CD");
			scr_N_DVI=rst.getInt("scr_N_DVI");
			scr_N_Adh=rst.getInt("scr_N_Adh");
			}
					
			
			if(pagefrom.equals("both"))
			{
			scr_N_DH=rst.getInt("a.scr_N_DH");
			scr_N_ND=rst.getInt("a.scr_N_ND");
			scr_N_CD=rst.getInt("a.scr_N_CD");
			scr_N_DVI=rst.getInt("a.scr_N_DVI");
			scr_N_Adh=rst.getInt("a.scr_N_Adh");
			}
			
			
			
			
			System.out.println("to"+to);
			
			if(rsttrip.next())
			{			
			km=rsttrip.getString("KmTravelled");
			rating=rsttrip.getDouble("TripRating");
			//from=rsttrip.getString("StartPlace");
			//to=rsttrip.getString("EndPlace");
			tripidnew=rsttrip.getString("tripid");
			
			oscount=rsttrip.getString("OsCount");
			racount=rsttrip.getString("RaCount");
			rdcount=rsttrip.getString("RdCount");
			cdcount=rsttrip.getString("CrCount");
			ndcount=rsttrip.getString("NDCount");
			osdur=rsttrip.getInt("OSDuration");
			
			
			
				scr_DH =rsttrip.getInt("scr_DH");
				scr_ND =rsttrip.getInt("scr_ND");
				scr_CD =rsttrip.getInt("scr_CD");
				scr_DVI =rsttrip.getInt("scr_DVI");
				scr_Adh =rsttrip.getInt("scr_Adh");
				
				
				scr_C_DH=rsttrip.getInt("scr_N_DH");
				scr_C_ND=rsttrip.getInt("scr_N_ND");
				scr_C_CD=rsttrip.getInt("scr_N_CD");
				scr_C_DVI=rsttrip.getInt("scr_N_DVI");
				scr_C_Adh=rsttrip.getInt("scr_N_Adh");
			
			
		
			}
			
			
			if(pagefrom.equals("debrif"))
			{
				if(trname.equals("ALL"))
				{
		Debrisql="select * from t_briefing where tripid='"+tripidnew+"' and Driverid='"+rst.getString("DriverId")+"' ";
				}
				else{
					Debrisql="select * from t_briefing where  tripid='"+tripidnew+"' and Driverid='"+rst.getString("DriverId")+"' ";

					
				}
			ResultSet derst=dbst.executeQuery(Debrisql);
			System.out.println("Debrief is  ==" +Debrisql);
			if(derst.next())
			{
				
					vehregno=derst.getString("VehRegNo");
					
					owner=derst.getString("Transporter");
					
					from=derst.getString("startplace");
					to=derst.getString("endplace");
					
				
			}
			}
			
					
			%>
			<tr>
			<td style="text-align: right"><%=i%></td>
			
			<%
			if(trname.equals("ALL") && pagefrom.equals("brif") || trname.equals("ALL") && pagefrom.equals("debrif"))
			{
				%>		
				<td style="text-align: left">
				<%
				out.print(rst.getString("TrainerName"));
				%>
				</td>
				<%
				
			}
			if(pagefrom.equals("brif"))
			{
				brifdate = rst.getString("brifdate");
				brifDebrifDate =brifdate;
			%>		
			
			<td colspan="3" style="text-align: right">
			<%
			out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("brifdate"))));
			
			%>
			</td>
			<td colspan="3" style="text-align: right"><%=rst.getString("Briefid")%></td>
			<%
			}
			else if(pagefrom.equals("debrif"))
			{
				debrifdate = rst.getString("Debriefdate");
				brifDebrifDate=debrifdate;
			%>
			
			<td colspan="3" style="text-align: right">
			<%
			try{
			out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("Debriefdate"))));
			}catch(Exception ee)
			{
				out.print("-");
			}
			%>	
			</td>
			<td colspan="3" style="text-align: right"><%=rst.getString("debriefid")%></td>
			<%
			}		
			else
			{
				brifdate = rst.getString("brifdate");
				debrifdate = rst.getString("debriefdate");
				brifDebrifDate=brifdate;
			%>
			<td colspan="3" style="text-align: right">
			<%
				out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("brifdate"))));
			%>
			</td>
			<td colspan="3" style="text-align: right">
			<%
			try
			{
					out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("debriefdate"))));
			}
			catch(Exception ee)
			{
				out.print("-");
			}
			%>
			</td>
			<td colspan="3" style="text-align: right"><%=rst.getString("Briefid")%></td>
			<td colspan="3" style="text-align: right"><%
			try{if
				(rst.getString("debriefid").equalsIgnoreCase("null")){out.print("-");
				}
			
			else{
				out.print(rst.getString("debriefid"));}
			}catch(Exception e){out.print("-");}
			%></td><%
			}
			if(pagefrom.equals("both"))
			{
			%>
			<td colspan="3" style="text-align: left"><%=rst.getString("btrainer")%></td>
			<td colspan="3" style="text-align: left"><%
			try{if(rst.getString("dbtrainer").equalsIgnoreCase("null"))
			{out.print("-");
			}
			else{
				out.print(rst.getString("dbtrainer"));
			}
			}
			catch(Exception e)
			{out.print("-");
			}		
			%></td>
			<%
			}
			%>
			<%
			if(pagefrom.equals("brif")||pagefrom.equals("both"))
			{
				%>
				<td style="text-align: left; width: 200px; "><%=rst.getString("VehRegNo")%></td>
				<%

			}
			else{
				%>
								<td style="text-align: left; width: 200px; "><%=vehregno%></td>
				
				<%
								
			}
			 %>
			 
			<%
			//String today = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
			java.util.Date dtbrif = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(brifDebrifDate);
			java.util.Date dtprev = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(twodaysback);
			int days=0;
			String numOfDays = "SELECT TO_DAYS('"+brifDebrifDate+"') - TO_DAYS('"+twodaysback+"') as days";
			ResultSet rss = st1.executeQuery(numOfDays);
			if(rss.next())
			{
				days = Integer.parseInt(rss.getString("days"));
				//System.out.println("days=========>"+days);
			}
			if((dtbrif.compareTo(dtprev)>0))
				//else if(days<2)
				{
					
					%>
					
					<td style="text-align: right"><a href="#" onclick="javascript:window.open('enterTripid.jsp?&rdpassport=<%=pagefrom %>&brifId=<%=rst.getString("Briefid") %>&briefdate=<%=brifdate %>&debrifdate=<%=debrifdate %>&CurrTripId=<%=tripidnew %>','','top=400, left=400,menubar=1,resizable=1,scrollbars=1,width=600,height=150,location=no');"><%=tripidnew%></a></td>
					<%
				}
			else{
				%>
				<td style="text-align: right"><%=tripidnew%></td>
				<%
			}
			
			%>
			
			<td style="text-align: left" style="width: 40%"><%=rst.getString("DriverName")%></td>
			<td style="text-align: right"><%=rst.getString("driverid")%></td>
			<%
			if(pagefrom.equals("brif")||pagefrom.equals("both"))
			{
				%>
				<td style="text-align: left"><%=rst.getString("Transporter")%></td>
				<td style="text-align: left"><%=rst.getString("startplace")%></td>
			<td style="text-align: left"><%=rst.getString("endplace")%></td>
				
				<%
			}
			else{
			%>
			<td style="text-align: left"><%=owner%></td>
					<td style="text-align: left"><%=from%></td>
			<td style="text-align: left"><%=to%></td>
			<%} %>
			
					
			<%
			if(pagefrom.equals("brif")||pagefrom.equals("both"))
			{
				String Incident="";
			  
						
				
			try{
				Incident = new String(rst.getString("Incident"));
				Incident = Incident.replace("~",",\n"); 
								
			}catch(Exception e){
				Incident="NA";
			}
			
			
			%><td style="text-align: left"><%=Incident%></td><%
			String Dmc="";
				try{
					Dmc = new String(rst.getString("Dmc"));
					Dmc = Dmc.replace("~",",\n"); 
									
				}catch(Exception e){
					Dmc="NA";
				}	
				%><td style="text-align: left"><%=Dmc%></td><%
						
						
				String GoalsToBeAchieved="";
				try{
					GoalsToBeAchieved = new String(rst.getString("GoalsToBeAchieved"));
					GoalsToBeAchieved = GoalsToBeAchieved.replace("~",",\n"); 
									
				}catch(Exception e){
					GoalsToBeAchieved="NA";
				}	
				%><td style="text-align: left"><%=GoalsToBeAchieved%></td><%
						
						
				String JRM="";
				try{
					JRM = new String(rst.getString("JRM"));
									
				}catch(Exception e){
					JRM="NA";
				}	
				%>
<%-- 				<td style="text-align: left"><%=JRM%></td> --%>
				<%
						
						String JrmPersent ="";
				try{
					JrmPersent  = new String(rst.getString("JrmPersent"));
									
				}catch(Exception e){
					JrmPersent ="NA";
				}	
				%><td style="text-align: right"><%=JrmPersent %></td><%
					
						String JrmReason  ="";
				try{
					JrmReason   = new String(rst.getString("JrmReason"));
									
				}catch(Exception e){
					JrmReason  ="NA";
				}	
				%><td style="text-align: left"><%=JrmReason %></td><%
		String probcd="",probnd="";
				
				probcd=rst.getString("probableCD");
				probnd=rst.getString("probableND");
						
				%>
				<td style="text-align: left"><%=probcd %></td>
				<td style="text-align: left"><%=probnd %></td>
				
				<%		
				
			}
	
			if(pagefrom.equals("debrif")||pagefrom.equals("both"))
			{
				String AdhJRM="";
			
			
				
			try{
				AdhJRM = new String(rst.getString("AdhJRM"));
			}catch(Exception e){
				AdhJRM="NA";
			}
			
			
			%><td style="text-align: left"><%=AdhJRM%></td><%
					
			String AdhJRMReason="";
				try{
					AdhJRMReason = new String(rst.getString("AdhJRMReason"));
					AdhJRMReason = AdhJRMReason.replace("~",",\n"); 
									
				}catch(Exception e){
					AdhJRMReason="NA";
				}	
				%><td style="text-align: left"><%=AdhJRMReason%></td><%
						
						
				String AdhJourney="";
				try{
					AdhJourney = new String(rst.getString("AdhJourney"));
					 
									
				}catch(Exception e){
					AdhJourney="NA";
				}	
				%><td style="text-align: left"><%=AdhJourney%></td><%
						
						
				String AdhJourneyReason="";
				try{
					AdhJourneyReason = new String(rst.getString("AdhJourneyReason"));
									
				}catch(Exception e){
					AdhJourneyReason="NA";
				}	
				%><td style="text-align: left"><%=AdhJourneyReason%></td><%
						
						
						
						String FeedBack ="";
				try{
					FeedBack  = new String(rst.getString("FeedBack"));
									
				}catch(Exception e){
					FeedBack ="NA";
				}	
				%><td style="text-align: left"><%=FeedBack %></td><%
					
						String GoalsAchived   ="";
				try{
					GoalsAchived    = new String(rst.getString("GoalsAchived"));
									
				}catch(Exception e){
					GoalsAchived   ="NA";
				}	
				%><td style="text-align: left"><%=GoalsAchived  %></td><%
						
						
						String NearMiss   ="";
				try{
					NearMiss    = new String(rst.getString("NearMiss"));
									
				}catch(Exception e){
					NearMiss   ="NA";
				}	
				%><td style="text-align: left"><%=NearMiss  %></td><%
						
						
						String NMDescription   ="";
				try{
					NMDescription    = new String(rst.getString("NMDescription"));
									
				}catch(Exception e){
					NMDescription   ="NA";
				}	
				%><td style="text-align: left"><%=NMDescription  %></td><%
				
			}
			
			
			
			%>
				
			<td style="text-align: right"><%=oscount%></td>
			<td style="text-align: right"><%=osdur%></td>
			<td style="text-align: right"><%=racount%></td>
			<td style="text-align: right"><%=rdcount%></td>
			<td style="text-align: right"><%=cdcount%></td>
			<td style="text-align: right"><%=ndcount%></td>
			<%
			//if(rsttrip.getDouble("KmTravelled")==0.0 || km.equals("-"))
				//out.println(km);
				if(km.equals("0") || km.equals("-"))
			{
				%>
				
				<td colspan="1" style="text-align: right">NA</td>
				<%
			}
			else
			{
			%>
			<td colspan="1" style="text-align: right"><%=nf1.format(rating)%></td>
				
			<%
			}
				
				int Total_N_Scr=0;
				
				
				%>
			
				<%
			if(pagefrom.equals("brif")||pagefrom.equals("both"))
			{				Total_N_Scr=scr_N_DH+scr_N_ND+scr_N_CD+scr_N_DVI+scr_N_Adh;	
			
				%><td style="text-align: right"><%=Total_N_Scr%></td>
				<%
			}
			if(pagefrom.equals("debrif")||pagefrom.equals("both"))
			{

				Total_Scr=scr_DH+scr_ND+scr_CD+scr_DVI+scr_Adh;	
				
				Total_C_Scr=scr_C_DH+scr_C_ND+scr_C_CD+scr_C_DVI+scr_C_Adh;	

				%><td style="text-align: right"><%=Total_Scr%></td>
				<td style="text-align: right"><%=Total_C_Scr%></td>
				<%			}
				
			%>			
			</tr>			
			<%
			i++;
			}
			%>
			</table>
			
 <%
 }
  }catch(Exception e){
 	out.print("Exception::"+e);
 }
  finally
  {
	try
	{ conn.close();}
	catch(Exception e)
	{}
	try
	{fleetview.closeConnection();}
	catch(Exception e)
	{}	
  }
%>

</body>
</html>
</jsp:useBean>

<%@include file="footernew.jsp" %>