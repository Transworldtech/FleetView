<%@ include file="headernew.jsp" %>

<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
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
};



function deleteVeh(id)
{
   // alert(id);
	var agree=confirm("Do You Want to Delete this Vehicle?");
	if(agree)
    {
           window.location="DeleteVehMst.jsp?id="+id;
    }
    else
    {
            return false;
    }
}



function showdetails(id)
{

 window.open("vehMasterRepDetails.jsp?id="+id+"",'details','width=900,height=600,resizable=yes,scrollbars=yes');
 popWin.focus();
 return false;
}

function toggleDetails(id,num,show)
{
	var popup = document.getElementById("popup"+id);
	//var html = document.getElementById("html"+id).value;
	//alert(id);
	if(show) {
		popup.style.display = "";
		popup.setfocus();
	} else {

            if(num==4)
            {		

			  deleteVeh(id);
  			   popup.style.display = "none";
            }

            if(num==6)
            {
            	popup.style.display = "none";
            	showdetails(id)
               
                 
                }
            
            if(num==7)
            {
            	popup.style.display = "none";
            	Peripherals(id)
               
                 
                }
            else
            {
            	popup.style.display = "none";
            }
	}
}

function getFTPImage(ftpFile)
{
	try
	{
		//alert(escape(ftpFile));
		//alert(ftpFile);
		window.open('showFTP.jsp?ftpFile='+ftpFile+'','mywindow','width=1000, height=850, toolbar=false, location=false, status=no, menubar=no, resizable=no, scrollbars=yes');
	}
	catch(e)
	{
		alert(e);
	}
}

</script>
<div style="font-size: 1.8em; text-align: center; margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em" align="center">
	Vehicle Master Report</div>
	<%! Connection conn=null;%>
	<%
	try
	{
	       
			conn = fleetview.ReturnConnection();
			Statement st=null;
			String sql=null;
			ResultSet rst=null;
			st=conn.createStatement();
			String vehlist = session.getAttribute("VehList").toString();
			int i=1;
			String html = "";
			
			String Msg ="0";
			Msg = request.getParameter("Msg");
			if(Msg!=null && Msg.equalsIgnoreCase("1"))
			{
			%>
			<script>
					alert("Deleted Successfully!!!");
			</script>
			<%
			}
			else
				if(Msg!=null && Msg.equalsIgnoreCase("2"))
				{
					%>
					<script>
					   alert("Unable to delete the Vehicle!!!");
					</script>
					<%
				}
			
	%>
	
	<div style="margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em" align="center">
<form name="customdetail" method="get">
	<table align="center" border="0" style="text-align: center; margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em">
			<tr>
			<td>
			<table align="center" class="sortable">
			<tr>
			<th><div align="center"><font size="2"><b>Sr. No.</b></font></div></th>
			<th><div align="center"><font size="2"><b>Veh Reg No</b></font></div></th>
			<th><div align="center"><font size="2"><b>Veh Typ</b></font></div></th>
		
	       <!--<th><div align="center"><font size="2"><b>Usage</b></font></div></th>-->
		
			<th><div align="center"><font size="2"><b>Owner Name</b></font></div></th>
		
		   <!--<th><div align="center"><font size="2"><b>Owner Sr No</b></font></div></th>-->
		
			<th><div align="center"><font size="2"><b>Company</b></font></div></th>
			
		<!--  	<th><div align="center"><font size="2"><b>Addr1</b></font></div></th>
			<th><div align="center"><font size="2"><b>Addr2</b></font></div></th>
			<th><div align="center"><font size="2"><b>Addr3</b></font></div></th>
			<th><div align="center"><font size="2"><b>State</b></font></div></th>
			<th><div align="center"><font size="2"><b>City</b></font></div></th>
			<th><div align="center"><font size="2"><b>PinCode</b></font></div></th>
			<th><div align="center"><font size="2"><b>Mnf Name</b></font></div></th>-->
			
			<th><div align="center"><font size="2"><b>Model</b></font></div></th>
			
		<!--<th><div align="center"><font size="2"><b>Mnf Date</b></font></div></th>-->
			
			<th><div align="center"><font size="2"><b>RTO</b></font></div></th>
			
		<!--<th><div align="center"><font size="2"><b>RTO State</b></font></div></th> -->
			<th><div align="center"><font size="2"><b>Reg Date</b></font></div></th>
			<th><div align="center"><font size="2"><b>RCBookNo</b></font></div></th>
			
		<!-- <th><div align="center"><font size="2"><b>Engine No</b></font></div></th>
			<th><div align="center"><font size="2"><b>Chassis No</b></font></div></th>
			<th><div align="center"><font size="2"><b>Gear Box No</b></font></div></th>
			<th><div align="center"><font size="2"><b>VIN No</b></font></div></th>
			<th><div align="center"><font size="2"><b>Unladen WT</b></font></div></th>
			<th><div align="center"><font size="2"><b>RLW</b></font></div></th>
			<th><div align="center"><font size="2"><b>GVS</b></font></div></th>	
			<th><div align="center"><font size="2"><b>Veh Class</b></font></div></th>
			<th><div align="center"><font size="2"><b>Type of Body</b></font></div></th>
			<th><div align="center"><font size="2"><b>Length</b></font></div></th>
			<th><div align="center"><font size="2"><b>Breadth</b></font></div></th>
			<th><div align="center"><font size="2"><b>Width</b></font></div></th>
			<th><div align="center"><font size="2"><b>Seating Capacity</b></font></div></th>
			<th><div align="center"><font size="2"><b>Standing Capacity</b></font></div></th>
			<th><div align="center"><font size="2"><b>No of tyres</b></font></div></th>
			<th><div align="center"><font size="2"><b>No of Cylinder</b></font></div></th>
			<th><div align="center"><font size="2"><b>Color</b></font></div></th>
			<th><div align="center"><font size="2"><b>Fuel</b></font></div></th>
			<th><div align="center"><font size="2"><b>RCBook Image</b></font></div></th>
			<th><div align="center"><font size="2"><b>Photo</b></font></div></th> -->
			
			<th><div align="center"><font size="2"><b>Entered By</b></font></div></th>
			<th><div align="center"><font size="2"><b>Entered Date Time</b></font></div></th>
			</tr>
			<%
			sql = "select * from db_gps.t_VehMst where Status = 'Active' and VehId in "+vehlist+" order by EntDateTime";
			rst = st.executeQuery(sql);
			while(rst.next())
			{
				html =rst.getString("VehRegn")+"%"+rst.getString("VehicleType")+"%"+rst.getString("VehUsage")+"%"+rst.getString("Regowner")+"%"+rst.getString("OSrNo")+"%"+rst.getString("Company")+"%"+rst.getString("Address1")+"%"+rst.getString("Address2")+"%"+
				rst.getString("Address3")+"%"+rst.getString("State")+"%"+rst.getString("City")+"%"+rst.getString("Pincode")+"%"+rst.getString("MnfName")+"%"+rst.getString("Model")+"%"+rst.getString("Mnfdate")+"%"+rst.getString("RTO")+"%"+rst.getString("RTOState")+"%"+
				rst.getString("RegDate")+"%"+rst.getString("RCBookNo")+"%"+rst.getString("Engno")+"%"+rst.getString("Chassisno")+"%"+rst.getString("Gearno")+"%"+rst.getString("VinNo")+"%"+rst.getString("UnladenWt")+"%"+rst.getString("RLW")+"%"+rst.getString("GVS")+"%"+
				rst.getString("Class")+"%"+rst.getString("body")+"%"+rst.getString("Length")+"%"+rst.getString("Breadth")+"%"+rst.getString("Width")+"%"+rst.getString("SeatingCap")+"%"+rst.getString("StandingCap")+"%"+rst.getString("NoOfTyres")+"%"+rst.getString("NoofCyl")+"%"+
				rst.getString("Color")+"%"+rst.getString("Fuel")+"%"+rst.getString("VehId")+"%"+rst.getString("RCBookCopy")+"%"+rst.getString("Photo");
				
				session.setAttribute("html"+i,html);
				System.out.println(html);
				String copy1="-",copy2="-";
				String abc=rst.getString("VehId");
				System.out.println("abcccccccaccacacashfdghavsd"+abc);
				
				%>
			
				<script>

// 				function Peripherals(id)
// 				{

<%-- 				 window.open("showperipheralsDet.jsp?id="+id+"&VehId=<%=rst.getString("VehId")%>&VehRegNo=<%=rst.getString("VehRegn")%>",'details','width=900,height=600,resizable=yes,scrollbars=yes'); --%>
// 				 popWin.focus();
// 				 return false;
// 				}

				
				</script>
				<tr>
				<td align="right"><div align="right"><font size="2" ><%=i%></font></div></td>
				<td align="right"><div align="left"><a href="javascript:toggleDetails(<%=i %>,1,true);"><font size="2" ><%= rst.getString("VehRegn")%></font>
				<div class="popup"  id="popup<%=i %>" style="display: none; position: absolute;">
				<table border="1" bgcolor="#9db5e5" cellpadding="1px" cellspacing="1px" style="width: 8em;">
				<tr>
				<td>
				<div  align="left"><a href="VehMstHistReport.jsp?VehID=<%=rst.getString("VehId")%>" onclick="javascript:toggleDetails(<%=i %>,2,false);">View History </a></div>
				</td>
				</tr>
				<tr>
				<td>
				<div  align="left"><a href="EditVehMst.jsp?id=<%=i%>" onclick="javascript:toggleDetails(<%=i %>,3,false);">Edit</a></div>
				</td>
				</tr>
				
				<tr>
				<td>
				<div  align="left"><a href="javascript:toggleDetails(<%=i %>,4,false);">Delete</a></div>
				</td>
				</tr>
				
				<tr>
				<td>
				<div align="left"><a href="javascript:toggleDetails(<%=i %>,6,false);">show details</a></div>
				</td>
				</tr>
				
				<tr>
				<td>
				<div align="left"><a href="showperipheralsDet.jsp?VehId=<%=rst.getString("VehId")%>&VehRegNo=<%=rst.getString("VehRegn") %> onclick="javascript:toggleDetails(<%=i %>,7,false);">Show Peripherals</a></div>
				</td>
				</tr>
				
				<tr>
				<td>
				<div align="left"><a href="javascript:toggleDetails(<%=i %>,5,false);">Close </a></div>
				</td>
				</tr>
				
				</table>
				</div>
				</a>
				</div></td>
				<td align="right"><div align="left"><font size="2"><%= rst.getString("VehicleType")%></font></div></td>
			<!-- <td align="right"><div align="left"><font size="2">< %= rst.getString("VehUsage")%></font></div></td>-->
				
			
				<td align="right"><div align="left"><font size="2"><%= rst.getString("Regowner")%></font></div></td>
			
			<!--<td align="right"><div align="right"><font size="2">< %= rst.getString("OSrNo")%></font></div></td>-->
				
				<td align="right"><div align="left"><font size="2"><%= rst.getString("Company")%></font></div></td>
				
			<!--<td align="right"><div align="left"><font size="2" >< %= rst.getString("Address1")%></font></div></td>
				<td align="right"><div align="left"><font size="2" >< %= rst.getString("Address2")%></font></div></td>
				<td align="right"><div align="left"><font size="2" >< %= rst.getString("Address3")%></font></div></td>
				<td align="right"><div align="left"><font size="2" >< %= rst.getString("State")%></font></div></td>
				<td align="right"><div align="left"><font size="2" >< %= rst.getString("City")%></font></div></td>
				<td align="right"><div align="left"><font size="2" >< %= rst.getString("Pincode")%></font></div></td>
				<td align="right"><div align="left"><font size="2" >< %= rst.getString("MnfName")%></font></div></td>-->
				
				<td align="right"><div align="left"><font size="2" ><%= rst.getString("Model")%></font></div></td>
				
		<!--  <td align="right"><div align="right"><font size="2">< %= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").parse(rst.getString("Mnfdate")))%></font></div></td>-->
				
				<td align="right"><div align="left"><font size="2" ><%= rst.getString("RTO")%></font></div></td>
				
		<!--  	<td align="right"><div align="left"><font size="2" >< %= rst.getString("RTOState")%></font></div></td>-->
				
				<td align="right"><div align="right"><font size="2" ><%= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("RegDate")))%></font></div></td>
				<td align="right"><div align="right"><font size="2" ><%= rst.getString("RCBookNo")%></font></div></td>
				
				
		<!--  		<td align="left"><div align="left"><font size="2" >< %= rst.getString("Engno")%></font></div></td>
				<td align="left"><div align="left"><font size="2" >< %= rst.getString("Chassisno")%></font></div></td>
				<td align="right"><div align="right"><font size="2" >< %= rst.getString("Gearno")%></font></div></td>
				<td align="right"><div align="right"><font size="2" >< %= rst.getString("VinNo")%></font></div></td>
				<td align="right"><div align="right"><font size="2" >< %= rst.getString("UnladenWt")%></font></div></td>	
				<td align="right"><div align="right"><font size="2" >< %= rst.getString("RLW")%></font></div></td>
				<td align="right"><div align="right"><font size="2" >< %= rst.getString("GVS")%></font></div></td>
				<td align="right"><div align="left"><font size="2" >< %= rst.getString("Class")%></font></div></td>
				<td align="right"><div align="left"><font size="2" >< %= rst.getString("body")%></font></div></td>
				<td align="right"><div align="right"><font size="2" >< %= rst.getString("Length")%></font></div></td>
				<td align="right"><div align="right"><font size="2" >< %= rst.getString("Breadth")%></font></div></td>
				<td align="right"><div align="right"><font size="2" >< %= rst.getString("Width")%></font></div></td>
				<td align="right"><div align="right"><font size="2" >< %= rst.getString("SeatingCap")%></font></div></td>
				<td align="right"><div align="right"><font size="2" >< %= rst.getString("StandingCap")%></font></div></td>
				<td align="right"><div align="right"><font size="2" >< %= rst.getString("NoOfTyres")%></font></div></td>		
				<td align="right"><div align="right"><font size="2" >< %= rst.getString("NoofCyl")%></font></div></td>
				<td align="right"><div align="left"><font size="2" >< %= rst.getString("Color")%></font></div></td>
				<td align="right"><div align="left"><font size="2" >< %= rst.getString("Fuel")%></font></div></td> -->
			
			
			
			
				<%
			/*	if(rst.getString("RCBookCopy")=="-" || rst.getString("RCBookCopy").equals("-") || rst.getString("RCBookCopy")==null || rst.getString("RCBookCopy").equals("null"))
				{*/
					%>
<!--					<td align="right"><div align="left"><font size="2" >< %= rst.getString("RCBookCopy")%></font></div></td>-->
					<%
				/*}
				else
				{
					String[] token=rst.getString("RCBookCopy").split(",");
					System.out.println("************    "+token.length);
					if(token.length==2)
					{
						System.out.println("******   in 2");
						copy1 = token[0].substring(token[0].lastIndexOf("/")+1).substring(18);
				        copy2 = token[1].substring(token[1].lastIndexOf("/")+1).substring(18);*/
				        %>
<!--				         <td align="right"><div align="left">-->
<!--				        <a href="#" onclick="getFTPImage('< %=token[0].substring(token[0].lastIndexOf("/")+1) %>')">-->
<!--						<font size="2" >< %=copy1%></font></a>-->
<!--						<br>-->
<!--						<a href="#" onclick="getFTPImage('< %=token[1].substring(token[1].lastIndexOf("/")+1) %>')">-->
<!--						<font size="2" >< %=copy2%></font></a>-->
<!--						</div></td>-->
				        <%
					/*}
					else
					{
						System.out.println("****** not 2");
						copy1 = token[0].substring(token[0].lastIndexOf("/")+1).substring(18);*/
						%>
<!--						 <td align="right"><div align="left">-->
<!--				        <a href="#" onclick="getFTPImage('< %=token[0].substring(token[0].lastIndexOf("/")+1) %>')">-->
<!--						<font size="2" >< %=copy1%></font></a>-->
<!--						</div></td>-->
						<%
						
				/*	}
				}
				
				if(rst.getString("Photo")=="-" || rst.getString("Photo").equals("-") || rst.getString("Photo")==null || rst.getString("Photo").equals("null"))
				{*/
					%>
<!--					<td align="right"><div align="left"><font size="2" >< %= rst.getString("Photo")%></font></div></td>-->
					<%
				/*}
				else
				{*/
					%>
<!--					<td align="right"><div align="left">-->
<!--					<a href="#" onclick="getFTPImage('< %=rst.getString("Photo").substring(rst.getString("Photo").lastIndexOf("/")+1) %>')">-->
<!--					<font size="2" >< %= rst.getString("Photo").substring(rst.getString("Photo").lastIndexOf("/")+1).substring(18)%></font></div></td>-->
					<%
				//}
				%>
				
				
				
				<td align="right"><div align="left"><font size="2" ><%= rst.getString("EntBy")%></font></div></td>
				<td align="right"><div align="right"><font size="2" ><%= new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("EntDateTime")))%></font></div></td>
				
				</tr>
		  <%
		  
		  i++;
			}
			
			%>
			
			</table>
	
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
	