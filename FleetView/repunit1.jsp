<%@ include file="headernew.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 4.01 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" import=" java.text.*" import=" java.util.*"
	errorPage=""%>

<%!Connection conn, conn1;
	Statement st, st1, st2, st3, st4;
	String sql, sql1, sql2, sql3, sql4, username, userrole, olddate, Svehlist;
	int total, updated, dealy, disconnected, notactive, transid;
	String vid, vehno;%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />


<link rel="stylesheet" href="style.css" type="text/css" charset="utf-8" />
<link rel="stylesheet" href="css/css.css" type="text/css"
	charset="utf-8" />
<script src="sorttable.js" type="text/javascript"></script>
<style type="text/css">

</style>


<script language="javascript">
showvoicepar="No";

var state = 'none';

function showwarcom1(layer_ref) {
//alert(layer_ref);
if (state == 'block') {
state = 'none';
}
else {
state = 'block';
}
if (document.all) { //IS IE 4 or 5 (or 6 beta)
eval( "document.all." + layer_ref + ".style.display = state");
}
if (document.layers) { //IS NETSCAPE 4 or below
document.layers[layer_ref].display = state;
}
if (document.getElementById &&!document.all) {
hza = document.getElementById(layer_ref);
hza.style.display = state;
}
}
UnitDamaged="No";
warcommentt="No";
NewDamage="No";
	function OnChangeFunc2(dropdown)
  	{
 		var vv1=dropdown.selectedIndex;
 		var SelValue1 = dropdown.options[vv1].value;
 
        	if(SelValue1=="Other")
       		{
             		document.getElementById("othinstloc").style.visibility="visible";
        	}      
        	else 
		{ 
         		document.getElementById("othinstloc").style.visibility="hidden";   
         		document.repunitform.othinst.value="";
             	}
 	}    
	function OnChangeChkBx()
	{

  		if(document.repunitform.instin.checked == false)
  		{
   
   			document.repunitform.tme.disabled=true;
   			document.repunitform.tme.value="";
   			document.getElementById("nwtme").style.visibility="visible";

   		}
  		else
  		{
    			document.repunitform.tme.disabled=false;
   			document.repunitform.tme.value="5.30";
   			document.repunitform.newtme.value="";
   			document.getElementById("nwtme").style.visibility="hidden";
  		}
	}
function AJAXFunc1()
{
 // alert(">>>rput1>>>");
  var v1=document.repunitform.newunid.value;
 // alert(v1);
  var owner=document.repunitform.owner.value;
 // alert(owner);

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
					 // alert(reslt);
                      var mySplitResult = reslt.split("#");
                      var mySplitResult1=  mySplitResult[0].replace(/^\s+|\s+$/g,"");//Mobile Number
                      var mySplitResult2=  mySplitResult[1].replace(/^\s+|\s+$/g,"");//Sim Number
                      var mySplitResult3=  mySplitResult[2].replace(/^\s+|\s+$/g,"");//Inst Type
                      var mySplitResult4=  mySplitResult[3].replace(/^\s+|\s+$/g,"");//Recieve by tech/cust
                      var mySplitResult5=  mySplitResult[4].replace(/^\s+|\s+$/g,"");//Hold By
                      var mySplitResult6=  mySplitResult[5].replace(/^\s+|\s+$/g,"");//Swr Ver
                      var mySplitResult7=  mySplitResult[6].replace(/^\s+|\s+$/g,"");//code Version
                      var mySplitResult8=  mySplitResult[7].replace(/^\s+|\s+$/g,"");//available
                      var mySplitResult9=  mySplitResult[8].replace(/^\s+|\s+$/g,"");//JRM
					  // Results from Ajaxunitadd.jsp are put into fields
					  var swver=mySplitResult6;
					  var invalide=mySplitResult7;
					  var available=mySplitResult8;
 		              document.repunitform.mobno.value = mySplitResult1;
                      document.repunitform.simno.value = mySplitResult2;
                      document.repunitform.InstType.value = mySplitResult3;
                      document.repunitform.jrm.value = mySplitResult9;
                     // document.repunitform.recby.value = mySplitResult5;
                      
                      
                     // alert("software version is"+swver);
      					if(
      						(((swver.indexOf("AVL_LITE")!=-1)||(swver.indexOf("SIMARM")!=-1))&&(owner.indexOf("Castrol")!=-1))
      						||(((swver.indexOf("AVL_LITE")!=-1)||(swver.indexOf("SIMARM")!=-1))&&(owner.indexOf("Praxair")!=-1))
      						)
      						{
      						 alert("AVL_LITE unit is not allowed in "+owner);
      								return false;
                        		}else{
								//	alert("condition is not matched");
                            		}
      					if(invalide=="Yes"){
							alert("Invalide software version in "+v1);
							return false;
                  		}
                  		if(available=="Yes"){
									alert("Unit ID "+v1+" already available in other vehicle.");
                      		}
                  		
 	       }
            }
            
  
           var queryString = "?unid=" +v1;
 	   ajaxRequest.open("GET", "Ajaxunitadd1.jsp" + queryString, true);
 	   ajaxRequest.send(null); 
}

function validate()
{
	var jrm=document.repunitform.jrm.value;
	//alert(">>1"+jrm);
	var instruction=document.repunitform.instruction.value;
	//alert(">>2"+instruction);
	if(jrm==instruction||instruction=="-"){
			//alert("right decision!!!!!!!!");
		}else{
			alert("Only JRM units are valide for this vehicle.Please use JRM unit");
			}
	var mob=document.repunitform.mobno.value;
	//alert(mob);
	//var unitholdby=document.repunitform.holdby.value;
	//alert(unitholdby);
	//var unitinstalby=document.repunitform.instby.value;
	//alert(">>>"+unitinstalby);
	//var recby=document.repunitform.recby.value;
	//alert(">>##"+document.repunitform.instby.value);
	
	//var adminoption=document.repunitform.whyoption.value;
	//alert(">><after<<<");
	
	//alert("admin >>"+adminoption);
    //if(adminoption=="-"){
			//alert("Please enter proper details instead of - in Why you are using this option?");
			//return false;
        //}
    //if(adminoption==""||adminoption==null){
    	//alert("Please enter proper details in Why you are using this option?");
		//return false;
          //  }
	
	//unitholdby = unitholdby.replace(/^\s+|\s+$/g,"");//trim
	//alert("unitholdby"+unitholdby)
	//recdby = recby.replace(/^\s+|\s+$/g,"");//trim
	//alert("unitinstalby"+unitinstalby)
	//if(unitholdby != unitinstalby)
//	{

		//if(unitinstalby=="customer")
		//{
		//}
		//else
		//{
		//alert("Hi"+unitholdby);
		//alert("Hi"+unitinstalby);
		//alert("UNIT HOLD BY DIFFERENT TECH/CUST");
		//return false;
		//} 
	//}

//	alert("Hi"+recby);
	
	//if(recby==" NO")
	//{
		//alert("UNIT NOT RECEIVED BY TECH/CUST. FIRST RECEIVE IT");
		//return false;
		
//	}
	
	 //alert("@@@@>>>");
	if(document.repunitform.instat.value=="Select")
	{
		alert("Please Select Installed Place");
		return false; 
	}
	// alert("@@@@>11>>");
	if(document.repunitform.hour.value=="Select")
	{
		alert("Please Select Installed Time");
		return false; 
	}
	//alert("@@@@>22>>");
	if(document.repunitform.typeunit.value=="SELECT")
	{
		alert("Please Select Unit Type");
		return false; 
	}

	//alert("@@@@>33>>");

	
	if(document.repunitform.newunid.value=="")
	{ 
		alert("Please Enter New UnitId");
		return false; 
	}
	
	if(document.repunitform.unitrunon[0].checked==false && document.repunitform.unitrunon[1].checked==false)	
	{
		alert("Please select whether the Unit runs on Battery or Ignition");
		return false;
	}
	
	if(document.repunitform.instby.value=="Select")
	{
		alert("Please Select Technician Name");
		return false; 
	}

	//alert("@@@@>44>>");
	if(document.repunitform.newunid.value=="")
	{ 
		alert("Please Enter New UnitId");
		return false; 
	}

	//alert("@@@@>44>>");
	if(document.repunitform.mobno.value=="")
	{	
		alert("The Mobile number not available");
		return false;
	}

	//alert("@@@@>55>>");
	if(document.repunitform.simno.value=="")
	{	
		alert("The sim number not available");
		return false;
	}
	//alert("@@@@>66>>");

  	//alert(">rsdio>"+document.repunitform.unitrunon.value);
	
  	if(document.repunitform.unitrunon[0].checked==false && document.repunitform.unitrunon[1].checked==false)	
	{
		alert("Please select whether the Unit runs on Battery or Ignition");
		return false;
	}
	/*if(!(mob.length==10))
	{
		alert("Not Valid Mobile Number");
		return false;		
	}*/

	if(showvoicepar=="Yes")
   {
	var voic1=document.repunitform.voice1.value;
	var voic2=document.repunitform.voice2.value;

	if(voic1=="" || voic2=="")
	{
		alert("Please enter both Voice Call No's");
	        return false;
	}
	if(voic1.length<10 || voic1.length>10) 
	{
		alert("Please enter proper 10 digit Voice Call No. 1");
	        return false;
	}
	if(voic2.length<10 || voic2.length>10) 
	{
		alert("Please enter proper 10 digit Voice Call No. 2");
	        return false;
	}
	if(isNaN(voic1))
	{
		alert("Please enter proper Voice Call No. 1");
		return false;
	}
	if(isNaN(voic2))
	{
		alert("Please enter proper Voice Call No. 2");
		return false;
	}


       // return false;
   }	

	if(UnitDamaged=="Yes")
	{
		if(document.repunitform.gpsantcut.checked==false && document.repunitform.greenlightoff.checked==false && document.repunitform.loosecon.checked==false && document.repunitform.powharndam.checked==false && document.repunitform.unitfndop.checked==false)
		{
			alert("Please select damage of Old Unit");
			return false;
		}
		  /*if(document.repunitform.unitdamagedopt.value=="Select")	
  		{
			alert("Please select damage of Old Unit");
			return false;
  		}*/	
	}
	var comm=document.repunitform.comment.value;
	if(warcommentt=="Yes")
	{
		if(comm.length < 2)
		{
			alert("Please Enter Warranty Comment");
			return false;
		}
		  /*if(document.repunitform.unitdamagedopt.value=="Select")	
  		{
			alert("Please select damage of Old Unit");
			return false;
  		}*/	
	}
	

	if(NewDamage=="Yes")
	{
		 if(document.repunitform.newdamageoption.value=="")	
  		{
			alert("Please enter new Unit damage option");
			return false;
  		}	
	}

	

	if(document.repunitform.redlight[0].checked==false && document.repunitform.redlight[1].checked==false)
	{
		alert("Please Select The RED LIGHT condition");
		return false;
	}
	if(document.repunitform.greenlight[0].checked==false && document.repunitform.greenlight[1].checked==false && document.repunitform.greenlight[2].checked==false)
	{
		alert("Please Select The GREEN LIGHT Condition");
		return false;
	}
	if(document.repunitform.gpslight[0].checked==false && document.repunitform.gpslight[1].checked==false && document.repunitform.gpslight[2].checked==false)
	{
		alert("Please Select The GPS LIGHT Condition");
		return false;
	}
	if(document.repunitform.ringing[0].checked==false && document.repunitform.ringing[1].checked==false )
	{
		alert("Please Select The RINGING Status");
		return false;
	}

	
	if(document.repunitform.warcom[0].checked==false && document.repunitform.warcom[1].checked==false )
	{
		alert("Please Select The Warranty Comment");
		return false;
	}


	var spcomt=document.repunitform.spcomment.value;	
	if(spcomt=="Select")
	{
		alert("Please Select Special Comment");
		return false;
	}
	if(document.repunitform.oldunitwith[0].checked==false && document.repunitform.oldunitwith[1].checked==false)
	{
		alert("Please select whether the Unit is with Cust / Tech / Company");
		return false;
	}

	var drivarname=document.repunitform.drivername.value;  
//  	alert(drivarname);
  	 var drivermobno=document.repunitform.drivermob.value;  
//  	alert(drivermobno);
    	 if(drivarname==""){
 			alert("Please enter Driver Name");
 			return false;
    	   	 }
    	if(drivermobno==""){
 		alert("Please enter Driver mobile no");
 		return false;
 	   	 }else{
 			if(drivermobno.length==10){
 			}else{
 					alert("Please enter drivers valid mobile number");
 					return false;
 				}
 				if(isNaN(drivermobno))
 				{
 					alert("Please enter proper driver mobile no.Alfabets are not valid");
 					return false;
 				}
 		   	 }
	
  return true;
	 
}

// if Type of UNit is 'Voice call', then this will get called

function voicecall(dropdown)
{
	var vv1=dropdown.selectedIndex;
 	var SelValue1 = dropdown.options[vv1].value;
	//alert(SelValue1);
 
       	if(SelValue1=="VOICECALL")
       	{
		document.getElementById("voiceparam").style.display="";
		showvoicepar="Yes";
	}   
	else
	{
		document.getElementById("voiceparam").style.display='none';
		document.unitaddform.voice1.value="";
		document.unitaddform.voice2.value="";
		showvoicepar="No";
	}   
}

function showDamageOpt(ind)
{ 
	if(ind==0)
	{ 
		//document.getElementById("unitdamagedopt").style.visibility="visible";
		document.getElementById("damagedoption").style.display="";
		UnitDamaged="Yes";
	}
	else
	{ 
		//document.getElementById("unitdamagedopt").style.visibility="hidden";

		document.repunitform.gpsantcut.checked=false;
		document.repunitform.greenlightoff.checked=false;
		document.repunitform.loosecon.checked=false;
		document.repunitform.powharndam.checked=false; 			
		document.repunitform.unitfndop.checked==false;	

		document.getElementById("damagedoption").style.display='none';
		document.repunitform.newdamageoption.style.visibility='hidden';

		UnitDamaged="No";
	}
}



function showwarcom(ind)
{ 
	if(ind==0)
	{ 
		//document.getElementById("unitdamagedopt").style.visibility="visible";
		document.getElementById("warcomment").style.display="";
		warcommentt="Yes";
	}
	else
	{ 
		//document.getElementById("unitdamagedopt").style.visibility="hidden";

		document.getElementById("warcomment").style.display='none';
		document.repunitform.newdamageoption.style.visibility='hidden';

		warcommentt="No";
	}
}

function NewDamageOpt()
{ 
	document.repunitform.newdamageoption.style.visibility="visible";
	NewDamage="Yes";
	
}

	</script>
</head>

<body>


</div>


<form name="repunitform" method="get" action="repunitinsrt.jsp"
	onsubmit="return validate();">
<%
	try {
		System.out.println(">>>hiii3333iiiiiii<<");
		
		vid = request.getParameter("vid");
		//out.print(vid);
		Class.forName(MM_dbConn_DRIVER);
		conn = DriverManager.getConnection(MM_dbConn_STRING,
				MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
		conn1 = DriverManager.getConnection(MM_dbConn_STRING1,
				MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
		st = conn.createStatement();
		st1 = conn.createStatement();
		st2 = conn1.createStatement();
		st3 = conn1.createStatement();
		Statement stmt2 = conn.createStatement();

		String userrole = (String)session.getAttribute("mainuser");
		System.out.println(">>>hiiiiiii<<");

		String email = "", unid = "", status = "", owner = "",Instruction="";

		java.util.Date dte = new java.util.Date();
		Format formatter = new SimpleDateFormat("yyyy-MM-dd");
		String today = formatter.format(dte);
		
		
		
		//String tcategory=request.getParameter("category");

		String  tid=request.getParameter("tid"); 

		String cat="";
		


	

		
		
		
		

		sql = "select * from db_gps.t_vehicledetails where VehicleCode='"
				+ vid + "' ";

		ResultSet rst = st2.executeQuery(sql);
		if (rst.next()) {
			status = rst.getString("Status");
			owner = rst.getString("OwnerName");
			vehno = rst.getString("VehicleRegNumber");
			email = rst.getString("TheFieldFromEmailAddress");
			Instruction=rst.getString("Instruction");
			String sql5 = "select * from db_gps.t_unitreplacement where VehCode='"
					+ vid
					+ "' or VehregNo='"
					+ vehno
					+ "' order by InstDate desc limit 1";
			//out.print(sql5);
			ResultSet rs5 = st2.executeQuery(sql5);
			if (rs5.next()) {
				unid = rs5.getString("NewUnitId");

			} else {
				//email=rst.getString("TheFieldFromEmailAddress");
				int pos = email.indexOf('@');
				unid = email.substring(2, pos);
			}

		}
%> <%
 	String send = request.getParameter("send");
 		if (send == null) {
 		} else {
 			String veh = "", unitidnew = "";
 			String sql6 = "select * from db_gps.t_vehicledetails where VehicleCode='"
 					+ vid + "' ";
 			ResultSet rs6 = st2.executeQuery(sql6);
 			if (rs6.next()) {
 				veh = rs6.getString("VehicleRegNumber");
 				unitidnew = rs6.getString("UnitID");

 			}
 %>
<table border="0" width="750px" bgcolor="#77D7D4" align="center">
	<tr>
		<td>
		<div align="center"><font color="maroon"><B>
		Successfuly Replaced ( Vehicle No <%=veh%> with Unit Id <%=unitidnew%>
		) </B></font></div>
		</td>
	</tr>
</table>
<%
	}

		String unidchk = request.getParameter("unidchk");
		if (unidchk == null) {
		} else {
			String own = request.getParameter("own");
			String vehnumb = request.getParameter("vehnumb");
%>
<table border="0" width="750px" bgcolor="#77D7D4" align="center">
	<tr>
		<td>
		<div align="center"><font color="maroon"> <b>
		Unit Id <%=unidchk%> is already in Use in Vehicle no. <%=vehnumb%> of
		<%=own%> </b></font></div>
		</td>
	</tr>
</table>

<%
	}
%>
<table border="0" width="750px" bgcolor="#E6E6E6" align="center">
	<tr bgcolor="#BDBDBD"><td align="center"><font color="#2A0A12" size="3"><b>Unit Replacement</b></font></td></tr>
</table>


<table border="0" width="750px" bgcolor="#E6E6E6" align="center">
	<tr bgcolor="#BDBDBD">
		<td><b>Transporter:</b></td>
		<td>
			<input type="text" name="owner" value='<%=owner%>'
			class="formElement" readonly />
			<input type="hidden" name="instruction" class="formElement" value="<%=Instruction%>"/>
		</td>
		<td><b>Vehicle Reg. No.:</b></td>
		<td><input type="text" name="vehreg" class="formElement"
			value='<%=vehno%>' readonly /></td>
	</tr>
	<tr bgcolor="#BDBDBD">
		<td><b>Old Unit Id:</td>
		<td><input type="text" name="oldunid" class="formElement"
			value='<%=unid%>' /></td>
		<td><b>New Unit Id:</b></td>
		<td>
			<input type="text" name="newunid" class="formElement" />
			<input type="hidden" name="jrm" class="formElement" />
		</td>
	</tr>

	<%
		//out.print(userrole);
			if (userrole.equalsIgnoreCase("service")) {
	%>

	
	


	<tr bgcolor="#BDBDBD">
		<td><b> Hold By:</b> <br>
		<b>Received Status:</b><br>
		</td>
		<td><input type="text" name="holdby" size="20"
			class="formElement" readonly /> <input type="text" name="recby"
			size="20" class="formElement" readonly /></td>
	</tr>
	<%
		} else {
	%>

	
	



	<%
		}
	%>
	<tr bgcolor="#BDBDBD">
		<td><b>Installation Date:</b></td>
		<td><input type="text" id="calender" name="calender" size="13"
			class="formElement" value="<%=today%>" readonly class="formElement" />
		<script type="text/javascript">
               Calendar.setup(
               {
                    inputField  : "calender",         // ID of the input field
                    ifFormat    : "%Y-%m-%d",     // the date format
                    button      : "trigger"       // ID of the button
               }
                             );
               </script></td>
		<td><b>Installation Time:</b></td>
		<td><b>HH : <select name="hour" class="formElement">
			<option value="Select">Select</option>
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
			<option value="10">10</option>
			<option value="11">11</option>
			<option value="12">12</option>
			<option value="13">13</option>
			<option value="14">14</option>
			<option value="15">15</option>
			<option value="16">16</option>
			<option value="17">17</option>
			<option value="18">18</option>
			<option value="19">19</option>
			<option value="20">20</option>
			<option value="21">21</option>
			<option value="22">22</option>
			<option value="23">23</option>
		</select> <b>MM : </b><select name="minutes" class="formElement">

			<option value="00">00</option>
			<option value="10">10</option>
			<option value="20">20</option>
			<option value="30">30</option>
			<option value="40">40</option>
			<option value="50">50</option>
		</select></td>
	</tr>

	<%
		sql = "select Distinct(LName) as LName from db_CustomerComplaints.t_location order by LName";
	//System.out.println(">>>sql!!!before!!<<<"+sql);
	ResultSet rst2 = st.executeQuery(sql);
			System.out.println(">>>sql!!!!!<<<"+sql);
	%>
	<tr bgcolor="#BDBDBD">
		<td><b>Installed at:</b></td>
		<td><select name="instat" onChange="OnChangeFunc2(this);"
			class="formElement">

			<option value="Select">Select</option>
			<%
				while (rst2.next()) {
			%>
			<option value="<%=rst2.getString("LName")%>"><%=rst2.getString("LName")%>
			</option>
			<%
				}
			%>
			<option value="Other"><b>Other</b></option>
		</select>
		</td>
		<div id="othinstloc" style="visibility: hidden">
		<center><input type="text" name="othinst" size="20"
			class="formElement"> </input></center>
		</div>
		
		<td><b>Type of Unit:</b></td>
		<td><input type="text" name ="typeunit" value ="Normal" style="width:60px "  readonly="readonly" >
		<div id="voiceparam" style="display: none"><br>

		<label for="voic1" name="voic1" id="voic1" style="visibility: visible">
		<font color="maroon">Voice Call no.1 </font></label> <input type="text"
			name="voice1" class="formElement" style="visibility: visible" /> <br>
		<label for="voic2" style="visibility: visible"> <font
			color="maroon">Voice Call no.2 </font> </label> <input type="text"
			name="voice2" class="formElement" style="visibility: visible" /></div>

		</td>
	</tr>

	<!-- When Voice Call will be selected, two text boxes will get appeared to enter two Mobile No's which is mandatory-->
	<tr bgcolor="#BDBDBD">
		
		<td><b>Installed By:</b></td>
		<td><input type="text" name ="customer" value ="Customer"  style="width:80px " readonly="readonly" ></td>
		
		<td><b>New Unit Run on:</b></td>
		<td><input type="radio" name="unitrunon" value="Battery">Battery
		<input type="radio" name="unitrunon" value="Ignition">Ignition
		</td>
	</tr>

	
	

	
	
	
	<%
	int defaultST=0,defaultTX=0,defaultRA=0,defaultRD=0,defaultOS=0;
	String sqlDefault1="select ST,TX,AccelerationSpeedVarLimit,DecelerationSpeedVarLimit,Overspeedlimit from db_gps.t_defaultvals where OwnerName='Default'";
	ResultSet rsDefault1=st2.executeQuery(sqlDefault1);
	System.out.println(">>>sql!!!sqlDefault1!!<<<"+sqlDefault1);
	if(rsDefault1.next()){
	defaultST=rsDefault1.getInt("ST");
	defaultTX=rsDefault1.getInt("TX");
	defaultRA=rsDefault1.getInt("AccelerationSpeedVarLimit");
	defaultRD=rsDefault1.getInt("DecelerationSpeedVarLimit");
	defaultOS=rsDefault1.getInt("Overspeedlimit");
	}

	String sqlDefault="select ST,TX,RA,RD,OS from db_gps.t_vehicledetails where vehicleCode='"+vid+"'";
	ResultSet rsDefault=st2.executeQuery(sqlDefault);
	System.out.println(">>>sql!!!sqlDefault&&&!!<<<"+sqlDefault);
	if(rsDefault.next()){
		defaultST=rsDefault.getInt("ST");
		defaultTX=rsDefault.getInt("TX");
		defaultRA=rsDefault.getInt("RA");
		defaultRD=rsDefault.getInt("RD");
		defaultOS=rsDefault.getInt("OS");
	}
	
	String a="Customer ",b="cust";
	%>
	
     	
	<div id="dispST" style="display: none;" align="right">
		<input name="getST" id="getST" class="formElement"  size="13">
		</div>
		<div id="dispTX" style="display: none;" align="right">
		<input name="getTX" id="getTX" class="formElement"  size="13">
		</div>
		
		<div id="dispRA" style="display: none;" align="right">
		<input name="getRA" id="getRA" class="formElement"  size="13">
		</div>
		<div id="dispRD" style="display: none;" align="right">
		<input name="getRD" id="getRD" class="formElement"  size="13">
		</div>
		
		<div id="dispOS" style="display: none;" align="right">
		<input name="getOS" id="getOS" class="formElement"  size="13">
		</div>
		
	
	
	
	
	<br></br>
	<tr bgcolor="#BDBDBD">
		<td colspan="4">
		<div align="center"><input type="submit" name="submit"
			value="Submit" class="formElement"></div>
			
			
			
		<input type="hidden" name="tid" value="<%=tid%>" />
								<input type="hidden" name="comptype" value="<%=cat%>" />
		
			<input type="hidden" name="ST" value="<%=defaultST%>" />
				<input type="hidden" name="TX" value="<%=defaultTX%>" />
					<input type="hidden" name="RA" value="<%=defaultRA%>" />
						<input type="hidden" name="RD" value="<%=defaultRD%>" />
							<input type="hidden" name="OS" value="<%=defaultOS%>" />
								
								<input type="hidden" name="oldunitwith" value="<%=b%>" />
								
									<input type="hidden" name="vid" value="<%=vid%>" />
								
		
		<input type="hidden" name="mobno"
			size="20" class="formElement" readonly />
			<input type="hidden" name="simno"
			size="20" class="formElement" readonly />
			<input type="hidden" name="recby"
			size="20" class="formElement" readonly />
			<input type="hidden" name="InstType"
			size="20" class="formElement" readonly />
			<!--   <input type="hidden" name="instby"
			size="20" class="formElement"  value=<%= a%> readonly /> -->
			
			<input type="hidden" name="holdby"
			size="20" class="formElement" readonly />
			<input type="hidden" name="recby"
			size="20" class="formElement" readonly />
			<input type="hidden" name="jrm"
			size="20" class="formElement" readonly />
		
		
		
		
		
		
		</td>
	</tr>
</table>
<script language="javascript" >

AJAXFunc1();

</script>

</form>


<%
	} catch (Exception e) {
		out.print("Exception --->" + e);
	} finally {
		conn.close();
		conn1.close();
	}
%> <!-- code end here --->

<table width="750px" height="350px" border="0">
	<tr>
		<td></td>
	</tr>
</table>



<div id="gbox-bot1"></div>


<div id="copyright">Copyright 2008 by Transworld Compressor
Technologies Ltd. All Rights Reserved.</div>

</body>
</html>
