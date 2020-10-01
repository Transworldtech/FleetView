<script language="javascript">

// This function will get called when any Transporter is selected and it will get all the Vehicles of that selected Transporter and will display in 'Vehicles' drop-down box..

function showvehs(dropdown)
{
  var vv1=dropdown.selectedIndex;
       
  var SelValue1 = dropdown.options[vv1].value;
//   alert(SelValue1);
          

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

             // Create a function that will receive data sent from the server
           	  ajaxRequest.onreadystatechange = function()
                   {
    	 	  if(ajaxRequest.readyState == 4)
                      {
                         var reslt=ajaxRequest.responseText;
                         //alert(reslt);
                        //document.getElementById("mydiv").innerHTML=reslt;
                        
                          var reslt=ajaxRequest.responseText;
                         var mySplitResult = reslt.split("#");
                         //alert(mySplitResult[0]);
                         //alert(mySplitResult[1]);  
                         document.getElementById("mydiv").innerHTML=mySplitResult[0]; 
                         document.getElementById("mydiv1").innerHTML=mySplitResult[1];   
                         
		      } 
         	  }
             var queryString = "?transp=" +SelValue1;
	     ajaxRequest.open("GET", "Ajaxgettransvehs.jsp" + queryString, true);
	     ajaxRequest.send(null);  
}

// This function will get called when any vehicle will be selected and it will get all the Exceptions related to that Vehicle during last 24 hours.

function showVehExcep(dropdown)
{
  var vv1=dropdown.selectedIndex;
       
  var SelValue1 = dropdown.options[vv1].value;
  //alert(SelValue1);

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

             // Create a function that will receive data sent from the server
           	  ajaxRequest.onreadystatechange = function()
                   {
    	 	  if(ajaxRequest.readyState == 4)
                      {
                         var reslt=ajaxRequest.responseText;
                         //alert(reslt);
                        document.getElementById("mydiv2").innerHTML=reslt;
                         
		      } 
         	  }
             var queryString = "?vehic=" +SelValue1;
	     ajaxRequest.open("GET", "Ajaxgetvehdrivers.jsp" + queryString, true);
	     ajaxRequest.send(null); 
}

// This function will get called when any Driver will be selected and it will get all the Exceptions related to that driver during last 24 hours.

function showDriverTrips(dropdown)
{
  var vv1=dropdown.selectedIndex;
       
  var SelValue1 = dropdown.options[vv1].value;
  //alert(SelValue1);
  
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

             // Create a function that will receive data sent from the server
           	  ajaxRequest.onreadystatechange = function()
                   {
    	 	  if(ajaxRequest.readyState == 4)
                      {
                         var reslt=ajaxRequest.responseText;
                         //alert(reslt);
                        document.getElementById("mydiv3").innerHTML=reslt;
                         
		      } 
         	  }
             var queryString = "?driv=" +SelValue1;
	     ajaxRequest.open("GET", "Ajaxgetdrivertrips.jsp" + queryString, true);
	     ajaxRequest.send(null); 
}

/*function submitdriver(dropdown)
{
   var vv1=dropdown.selectedIndex;
   var SelValue1 = dropdown.options[vv1].value;
   //alert(SelValue1);
   
   document.vehdispform.submit();
} */

</script>

<%@ include file="header.jsp" %>

<form name="vehdispform" method="get" action="vehdisprep.jsp" onSubmit="return validate();" >

<input type="hidden" name="submitted" value="yes" /> 



<%!
Connection con1;
%>

<table border="1" bgcolor="white" width="100%">
            <tr> 
		 <td align="left"> <font color="red"><B> Note: </B> Please select <I> Transporter + Vehicle </I> to check Vehicle Exception. And <I> Transporter + Driver </I> to check Driver Exception </font></td>
                 <td> <div align="right"> <a href="#" title="Print "><img src="images/print.jpg" onclick="javascript:window.print()" width="15px" height="15px"></a>&nbsp; &nbsp;
                       <a href="excelrepallexcep.jsp"  title="Export both reports to Excel"><img src="images/excel.jpg" width="15px" height="15px"> </a> </div> </td>
            </tr>
         </table>
<table border="1" width="100%" bgcolor="white">
  <tr>
      <td> <center>
<table border="0" width="40%">
  <tr>
      <td> <div align="center"> <font color="maroon" size="3"> <b> Exception Analysis of Vehicles / Drivers</b> </font> </div> </td>
  </tr>
</table>

<%
try {

Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt1=con1.createStatement();
ResultSet rs1=null;
String sql1="";

String user=session.getValue("usertypevalue").toString();

sql1="select distinct(VehRegNo) as grp from t_group where SepReport='Yes' and GPName='Castrol' order by VehRegNo asc";
//out.print(sql1);
rs1=stmt1.executeQuery(sql1);

%>



<table border="1" width="40%">
  <tr> <td> <font color="maroon" > Transporter </font> </td>
       <td> <select name="trans" class="formElement" onChange="showvehs(this);"> <option value="Select" >Select</option> 
             <% 
                 while(rs1.next())
                 { %>
                       <option value="<%=rs1.getString("grp") %> "> <%=rs1.getString("grp") %> </option>
                      
             <%  } %>
            </select>   
       </td>
  </tr>
  <tr> <td> <font color="maroon" > Vehicles </font> </td>
       <td> <div id="mydiv"> <select name="vehs" class="formElement" onChange="showVehExcep(this);" > <option value="Select" >Select</option> 
             
            </select>   </div>
       </td>
  </tr>
  <tr> <td> <font color="maroon" > Drivers </font> </td>
       <td> <div id="mydiv1"> <select name="drivers" class="formElement" onChange="showDriverTrips(this);"> <option value="Select" >Select</option> 
             
            </select>  </div> 
       </td>
  </tr>
    
    
</table>


<% 
  String submitted=request.getParameter("submitted");
   if(submitted==null)
    {
      
    }
    else
    { 
         String veh=request.getParameter("vehs"); 
         String driv=request.getParameter("drivers");    
%>
         
 
<%  }
%>     


      <div id="mydiv2">  </div>
      <div id="mydiv3">  </div>
      <td></tr>
  </table>
<%

 } catch(Exception e) { out.println("Exception----->" +e); }
finally
{
con1.close();
}
%>

<!--

<FORM>
<INPUT TYPE="button" VALUE="Click Here to Write to Me"
onClick="parent.location='mailto:jburns@htmlgoodies.com'">
</FORM> -->
<table border="1" width="100%">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>



</form>
</body>
</html>
