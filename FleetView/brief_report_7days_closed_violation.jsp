<%@ include file="headernew.jsp"%>

	<link rel="stylesheet" type="text/css" href="css/form.css" media="all">

<%@page import="com.transworld.fleetview.framework.VehicleDao"
	import="com.transworld.fleetview.framework.OverSpeedDetailsData"
	import="com.transworld.fleetview.framework.RapidAccelerationDetailsData"
	import="com.transworld.fleetview.framework.ContinuousDrivingDetailsData"
	import="com.transworld.fleetview.framework.GetVehicleDetails"
	import="com.transworld.fleetview.framework.Utilities"%>

<jsp:useBean id="vehicleDao"
	type="com.transworld.fleetview.framework.VehicleDao"
	scope="application"></jsp:useBean>
	
	<script type="text/javascript">

function saveos(id,vehid)
{

	
		try{


			
			var comments=document.getElementById("comments"+id).value;
			var date = document.getElementById("data"+id).innerHTML;
		
   if(comments=="Select")
   {
	   alert("Please Select Reason");
   }
   
   else{

			

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
					try
					{
						
					var reslt=ajaxRequest.responseText;

					reslt=reslt.replace(/^\s+|\s+$/g,'');

					if(reslt=="Updates")
					alert("Record Save Succesfully");

					document.getElementById("tdreason"+id).innerHTML = comments;
					
				
					}catch(e)
					{
					alert(e);
					}
				} 
			};

			

			
			var queryString ="?vehid="+vehid+"&date="+date+"&comment="+comments;
			ajaxRequest.open("GET", "brief_report_insert_Ajax.jsp" + queryString, true);
			ajaxRequest.send(null); 
		}
			
		}
		    catch(e)
			{
				alert(e);
			}

	
		
}


function savera(id,vehid)
{

	
		try{


			
			var comments1=document.getElementById("comments1"+id).value;
			var date1 = document.getElementById("data1"+id).innerHTML;
		
			if(comments1=="Select")
			   {
				   alert("Please Select Reason");
			   }
			else{

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
					try
					{
						
					var reslt=ajaxRequest.responseText;

					reslt=reslt.replace(/^\s+|\s+$/g,'');

					if(reslt=="Updates")
						alert("Record Save Succesfully");
					
					document.getElementById("tdreason1"+id).innerHTML = comments1;
				
					}catch(e)
					{
					alert(e);
					}
				} 
			};

			

			
			var queryString ="?vehid="+vehid+"&date="+date1+"&comment="+comments1;
			ajaxRequest.open("GET", "brief_report_insert_ra_Ajax.jsp" + queryString, true);
			ajaxRequest.send(null); 

		}
		}
		    catch(e)
			{
				alert(e);
			}

	
		
}

function saverd(id,vehid)
{

	
		try{


			
			var comments2=document.getElementById("comments2"+id).value;
			var date2 = document.getElementById("data2"+id).innerHTML;
			
			if(comments2=="Select")
			   {
				   alert("Please Select Reason");
			   }
			else{
		

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
					try
					{
						
					var reslt=ajaxRequest.responseText;

					reslt=reslt.replace(/^\s+|\s+$/g,'');

					if(reslt=="Updates")
						alert("Record Save Succesfully");
					
					document.getElementById("tdreason2"+id).innerHTML = comments2;
					
				
					}catch(e)
					{
					alert(e);
					}
				} 
			};

			

			
			var queryString ="?vehid="+vehid+"&date="+date2+"&comment="+comments2;
			ajaxRequest.open("GET", "brief_report_insert_rd_Ajax.jsp" + queryString, true);
			ajaxRequest.send(null); 
		}
			
		}
		    catch(e)
			{
				alert(e);
			}

	
		
}

function savend(id,vehid)
{

	
		try{


			
			var comments=document.getElementById("comments3"+id).value;
			var date = document.getElementById("data3"+id).innerHTML;
		
			if(comments=="Select")
			   {
				   alert("Please Select Reason");
			   }
			else{

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
					try
					{
						
					var reslt=ajaxRequest.responseText;

					reslt=reslt.replace(/^\s+|\s+$/g,'');

					if(reslt=="Updates")
						alert("Record Save Succesfully");
					
					document.getElementById("tdreason3"+id).innerHTML = comments;
					
				
					}catch(e)
					{
					alert(e);
					}
				} 
			};

			

			
			var queryString ="?vehid="+vehid+"&date="+date+"&comment="+comments;
			ajaxRequest.open("GET", "brief_report_insert_nd_Ajax.jsp" + queryString, true);
			ajaxRequest.send(null); 

		}
		}
		    catch(e)
			{
				alert(e);
			}

	
		
}







function savecd(id,vehid)
{

	
		try{


			
			var comments=document.getElementById("comments4"+id).value;
			var date = document.getElementById("data4"+id).innerHTML;
		
			if(comments=="Select")
			   {
				   alert("Please Select Reason");
			   }
			else{
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
					try
					{
						
					var reslt=ajaxRequest.responseText;

					reslt=reslt.replace(/^\s+|\s+$/g,'');

					if(reslt=="Updates")
						alert("Record Save Succesfully");
					
					document.getElementById("tdreason4"+id).innerHTML = comments;
					
				
					}catch(e)
					{
					alert(e);
					}
				} 
			};

			

			
			var queryString ="?vehid="+vehid+"&date="+date+"&comment="+comments;
			ajaxRequest.open("GET", "brief_report_insert_cd_Ajax.jsp" + queryString, true);
			ajaxRequest.send(null); 

			}
		}
		    catch(e)
			{
				alert(e);
			}

	
		
}



function saveall()
{

	
		try{


			
			var vehid=document.getElementById("vid1").value;
			var date1=document.getElementById("thedate1").value;
			var date2=document.getElementById("thedate2").value;
			var comments7=document.getElementById("comments7").value;
			
			
			if(comments7=="Select")
			   {
				   alert("Please Select Reason");
			   }
			else{

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
					try
					{
						
					var reslt=ajaxRequest.responseText;

					reslt=reslt.replace(/^\s+|\s+$/g,'');

					if(reslt=="Updates")
						alert("Record Save Succesfully");
					window.location.reload("brief_report_7days.jsp");
					
				
					}catch(e)
					{
					alert(e);
					}
				} 
			};

			

			
			var queryString ="?vehid="+vehid+"&date1="+date1+"&comments7="+comments7+"&date2="+date2;
			ajaxRequest.open("GET", "brief_report_insert_saveall_Ajax.jsp" + queryString, true);
			ajaxRequest.send(null); 
			}
			
		}
		    catch(e)
			{
				alert(e);
			}

	
		
}




	
</script>
<%

String vid="", sql="",sql1="",sql2="", transporter="", vehregno="", thedate1="", thedate2="",Transporter="",vehRegNo="";
String showdate="",dateformat="";
Connection con ;

%>


<%
try
{
	Class.forName(MM_dbConn_DRIVER);
	con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement st1=con.createStatement();
	 Statement st2=con.createStatement();
	Statement st3=con.createStatement();
	 Statement st4=con.createStatement();
	
	
	vid=request.getParameter("vid");
	
	thedate1=request.getParameter("SD");
	
	thedate2=request.getParameter("ED");
	vehRegNo=request.getParameter("vehRegNo");
	Transporter=request.getParameter("Transporter");

	String closedby="",clsdttm="",closedby1="",clsdttm1="",closedby2="",clsdttm2="",closedby3="",clsdttm3="";
	
	
%>
<table width="100%" align="center" class="stats" >
			<tr>
			<td align="center">
		<!-- 	<div align="left"><font size="3" >Report No: 1.8</font></div>-->
			<font  size="3" ><b></b></font></td>
			</tr>
			<tr>
			<td>
			<div align="center"><font  size="3"><b>Exception Report For <%=Transporter%>, Vehicle <%=vehRegNo%> For The Period : <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(thedate1)) %>  to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(thedate2))%>  </b></font></div>
				
			</td>
			</tr>
			
			
			
			</table>
			<div>
			<br></br>
			<table border="0" align="center" width="100%">
			
			<tr>
		<!--  	<td><input type="button" id="save" name="save" value="Save All" style="border-style: outset;border-color: black " onclick="saveall();"></input>
			
			
			<input type="hidden" id="vid1" name="vid1" value="< %=vid %>"></input>
			<input type="hidden" id="thedate1" name="thedate1" value="< %=thedate1 %>"></input>
			<input type="hidden" id="thedate2" name="thedate2" value="< %=thedate2 %>"></input>
			
			
			<select name="comments7" id="comments7" class="element select medium" style="width: 200px">
                     <option value="Select">--Select--</option>
                     <option value="Traffic Jam">Traffic Jam</option>
                     <option value="No Entry Area in Day Time">No Entry Area in Day Time</option>
                     <option value="For Safe Parking">For Safe Parking</option>
                     

                       </select>
			
			
			</td> -->
			
			</tr>
			</table>
			</div>
			
			
			
			
			<table border="0" align="center" width="100%" class="stats">
			
			
			<tr>
		<td align="center"><font size="3"><b>Over Speed</b></font></td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="1" align="center" class="sortable">
			<tr>
				<th><b> Sr. </b></th>
				<th><b>From-Date-Time</b></th>
				<th><b>Speed</b></th>
				<th><b>Duration in Sec.</b></th>
				
				<th><b>Reason</b></th>
				<th><b>Closed By</b></th>
<!--				<th><b>Closed DateTime</b></th>-->
			</tr>
			
				<%
				int i=1,h=0;
				String cmt4="";
				sql="select FromDate,FromTime,Speed,Duration,ClosingComment,ClosedBy,Closedatetime from db_gpsExceptions.t_vehall_overspeed where VehCode='"+vid+"' and FromDatetime >='"+thedate1+" 00:00:00' and FromDatetime <='"+thedate2+" 23:59:59' and violationstatus='Close' ";
				
				ResultSet rs=st1.executeQuery(sql);
				System.out.println(">>>>>>>sql>>" +sql);
				while(rs.next())
				{
					cmt4=rs.getString("ClosingComment");

					%>
					
					<tr>
					<td><%=i %></td>
					<td id="data<%=i%>"><%=rs.getString("FromDate") %> <%=rs.getString("FromTime") %></td>
					<td><%=rs.getString("Speed") %></td>
					<td><%=rs.getString("Duration") %></td>
					
					<%
					
					if(cmt4=="-" || cmt4.equals("-"))
					{
					%>
					<td id = "tdreason<%=i%>">
					
					<select name="comments" id="comments<%=i %>" class="element select medium" style="width: 200px">
                     <option value="Select">--Select--</option>
                     <option value="Traffic Jam">Traffic Jam</option>
                     <option value="No Entry Area in Day Time">No Entry Area in Day Time</option>
                     <option value="For Safe Parking">For Safe Parking</option>
                     

                       </select>
                <a title="Save" onclick="saveos(<%=i%>,<%=vid%>);"><img src="newimages/save.png" border="0"></a>                        
                        </td>
                        
                        
                        <%
                        
					}
					else{
						%>
						<td><%=cmt4 %></td>
						<%
						
					}
                        
                        
                        %>
                        <td><%=rs.getString("ClosedBy") %></td>
<!--                        <td>< %=rs.getString("Closedatetime") %></td>-->
					</tr>
					<%
					
					i++;	
					
				}
				
				
				
				
				%>
				
				
			
						
		</table>

		</td>
	</tr>
	<tr>
		<td align="center"><font size="3"><b>Rapid
		Acceleration</b></font></td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="1" align="center" class="sortable">
			<tr>
				<th><b> Sr. </b></th>
				<th><b>Date-Time</b></th>
				<th><b>From Speed</b></th>
				<th><b>To Speed</b></th>
				<th><b>Reason1</b></th>
				<th><b>Closed By</b></th>
<!--				<th><b>Closed DateTime</b></th>-->
				
			</tr>
			
			
			
			<%
			    int m=1,s=0;
			String cmt3="";
				String sql4="select TheDate,TheTime,FromSpeed,ToSpeed,ClosingComment,ClosedBy,Closedatetime from db_gpsExceptions.t_vehall_ra where VehCode='"+vid+"' and TheDatetime >='"+thedate1+" 00:00:00' and TheDatetime <='"+thedate2+" 23:59:59' and violationstatus='Close' ";
				
				ResultSet rs4=st1.executeQuery(sql4);
				while(rs4.next())
				{
					cmt3=rs4.getString("ClosingComment");

					%>
					
					<tr>
					<td><%=m %></td>
					<td id="data1<%=m%>"><%=rs4.getString("TheDate") %> <%=rs4.getString("TheTime") %></td>
					<td><%=rs4.getString("FromSpeed") %></td>
					<td><%=rs4.getString("ToSpeed") %></td>
					
					<%
					if(cmt3=="-" || cmt3.equals("-"))
					{
					
					%>
					<td id = "tdreason1<%=m%>">
					
					<select name="comments1" id="comments1<%=m %>" class="element select medium" style="width: 200px">
                     <option value="Select">--Select--</option>
                     <option value="Traffic Jam">Traffic Jam</option>
                     <option value="No Entry Area in Day Time">No Entry Area in Day Time</option>
                     <option value="For Safe Parking">For Safe Parking</option>
                     

                       </select>
                <a title="Save" onclick="savera(<%=m%>,<%=vid%>);"><img src="newimages/save.png" border="0"></a>                        
                        </td>
                        
                        
                        <%
                        
					}
					
					else{
						
						%>
						<td><%=cmt3 %></td>
						<%
					}
                        %>
                        <td><%=rs4.getString("ClosedBy") %></td>
<!--                        <td>< %=rs4.getString("Closedatetime") %></td>-->
					</tr>
					<%
					
					m++;	
					
				}
			
			
			
			%>
			
			
			
				
		</table>
		</td>
		</tr>
	<tr>
		<td align="center"><font size="3"><b>Rapid
		Deceleration</b></font></td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="1" align="center" class="sortable">
			<tr>
				<th><b> Sr. </b></th>
				<th><b>Date-Time</b></th>
				<th><b>From Speed</b></th>
				<th><b>To Speed</b></th>
				<th><b>Reason</b></th>
				<th><b>Closed By</b></th>
<!--				<th><b>Closed DateTime</b></th>-->
			</tr>
			
			
			
			<%
			    int j=1,t=0;
			String cmt2="";
				sql1="select TheDate,TheTime,FromSpeed,ToSpeed,ClosingComment,ClosedBy,Closedatetime from db_gpsExceptions.t_vehall_rd where VehCode='"+vid+"' and TheDatetime >='"+thedate1+" 00:00:00' and TheDatetime <='"+thedate2+" 23:59:59'  and violationstatus='Close'";
				
				ResultSet rs1=st1.executeQuery(sql1);
				while(rs1.next())
				{
					cmt2=rs1.getString("ClosingComment");
					%>
					
					<tr>
					<td><%=j %></td>
					<td id="data2<%=j%>"><%=rs1.getString("TheDate") %> <%=rs1.getString("TheTime") %></td>
					<td><%=rs1.getString("FromSpeed") %></td>
					<td><%=rs1.getString("ToSpeed") %></td>
					
					
					
					<%
					if(cmt2=="-" || cmt2.equals("-"))
					{
					%>
					<td id = "tdreason2<%=j%>">
					
					<select name="comments2" id="comments2<%=j %>" class="element select medium" style="width: 200px">
                     <option value="Select">--Select--</option>
                     <option value="Traffic Jam">Traffic Jam</option>
                     <option value="No Entry Area in Day Time">No Entry Area in Day Time</option>
                     <option value="For Safe Parking">For Safe Parking</option>
                     

                       </select>
                <a title="Save" onclick="saverd(<%=j%>,<%=vid%>);"><img src="newimages/save.png" border="0"></a>                        
                        </td>
                        
                        
                        <%
					}
					else{
						%>
						<td><%=cmt2 %></td>
						<%
						
					}
                        
                        %>
                        <td><%=rs1.getString("ClosedBy") %></td>
<!--                        <td>< %=rs1.getString("Closedatetime") %></td>-->
					</tr>
					<%
					
					j++;		
							
				}
			
			
			
			%>
			
			
			
			
			
			
		</table>
		</td>
	</tr>
	
	
	<tr>
		<td align="center"><font size="3"><b>Night Driving</b></font></td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="1" align="center" class="sortable">
			<tr>
				<th><b> Sr. </b></th>
				<th><b>Start Date-Time</b></th>
				<th><b>End Date-Time</b></th>
				<th><b>Distance</b></th>
				<th><b>Duration</b></th>
				<th><b>Reason</b></th>
				<th><b>Closed By</b></th>
<!--				<th><b>Closed DateTime</b></th>-->
				
				
			</tr>
			
			
			<%
				int k=1,kn=0;
			String cmt1="";
				sql2="select FromDate,FromTime,ToDate,ToTime,Distance,Duration,ClosingComment,ClosedBy,Closedatetime from db_gpsExceptions.t_vehall_nd where VehCode='"+vid+"' and FromDatetime >='"+thedate1+" 00:00:00' and FromDatetime <='"+thedate2+" 23:59:59' and violationstatus='Close' ";
				
				ResultSet rs2=st1.executeQuery(sql2);
				System.out.println(">>>>>>>sql2>>" +sql2);
				while(rs2.next())
				{
					cmt1=rs2.getString("ClosingComment");
					
					%>
					
					<tr>
					<td><%=k %></td>
					<td id="data3<%=k%>"><%=rs2.getString("FromDate") %> <%=rs2.getString("FromTime") %></td>
					<td><%=rs2.getString("ToDate") %> <%=rs2.getString("ToTime") %></td>
					<td><%=rs2.getString("Distance") %></td>
					<td><%=rs2.getString("Duration") %></td>
					
					
					
					<%
					
					if(cmt1=="-" || cmt1.equals("-"))
					{
					
					%>
					<td id = "tdreason3<%=k%>">
					
					<select name="comments3" id="comments3<%=k %>" class="element select medium" style="width: 200px">
                     <option value="Select">--Select--</option>
                     <option value="Traffic Jam">Traffic Jam</option>
                     <option value="No Entry Area in Day Time">No Entry Area in Day Time</option>
                     <option value="For Safe Parking">For Safe Parking</option>
                     

                       </select>
                <a title="Save" onclick="savend(<%=k%>,<%=vid%>);"><img src="newimages/save.png" border="0"></a>                        
                        </td>
                        <%
					}
					else{
						
						%>
						<td><%=cmt1 %></td>
						<%
						
					}
                        
                        %>
                        <td><%=rs2.getString("ClosedBy") %></td>
<!--                         <td>< %=rs2.getString("Closedatetime") %></td>-->
                        
					</tr>
					<%
					
					k++;
					
				}
				
				
				
				
				%>
			
			
		</table>
		</td>
	</tr>
	
	<tr>
		<td align="center"><font size="3"><b>Continuous
		Driving</b></font></td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="1" align="center" class="sortable">
			<tr>
				<th><b> Sr. </b></th>
				<th><b>Start Date-Time</b></th>
				<th><b>End Date-Time</b></th>
				<th><b>Distance</b></th>
				<th><b>Duration</b></th>
				<th><b>Reason</b></th>
				<th><b>Closed By</b></th>
<!--				<th><b>Closed DateTime</b></th>-->
				
			</tr>
			
			
			
			<%
				int l=1,ln=0;
			
			String cmt="";
				String sql3="select FromDate,FromTime,ToDate,ToTime,Distance,Duration,ClosingComment,ClosedBy,Closedatetime from db_gpsExceptions.t_vehall_crcopy where VehCode='"+vid+"' and FromDatetime >='"+thedate1+" 00:00:00' and FromDatetime <='"+thedate2+" 23:59:59' and violationstatus='Close' ";
				
				ResultSet rs3=st1.executeQuery(sql3);
				while(rs3.next())
				{
					cmt=rs3.getString("ClosingComment");
					
					
					%>
					
					<tr>
					<td><%=l %></td>
					<td id="data4<%=l%>"><%=rs3.getString("FromDate") %> <%=rs3.getString("FromTime") %></td>
					<td><%=rs3.getString("ToDate") %> <%=rs3.getString("ToTime") %></td>
					<td><%=rs3.getString("Distance") %></td>
					<td><%=rs3.getString("Duration") %></td>
					
					<%
					if(cmt=="-" || cmt.equals("-"))
					{
						%>
						<td id = "tdreason4<%=l%>">
					
					<select name="comments4" id="comments4<%=l %>" class="element select medium" style="width: 200px">
                     <option value="Select">--Select--</option>
                     <option value="Traffic Jam">Traffic Jam</option>
                     <option value="No Entry Area in Day Time">No Entry Area in Day Time</option>
                     <option value="For Safe Parking">For Safe Parking</option>
                     

                       </select>
                <a title="Save" onclick="savecd(<%=l%>,<%=vid%>);"><img src="newimages/save.png" border="0"></a>                        
                        </td>
						<%
						
					}
					else{
						
						
						%>
						<td><%=cmt %></td>
						<%
					}
					
					%>
					<td><%=rs3.getString("ClosedBy") %></td>
<!--					<td>< %=rs3.getString("Closedatetime") %></td>-->
					
					
					</tr>
					<%
					
					l++;
					
				}
				
				
				
				
				%>
				
			
		
			
		</table>
		</td>
	</tr>

</table>
<%
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		
	%>



<%@ include file="footernew.jsp"%>