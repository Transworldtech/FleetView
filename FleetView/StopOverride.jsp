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
	<html>
	<head>
	<script type="text/javascript">

function savestp(id,vehid)
{

	try{
		  

		//alert(id);
		var commentsstp=document.getElementById("commentsstp"+id).value;
		var date = document.getElementById("datastp"+id).value;
		var otherrson=document.getElementById("othSTOPreason"+id).value;
		var oth=otherrson.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
		if(commentsstp=="Select")
		   {
			   alert("Please Select Reason");
		   }
		else if(commentsstp=="Other" && (oth=="" || otherrson==""))
		   {
			      alert("Please Enter Other Reason");

			   
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
//alert(reslt);
                           reslt=reslt.split("-");
                           
				if(reslt[0]=="Updates" || reslt=="")
					alert("Record Save Succesfully");
				
				document.getElementById("tdreasonstp"+id).innerHTML = reslt[1];
				
			
				}catch(e)
				{
				alert(e);
				}
			} 
		};

		var queryString ="?vehid="+vehid+"&date="+date+"&otherrson="+otherrson+"&comment="+commentsstp;
		ajaxRequest.open("GET", "Override_Stop_Ajax.jsp" + queryString, true);
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
			var commentsall=document.getElementById("commentsall").value;
			var otherall=document.getElementById("othALLreason").value;
			var oth=otherall.replace(/^\s\s*/, '').replace(/\s\s*$/, '');

			
			
			if(commentsall=="Select")
			   {
				   alert("Please Select Reason");
			   }
			else if(commentsall=="Other" && (otherall=="" || oth==""))
			   {
				      alert("Please Enter Other Reason");

				   
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
					//alert(reslt);

					if(reslt=="Updates"){
						alert("Record Save Succesfully");
						window.location.reload("brief_report_7days.jsp");
						
					}else{
						alert("Violations are already closed");
						
					}
					
				
					}catch(e)
					{
					alert(e);
					}
				} 
			};

			var queryString ="?vehid="+vehid+"&date1="+date1+"&comments7="+commentsall+"&otherall="+otherall+"&date2="+date2;
			ajaxRequest.open("GET", "Override_AllStop_Ajax.jsp" + queryString, true);
			ajaxRequest.send(null); 
			}
			
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
    
    document.brief7close.action ="excel.jsp";
    document.forms["brief7close"].submit();
} 
function showothloc(id)
{
	//alert(id);
	var SelValue1=document.getElementById("comments"+id).value;
	//alert(SelValue1);
        if(SelValue1=="Other")
        {
        	document.getElementById("othosreason"+id).style.display="";          
        }
        else 
       {
        	document.getElementById("othosreason"+id).style.display='none';         
       }
}


function showothlocra(id)
{
	//alert(id);
	var SelValue1=document.getElementById("commentsra"+id).value;
	//alert(SelValue1);
        if(SelValue1=="Other")
        {
        	document.getElementById("othRAreason"+id).style.display="";          
        }
        else 
       {
        	document.getElementById("othRAreason"+id).style.display='none';         
       }
}

function showothlocrd(id)
{
	//alert(id);
	var SelValue1=document.getElementById("commentsrd"+id).value;
	//alert(SelValue1);
        if(SelValue1=="Other")
        {
        	document.getElementById("othRDreason"+id).style.display="";          
        }
        else 
       {
        	document.getElementById("othRDreason"+id).style.display='none';         
       }
}

function showothlocnd(id)
{
	//alert(id);
	var SelValue1=document.getElementById("commentsnd"+id).value;
	//alert(SelValue1);
        if(SelValue1=="Other")
        {
        	document.getElementById("othNDreason"+id).style.display="";          
        }
        else 
       {
        	document.getElementById("othNDreason"+id).style.display='none';         
       }
}

function showothloccd(id)
{
	//alert(id);
	var SelValue1=document.getElementById("commentscd"+id).value;
	//alert(SelValue1);
        if(SelValue1=="Other")
        {
        	document.getElementById("othCDreason"+id).style.display="";          
        }
        else 
       {
        	document.getElementById("othCDreason"+id).style.display='none';         
       }
}

function showothlocdc(id)
{
	//alert(id);
	var SelValue1=document.getElementById("commentsdic"+id).value;
	//alert(SelValue1);
        if(SelValue1=="Other")
        {
        	document.getElementById("othDCreason"+id).style.display="";          
        }
        else 
       {
        	document.getElementById("othDCreason"+id).style.display='none';         
       }
}

function showothlocrhr(id)
{
	//alert(id);
	var SelValue1=document.getElementById("commentsrunhr"+id).value;
	//alert(SelValue1);
        if(SelValue1=="Other")
        {
        	document.getElementById("othRHRreason"+id).style.display="";          
        }
        else 
       {
        	document.getElementById("othRHRreason"+id).style.display='none';         
       }
}

function showothlocstop(id)
{
	//alert(id); 
	var SelValue1=document.getElementById("commentsstp"+id).value;
	//alert(SelValue1);
        if(SelValue1=="Other")
        {
        	document.getElementById("othSTOPreason"+id).style.display="";          
        }
        else 
       {
        	document.getElementById("othSTOPreason"+id).style.display='none';         
       }
}




function showothlocall()
{
	//alert(id);
	var SelValue1=document.getElementById("commentsall").value;
	//alert(SelValue1);
        if(SelValue1=="Other")
        {
        	document.getElementById("othall").style.display="";          
        }
        else 
       {
        	document.getElementById("othall").style.display='none';         
       }
}






</script>

</head>

	
<%

String vid="", sql="",sql1="",sql2="", transporter="", vehregno="", thedate1="", thedate2="",Transporter="",vehRegNo="";
String showdate="",dateformat="";
Connection con=null ;

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
	 Statement smtos=con.createStatement();
	 Statement smtra=con.createStatement();
	 Statement smtrd=con.createStatement();
	 Statement smtnd=con.createStatement();
	 Statement smtcd=con.createStatement();
	 Statement smtalll=con.createStatement();
	 Statement smtstp=con.createStatement();
	 Statement smtdicc=con.createStatement();
System.out.println("statement   "+st1);
	String tripid=request.getParameter("tripid");
	vid=request.getParameter("vid");
	
	thedate1=request.getParameter("SD");
	
	thedate2=request.getParameter("ED");
	vehRegNo=request.getParameter("vehRegNo");
	Transporter=request.getParameter("Transporter");

%>
<%	   String exportFileName=session.getAttribute("user").toString()+"_brief7closeReport.xls";
%>
<body>

<form id="brief7close" name="brief7close" action="" method="post">

<table border="0" cellpadding="0" width="100%" align="center" class="stats">
		<tr>
		<td>
		<div class="bodyText" align="right">
                           <input type="hidden" id="tableHTML" name="tableHTML" value="" />  
                           <input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 
     
                           <a href="#" style="font-weight: bold; color: black; " onclick="gotoPrint('table1');">
                           <img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img></a> 
      
                           <a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('table1','tableHTML');">
                           <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img></a>
                           <%=Utilities.printDate()%>
                           </div>
		</td>
		</tr>
		</table>
		 <div id="table1">
		
<table width="100%" align="center" class="stats" >
			<tr>
			<td align="center">
		<!-- 	<div align="left"><font size="3" >Report No: 1.8</font></div>-->
			<font  size="3" ><b></b></font></td>
			</tr>			<tr>			<td>
			<div align="center"><font  size="3"><b>Exception Report For <%=Transporter%>,TripId <%=tripid%>, Vehicle <%=vehRegNo%> For The Period : <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(thedate1)) %>  to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(thedate2))%>  </b></font></div>
					</td>			</tr>
		
			</table>
						<div style="margin-left: 100px">			<br></br>
			<table border="0" align="center" width="100%">
					<tr>
			<td><input type="button" id="save" name="save" value="Save All" style="border-style: outset;border-color: black " onclick="saveall();"></input>
			
			
			<input type="hidden" id="vid1" name="vid1" value="<%=vid %>"></input>
			<input type="hidden" id="thedate1" name="thedate1" value="<%=thedate1 %>"></input>
			<input type="hidden" id="thedate2" name="thedate2" value="<%=thedate2 %>"></input>
				<%
					String sqlalll = "select distinct(Reason) from db_gps.t_violationclose where category='Stop' and GPName='Castrol'";
			             ResultSet rsalll = smtalll.executeQuery(sqlalll);
									
					%>
			
			<select name="commentsall" id="commentsall" class="element select medium" style="width: 250px" onChange="showothlocall();">
                     <option value="Select">--Select--</option>
                     <%
							while (rsalll.next()) {
						%>
						<option value="<%=rsalll.getString("Reason")%>"><%=rsalll.getString("Reason")%>
						</option>
						<%		}	%>   
						
						<option value="Other">Other</option>
                     			 </select>	
                     	              

                      
			</td>
						</tr>
						<tr id="othall" style="display: none;">
						<td><br></br>
						   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						   <input type="text" class="element text medium" name="othALLreason" id="othALLreason" style="width: 250px" />
											
						</td>
						
						</tr>
			</table>
			</div>
				
			
			<table border="0" align="center"  class="stats">
		<tr>
		<td align="center"><font size="3"><b>Stops</b></font></td>
	</tr>
	<tr>
		<td><div align="center">
		<table style="width: 800px" border="1" align="center" class="sortable">
			<tr>
				<th><b> Sr. </b></th>
				<th><b>Start Date-Time</b></th>
				<th><b>End Date-Time</b></th>
				<th><b>Duration</b></th>
				<th><b>Location</b></th>
				<th><b>Override Reason</b></th>
				
			</tr>
			<%
				int st=1,sp=0;
			
			String cmtstp="",datestpvio="",datestpvios="",timefrom="",timeto="";
				String sqlstp="select * from db_gpsExceptions.t_vehall_stsp where VehCode='"+vid+"' and Duration > '04:00:00'  and FromTime >='05:00:00' and FromTime <= '23:00:00' and FromDate=ToDate and  FromDatetime >='"+thedate1+"' and FromDatetime <='"+thedate2+"' ";
				System.out.println("sqlstp>>>>"+sqlstp);

				ResultSet rsstp=st1.executeQuery(sqlstp);
				System.out.println("sqlstp>>>>"+sqlstp);
				while(rsstp.next())
				{
					cmtstp=rsstp.getString("OverrideComents");
					datestpvio=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsstp.getString("FromDate")));
					datestpvios=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsstp.getString("ToDate")));
					System.out.println("^^^^^^^     "+cmtstp);
					timefrom=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rsstp.getString("FromTime")));
					timeto=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rsstp.getString("ToTime")));
					 
					%>
					
					<tr>
					<td align="right"><div align="right"><%=st%></div></td>
					<td align="right" style="width: 120px"><div  align="right"><%=datestpvio%> <%=timefrom%></div><input type="hidden" id="datastp<%=st%>" value="<%=rsstp.getString("FromDate")+" "+rsstp.getString("FromTime")%>"></input></td>
					<td align="right" style="width: 120px"><div align="right"><%=datestpvios%> <%=timeto%></div></td> 
 		<td align="right"><div align="right"><%=rsstp.getString("Duration") %></div></td>
					<td align="right"><div align="left"><%=rsstp.getString("Location") %></div></td>
					
					<%
					if(cmtstp=="-" || cmtstp.equals("-"))
					{
						%>
						<td id = "tdreasonstp<%=st%>" style="width: 40%" align="left"><div align="left">
					<%
					String sqlstpp = "select distinct(Reason) from db_gps.t_violationclose where category='Stop' and GPName='Castrol'";
			             ResultSet rsstpp=smtstp.executeQuery(sqlstpp);
									
					%>
					<select name="commentsstp" id="commentsstp<%=st%>" class="element select medium" style="width: 250px" onChange="showothlocstop(<%=st%>)">
                     <option value="Select">--Select--</option>
                     <%
							while (rsstpp.next()) {
						%>
						<option value="<%=rsstpp.getString("Reason")%>"><%=rsstpp.getString("Reason")%>
						</option>
						<%
							}
						%>
                     <option value="Other">Other</option>   
                     			 </select>	  <input type="text" class="element text medium" name="othSTOPreason" id="othSTOPreason<%=st%>" style="display:none;width: 230px" />
                     	
                     

                      
                <a title="Save" onclick="savestp(<%=st%>,<%=vid%>);"><img src="newimages/save.png" border="0"></a>                        
                       </div></td>
						<%
						
					}
					else{
						
						
						%>
						<td align="left"><div align="left"><%=cmtstp %></div></td>
						<%
					}
					
					%>
					
					</tr>
					<%
					
					st++;
					
				}
				
				
				
				
				%>
				
			
		
			
		</table></div>
		</td>
	</tr>

</table>
</div>
</form>
</body>
</html>
<%
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			finally
			{
				try{
					con.close();
				}catch(Exception e)
				{
					
				}
			}
		
	%>



<%@ include file="footernew.jsp"%>