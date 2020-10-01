
<%@ include file="Connections/conn.jsp" %>
<link rel="stylesheet" type="text/css" href="css/form.css" media="all">
<%@page import="java.util.Date"%>


<%!
Connection conn,conn1;
Statement st;
String ReportName="",Description="",Entby="",Name="",EmailID="",Email1="",FileName="",Category="";
String Priority="",ClosingComments="",ClosedBy="",Status="";
Date ComplaintDateTime,UpadteDateTime;
String ContactNumber="";

%>
<%
Class.forName(MM_dbConn_DRIVER); 
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);	
st=conn.createStatement();
%>
<html>
<head>
<script type="text/javascript">
function validate()
{
 var subcategory=document.getElementById("addsubcat").value;
 var addoptions=document.getElementById("addoptions").value;
// alert(addoptions);

 var subcatlen=subcategory.length;
 var addoptionslen=addoptions.length;
 subcategory=subcategory.replace(/\s/g, "");
 addoptions=addoptions.replace(/\s/g, "");

 var newsubcategorylen=subcategory.length;
 var newaddoptionslen=addoptions.length;
 
 var iChars = "!@#$%^&*()+=-[]\\\';./{}|\":<>?";
 
 for (var i = 0; i < subcategory.length; i++) 
	{
			if (iChars.indexOf(subcategory.charAt(i)) != -1) 
		{
		  	alert ("Special Characters are not allowed");
		  	return false;
			}
		}

 //for (var i = 0; i < addoptions.length; i++) 
//	{
	//		if (iChars.indexOf(addoptions.charAt(i)) != -1) 
//		{
	///	  	alert ("Special Characters are not allowed");
	//	  	return false;
	//		}
	//	}

 var letter = /^[A-Za-z]+$/;  

 if(!(subcategory.match(letter)) && subcategory.length!=0)  
 {  
    alert('Please enter characters value for subcategory');  
 return false;  
 } 

 
// if(!(addoptions.match(letter)) && addoptions.length!=0)  
 //{  
 //   alert('Please enter characters value for options');  
 //return false;  
 //} 
// if(subcatlen!=newsubcategorylen)
 //{
//	 alert("please enter valid subcategory");
//	 return false;
	 
 //}
 //  if(addoptionslen!=newaddoptionslen)
 //  {
//	   alert("Please enter valid options");
//	   return false;
 //  }
 
 if(subcategory=="" || subcategory==null)
 {
	 alert("Please enter subcategory");
	 return false;
 }

 if(addoptions=="" || addoptions==null)
 {
	 alert("Please add Input");
	 return false;
 }
	
}
function cktripid()
{

//	alert("------------------------------>");
	var cat=document.getElementById("addcat").value;
	//alert(cat);
	var subcat=document.getElementById("addsubcat").value;
	//alert(subcat);
	 var addoptions=document.getElementById("addoptions").value;
	// alert(addoptions);
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
		
		var result1;
		result1=reslt;

		result1=result1.replace(/^\s+|\s+$/g,'');
        //alert(result1);
        if(result1=='Yes')
        {
            alert("subcategory and input Already Exist,Please enter a new value for input");
            document.getElementById("addoptions").value="";
            
        }
        
       
        
		}catch(e)
		{
		alert(e);
		}
	} 
};
 
var queryString = "?options="+addoptions+"&subcat="+subcat+"";
ajaxRequest.open("get", "standardinput_ajax.jsp" + queryString, true);
ajaxRequest.send(null); 

}
</script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body style="background-color: #F5F5F5">
<%
try
{
  //System.out.println("\n\n in try");
 //String user=session.getAttribute("user").toString();
 st=conn.createStatement();
 String PageName="";
 String add=request.getParameter("Parameter");
 
 String msg=request.getParameter("msg");
 System.out.println("******** " +add);
 String desc="";
 String EmailID="";
 String Number="";
 String category="";
 String priority="";
 String name="";

 if(add!=null)
 {%>
 <script language="javascript" type="text/javascript">
alert("Record added successfully");	
window.opener.location.reload();
	
 	
 	</script>
 	
 <% }
 if(msg!=null)
 {%>
 <script language="javascript" type="text/javascript">
alert("Input Already present for subcategory");	
//window.opener.location.reload();
	
 	
 	</script>
 	
 <% }
   %>

	<form name="incident" style="background: #F5F5F5;" method="post"  action="StandardOptionInsert.jsp" onsubmit="return validate();">
		
	<div
		style="background: #E6E6E6; font-size: 1.5em; text-align: center; font-family: Arial; color: Red; width: 50%; margin-left: 18%;">
     DMC Standard Option Entry</div>
	<table align="center"  style="background: #F5F5F5;width: 50%; margin-left: 17%;">
	
<tr id="trb">
        
        <td ><font size="2" color="black"><b>AddCategory</b></font></td> 
        <td>
	<select  name="addcat" id="addcat" class="element select medium" style="width: 180px;">
	<% 
			String sql="select distinct(Categoery) from db_gps.t_JourneyGoals";
			ResultSet rst=st.executeQuery(sql);
			while(rst.next())
			{
				out.println(rst.getString("Categoery"));
			%>
			<option value="<%=rst.getString("Categoery")%>"><%=rst.getString("Categoery")%></option>						
			<%			}				
	%>			
	</select></td>
</tr>

<tr id="trc">

	<td><font size="2" color="black"><b>AddSubCategory</b></font></td>
		<td><input style="width: 180px;" type="text" name="addsubcat" id="addsubcat" class="element text medium" ></td>
	</tr>
	<tr id="trc">
	
		<td><font size="2" color="black"><b>AddInput</b></font></td>
		<td><input style="width: 180px;" type="text" name="addoptions" id="addoptions" class="element text medium"  ></td>
	</tr>
	
	
	 
	<tr id="tri">
	<td colspan="2" align="center">
	<input type="submit" name="submit" id="submit" value="submit" style="border-style: outset; border-color: black"  >
	 </td>		
	</tr>

</table>
		
		
			
			

		

	
	

	
	</form>

	
	
	
	<%
	
// }
//else
//{
 //   	System.out.println("IN main    main   ELSE  ");
  //  	session.invalidate();
  //  	%>
<!-- 	<script>  -->
<!--  window.close(); -->
    <!-- 	</script>  -->
   	<%
    	//response.sendRedirect("index.jsp");
//}
    
    
}
catch(Exception e)
{
	e.printStackTrace();
}
 %></body>
	</html>


