

<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());

String filename=session.getAttribute("user").toString()+showdatex+"trainer_report.xls";
response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="../Connections/conn.jsp" %>
<%!
Connection conn, con1;
Statement st,st1, stmt1,dbst;
String date1, date2,datenew1,datenew2, vehcode, vehregno,tbname,sql,owner,km,rating,from,to,ndcount;
int os,ra,rd,cd,nd,osdur;
String oscount,racount,rdcount,cdcount;
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





String brfDate = "";
String trainername = "";
String brStatus = "";
String tripid=request.getParameter("tripid");
String pagefrom=request.getParameter("pgFrom");
date1=request.getParameter("data");
date2=request.getParameter("data1");

NumberFormat nf1 = DecimalFormat.getNumberInstance();
nf1.setMaximumFractionDigits(2);
nf1.setMinimumFractionDigits(2);	
nf1.setGroupingUsed(false);
 if(null==date1)
 {
 	date1=date2=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
 }

	//out.print(tbname);
 
try{
Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=conn.createStatement();
st1=conn.createStatement();
dbst=conn.createStatement(); 
%>
 
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<title>Vehicle Tracking System</title>
</head>
<body >
	
	<table border="0" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" >
    <!-- body part come here -->
    
 		<tr><td>
				<table width="100%" align="center" border="0">
					<tr>
					<td  class="sorttable_nosort" colspan="21">
         	    <div id="report_heding" align="center"><b><font color="brown" size="2"><% if(pagefrom.equals("brif")) {out.print(" Briefing ");}else if(pagefrom.equals("debrif")){ out.print(" Debriefing ");}else{out.print(" Briefing Debriefing  ");} %> Report for Trainer <%=trname %> and Driver <%=trname1 %> from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date1))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date2))%></font></b></div>
     	<div align="right">
         		
					<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%>
					</div>
					</td>
			</tr>
			</table>
		</td></tr>
		<tr><td>	
		
			<table width="100%" border="1" align="center" class="sortable">
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
			<th class="hed" rowspan="2" colspan="3" align="center" > Briefing Id</th>
		<%
		}
		else if((pagefrom.equals("debrif")))
		{
		%>
			<th class="sorttable_sorted" rowspan="2" colspan="3" align="center" > Debriefing Date</th>
			<th class="hed" rowspan="2" colspan="3" align="center" > Debriefing Id</th>
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
			<th class="hed" rowspan="2" align="center" style="width: 120px;">Veh.</th>
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
			<th class="hed" colspan="6" align="center">De Briefing</th>
							
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
				
				<th class="hed" align="center" style="width: 40%">Name</th>
				<th class="hed" align="center">Driver Id</th>
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
			Calendar cal=Calendar.getInstance();
			cal.add(Calendar.DATE, -10);
			String twodaysback = dateFormat.format(cal.getTime()); 
		//	prevDayDate = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(yesrtday));

		
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
					sql="select a.Transporter as Transporter, b.AdhJRM as AdhJRM,b.AdhJRMReason as AdhJRMReason,b.AdhJourney as AdhJourney,b.AdhJourneyReason as AdhJourneyReason,b.FeedBack as FeedBack,b.GoalsAchived as GoalsAchived,a.Incident as Incident,a.Dmc as Dmc,a.GoalsToBeAchieved as GoalsToBeAchieved,a.JRM as JRM,a.JrmPersent as JrmPersent,a.JrmReason as JrmReason,a.probableCD as probableCD,a.probableND as probableND,a.startplace as startplace,a.endplace as endplace,a.TrainerName as TrainerName,a.VehRegNo as VehRegNo,a.scr_N_DH,a.scr_N_ND,a.scr_N_CD,a.scr_N_DVI,a.scr_N_Adh,a.briefid as Briefid,b.debriefid as debriefid,a.brifdate as brifdate,a.tripid as tripid,a.drivername as drivername,a.driverid as driverid,b.debriefdate as debriefdate,a.gpsdata as gpsdata,a.jrm as jrm,a.remark as BriefingRemark,b.trainername as dbtrainer,a.trainername as btrainer,b.remark as DebriefingRemark from  t_briefing a left outer join t_debriefing b on a.tripid=b.tripid where (a.trainername ='"+trname+"') and ((a.brifdate>='"+date1+" 00:00:00' and a.brifdate<='"+date2+" 23:59:59') or (b.Debriefdate>='"+date1+" 00:00:00' and b.Debriefdate<='"+date2+" 23:59:59')) "+QryStr1+" order by a.brifdate desc";
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
 
  }catch(Exception e){
 	out.print("Exception::"+e);
 }
  finally
  {
	try
	{
	  conn.close();
	}
	catch(Exception e)
	{
		
	}
	
  }
%>

<%@ include file="footernew.jsp" %>
</body>
</html>