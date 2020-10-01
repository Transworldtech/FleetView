<%@ include file="headernew.jsp" %>

<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<script language="JavaScript1.2">

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



function addcomment(vehcode,vehregno)
{
	try{
		 //alert("******");
		window.open('addunlockcmnt.jsp?vehcode='+vehcode+'&vehregno='+vehregno,'win1','width=450,height=300,top=200,left=500');
	// alert("******");
	 }catch(e)
	 {
		 alert(e);
	 }
}

function Reload()
{
	//alert("Hej");  
    window.location.reload(); 
}
</script>
<%! Connection conn;%>

<%
try
{
       
		conn = fleetview.ReturnConnection();
		Statement st=null,st1=null,st2 = null;
		String sql=null;
		ResultSet rst=null;
		st=conn.createStatement();
		st1=conn.createStatement();
		st2=conn.createStatement();
String exportFileName="LockunlockReport.xls"; 
String category  = "",cat1 = "";


category = request.getParameter("category");
String status1=request.getParameter("Status");
String vio = request.getParameter("vio");
String briefid = request.getParameter("briefid");
int briefid1 = 1;
String backcolor = "All";
if(briefid == null || briefid.equalsIgnoreCase("null"))
{
	briefid1 = 1;
}
else
{
	briefid1 = Integer.parseInt(briefid);
}


String cat2 ="All";
if(status1 == null || status1.equalsIgnoreCase("null"))
{
	if(category == null || category.equalsIgnoreCase("null"))
	{
		category = "where category in ('Castrol Primary')";
		cat1 = "Castrol Primary";
		cat2 = "Castrol Primary";
	}
	else
		if( category == "All" || category.equalsIgnoreCase("All"))
	{
		cat2 = category;
		cat1 = category;
		cat1 = "All Category";
		category = "";
		
	}
		else
		{
			cat2 = category;
			cat1 = category;
			category = " where category in ('"+category+"') ";
		}
	backcolor = "All";
}
else
{
if(category == null || category.equalsIgnoreCase("null"))
{
	category = "where category in ('Castrol Primary') and ";
	cat1 = "Castrol Primary";
	cat2 = "Castrol Primary";
}
else
	if( category == "All" || category.equalsIgnoreCase("All"))
{
	cat2 = category;
	
	cat1 = "All Category";
	category = "where ";
	
}
	else
	{
		cat2 = category;
		cat1 = category;
		category = " where category in ('"+category+"') and";
	}

if((status1 == "Locked" || status1.equalsIgnoreCase("Locked")) && (vio == "Yes" || vio.equalsIgnoreCase("Yes")))
{
	category = category + " Status = 'Locked' and violated = 'Yes' ";
	backcolor = "#FF4949";
}
else
	if(status1 == "Locked" || status1.equalsIgnoreCase("Locked") && (briefid=="2" || briefid.equals("2")))
	{
		category = category + " Status = 'Locked' ";
		backcolor = "#BDB9B9";
	}
	else
		if(status1 == "Locked" || status1.equalsIgnoreCase("Locked") && (briefid=="0" || briefid.equals("0")))
		{
			category = category + " Status = 'Locked'";
			backcolor = "#FFEF7D";
		}
		else
			if(status1 == "Unlocked" || status1.equalsIgnoreCase("Unlocked"))
			{
				category = category + " Status = 'Unlocked' and CastrolUnlock = 'Yes' and TransUnlock = 'Yes' ";
				backcolor = "#92FF95";
			}
			else
				if(status1 == "cascomment" || status1.equalsIgnoreCase("cascomment"))
				{
					category = category + " Status = 'Unlocked' and CastrolUnlock = 'Yes'  and TransUnlock = '-' " ;
					backcolor = "#FF9D3C";
				}
				else
					if(status1 == "transcomment" || status1.equalsIgnoreCase("transcomment"))
					{
						category = category + " Status = 'Unlocked' and CastrolUnlock = '-'  and TransUnlock = 'Yes' ";
						backcolor = "#CF6EFF";
					}
	
}
 System.out.println("HHHHHH    "+backcolor);
%>
<div style="font-size: 1.7em; text-align: center; margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em">
	Fleet Audit Report for <%=cat1 %></div>
	<br>
	
<div  align="center">
<form name="lockulock" name="lockulock" action="" method="post">
<div id="table1" align="center">
<table border="0"  width="84%" align="center" >
		<tr align="right">
		<td align="right">
		<div class="bodyText" align="right">
                           <input type="hidden" id="tableHTML" name="tableHTML" value="" />  
                           <input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 
     
                           <a href="#" style="font-weight: bold; color: black; " onclick="gotoPrint('table1');">
                           <img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img></a> 
      
                           <a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('table1','tableHTML');">
                           <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img></a>
                           <%=fleetview.PrintDate() %>
                           </div>
		</td>
		</tr>
		</table>
		<%
		
		
		%>
<table width="100%" align="left" border="0">
<tr>
<td><div class="box" style="background-color: #FF4949; " align="right"><font color="#FF4949">Vi</font></div></td>
<td><a href="vehlockunlock.jsp?Status=Locked&vio=Yes&briefid=1&category=<%=cat2%>">Violator</a></td>
<td><div class="box" style="background-color: #BDB9B9;" align="right"><font color="#BDB9B9">br</font></div></td>
<td><font color="black">Locked and Briefed</font></td>
<td><div class="box" style="background-color: #FFEF7D;" align="right"><font color="#FFEF7D">nb</font></div></td>
<td><font color="black"> Locked and Not Briefed</font></td>
<td><div class="box" style="background-color: #92FF95;" align="right"><font color="#92FF95">un</font></div></td>
<td style="width: 7em;"><a href="vehlockunlock.jsp?Status=Unlocked&briefid=1&vio=No&category=<%=cat2%>"> Unlocked</a></td>
<td><div class="box" style="background-color: #FF9D3C;" align="right"><font color="#FF9D3C">uc</font></div></td>
<td><a href="vehlockunlock.jsp?Status=cascomment&briefid=1&vio=No&category=<%=cat2%>"> Unlocked by<br> Castrol</a></td>
<td><div class="box" style="background-color: #CF6EFF;" align="right"><font color="#CF6EFF">ut</font></div></td>
<td><a href="vehlockunlock.jsp?Status=transcomment&briefid=1&vio=No&category=<%=cat2%>"> Unlocked by<br> Transporter</a></td>
			<td align="center" style="width: 5em;">
			<a href="vehlockunlock.jsp?category=All">All</a>
			</td>
		<%
		sql = "select distinct(Category) from db_gps.t_vehiclelock ";
		rst = st.executeQuery(sql);
		while(rst.next())
		{
			if(rst.getString("Category")== "No Trip" ||  rst.getString("Category").equalsIgnoreCase("No Trip"))
			{
				
			}
			else
			{
			%>
			<td align="center">
			<a href="vehlockunlock.jsp?category=<%=rst.getString("Category") %>"><%=rst.getString("Category") %></a>
			</td>
			<%
			}
		}
		%>
		</tr>
		</table>
		<br></br>
		<br>
		<div align="left">
		<table  align="left" >
		<tr><td>
		<table align="left" class="sortable">
		<tr>
		<th>Sr.No</th>
		<th>VehRegNo</th>
		<th>Transporter</th>
		<th>Category</th>
		<th>Driver Name</th>
		<th>Driver ID</th>
		<th>Driver Mob. No. 1</th>
		<th>Driver Mob. No. 2</th>
		<th>Last Location</th>
		<th>Last Updated Date Time</th>
		<th>Trip ID</th>
		<th>Trip Origin</th>
		<th>Trip Destination</th>
		<th>Trip Start Date Time</th>
		<th>Trip Category</th>
		<th>Brief ID</th>
		<th>Trainer Name</th>
		<th>Brief Date</th>
		</tr>
		<%
		int i=1;
		sql = "select * from db_gps.t_vehiclelock "+category+"  order by vehcode ";
		rst = st.executeQuery(sql);
		System.out.println("******     "+sql);
		while(rst.next())
		{
			String vehcode = rst.getString("Vehcode");
			String vehregno = rst.getString("Vehregno");
			String Category = rst.getString("Category");
			String Status = rst.getString("Status");
			String Comments = rst.getString("Comments");
			String transcomment = rst.getString("TransComment");
			String casunlock = rst.getString("CastrolUnlock");
			String transunlock = rst.getString("TransUnlock");
			//String EntDateTime = rst.getString("UpdatedDateTime");
			//String EntryBy = rst.getString("EntryBy");
			String Latitude = rst.getString("Lockedtimelat");
			String Longitude = rst.getString("Lockedtimelong");	
			int BriefID = 0;
			String TrainerName = "";
			String BriefDate = "";
			String drivername = "",driverid = "",tripid = "",startlocation = "",endlocation = "",startdate = "";
			String transporter = "",lastloc = "",lastdate = "",lastlat = "",lastlong = "",mob1 = "",mob2 = "";
			String bgcolor = "",violation = "",tripcat = "";
			violation = rst.getString("violated");
			String sql1 = "select * from db_gps.t_vehicledetails where vehiclecode = '"+vehcode+"'";
			ResultSet rs = st1.executeQuery(sql1);
			if(rs.next())
			{
				transporter = rs.getString("OwnerName");
			}
			String tripid1 = "",startdate1 = "";
			sql1 = "select * from db_gps.t_startedjourney where vehid = '"+vehcode+"' order by StartDate desc,StartTime desc limit 1";
			rs = st1.executeQuery(sql1);
			if(rs.next())
			{
				//System.out.println("***    ");
				drivername = rs.getString("DriverName");
				driverid = rs.getString("DriverCode");
				tripcat =rs.getString("TripCategory");
				 tripid1 = rs.getString("tripid");
				 startdate1 =new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("StartDate")+" "+rs.getString("StartTime"))) ;
				if(rs.getString("JStatus") == "Running" || rs.getString("JStatus").equalsIgnoreCase("Running"))
				{
					tripid = rs.getString("tripid");
					startlocation = rs.getString("StartPlace");
					endlocation = rs.getString("EndPlace");
					startdate =new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("StartDate")+" "+rs.getString("StartTime"))) ;
				}
				else
				{
					tripid = "-";
					startlocation = "-";
					endlocation = "-";
					startdate = "-";
				}
				
			}
			else
			{
				drivername ="-";
					driverid = "-";
					tripcat = "-";
				tripid = "-";
				startlocation = "-";
				endlocation = "-";
				startdate = "-";
			}
			
			if(tripid1 == "" || tripid1.equalsIgnoreCase(""))
			{
				BriefID = 0;
		    	 TrainerName = "-";
		    	 BriefDate = "0000-00-00";
		    	 mob1 = "-";
			}
			else
			{
			sql1 = "select * from db_gps.t_briefing where  tripid='"+tripid1+"'";
		     rs = st1.executeQuery(sql1);
		   //  System.out.println("***    "+sql1);
		     if(rs.next())
		     {
		    	 BriefID = rs.getInt("Briefid");
		    	 TrainerName = rs.getString("Trainername");
		    	 BriefDate = rs.getString("brifdate");
		    	 mob1 = rs.getString("DrivMobNo");
		     }
		     else
		     {
		    	 String sql2 = "select * from db_gps.t_briefing where Driverid = '"+driverid+"' and brifdate = '"+startdate1+"' ";
		    	 ResultSet rs1 = st2.executeQuery(sql2);
		    	 if(rs1.next())
		    	 {
		    		 BriefID = rs1.getInt("Briefid");
			    	 TrainerName = rs1.getString("Trainername");
			    	 BriefDate = rs1.getString("brifdate");
			    	 mob1 = rs1.getString("DrivMobNo");
		    	 }
		    	 else
		    	 {
		    		 BriefID = 0;
			    	 TrainerName = "Not Briefed";
			    	 BriefDate = "0000-00-00";
			    	 mob1 = "-";
		    	 }
		    	 
		     }
			}
			
			
			sql1 = "select * from db_gps.t_onlinedata where vehiclecode = '"+vehcode+"'";
			 rs = st1.executeQuery(sql1);
			if(rs.next())
			{
				lastloc = rs.getString("Location");
				lastdate =new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("TheDate")+" "+rs.getString("TheTime")));
				lastlat = rs.getString("LatitudePosition");
				lastlong = rs.getString("LongitudePosition");
			}
			else
			{
				lastloc = "-";
				lastdate = "-";
				lastlat = "-";
				lastlong = "-";
			}
			
			if((Status == "Locked" || Status.equalsIgnoreCase("Locked")) && (violation == "Yes" || violation.equalsIgnoreCase("Yes")))
			{
				bgcolor = "#FF4949";
			}
			else
				if((Status == "Locked" || Status.equalsIgnoreCase("Locked")) && BriefID > 1)
				{
					bgcolor = "#BDB9B9";
				}
				else
					if((Status == "Locked" || Status.equalsIgnoreCase("Locked")) && BriefID == 0)
					{
						bgcolor = "#FFEF7D";
					}
					else
						if(Status == "Unlocked" || Status.equalsIgnoreCase("Unlocked"))
						{
							if((casunlock == "Yes" || casunlock.equals("Yes")) && (transunlock == "-" || (transunlock.equals("-"))))
							{
								bgcolor = "#FF9D3C";
							}
							else
								if((casunlock == "-" || casunlock.equals("-")) && (transunlock == "Yes" || (transunlock.equals("Yes"))))
								{
									bgcolor = "#CF90FF";
								}
								else
								{
									bgcolor = "#92FF95";
								}
						}
			    
			//System.out.println("bgcolor    "+bgcolor);
			
			   %>
			   <tr>
			   <td  align="right" style="background-color: <%=bgcolor %>;"><div align="right"><%=i %></div></td>
			   <%
			   if(Status == "Locked" || Status.equalsIgnoreCase("Locked"))
			   {
				   %>
				   <td style="background-color: <%=bgcolor %>;" align="left"><div align="left"><a href="#"  onclick="addcomment('<%=vehcode %>','<%=vehregno %>')"  title="Click here to unblock"><%=vehregno %></a></div></td>
				   <%
			   }
			   else
				   if(casunlock == "-" || casunlock.equals("-") || transunlock == "-" || transunlock.equals("-"))
			  		 {
				 		  %>
				   			<td style="background-color: <%=bgcolor %>;" align="left"><div align="left"><a href="#"  onclick="addcomment('<%=vehcode %>','<%=vehregno %>')"  title="Click here to unblock"><%=vehregno %></a></div></td>
				   		<%
			   		}
				   else
				   {
					   %>
			   			<td style="background-color: <%=bgcolor %>;" align="left"><div align="left"><%=vehregno %></div></td>
			   		<%
				   }
			   %>
			   
			   <td style="background-color: <%=bgcolor %>;" align="left"><div align="left"><%=transporter %></div></td>
			   <td style="background-color: <%=bgcolor %>;" align="left"><div align="left"><%=Category %></div></td>
			   <td style="background-color: <%=bgcolor %>;" align="left"><div align="left"><%=drivername %></div></td>
			   <td style="background-color: <%=bgcolor %>;" align="right"><div align="right"><%=driverid %></div></td>
			   <td style="background-color: <%=bgcolor %>;" align="right"><div align="right"><%=mob1 %></div></td>
			   <td style="background-color: <%=bgcolor %>;" align="right"><div align="right"><%=mob2 %></div></td>
			   <%
			   if(lastlat == "-" || lastlat.equalsIgnoreCase("-"))
			   {
				   %>
				   <td style="background-color: <%=bgcolor %>;" align="left"><div align="left"><%=lastloc%></div></td>
				   <%
			   }
			   else
			   {
				   %>
				   <td style="background-color: <%=bgcolor %>;" align="left"><div align="left"><%="<a href=\"shownewmap.jsp?lat="+lastlat+"&long="+lastlong+"&discription="+lastloc+"\"onclick=\"popWin=open('shownewmap.jsp?lat="+lastlat+"&long="+lastlong+"&discription="+lastloc+"','myWin','width=500, height=500'); popWin.focus(); return false\">"+lastloc+"</a>" %></div></td>
				   <%
			   }
				   
			   %>
			   
			   <td style="background-color: <%=bgcolor %>;" align="right"><div align="right"><%=lastdate %></div></td>
			   <td style="background-color: <%=bgcolor %>;" align="right"><div align="right"><%=tripid %></div></td>
			   <td style="background-color: <%=bgcolor %>;" align="left"><div align="left"><%=startlocation%></div></td>
			   <td style="background-color: <%=bgcolor %>;" align="left"><div align="left"><%=endlocation %></div></td>
			   <td style="background-color: <%=bgcolor %>;" align="right"><div align="right"><%=startdate%></div></td>	   
			   <td style="background-color: <%=bgcolor %>;" align="left"><div align="left"><%=tripcat%></div></td>	   
			   <td style="background-color: <%=bgcolor %>;" align="right"><div align="right"><%=BriefID%></div></td>	   
			    <td style="background-color: <%=bgcolor %>;" align="left"><div align="left"><%=TrainerName%></div></td>	
			    <%
			    if(BriefDate == "0000-00-00" || BriefDate.equalsIgnoreCase("0000-00-00"))
			    {
			    	%>
			    	<td style="background-color: <%=bgcolor %>;" align="right"><div align="right"><%=BriefDate%></div></td>	
			    	<%
			    }
			    else
			    {
			    %>   
			    <td style="background-color: <%=bgcolor %>;" align="right"><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(BriefDate))%></div></td>	   
			  <%
			    }
			  %>
			   </tr>
			   <%	
			   i++;
			}
		
		%>
		
		</table>
		</td>
		</tr>
		</table>
</div>
</div>
</form>
</div>

				
		
		<%
}
catch(Exception e)
{
	//out.print("Exception "+e);
	e.printStackTrace();
}
finally
{
	try
	{
		conn.close();
	}catch(Exception e)
	{e.printStackTrace();}
	try
	{
		fleetview.closeConnection();
	}catch(Exception e)
	{e.printStackTrace();}
}
%>
			
	
</body>
</html>
</jsp:useBean>
<%@ include file="footernew.jsp" %>	
