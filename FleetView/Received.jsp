<%@ include file="header.jsp" %>
<html>
<head>
<script language="javascript">
function updateClock ()
{
  var currentTime = new Date ();

  var currentHours = currentTime.getHours ();
  var currentMinutes = currentTime.getMinutes ();
  var currentSeconds = currentTime.getSeconds ();
  // Compose the string for display
  var currentTimeString = currentHours + ":" + currentMinutes + ":" + currentSeconds;

  // Update the time display
  document.document.receivedform.ctime.value = currentTimeString;
}




function addnew(th)
{

var val=parseInt(th)+1;
var val1=val+1;
document.receivedform.h1.value=""+val1;
var str="<br><input type='text' name='unitId"+val+"' class='formElement'>&nbsp;<input type='button' name='"+val+"' onclick='addnew("+val+");' value='Add' class='formElement'></div><div name='dd"+val1+"' id='dd"+val1+"'>";
document.getElementById("dd"+val).innerHTML=str;
}
</script>
</head>
<body>
<%!
String tm;
 %>
<%
java.util.Date td =new java.util.Date();
Format fmt = new SimpleDateFormat("yyyy-MM-dd");
String sdt = fmt.format(td);

tm=td.getHours()+":"+td.getMinutes()+":"+td.getSeconds();
%>
<form name="receivedform" action="addtodatabase.jsp" method="post">
<table border="1" width="100%" bgcolor="white">
<tr><td class="bodyText" colspan="2" align="center"> <input type=radio name="rd" value="Received From">Recieved From <input type=radio name="rd" value="Dispached To">Dispatched To</td></tr>
<tr><td class="bodyText">Date :</td><td class="bodyText"><input type="text" id="calender" name="calender" size="13" class="formElement" value=<%=sdt%>  readonly/>
<input type="button" name="trigger" id="trigger" value="From Date" class="formElement" style="visibility:visible">
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "calender",         // ID of the input field
      ifFormat    : "%Y-%m-%d",     // the date format
      button      : "trigger"       // ID of the button
    }
  );
</script>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Time : &nbsp;&nbsp;<input type="text" name="rtime" value="<%=tm%>" class="formElement" readonly>
</td></tr>
<tr><td class="bodyText">Received From / Dispatch To:</td>

<td class="bodyText">
<div>
<input type=radio name="radio1" value="Customer" >Customer
<input type=radio name="radio1" value="Ware House" >Ware House
<input type=radio name="radio1" value="Vendor" >Vendor
<input type=radio name="radio1" value="Office" >Office
</div>
</td></tr>
<tr><td class="bodyText">Name:</td><td class="bodyText"><input type="text" name="cname" class="formElement"></td></tr>
<tr><td class="bodyText">Courier /Person :</td><td class="bodyText"><input type="text" name="courier" class="formElement"  onChange="updateClock();"></td></tr>
<tr><td class="bodyText">

</td>
<td class="bodyText">
<input type=radio name="radio2" value="Defective" >Defective
<input type=radio name="radio2" value="New" >New
<input type=radio name="radio2" value="Service Unit" >Service Unit
</td></tr>
<tr><td class="bodyText">Unit ID:</td><td class="bodyText">
<div name="dd" id="dd">
<input type="text" name="unitId" class="formElement"><input type="button" name="0" onclick="addnew(0);" value="Add" class="formElement">
<div name="dd1" id="dd1">
</div>
</div>
<input type="hidden" name="h1" value="1">
</td></tr>
<tr><td colspan="2" align="center"><input type="submit" name="Submit" value="Submit" class="formElement"></td></tr>
</table>
</form>
<table border="1" width="100%" bgcolor="white">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
</body>
</html>
