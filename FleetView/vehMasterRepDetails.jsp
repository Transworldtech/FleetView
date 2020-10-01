
<%@ page language="java" import="java.sql.*" import="java.util.*"
import=" java.text.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/view.css" media="all" />
<link rel="stylesheet" type="text/css" href="css/mystyle.css" media="all" />
<title>Vehicle Master Report Details</title>

</head>
<body id="main_body" >
<%@ include file="headernew.jsp"%>
<script type="text/javascript">

//function gotoPrint(divName)  
//{  
	  
	//  var printContents = document.getElementById(divName).innerHTML; 
	 // var originalContents = document.body.innerHTML; 
	 // document.body.innerHTML = printContents;  
	//  window.print();
	//  document.body.innerHTML = originalContents;  
//}





function getFTPImage(ftpFile)
{
	try
	{
		//alert("+++++"+ftpFile+"+++++");
		
		var fup = ftpFile;
		var ext = fup.substring(fup.lastIndexOf('.') + 1);
		
		//alert("+++++"+ext+"+++++");
		
		if(ext == "pdf" || ext == "PDF")			
		{
			//alert("in if");
			window.open('http://myfleetview.com:8080/images1/savedimages/'+ftpFile+'','mywindow','width=1000, height=600, toolbar=false, location=false, status=no, menubar=no, resizable=no, scrollbars=yes');
		}
		else 
		{
			//alert("in if");
			window.open('showFTP.jsp?ftpFile='+ftpFile+'','mywindow','width=1000, height=600, toolbar=false, location=false, status=no, menubar=no, resizable=no, scrollbars=yes');
		}

	}
	catch(e)
	{
		alert(e);
	}
}


</script>

<!--  <table border="0" align="right" >-->
<!--<tr>-->
<!--<td>-->

                        <!--   <div class="bodyText" align="right">-->
                           
     
                        <!--    <a href="#" style="font-weight: bold; color: black; " onclick="gotoPrint('form_container');" title="Print">-->
                       <!--      <img src="images/print.jpg" width="25px" height="25px" style="border-style: none"></img></a> -->
      
                           
                       <!--      </div>  -->
                <!--      </td>  -->
                <!--      </tr>  -->
 <!--  </table> -->

<img id="top" src="newimages/top.png" alt="">
	
	<div id="form_container">
	
		<h1 align="center"><u><a>Vehicle Master Details</a></u></h1>
		<br>
		<form id="vehMasterRepDetails" class="appnitro"  method="post" >


<%
try
{

	String vehlist= session.getAttribute("VehList").toString();
	String nwfrmtdte = new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	//System.out.println("**********   ");
	String id =  request.getParameter("id");
	System.out.println("^^^^^^^^^   "+id);
	String html = session.getAttribute("html"+id).toString();
	System.out.println("#########   "+html);
    String[] token = html.split("%");
    
    System.out.println("length  "+token.length);
    for(int k=0; k<token.length; k++)
	{
		System.out.println("*****    "+k+"  ********     "+token[k]);
	}



%>




<div width="100%" align="left"  style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff">
<font size="3"style="margin-left: 0.4em;"><u>Vehicle Details</u></font>
<br></br>
<table border="1" width="100%">
<tr bordercolor="black">
 <th style="background-color: #C6DEFF;" align="center">Vehicle RegNo</th>
 <th style="background-color: #C6DEFF;" align="center">Vehicle Type</th>
  <th style="background-color: #C6DEFF;" align="center">Usage</th>
   <th style="background-color: #C6DEFF;" align="center">Owner Name</th>
    <th style="background-color: #C6DEFF;" align="center">Owner Sr.No</th>
     <th style="background-color: #C6DEFF;" align="center">Company/Group</th>
     </tr>
     
     <tr>
     <td width="16%"><%=token[0]%></td>
     <td width="16%"><%=token[1]%></td>
     <td width="16%"><%=token[2]%></td>
     <td width="16%"><%=token[3]%></td>
     <td width="16%"><%=token[4]%></td>
     <td width="16%"><%=token[5]%></td>
     </tr>



</table>
</div>
<br>

<table border="1" width="100%">

<tr>
 <th style="background-color: #C6DEFF;" align="center">Address1</th>
 <th style="background-color: #C6DEFF;" align="center">Address2</th>
  <th style="background-color: #C6DEFF;" align="center">Address3</th>
   <th style="background-color: #C6DEFF;" align="center">State</th>
    <th style="background-color: #C6DEFF;" align="center">City</th>
     <th style="background-color: #C6DEFF;" align="center">PinCode</th>
     </tr>
     
     <tr>
     <td width="16%"><%=token[6]%></td>
     <td width="16%"><%=token[7]%></td>
     <td width="16%"><%=token[8]%></td>
     <td width="16%"><%=token[9]%></td>
     <td width="16%"><%=token[10]%></td>
     <td width="16%"><%=token[11]%></td>
     </tr>

</table>


<br></br>
<div width="100%" align="left"  style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff">
<font size="3"style="margin-left: 0.4em;"><u>Manufacturing Details</u></font>
<br></br>
<table border="1" width="100%">

<tr>
 <th style="background-color: #C6DEFF;" align="center">Manufacturer Name/Make</th>
 <th style="background-color: #C6DEFF;" align="center">Model</th>
  <th style="background-color: #C6DEFF;" align="center">Date of Manufacture</th>
   </tr>
     
     <tr>
     <td width="50%"><%=token[12]%></td>
     <td width="25%"><%=token[13]%></td>
     <td width="25%"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(token[14]))%></td>
     
     </tr>



</table>

</div>
<br></br>


<div width="100%" align="left"  style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff">
<font size="3"style="margin-left: 0.4em;"><u>RTO Details</u></font>
<br></br>
<table border="1" width="100%">

<tr>
 <th style="background-color: #C6DEFF;" align="center">RTO Name</th>
 <th style="background-color: #C6DEFF;" align="center">RTO State</th>
  <th style="background-color: #C6DEFF;" align="center">Date of Registration</th>
  <th style="background-color: #C6DEFF;" align="center">RC Book No/Card</th>
   </tr>
     
     <tr>
     <td width="25%"><%=token[15]%></td>
     <td width="25%"><%=token[16]%></td>
     <td width="25%"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(token[17]))%></td>
     <td width="25%"><%=token[18]%></td>
     </tr>



</table>
</div>
<br></br>

<div width="100%" align="left"  style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff">
<font size="3"style="margin-left: 0.4em;"><u>Engine Details</u></font>
<br></br>
<table border="1"  width="100%">

<tr>
 <th style="background-color: #C6DEFF;" align="center">Engine No</th>
 <th style="background-color: #C6DEFF;" align="center">Chassis No</th>
  <th style="background-color: #C6DEFF;" align="center">GearBox No</th>
  <th style="background-color: #C6DEFF;" align="center">VIN No</th>
   </tr>
     
     <tr>
     <td width="25%"><%=token[19]%></td>
     <td width="25%"><%=token[20]%></td>
     <td width="25%"><%=token[21]%></td>
     <td width="25%"><%=token[22]%></td>
     </tr>
</table>
<br>

<table border="1"  width="100%">

<tr>
 <th style="background-color: #C6DEFF;" align="center">UnladenWT(KG)</th>
 <th style="background-color: #C6DEFF;" align="center">RLW(KG)</th>
  <th style="background-color: #C6DEFF;" align="center">GVS</th>
  <th style="background-color: #C6DEFF;" align="center">Class</th>
   </tr>
     
     <tr>
     <td width="25%"><%=token[23]%></td>
     <td width="25%"><%=token[24]%></td>
     <td width="25%"><%=token[25]%></td>
     <td width="25%"><%=token[26]%></td>
     </tr>
</table>

<br>
<table border="1" width="100%">

<tr>
 <th style="background-color: #C6DEFF;" align="center">Type Of Body</th>
 <th style="background-color: #C6DEFF;" align="center">Length(meters)</th>
  <th style="background-color: #C6DEFF;" align="center">Breadth(meters)</th>
  <th style="background-color: #C6DEFF;" align="center">width(meters)</th>
   </tr>
     
     <tr>
     <td width="25%"><%=token[27]%></td>
     <td width="25%"><%=token[28]%></td>
     <td width="25%"><%=token[29]%></td>
     <td width="25%"><%=token[30]%></td>
     </tr>
</table>
<br>

<table border="1" width="100%">

<tr>
 <th style="background-color: #C6DEFF;" align="center">Seating Capacity</th>
 <th style="background-color: #C6DEFF;" align="center">Standing Capacity</th>
  <th style="background-color: #C6DEFF;" align="center">No of Tyres</th>
  <th style="background-color: #C6DEFF;" align="center">No of Cylinders</th>
   </tr>
     
     <tr>
     <td width="25%"><%=token[31]%></td>
     <td width="25%"><%=token[32]%></td>
     <td width="25%"><%=token[33]%></td>
     <td width="25%"><%=token[34]%></td>
     </tr>
</table>

<br>
<table border="1" width="50%">

<tr>
 <th style="background-color: #C6DEFF;" align="center">Color</th>
 <th style="background-color: #C6DEFF;" align="center">Fuel</th>

   </tr>
     
     <tr>
     <td width="25%"><%=token[35]%></td>
     <td width="25%"><%=token[36]%></td>
    
     </tr>
</table>

</div>

<br>


<div width="100%" align="left"  style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff">
<font size="3"style="margin-left: 0.4em;"><u>Uploaded Documents</u></font>
<br></br>
<table border="1" width="100%">

<tr>
<th style="background-color: #C6DEFF;" align="center">RCBook Image</th>
 <th style="background-color: #C6DEFF;" align="center">Photo</th>
  
   </tr>
     
<tr>
<%
String copy1 = "",copy2 = "";
				if(token[38]=="-" || token[38].equals("-") || token[38]==null || token[38].equals("null"))
				{
					%>
					<td ><div align="left"><font size="2" ><%=token[38]%></font></div></td>
					<%
				}
				else
				{
					String[] token1=token[38].split(",");
					System.out.println("************    "+token1.length);
					if(token1.length==2)
					{
						System.out.println("******   in 2");
						copy1 = token1[0].substring(token1[0].lastIndexOf("/")+1).substring(18);
				        copy2 = token1[1].substring(token1[1].lastIndexOf("/")+1).substring(18);
				        %>
				         <td width="50%"><div align="left">
				        <a href="#" onclick="getFTPImage('<%=token1[0].substring(token1[0].lastIndexOf("/")+1)%>')">
						<%=copy1%></a>
						<br>
						<a href="#" onclick="getFTPImage('<%=token1[1].substring(token1[1].lastIndexOf("/")+1) %>')">
						<%=copy2%></a>
						</div></td>
				        <%
					}
					else
					{
						System.out.println("****** not 2");
						copy1 = token1[0].substring(token1[0].lastIndexOf("/")+1).substring(18);
						%>
						 <td width="50%"><div align="left">
				        <a href="#" onclick="getFTPImage('<%=token1[0].substring(token1[0].lastIndexOf("/")+1) %>')">
						<%=copy1%></a>
						</div></td>
						<%
						
				}
				}
				
				if(token[39]=="-" || token[39].equals("-") || token[39]==null || token[39].equals("null"))
				{
					System.out.println("*******");
					%>
					<td width="50%"><div align="left"><%= token[39]%></div></td>
					<%
				}
				else
				{
					System.out.println("%%%%%%%");
					copy1 = token[39].substring(token[39].lastIndexOf("/")+1).substring(18);
					%>
					<td width="50%"><div align="left">
					<a href="#" onclick="getFTPImage('<%=token[39].substring(token[39].lastIndexOf("/")+1) %>')">
					<%=copy1%></a>
					</div>
					</td>
					<%
				}
				%>





</tr>



</table>

</div>












</form>
<%
} catch (Exception e) {
	out.println("Please Select The Transporter "+e);
} finally {
	try {
		
	} catch (Exception e) {
	}
	
}




%>

	</div>
	<img id="bottom" src="newimages/bottom.png" alt="">
	
	
	
	<!-- footer start here -->
				
   <%@ include file="footernew.jsp"%>

</body>

				

</html>

