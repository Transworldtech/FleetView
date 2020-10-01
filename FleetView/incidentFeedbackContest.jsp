<%@ include file="Connections/conn.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

%>
<%
	response.setHeader("Cache-Control","no-cache");
  	response.setHeader("Pragma","no-cache");
  	response.setDateHeader ("Expires", 0);
 %>
 <html>
 
 <head>
 	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Incident Contest</title>
<script type="text/javascript">
var videoFile=null;
function getAllIncidentvalues(incident)
{
	if(incident=="Select" || incident=="" || incident==null)
	{
		document.getElementById("dispLinks1").style.display='none';
		document.getElementById("dispLinks2").style.display='none';
	}
	else
	{
		document.getElementById("dispLinks1").style.display="";
		document.getElementById("dispLinks2").style.display="";
	}
	//alert(incident);
	try{
		var ajaxRequest;  // The variable that makes Ajax possible!
		try{
			// Opera 8.0+, Firefox, Safari
			ajaxRequest = new XMLHttpRequest();
		}  
		catch (e)
		{
			// Internet Explorer Browsers
			try
			{
				ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
			} 
			catch (e)
			{
				try
				{
					ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
				} 
				catch (e)
				{
					// Something went wrong
					alert("Your browser broke!");
					return false;
				}
			}
		}
		ajaxRequest.onreadystatechange = function()
		{
			if(ajaxRequest.readyState == 4)
			{
				var reslt=ajaxRequest.responseText;
				
				var l1=reslt.split("#");
				//document.getElementById("search-text").value=l1[3];
				//document.getElementById("element_1").value=l1[4];
			//	alert(l1[0]+"----------"+l1[1]);
		//	alert(l1[0]);
				//alert("**************"+l1[0]);
				videoFile=l1[0];
				assignValues(l1[0]);
			} 
		};
		var queryString = "?incidentID="+incident+"";
		ajaxRequest.open("GET", "AjaxContestIncidentEdit.jsp" + queryString, true);
		ajaxRequest.send(null); 
		}catch(e)
		{
			alert(e);
		}
}
function assignValues(videoIp)
{
	document.getElementById("hideVdo").value=videoIp;
	//alert("_______"+document.getElementById("hideVdo").value+"___________");
}
function playVideo()
{
	//alert(videoFile);
	if(videoFile==null || videoFile=="")
	{
		var incidentPlayVideo=document.getElementById("incidentid").value;
		//alert(incidentPlayVideo);
		getAllIncidentvalues(incidentPlayVideo);
		//alert("VDO file-->>"+document.getElementById("hideVdo").value);
	}
	window.open("incidentFeedVideo.jsp?vdoFile="+document.getElementById("hideVdo").value,'myWind1');
}
function feedbackReport()
{
	var incidentClicked=document.getElementById("incidentid").value;
	//alert(incidentClicked);
	window.open("feedbackReport.jsp?incidentid="+incidentClicked,'myWind2','width=800,height=600,resizable=yes,scrollbars=yes');
}
</script>

	
 </head>
 
 <body>
 <%
 	Connection con1;
 	Class.forName(MM_dbConn_DRIVER); 
	con1=fleetview.ReturnConnection();
	Statement stmt1=con1.createStatement();
	
	String driverId=session.getAttribute("driverid").toString();
 %>
 
 	<form action="" method="post" name="form1" id="form1">
 	<input type="hidden" name="hideVdo" id="hideVdo" value="">
 	
 	<table border="0" width="70%" align="center" class="sortable_entry">
				<tr align="center">
					<td align="center"> <font  size="2"> Incident ID:-&nbsp;&nbsp;&nbsp;&nbsp;</font> </td>
					<td align="center">
						<select name="incidentid" id="incidentid" onchange="getAllIncidentvalues(this.value);">
						<option value="Select">Select</option>
						<%
						String incidentid="";
						boolean f1=false;
						try
						{
						String sql2="SELECT * FROM t_contestIncidentMaster where incidentId not in (select incidentId from t_incidentFeedback where Driverid='"+driverId+"') order by incidentId asc";
				 		ResultSet rs2=stmt1.executeQuery(sql2);
				 		while(rs2.next())
        				{
				 			f1=true;
				 			incidentid=rs2.getString("incidentId");
				 			%>
				 			<option value="<%=incidentid%>"><%=incidentid%></option>
				 			<%        				
				 		}
						}
						catch(Exception e)
						{
							System.out.println("Connection Exception on Contest Incident Edit----->>"+e);
						}
				 	%>
				 		</select>
					</td>
					
				</tr>
				
					<tr align="center" id="dispLinks1" style="display:none">
						<td align="center"><font  size="2"><a href="#" onclick="playVideo();">Incident Details</a></font></td>
					</tr>
					
					<tr align="center" id="dispLinks2" style="display:none">
						<td align="center"><font  size="2"><a href="#" onclick="feedbackReport();">Feedback Report</a></font></td>
					</tr>
				
	</table>
	<table border="0" width="70%" align="center">
				<tr align="center">
				<td align="center"><font color="red" size="1">Note: Single Entry is allowed by Each Driver for Each Incident.</font></td>
				</tr>
	</table>
	</form>
 </body>
 
</html>
</jsp:useBean>
