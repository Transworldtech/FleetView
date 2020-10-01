<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
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
<body>
<table border="0" cellspacing="0" cellpadding="0" width="100%">
        <tr>
          <td width="1%" height="2"><img src="images/fboxtopleft.gif" width="20" height="12" alt="bk"/></td>
          <td class="fboxtop"><img src="images/spacer.gif" width="2" height="2" alt=" " /></td>
          <td width="1%" height="2"><img src="images/fboxtopright.gif" width="20" height="12" alt="bk"/></td>
        </tr>
        <tr>
          <td width="1%" class="fboxleft"><img src="images/spacer.gif" width="2" height="2" alt=" "/></td>

          <td width="98%" class="featureboxbg">
			<!-- header file -->
			<%@ include file="headerprintreport.jsp" %> 
			<%@ include file="Connections/conn.jsp" %>       
         <!-- header file -->
          </td>
          <td width="1%" class="fboxright" ><img src="images/spacer.gif" width="2" height="2" alt=" "/></td>
        </tr>
      
       <!-- <tr>
          <td width="1%" class="featureboxbg"><img src="images/fboxmiddleleft.gif" width="20" height="5" alt="bk" /></td>
          <td width="98%" class="fboxmiddle"><img src="images/spacer.gif" width="2" height="2" alt=" " /></td>
          <td width="1%" class="featureboxbg"><img src="images/fboxmiddleright.gif" width="20" height="5" alt="bk" /></td>
        </tr>
-->
        <tr>
          <td class="fboxlowleft">&nbsp;</td>
          <td>
			<!-- body part come here -->
	<link href="css/css.css" rel="StyleSheet" type="text/css">

<%!
	Connection conn, con1;
	Statement st, st1, st3;
	String sql;
	int kmrun1, kmrun2, kmrundist;
	String dateformat;
	
 %>
<form name="kmanalysis" method="get" action="">
<%
try{
		
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	con1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	
	st=conn.createStatement();
	st1=conn.createStatement();
	st3=con1.createStatement();
	dateformat=session.getAttribute("dateformat").toString();
%>
<table class="stats">
  <tr>
	<td colspan="16"><b>
		<font color="brown" size="2">Current Trip Report.</font></b>
</td>
</tr>
<tr>
<td class="hed" valign="top"> <br>Sr </b></td>
<td  class="hed" id="vehcol" valign="top"> <a href="#" onClick="hide('veh');" title="Click to hide TripId,Driver,StartDate,StartPlace,EndPlace Cols"><img id="img11" src="images/sub.jpg" width="13px" height="10px" border="0"> </a> <br> <B>Vehicle</td> 
<td class="hed" id="tripcol" valign="top"> <br> <B> TripID</B></br></td>
<td class="hed" id="drivcol" valign="top"> <br> <B> Driver</B></br></td>
<td class="hed" id="stdatecol" valign="top"> <br> <B>Start Date</B></br></td>
<td class="hed" id="stplacecol" valign="top"> <br> <B> Start Place</B></br></td>
<td class="hed" id="endplacecol" valign="top"> <br> <B> End Place</B></br></td>

<td class="hed" id="updtetmecol" valign="top"> <br> <B>Updated Date-Time</B></br></td>
<td class="hed" id="curposcol" valign="top"> <br> <B>Current Position</B></br></td>

<td class="hed" id="kmsruncol" valign="top"> <a href="#" onClick="hide('kmsrun');" title="Click to hide KmsToRun,ETA Cols"> <img src="images/sub.jpg" id="img2" width="13px" height="10px" border="0"></a> 

<% 
	if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
	{
%> 		<br><B>Miles to Run</B></br>
<%	}else
{ 
%>	<br><B>Kms to run</B></br>
<% } %>

</td>

<td class="hed" id="kmstoruncol" valign="top">
 <% 
	if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
	{
%> 		<br><B>Miles to Run</B></br>
<%	}else
{ 
%>	<br><B>Kms to run</B></br>
<% } %>

</td>

<td class="hed" id="etacol" valign="top">  <br> <B>ETA</td>


<td class="hed" id="fuelconscol" valign="top"> <a href="#" onClick="hide('fuelcons');" title="Click to hide LoadingDelay,TransitTime"> <img src="images/sub.jpg" id="img3" width="13px" height="10px" border="0"></a> <br> <B>Fuel Consumption</td>
<td class="hed" id="loaddelcol" valign="top">   <br> <B>Loading Delay</td>

<td class="hed" id="trantmecol" valign="top">  <br><B>Transit Time</td>
</tr>

<%
String today=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());	
sql="select * from t_startedjourney where Jstatus='Running' and Vehid in"+session.getAttribute("VehList").toString()+" order by StartDate desc";
ResultSet rsttrips=st.executeQuery(sql);
int j=1;
while(rsttrips.next())
{
String curpos="", updtetime="", lat="", lon="";
	String vehno=rsttrips.getString("VehRegNo");
	sql="select * from t_onlinedata where VehicleCode='"+rsttrips.getString("VehId")+"'";
//	out.print(sql);
	ResultSet rs1=st1.executeQuery(sql);
	if(rs1.next())
	{
		curpos=rs1.getString("Location");
		updtetime=new SimpleDateFormat(dateformat).format(new SimpleDateFormat("yyyy-MM-dd").parse(rs1.getString("TheDate")))+" "+rs1.getString("TheTime");
		lat=rs1.getString("LatitudePosition");
		lon=rs1.getString("LongitudePosition");
	}

	sql="select Distance from t_veh"+rsttrips.getString("VehId")+" where TheFieldDataDate ='"+today+"'  and TheFiledTextFileName='SI' order by TheFieldDataTime asc limit 1";
	//out.print(sql);
	ResultSet rstkmrun1=st1.executeQuery(sql);
	if(rstkmrun1.next())
	{
		kmrun1=rstkmrun1.getInt("Distance");
	}
	sql="select Distance from t_veh"+rsttrips.getString("VehId")+" where TheFieldDataDate ='"+today+"'  and TheFiledTextFileName='SI' order by TheFieldDataTime desc limit 1";
	ResultSet rstkmrun2=st1.executeQuery(sql);
	if(rstkmrun2.next())
	{
		kmrun2=rstkmrun2.getInt("Distance");
	}
	//kmrun3=km3+km2-km1; 
	//out.print(kmrun2-kmrun1);

	sql="select sum(Distance) as kmrundist from t_veh"+rsttrips.getString("VehId")+"_ds where TheDate>='"+rsttrips.getDate("StartDate")+"'";	
	ResultSet rstkmrtotrun=st3.executeQuery(sql);
	if(rstkmrtotrun.next())
	{
		kmrundist=rstkmrtotrun.getInt("kmrundist");
	}

	kmrundist=kmrundist+(kmrun2-kmrun1);  // Adding todays km also
%>
<tr>
<td><%=j%></td>
<td id="vehcol<%=j%>"><b><div align="left">  <%=rsttrips.getString("VehRegNo")%> </div></b></td>
<td id="tripcol<%=j%>"><%=rsttrips.getString("TripId")%></td>
<td id="drivcol<%=j%>"><div align="left"><%=rsttrips.getString("DriverName")+"("+rsttrips.getString("DriverCode")+")"%></div></td>
<td id="stdatecol<%=j%>">
<% try{
out.print(new SimpleDateFormat(dateformat).format(rsttrips.getDate("StartDate")));
}catch(Exception ee)
{
	out.print(rsttrips.getString("StartDate"));
}
%></td>
<td id="stplacecol<%=j%>"><div align="left"><%=rsttrips.getString("StartPlace")%></div></td>
<td id="endplacecol<%=j%>"><div align="left"><%=rsttrips.getString("EndPlace")%></div></td>
<td id="updtetmecol<%=j%>"><div align="left"><%=updtetime%> </div></td>
<td id="curposcol<%=j%>"><div align="left"> 
<a href="shownewmap.jsp?lat=<%=lat%>&long=<%=lon%>&discription=<%="<b>" + vehno + "</b><br>"%><%=curpos%>" onclick="popWin = open('shownewmap.jsp?lat=<%=lat%>&long=<%=lon%>&discription=<%="<b>" + vehno + "</b><br>"%><%=curpos%>','myWin','width=500,height=500');popWin.focus();return false">
<%=curpos%> </div></td>

<td id="kmsruncol<%=j%>"><div align="left"> 
<%
			if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
			{ %>
					<%=(int)fleetview.KM_TO_MILES1(kmrundist)%>
			<%}else{ %>
					 <%=kmrundist%> 
			<% } %>
 </div></td>
<td id="kmstoruncol<%=j%>"><div align="left"> </div></td>
<td id="etacol<%=j%>"><div align="left"> </div></td>

<td id="fuelconscol<%=j%>"><div align="left"> </div></td>

<td id="loaddelcol<%=j%>"><div align="left"> </div></td>

<td id="trantmecol<%=j%>"><div align="left"> </div></td>
</tr>
<%
j++;
}
%>

</table>
<input type="hidden" name="totrec" value="<%=j-1%>" />
<%	
}catch(Exception ee)
{
	out.print("Exception---->"+ee);
}	
finally
{
	try{
		con1.close();
		conn.close();
	}
	catch(Exception e)
	{
		
	}
	
}
%>

</table>
</td></tr>
</table>
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