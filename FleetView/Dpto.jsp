<%@ page language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>
<link href="css/Fleetview.css" rel="stylesheet" type="text/css"></link>
<style type="text/css">@import url(jscalendar-1.0/calendar-blue.css);</style>
<%@ page import = "java.io.FileNotFoundException"%>
<%@ page import = "java.io.FileOutputStream"%>
<%@ page import = " java.io.IOException"%>
<%@ page import="javax.activation.*" %>
<script type="text/javascript" language="javascript" src="calendar/prototype-1.js"></script>
<script type="text/javascript" language="javascript" src="calendar/prototype-base-extensions.js"></script>
<script type="text/javascript" language="javascript" src="calendar/prototype-date-extensions.js"></script>
<script type="text/javascript" language="javascript" src="calendar/behaviour.js"></script> 
<script type="text/javascript" language="javascript" src="calendar/datepicker.js"></script> 
<link rel="stylesheet" href="calendar/datepicker.css">
<script type="text/javascript" language="javascript" src="calendar/behaviors.js"></script> 
<jsp:useBean id="centconn" class="FormToolConnection.FormToolConn" scope="page">
<script>
<%
String VehId=request.getParameter("VehId");
System.out.println("VehId on Demo jsp-"+VehId);
String VehRegNo=request.getParameter("VehRegNo");
System.out.println("VehRegNo on demo jsp-"+VehRegNo);

String user=session.getAttribute("mainuser").toString();
String transporter=session.getAttribute("usertypevalue").toString();
%>

function formValidation()
{
var displaylabel="";
var displaycount="";
var count3="";
if((element_3_3.value==0)){
displaylabel+='<font face="Arial" size="1" color="red">Mandatory Field</font>,';
displaycount+='3,';
}
if(!(element_3_3.value==0))
{
var numbers = /^[0-9]+$/;
if(element_3_3.value.match(numbers))
{
count3+='3,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter Number only</font>,';
displaycount+='3,';
}
}
if(displaylabel == ""){
return true;
}

else{
var displaylabelres = displaylabel.split(",");
var res1=displaycount.split(",");
var res2=count3.split(",");
var i;
var j;

for(j=0; j < res2.length-1; j++){
 document.getElementById("element_error_"+ res2[j]).style.display='none';
 }
 
for (i = 0; i < displaylabelres.length-1; i++) {
    var element_error_="element_error_"+i;
    var number=i;
    document.getElementById("element_error_"+ res1[i]).style.display="";
    document.getElementById("element_error_"+ res1[i]).innerHTML=displaylabelres[i];
} 

 return false;
}
}

function deletexpence(){
	
	alert("here...");
	
}

function showexpence(field){


	if(field==0 || field=="")
	  {
	  alert("Please Enter Field Value");
	  return false;
	 
	  }
	
	
	if(field.length<3)
	{
	
	
	alert("Please Enter Proper Field Name");
	  return false;
	
	}
     
     
      var invalid=/^[A-Za-z_]+$/;
      
      if(!invalid.test(field))
      {
      alert("Please Enter Only Character Value");
      return false;
      }



  else{
	  try
	{
//alert("ajax 222");
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
	        document.getElementById("thisdaydiv").innerHTML = reslt;
			window.location.reload();
		    document.getElementById("element_3_2").value='';
		    }
			catch(e)
			{
				alert(e);
			}
		}
	};
	
	var queryString ="?field="+field;
	//alert(queryString);
	ajaxRequest.open("POST", "Dptoajax.jsp" + queryString, true);
	ajaxRequest.send(null); 
	}
	catch(e)
	{
		alert(e);
	}
  }

}

function deletexpence(id)
{

		 try{
			 var agree=confirm("Do You Want to Delete this Entry??");

			 	if(agree)
			     {
			 		
			           
			            window.location="Dptodelete.jsp?&rid="+id;
			            
			     }

			 }catch(e)
			 {alert(e);
			 }
		 
	 

	}
	
	
</script>
<%
Connection con1 = null;
Statement stdynamicdrop = null,st4=null;
String datenew1="",datenew2="",datenew3="",owner="";
ResultSet rst2=null;
datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
datenew3=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date());
datenew2=datenew1;
centconn.getConnection();
con1=centconn.ReturnConnection();
stdynamicdrop=con1.createStatement();
st4=con1.createStatement();

//String owner=session.getAttribute("usertypevalue").toString();
try{
owner=session.getAttribute("usertypevalue").toString();
}catch(Exception e){
	e.printStackTrace();
}
String routeid=request.getParameter("via");
%>

<%@ include file="headernew.jsp"%> 

<%	
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
					   alert("Unable to delete the Entry!!!");
					</script>
					<%
				}
%>

<form name="userform" action=" " method="post" onsubmit="return formValidation();">
<br>
<br>
<div align="center" class="headerlay"><table style="color:#fff;"><tbody><tr><td><label id="element_1" name="element_1"  class="description" for="element_1"><font size="3" color="black"><b>Add Custom Field For PTO</b></font> </label></td></tr></tbody></table></div>
<table border="0" width="400" align="center" class="sortable_entry_new">

 <tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Field : </b> </label><input id="element_3_2" name="element_3_2"  class="element text medium" type="text"  value=""/><br><label id="element_error_3"></label><br><br><!--2,2-->

</td>


<!-- <td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Type : </b> </label><input id="element_3_3" name="element_3_3"  class="element text medium" type="text"  value=""/><br><label id="element_error_3"></label><br><br>2,2</td> -->
<!-- </tr> -->
<!-- <tr> -->
<!-- <td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Length : </b> </label><input id="element_3_4" name="element_3_4"  class="element text medium" type="text"  value=""/><br><label id="element_error_3"></label><br><br>2,2</td> -->

<td><input id="saveForm" name="submit" class="button_text" type="button"  value="Add" onclick="javaprg:try{showexpence(document.getElementById('element_3_2').value);}catch(e){alert(e);}" /><br><br><!--4,1-->
</td>
<td><!--4,2--></td>
</tr>

</table>
  <div align="center">

<a href="EditDpto.jsp?VehId=<%=VehId%>&VehRegNo=<%=VehRegNo%>"><font color="Blue" size="2">Go Back</font></a>
</div>
<div align="center" id="thisdaydiv">
<%//String routecode=request.getParameter("element_3_1"); %>
 <table class="sortable" border="1" style="width:50%;" >
<tr>
                        <th>
						<b>SrNo</b>
						</th>
                        <th>
						<b>Field</b>
						</th>
						
			</tr>
						<% int j=1;
    String Sqlday="select * from db_gps.t_custpto where Owner='"+transporter+"' order by id";
	System.out.println("route name=====>"+Sqlday);
	 rst2= st4.executeQuery(Sqlday);
	 System.out.println("xyzxyzxyzxyzxyz111111"+Sqlday);
	 while(rst2.next())
	{ %>
		<tr>
                 
		<td align='right' width="25px"><div align='right'><%=j%></div></td>
                <td align='left'><div align='left'><%=rst2.getString("field")%></div></td>
<%--                 <td align='right'><div align='right'><%=rst2.getString("type")%></div></td> --%>
<%--                 <td align='right'><div align='right'><%=rst2.getString("length")%></div></td> --%>
 		<td> 
    <div  align='center'><a href="" onClick="return deletexpence('<%=rst2.getString("id")%>');">Delete</a></div></td></tr> 
				
		
	<% 	j++;
	}%>
			
</table>
</div>
</form>
</jsp:useBean>
<%@ include file="footernew.jsp" %>
