<%@ include file="headernew.jsp" %>
<script language="javascript">
  function validate()
  {
  	if(document.getElementById("data1").value=="")
  	{
  	
  		alert("Please select the from date");
  		return false;
  	}
  if(document.getElementById("data2").value=="")
  	{
  	
  		alert("Please select the to date");
  		return false;
  	}
  	return datevalidate();
  	
  }
  function datevalidate()
{	var date1=document.getElementById("data1").value;
	var date2=document.getElementById("data2").value;
	var dm1,dd1,dy1,dm2,dd2,dy2;
	dy1=date1.substring(0,4);
	dy2=date2.substring(0,4);
	dm1=date1.substring(5,7);
	dm2=date2.substring(5,7);
	dd1=date1.substring(8,10);
	dd2=date2.substring(8,10);
	var date=new Date();
	var month=date.getMonth()+1;
	var day=date.getDate();
	var year=date.getFullYear();
	
	
	
	if(dy1>year || dy2>year)
	{
		alert("selected date should not be greater than todays date");
		document.getElementById("data1").value="";
		document.getElementById("data2").value="";
		document.getElementById("data1").focus;

		return false;
	
	}
	else if(dm1>month || dm2>month)
	{
		alert("selected date should not be greater than todays date");
		document.getElementById("data1").value="";
		document.getElementById("data2").value="";
		document.getElementById("data1").focus;

		return false;
	
	}

	if(dm1==month){
		if(dd1>day || dd2>day)
		{
		alert("selected date should not be greater than todays date");
		document.getElementById("data1").value="";
		document.getElementById("data2").value="";
		document.getElementById("data1").focus;

		return false;
	
		}
	}
	if(dy1>dy2)
	{
		alert("From date year is should not be greater than to date year");
		document.getElementById("data1").value="";
		document.getElementById("data2").value="";
		document.getElementById("data1").focus;
		return false;
	}
	
	else if(dm1>dm2)
	{
		alert("From date month is should not be greater than to date month");
		document.getElementById("data1").value="";
		document.getElementById("data2").value="";
		document.getElementById("data1").focus;
		return false;
	}
	if(dm1==dm2) {
	if(dd1 > dd2)
	{
		alert("From date is should not be greater than to date");
		document.getElementById("data1").value="";
		document.getElementById("data2").value="";
		document.getElementById("data1").focus;
		return false;
	}
	}
	return true;
}

  </script>

<table class="sortable_entry">
<form name="dateform" action="nontrip_driver_transporter.jsp" method="get" onsubmit="return validate();">
<tr><td><b>From</b>&nbsp;&nbsp;
<input type="text" id="data1" name="data1"  value=""  size="15" readonly/>
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data1",         // ID of the input field
      ifFormat    : "%Y-%m-%d",     // the date format
      button      : "data1"       // ID of the button
    }
  );
</script>
  </td>
<!--  <td align="left">-->
<!--<input type="button" name="From Date" value="From Date" id="trigger" class="formElement">-->
<!---->
<!--</td>-->
<td>
<b>To</b>&nbsp;&nbsp;
<input type="text" id="data2" name="data2"  value="" size="15" readonly/>
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data2",         // ID of the input field
      ifFormat    : "%Y-%m-%d",    // the date format
      button      : "data2"       // ID of the button
    }
  );
</script>
</td>
<!--<td align="left">-->
<!--  <input type="button" name="To Date" value="To Date" id="trigger1" class="formElement">-->
<!---->
<!--</td>-->
</tr>
<tr>
<td colspan="2">
<input type="hidden" name="transporter" id="transporter" value="<%=session.getAttribute("usertypevalue").toString()%>">
<div align="center"><input type="submit" name="submit" id="submit" value="submit" ></div></td>
</tr>
<tr><td colspan="5"><center class='bodyText'><b>Please select the dates to display the report</b></center></td></tr>
</form>
</table>
<br><br>
<br><br>
<br><br>
<br><br>
<br><br>
<br><br>
<br><br>
<br><br>
<br><br>
<br><br>
<br><br>
<!-- footer start here -->
<%@ include file="footernew.jsp" %>