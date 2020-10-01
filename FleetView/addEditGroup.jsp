

<%@ include file="headernew.jsp"%>

<%! 
Connection con, con2;
Statement stmt1,stmt2;
%>
<script language="javascript">
function validate(){
//	alert("in validate function");
	
	
		//	alert(document.addgrpform.gadd.value);
			if(document.addgrpform.gadd.value==" "){
					alert("Please enter group name");
					return false;
				}
		//	alert(document.addgrpform.vehcles.value);
			if(document.addgrpform.vehcles.value=="" || document.addgrpform.vehcles.value=="Select"){
					alert("Please select at least one vehicle number");
					return false;
				}
	
return true;
}
function validate1(){
	//alert("in validate1 function");
		//	alert(document.deletegrpform.vehcles1.value);
			if(document.deletegrpform.vehcles1.value=="Select"){
					alert("Please select vehicleRegNumber");
					return false;
				}
		//	alert(document.getElementById("group").value);
			if(document.getElementById("group").value=="Select"){
					alert("Please select group");
					return false;
				}
	
return true;
}
function formsubmit()
{
	var aa=document.addgrpform.owner.value;
	if(!(aa=="Select"))
	{	
		document.addgrpform.submit();
		document.addgrpform.owner[0].value = "Select";
		document.addgrpform.owner[0].selected = true;
		//alert(document.addgrpform.vehcles.value)f;
	}

}

function formsubmit2()
{

	var bb=document.addgrpform.vehcles.value;
	
	if(!(bb=="Select"))
	{	
		document.addgrpform.submit();
	}

}

function getVehicleByOwner(dropdown)
{
var vv1=dropdown.selectedIndex;

var lowerLimit = dropdown.options[vv1].value;
//alert ("lowerLimit----->"  + lowerLimit);

var ajaxRequest;

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
	         	alert ("reslt---->" +  reslt);
             	reslt=ajaxRequest.responseText;
             	document.getElementById("veh_group").innerHTML=reslt; 
            
         } 
	}
	
		var url="getVehiclenum.jsp";
       	url = url + "?TripID="+lowerLimit;
	    ajaxRequest.open("GET", url , true);
     	ajaxRequest.send(null); 
 
}
function ShowHide(id)
{
//	alert(id);
	if(id==0)
	{
		document.getElementById("deleteid").style.display='none';
		document.getElementById("addid").style.display="";
		
	}
	else if(id==1)
	{
		document.getElementById("deleteid").style.display="";
		document.getElementById("addid").style.display='none';
		
	}
	else
	{
		document.getElementById("addid").style.display="";
		document.getElementById("deleteid").style.display='none';
		
	}
}
</script>

<body>


<br>
<br>
<div align=center>
<%
   try
{
	    Class.forName(MM_dbConn_DRIVER);
	    con=DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	    stmt1=con.createStatement();
        stmt2=con.createStatement();
	    String sql,sql1; 
	    ResultSet rs1,rs2;
	    String OwnerName=session.getAttribute("usertypevalue").toString();
        String RegNo=request.getParameter("vehcles"); 
        String thename=request.getParameter("radio1");   
        //out.println(thename);
        if(thename==null)
        {
       	 thename="add";
        }
          

%> <!--<input type="radio" name="radio1" value="add" onClick="">--> <!--<input type="radio" name="radio1" value="delete"  onClick="">-->

<input type="radio" name="radio1" id="radio1" value="add"
	<% if(thename.equals("add")) { out.print("CHECKED"); } %> onClick="ShowHide(0);" ><b>ADDGroup</b>
<input type="radio" name="radio1" id="radio1" value="delete"
	<% if(thename.equals("delete")) { out.print("CHECKED"); } %> onClick="ShowHide(1);"><b>DeleteGroup</b>



<br>
<br>
<%
 
   
  
         
                     			 
         	%>

<table border="0" width="850px">
<tr id="addid"><td>
<form name="addgrpform" method="post" action="newconfirmgrp.jsp"
	onSubmit="return validate();">
<table border="0" width="50%" align="center">
	<tr>
		<td bgcolor="#f5f5f5"><font color="maroon"> Owner Name: </font></td>
		<td colspan="3"  bgcolor="#f5f5f5"><select name="owner" id="owner"
			onchange="formsubmit();"">
			<option value="<%=OwnerName %>" selected="selected"><%=OwnerName %></option>
		</select></td>
	</tr>

	<tr>
		<td bgcolor="#f5f5f5"><font color="maroon">Vehicles : </font></td>
		<td bgcolor="#f5f5f5"><select name="vehcles"  multiple="multiple" size="5" >
			<option value="Select">Select &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>

			<%
	   sql="select Distinct(VehicleRegNumber) from db_gps.t_vehicledetails where OwnerName='"+OwnerName+"' order by VehicleRegNumber";
	   rs2=stmt2.executeQuery(sql);
	   while(rs2.next())
   	   { %>
			<option value="<%=rs2.getString("VehicleRegNumber") %> "><%=rs2.getString("VehicleRegNumber") %>
			</option>
			<% } %>

		</select></td>



	</tr>
	<tr>
		<td bgcolor="#f5f5f5"><font color="maroon">Groups : </font></td>
		<td bgcolor="#f5f5f5" colspan="3"><input type="text" name="gadd" value=" "></input>

		<%
	  // String OwnerName=request.getParameter("owner");
		//System.out.println(OwnerName);
	   sql="select Distinct(GPName) as grp from db_gps.t_group where GPName not like '%del' order by GPName";
	   //System.out.println("sql----->" +  sql);
	  	String str = "select Distinct(GPName) as grp from db_gps.t_group where GPName not like '%del' where GPName Not In (select Distinct(GPName) from db_gps.t_group where transporter='"+RegNo+"') order by GPName"; 
	   //System.out.println("str--->" +str);
	  	rs2=stmt2.executeQuery(sql);
	   while(rs2.next())
   	   { %> <% } %>
		
	</tr>
	<tr>
		<td bgcolor="#f5f5f5" colspan="4">
		<div align="center"><input type="Submit" name="Submit"
			value="Add" ></input></div>
		</td>

	</tr>
</table>
</form>
</td>
</tr>
<% 
            
      %>
<tr id="deleteid" style="display:none" ><td>
<form name="deletegrpform" method="post" action="deletegroup.jsp"
	onSubmit="return validate1();">
<table border="0" width="50%" align="center">
	<tr>
		<td bgcolor="#f5f5f5" ><font color="maroon"> Owner Name: </font></td>
		<td bgcolor="#f5f5f5" colspan="3"><select name="owner1" id="owner1"
			onChange="formsubmit();">
			<option value="<%=OwnerName%>" selected="selected"><%=OwnerName %></option>
		</select></td>
	</tr>
	<tr>
		<td bgcolor="#f5f5f5"><font color="maroon">Vehicles : </font></td>
		<td bgcolor="#f5f5f5"><select name="vehcles1" id="vehcles1"
			onChange="getVehicleByOwner(this);">
			<option value="Select">Select</option>

			<%
	  
	   sql1="select Distinct(VehicleRegNumber) from db_gps.t_vehicledetails where OwnerName='"+OwnerName+"' order by VehicleRegNumber";
	   rs2=stmt2.executeQuery(sql1);
	   while(rs2.next())
   	   { %>
			<option value="<%=rs2.getString("VehicleRegNumber") %> "><%=rs2.getString("VehicleRegNumber") %>
			</option>
			<% }
     	
	    %>
		</select></td>
	</tr>
	<tr>

		<td bgcolor="#f5f5f5"><font color="maroon"> Selected Vehicle Available in
		Group/s : </font></td>
		<td bgcolor="#f5f5f5">
		<div id="veh_group" ></div>
		</td>
	</tr>

	<tr>

		<td colspan="4"  bgcolor="#f5f5f5">
		<div align=center><input type="Submit" name="Submit"
			value="delete"></div>
		</td>
	</tr>
</table>
</form>
</td>
</tr>
</table>
<% 
    	 
    
        	
        	
        	
       	} 
catch(Exception e)
{
	out.println(e);
	}
finally
{
  con.close();	
}
%>
</div>
</form>


</body>




<%@ include file="footernew.jsp" %>




