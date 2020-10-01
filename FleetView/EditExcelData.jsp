
<%@ include file="header.jsp" %> 

<%@ page import="java.text.*" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.fleetview.beans.Connectionclass"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">


//var charfield=document.getElementById("txttripid");


//charfield.onkeypress=

function keypress(e){
var e=window.event || e
var keyunicode=e.charCode || e.keyCode
//Allow alphabetical keys, plus BACKSPACE and SPACE
return (keyunicode>=65 && keyunicode<=90 || keyunicode>=97 && keyunicode<=122 || keyunicode>=48 && keyunicode<=57 || keyunicode==8)? true : false
}




function validatestring(e){
	var e=window.event || e
	var keyunicode=e.charCode || e.keyCode
	//Allow alphabetical keys, digits, BACKSPACE and SPACE
	return (keyunicode>=65 && keyunicode<=90 || keyunicode>=97 && keyunicode<=122 || keyunicode>=48 && keyunicode<=57 || keyunicode==8 || keyunicode==32)? true : false
	}

function validatename(e){
	var e=window.event || e
	var keyunicode=e.charCode || e.keyCode
	//Allow alphabetical keys, plus BACKSPACE and SPACE
	return (keyunicode>=65 && keyunicode<=90 || keyunicode>=97 && keyunicode<=122 || keyunicode==8 || keyunicode==32)? true : false
	}

function validatetime(e){
	var e=window.event || e
	var keyunicode=e.charCode || e.keyCode
	//Allow alphabetical keys, plus BACKSPACE and SPACE
	return (  keyunicode>=48 && keyunicode<=57 || keyunicode==8)? true : false
	}


function Cleartextbox()
{
	document.getElementById("txttripid").value ="";
    //alert("Trip ID"+strar[0]);
    
 document.getElementById("txtvehregno").value ="";
 document.getElementById("txttripfrom").value ="";
	document.getElementById("txttripto").value ="";
	document.getElementById("tripdate").value ="";
	


	
	document.getElementById("triphr").value ="00";
	document.getElementById("tripMM").value ="00";
	//document.getElementById("tripSS").value ="";


	
	document.getElementById("txtETA").value ="";


	document.getElementById("ETAhr").value ="00";
	document.getElementById("ETAMM").value ="00";
	//document.getElementById("ETASS").value ="";
	

	

	document.getElementById("txtdriverid1").value ="";
	document.getElementById("txtdriverid2").value ="";
	
	document.getElementById("txtdrivername1").value ="";
	document.getElementById("txtdrivername2").value ="";
	
	document.getElementById("txttransport").value ="";

}
</script>

<script language="javascript" type="text/javascript">




function Showdata()
{

	var tripid=document.getElementById("TripID").value;
	var user=document.getElementById("user").value;
	
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

           		  document.getElementById("txttripid").value ="";
                  //alert("Trip ID"+strar[0]);
                  
               document.getElementById("txtvehregno").value ="";
               document.getElementById("txttripfrom").value ="";
              	document.getElementById("txttripto").value ="";
              	document.getElementById("tripdate").value ="";
              	

              
              	
           	document.getElementById("triphr").value ="00";
           	document.getElementById("tripMM").value ="00";
           //	document.getElementById("tripSS").value ="";


				
			 	document.getElementById("txtETA").value ="";
			

				document.getElementById("ETAhr").value ="00";
           	document.getElementById("ETAMM").value ="00";
         //  	document.getElementById("ETASS").value ="";
           	
              
              	
      
              	document.getElementById("txtdriverid1").value ="";
              	document.getElementById("txtdriverid2").value ="";
              	
              	document.getElementById("txtdrivername1").value ="";
              	document.getElementById("txtdrivername2").value ="";
              	
              	document.getElementById("txttransport").value ="";

                  
    	 	  if(ajaxRequest.readyState == 4)
                      {
                
                         var reslt=ajaxRequest.responseText;

                      
                           var strar = reslt.split("/");
                       	
                           strar[0]= strar[0].replace(/^\s+|\s+$/g,"");
                           document.getElementById("txttripid").value =strar[0];
                         //  alert("Trip ID"+strar[0]);
                           
                        document.getElementById("txtvehregno").value =strar[1];
                        document.getElementById("txttripfrom").value =strar[2];
                       	document.getElementById("txttripto").value =strar[3];
                       	document.getElementById("tripdate").value =strar[4];

                     var triptime = strar[5].split(":");
                       	
                    	document.getElementById("triphr").value =triptime[0];
                    	
                    	document.getElementById("tripMM").value =triptime[1];
                    	
                    	//document.getElementById("tripSS").value =triptime[2];

						/*document.write(strar[6]);
						document.write(strar[7]);
						document.write(strar[8]);
						document.write(strar[9]);*/
						if(strar[6]!="null")
								{
							
						var ETAdtTime=strar[6].split(" ");	
					 	document.getElementById("txtETA").value =ETAdtTime[0];
						
						var ETAtime=ETAdtTime[1].split(":");

						
						document.getElementById("ETAhr").value =ETAtime[0];
                    	document.getElementById("ETAMM").value =ETAtime[1];
                    	//document.getElementById("ETASS").value =ETAtime[2];
                    	
								}
						else{
							
						 	document.getElementById("txtETA").value ="";
						

							document.getElementById("ETAhr").value ="00";
			           		document.getElementById("ETAMM").value ="00";
			           	//	document.getElementById("ETASS").value ="";
			           	
							}
                       	
                       	var data=strar[7];
                       	var getdrivercode=data.split("-");
                       	document.getElementById("txtdriverid1").value =getdrivercode[0];
                      if(getdrivercode[1]==undefined)
                   	document.getElementById("txtdriverid2").value ="";
                   	else
                       	document.getElementById("txtdriverid2").value =getdrivercode[1];
                       	
                       	var drivername=strar[8];
                       	var getdrivername=drivername.split("-");
                       	document.getElementById("txtdrivername1").value =getdrivername[0];
                       	if(getdrivername[1]==undefined)
                       		document.getElementById("txtdrivername2").value ="";
                       	else   
                       	 	document.getElementById("txtdrivername2").value =getdrivername[1];
                   	 	                    	
                       	document.getElementById("txttransport").value =strar[9];
                                      
                       
		     } 
         	  }

           	var url="AjaxgetExceldata.jsp"
           		url=url+"?TripID="+tripid+"-"+user
           		
 	     ajaxRequest.open("GET", url , true);
	     ajaxRequest.send(null); 

             
		                      

   
}




</script>


<script type="text/javascript">




function validate()
{
	var tripid=document.getElementById("txttripid").value;
	var vehregno=document.getElementById("txtvehregno").value;
    var tripfrom=document.getElementById("txttripfrom").value;
  	var tripto=document.getElementById("txttripto").value;
 	 var triphr=document.getElementById("triphr").value;
	var tripMM=document.getElementById("tripMM").value;
	//var tripSS=document.getElementById("tripSS").value;
	var driverid=document.getElementById("txtdriverid1").value;  	
	var drivername=document.getElementById("txtdrivername1").value;
  	
 	 var transport=document.getElementById("txttransport").value;

 	var tripdate=document.getElementById("tripdate").value;

 	var driverid2=document.getElementById("txtdriverid2").value;
  	
 
  	var drivername2=document.getElementById("txtdrivername2").value;
  
  	
 
   	


	if(tripid=="-1" || tripid=="Select" || tripid=="")
	{
		alert("Please Select TripID");
		return false;
	}
	else if(tripdate=="")
	{
		alert("Please Enter Select Trip Date");
		return false;	
	}
	else if(triphr=="00")
	{
		alert("Please Enter value for Trip Time in Hour");
		return false;	
	}
	else if(tripMM=="00")
	{
		alert("Please Enter value for Trip Time in Minute");
		return false;	
	}
/*	else if(tripSS=="")
	{
		alert("Please Enter value for Trip Time in Second");
		return false;	
	}
	*/else if(vehregno=="")
	{
		alert("Please Enter Vehicle Reg No");
		return false;	
	}
	else if(tripfrom=="")
	{
		alert("Please Enter value for Trip From");
		return false;	
	}
	else if(tripto=="")
	{
		alert("Please Enter value for Trip To");
		return false;	
	}
	
	/*else if(driverid=="")
	{
		alert("Please Enter value for Driver ID");
		return false;	
	}
	else if(drivername=="")
	{
		alert("Please Enter value for Driver Name");
		return false;	
	}*/
	
	else if(transport=="")
	{
		alert("Please Enter value for Transporter ");
		return false;	
	}

	if(driverid2=="" || drivername2=="")
	{
		if(driverid=="" || drivername=="")	
		{
			alert("Please Enter atleast one Driver ID and Driver Name");
			return false;
		}
	}
	 return true;
	

	
	
	
}


</script>

</head>
<body>


<form name="myform" method="post" action="UpdateExcelDataServlet" onsubmit="if(validate()) return confirm('Are You Sure'); else return false">


<%

String user=session.getAttribute("dispalyname").toString();


java.util.Date d=new java.util.Date();
//String dte= "" + (d.getYear()+1900) + "-" + (1+d.getMonth()) + "-" + d.getDate();
int hours=(d.getHours());
int minutes=(d.getMinutes());

String nwfrmtdte=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());

Connection con=null;
Statement stmt=null;
ResultSet rs=null;

	try
	{
		con=Connectionclass.getConnection();
		
		stmt=con.createStatement();
		String sql="select TripID from t_startedjourney where EndedBy='"+user+"'";
		rs=stmt.executeQuery(sql);
		
		
		
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}


%>
  <table width="88%" border="0"  align="center" bgcolor="white">
    <tr>
      <td height="394"> 
        <table width="100%" border="1"  align="center"  class="sortable">
        <%
		     	String inserted=request.getParameter("inserted");
           String deleted=request.getParameter("Deleted");

           if(inserted!=null)
           {
		     		if(inserted.equalsIgnoreCase("yes"))
		     		{
		     	
		     	%>
		     	<tr>
		     				<td colspan="4" align="center"> <b><font size="2" color="orange">Successfully Updated! </font></b></td>
		     		</tr>
		     		  <%	}else if(inserted.equalsIgnoreCase("No"))
			     		{
			     			%>
		     		<tr>
		     				<td colspan="4" align="center"><b> <font size="2" color="orange">Cannot Update the Record because Vehicle Reg.No is not valid!</font></b> </td>
		     		</tr>			     		
		     <%	}
           }else if(deleted!=null)
           {
		     	if(deleted.equalsIgnoreCase("yes"))
		     	{
		     		%>
		     		<tr>
		     				<td colspan="4" align="center"><font size="2" color="orange"><b> Successfully Deleted!.</b></font></td>
		     		</tr>	
		     <%	}
           }
		     %>
          <tr> 
            <th colspan="4" height="23" bgcolor="#CCCCCC" class="sorttable_nosort"> 
              <div align="center"><b><font size="3" color="Black"><u>Update Trip Data</u> </font>
                </b></div>
            </th>
          </tr>
          
           
          
          <tr> 
            <input type="hidden" id="user" name="user" value="<%=user %>"></input>
          </tr>
          <tr> 
            <td><b>Trip ID</b></td>
            <td><b> 
              <input type="text" name="txttripid" id="txttripid" size="15" onKeyPress="return keypress(event)" readonly>
              <select name="TripID"  id="TripID" onChange="Showdata()" >
                <option value="-1">Select</option>
                <%	while(rs.next())
       	{
       	%> 
               <option value="<%= rs.getString(1) %>"><%= rs.getString(1) %></option>
                <%}
             %> 
              </select>
              </b>
                    </td>
            <td><b>Trip Date Time</b></td>
           
            <td><input type="text" name="tripdate" id="tripdate" size="13" value="<%=nwfrmtdte%>" readonly  />
  
 <!--  <img src="../images/calendar.png" id="trigger" border="0"> -->
              <input type="button" name="trigger" id="trigger" value="Date" class="formElement"> 
             <script type="text/javascript">
             Calendar.setup(
             {
                 inputField  : "tripdate",         // ID of the input field
                 ifFormat    : "%d-%b-%Y",     // the date format
                 button      : "trigger"       // ID of the button
             }
                           );
             </script> &nbsp;&nbsp;<br>
           <b>HR</b>  
             <select name="triphr" id="triphr">
		<option value="00">00</option>
		<option value="01">01</option>
		<option value="02">02</option>
		<option value="03">03</option>
		<option value="04">04</option>
		<option value="05">05</option>
		<option value="06">06</option>
		<option value="07">07</option>
		<option value="08">08</option>
		<option value="09">09</option>
		<%
			for(int i=10;i<24;i++)
			{
			%>
				<option value="<%=i%>"><%=i%></option>
			<%
			}		
		%>
		</select>
		
		 &nbsp <b>MM</b>
		<select name="tripMM" id="tripMM" >
		<option value="00">00</option>
		<option value="01">01</option>
		<option value="02">02</option>
		<option value="03">03</option>
		<option value="04">04</option>
		<option value="05">05</option>
		<option value="06">06</option>
		<option value="07">07</option>
		<option value="08">08</option>
		<option value="09">09</option>
		<%
			for(int i=10;i<60;i++)
			{
			%>
				<option value="<%=i%>"><%=i%></option>
			<%
			}		
		%>
	
		</select>	
           
				</td>
            
          </tr>
          
          <tr>
          <td> <b>Vehicle Reg. No</b></td>
          <td><input type="text" name="txtvehregno" id="txtvehregno" value="" onkeypress="return validatestring(event)"></input></td>
          <td><b>Transporter</b></td>
          <td><input type="text" name="txttransport" id="txttransport" value="" onkeypress="return validatestring(event)"></input></td>
          </tr>
          
          <tr>
          <td><b>Trip From</b></td>
          <td><input type="text" name="txttripfrom" id="txttripfrom" value="" onkeypress="return validatestring(event)"></input></td>
         
          <td><b>Trip To</b></td>
          <td><input type="text" name="txttripto" id="txttripto" value="" onkeypress="return validatestring(event)"></input></td>
          </tr>
          
          <tr>
           <td><b>Driver ID</b></td>
          <td><input type="text" name="txtdriverid1" id="txtdriverid1" value="" onkeypress="return validatestring(event)"></input></td>        
         
          <td><b>Driver Name</b></td>
          <td><input type="text" name="txtdrivername1" id="txtdrivername1" value="" onkeypress="return validatename(event)"></input></td>
          </tr>
          
          <tr>
           <td><b>Driver ID</b></td>
          <td><input type="text" name="txtdriverid2" id="txtdriverid2" value="" onkeypress="return validatestring(event)"></input></td>        
          
          <td><b>Driver Name</b></td>
          <td><input type="text" name="txtdrivername2" id="txtdrivername2" value="" onkeypress="return validatename(event)"></input></td>
          </tr>
          <tr>
              
          
          <td><b>ETA</b></td>
         
          
          <td><input type="text" name="txtETA" id="txtETA" size="13" value="" readonly  />
  
 <!--  <img src="../images/calendar.png" id="trigger" border="0"> -->
              <input type="button" name="trigger1" id="trigger1" value="Date" class="formElement"> 
             <script type="text/javascript">
             Calendar.setup(
             {
                 inputField  : "txtETA",         // ID of the input field
                 ifFormat    : "%d-%b-%Y",     // the date format
                 button      : "trigger1"       // ID of the button
             }
                           );
             </script> &nbsp;&nbsp;<br></br>
             
             
             <b>HR</b>  
             <select name="ETAhr" id="ETAhr">
		<option value="00">00</option>
		<option value="01">01</option>
		<option value="02">02</option>
		<option value="03">03</option>
		<option value="04">04</option>
		<option value="05">05</option>
		<option value="06">06</option>
		<option value="07">07</option>
		<option value="08">08</option>
		<option value="09">09</option>
		<%
			for(int i=10;i<24;i++)
			{
			%>
				<option value="<%=i%>"><%=i%></option>
			<%
			}		
		%>
		</select>
		
		 &nbsp <b>MM</b>
		<select name="ETAMM" id="ETAMM" >
		<option value="00">00</option>
		<option value="01">01</option>
		<option value="02">02</option>
		<option value="03">03</option>
		<option value="04">04</option>
		<option value="05">05</option>
		<option value="06">06</option>
		<option value="07">07</option>
		<option value="08">08</option>
		<option value="09">09</option>
		<%
			for(int i=10;i<60;i++)
			{
			%>
				<option value="<%=i%>"><%=i%></option>
			<%
			}		
		%>
	
		</select>	
           
         <!--     
            <b>HR</b><input type="text" name="ETAhr"  id="ETAhr" value="00" size=2 maxlength=2 onkeypress="return validatetime(event)"></input>
            &nbsp <b>MM</b><input type="text" name="ETAMM"  id="ETAMM" value="00" size=2 maxlength=2 onkeypress="return validatetime(event)"></input>
             &nbsp <b>SS</b><input type="text" name="ETASS"  id="ETASS" value="00" size=2 maxlength=2 onkeypress="return validatetime(event)"></input>								
			 -->	
 					
				</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
                    </tr>
          <tr>
          <td colspan="4" align="center">
          <input type="Submit" name="btn" value="Update"></input>
           <input type="Submit" name="btn" value="Delete"></input>
          <input type="button" name="btnCancel" value="Cancel" onclick="Cleartextbox()"></input></td>
          </tr>
      
        </table>
    </td>
</tr>
    </table>
 
  
</form>


</body>
</html>