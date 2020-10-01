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

function gotoPrint(divName)  
{  
	  
	  var printContents = document.getElementById(divName).innerHTML; 
	  var originalContents = document.body.innerHTML; 
	  document.body.innerHTML = printContents;  
	  window.print();
	  document.body.innerHTML = originalContents;  
}

function gotoExcel(elemId, frmFldId)  
{  
	      
          var obj = document.getElementById(elemId);  
          var oFld = document.getElementById(frmFldId); 
          oFld.value = obj.innerHTML;  
          document.batterytheft.action ="excel.jsp";
          document.forms["batterytheft"].submit();
} 

function GetFiles(datetime,vehcode)
{
	try
	{
	window.open('testTab.jsp?DateTime='+datetime+"&vehid="+vehcode,'Win','width=800,height=500,top=200,left=200,scrollbars=yes');	
	window.focus(); 
	}
	catch(e)
	{
		alert(e);
	}
}

function validate()
{ 
	try
	{
		//alert("date validate");
	//	var interval=document.getElementById("interval").value;
		// var num=interval.match("^[0-9]*[.][0-9]+$")
		//alert(interval);
   
    
	if(document.getElementById("data").value=="") 
	{
		alert("Please Select The from date.");
		return false;
	}
	if(document.getElementById("data1").value =="")
  	{
		alert("please select To Date");
		return false;
  	}  		
		return datevalidate();
	return true;
	}
	catch(e)
	{
		alert(e);
	}
}
function datevalidate()
{
	var date1=document.getElementById("data").value;
	var date2=document.getElementById("data1").value;
	var hr1=document.getElementById("ftime1").value;
	var min1=document.getElementById("ftime2").value;
	var hr2=document.getElementById("ttime1").value;
	var min2=document.getElementById("ttime2").value;
	var dm1,dd1,dy1,dm2,dd2,dy2;
	var dd11,yy11,mm1,mm2,mm11,dd22,yy22,mm22;
	dd11=date1.substring(0,2);
	dd22=date2.substring(0,2);
	mm1=date1.substring(3,6);
	mm2=date2.substring(3,6);
	mm11=dateformat(mm1);
	mm22=dateformat(mm2);
	yy11=date1.substring(7,11);
	yy22=date2.substring(7,11);
	var date=new Date();
	var month=date.getMonth()+1;
	var day=date.getDate();
	var hr=date.getHours();
	
	var min=date.getMinutes();
	//alert(hr);
	//alert(min);
	var year=date.getFullYear();
	if(yy11>year  || yy22>year) 
	{
		alert("selected date should not be greater than todays date");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}
	else if(year==yy11 && year==yy22)
	{
			if(mm11>month || mm22>month)
		{
			alert("selected date should not be greater than todays date");
			document.getElementById("data").value="";
			document.getElementById("data1").value="";
			document.getElementById("data").focus;
			return false;
		}
	}
	if(mm11==month && mm22==month)
	{
		if(dd11>day || dd22>day)
		{
			alert("selected date should not be greater than todays date");
			document.getElementById("data").value="";
			document.getElementById("data1").value="";
			document.getElementById("data").focus;
			return false;
		}
	}

	if(yy11 > yy22)
	{
		alert("From date year should not be greater than to date year");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}
	else if(year==yy11 && year==yy22)
	{
		 if(mm11>mm22)
	{
		alert("From date month should not be greater than to date month");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}
	}
	if(mm11==month && mm22==month) 
	{
		if(yy11==yy22)
		{
		if(dd11 > dd22)
		{
			alert("From date should not be greater than to date");
			document.getElementById("data").value="";
			document.getElementById("data1").value="";
			document.getElementById("data").focus;
			return false;
		}
		}
	}
	else
		if(yy11<yy22)
		{
			return true;
		}
	else
		if(dd11 > dd22)
	{
			if(mm11<mm22)
			{
				return true;
			}
			
		alert("From date should not be greater than to date");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}

	  
	   
	return true;
}

function dateformat(days)
{
	 if(days=='Jan')
		return(1);
	 else
		if(days=='Feb')
			return(2);
		else
			if(days=='Mar')
				return(3);
			else
				if(days=='Apr')
					return(4);
				else
					if(days=='May') //timeformat: "%M:%S"
						
						return(5);
					else
						if(days=='Jun')
							return(6);
						else
							if(days=='Jul')
								return(7);
							else
								if(days=='Aug')
									return(8);
								else
									if(days=='Sep')
										return(9);
									else
										if(days=='Oct')
											return(10);
										else
											if(days=='Nov')
												return(11);
											else
												if(days=='Dec')
													return(12);
 }

</script>
<%
String VehicleCode = "", fromdate = "", todate= "", desc= "",vehregno= "",fromtime= "",totime= "",ftime1= "",ftime2= "",ttime1= "",ttime2= "";
String vehid= "",ss1= "",ss2= "",ss3= "",dd= "",vehicle= "";
String datenew1= "",datenew2= "",date3= "";

String userTypeValue = session.getAttribute("usertypevalue").toString();

VehicleCode=request.getParameter("vehcode");
date3=datenew1=request.getParameter("data");
datenew2=request.getParameter("data1");
ftime1=request.getParameter("ftime1");
ftime2=request.getParameter("ftime2");
ttime1=request.getParameter("ttime1");
ttime2=request.getParameter("ttime2");
String dateformat="dd-MMM-yyyy HH:mm";
if(null==datenew1 || datenew1.equalsIgnoreCase("null"))
{
	datenew2=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	 ttime1=new SimpleDateFormat("HH").format(new java.util.Date());
     ttime2=new SimpleDateFormat("mm").format(new java.util.Date());
     Calendar cal=Calendar.getInstance();
     cal.add(Calendar.DATE,-1);
     cal.add(Calendar.HOUR,+12);
     datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(cal.getTime());
     ftime1=new SimpleDateFormat("HH").format(cal.getTime());
     ftime2=new SimpleDateFormat("mm").format(cal.getTime());
     System.out.println("VehicleCode "+VehicleCode);
     //System.out.println("date3 "+date3);
    // System.out.println("datenew1 "+datenew1);
    // System.out.println("datenew2 "+datenew2);
   //  System.out.println("ftime1 "+ftime1);
   //  System.out.println("ftime2 "+ftime2);
    // System.out.println("ttime1 "+ttime1);
    // System.out.println("ttime2 "+ttime2);
}

%>
<div style="font-size: 1.4em; text-align: center; margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em" align="center">
	Battery Theft Report</div>
	<div  align="center">
<form name="customdetail" method="get" onsubmit="return  validate();">
<div align="center">
<table align="center" border="0" style="text-align: center;width: 700px;">
			<tr align="center">
			<td align="left"><b>From&nbsp;&nbsp;</b>
		<input type="text" id="data" name="data" size="12" value="<%=datenew1%>"  class="formElement" readonly/>
		<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data",         // ID of the input field
      ifFormat    : "%d-%b-%Y",     // the date format
      button      : "data"       // ID of the button
    }
  );
		</script>
		&nbsp;&nbsp;
		<select name="ftime1" id="ftime1"  class="formElement">
			<option value="00" selected>00</option>
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
		<select name="ftime2" id="ftime2"  class="formElement">
			<option value="00" selected>00</option>
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
					<option value="<%=i%>" ><%=i%></option>
				<%
				}		
		%>
		
		</select>
		</td>
		<td align="left"><b>To&nbsp;&nbsp;</b>
		<input type="text" id="data1" name="data1" value="<%=datenew2%>"  size="12"  class="formElement" readonly/>
		<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data1",         // ID of the input field
      ifFormat    : "%d-%b-%Y",    // the date format
      button      : "trigger1"       // ID of the button
    }
  );
		</script>
		&nbsp;&nbsp;
		<select name="ttime1" id="ttime1"  class="formElement">
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
			for(int i=10;i<23;i++)
			{
			%>
				<option value="<%=i%>"><%=i%></option>
			<%
			}		
		%>
		<option value="23" selected>23</option>
		</select>
		
		<select name="ttime2" id="ttime2"  class="formElement" >
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
				for(int i=10;i<59;i++)
				{
				%>
					<option value="<%=i%>"><%=i%></option>
				<%
				}		
			%>
			<option value="59" selected>59</option>
			
		
		</select>		
		</td>
		<td><div align="left" > 
		<!--<font color="Blue" size="1"> Note- Enter date in format(yyyy-mm-dd)</font>-->
		
		<input type="submit" name="submit" value="Submit"  class="formElement">
	</div></td>
			</tr>
			</table>

</div>
</form>
</div>
<br>
<div  align="center">
<form name="batterytheft" name="batterytheft" action="" method="post">
<div id="table1"  align="center">
<%! Connection conn=null;%>
<%
try
{
	
       
		conn = fleetview.ReturnConnection();
		Statement st=null,st1=null;
		String sql=null;
		ResultSet rst=null;
		st=conn.createStatement();
		st1=conn.createStatement();
	    String exportFileName=session.getAttribute("mainuser").toString()+"_BatteryTheft.xls"; 
	    fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datenew1));
		todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datenew2));	
		
		//ftime1=request.getParameter("ftime1");
		//ftime2=request.getParameter("ftime2");
		//ttime1=request.getParameter("ttime1");
		//ttime2=request.getParameter("ttime2");
	
		fromtime=ftime1+":"+ftime2+":00";
		totime=ttime1+":"+ttime2+":00";
%>
<table border="0" style="width: 700px;" align="center" >
<tr>

<td align="center"><font size="3" face = "Arial"><b> Battery Theft Report from <%=datenew1 %> <%=fromtime%> to <%=datenew2%> <%=totime%></b></font>
</td>
</tr>
		<tr>
		<td align="center">
		<div class="bodyText" align="right">
                           <input type="hidden" id="tableHTML" name="tableHTML" value="" />  
                           <input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 
     
                           <a href="#" style="font-weight: bold; color: black; " onclick="gotoPrint('table1');">
                           <img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img></a> 
      
                           <a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('table1','tableHTML');">
                           <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img></a>
                           <%=fleetview.PrintDate() %>
                           </div>
		</td>
		</tr>
		</table>
		
		 <table style="width: 700px;" align="center"><tr><td align="center">
		<table align="center" class="sortable">
		<tr>
		<th><div align="center"><font size="2" ><b>Sr. No.</b></font></div></th>
		<th><div align="center"><font size="2" ><b>DateTime</b></font></div></th>
		<th><div align="center"><font size="2" ><b>Location</b></font></div></th>
		<th></th>
		</tr>
		<%
		int i = 1;
		sql = "select * from db_gps.t_veh6469 where  TheFieldDataDateTime >='"+fromdate+" "+fromtime+"' and TheFieldDataDateTime <='"+todate+" "+totime+"' and TheFiledTextFileName in ('BT') order by TheFieldDataDateTime asc ";
		System.out.println("sql  "+sql);
		ResultSet rst1=st.executeQuery(sql);
		while(rst1.next())
		{
			%>
			<tr>
			<td class="bodyText"  ><div align="right"><%=i%></div></td>
			<td class="bodyText" ><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst1.getString("TheFieldDataDateTime"))) %></div></td>
			<td class="bodyText" ><div align="left"><a href="shownewmap.jsp?lat=<%=rst1.getString("LatinDec") %>&long=<%=rst1.getString("LonginDec")%>&discription=<%=rst1.getString("TheFieldSubject")+"<br>"+rst1.getString("TheFieldSubject")%>" onclick="popWin=open('shownewmap.jsp?lat=<%=rst1.getString("LatinDec") %>&long=<%=rst1.getString("LonginDec")%>&discription=<%=rst1.getString("TheFieldSubject")+"<br>"+rst1.getString("TheFieldSubject")%>', 'myWin','width=500, height=500'); popWin.focus(); return false">&nbsp;&nbsp;<%=rst1.getString("TheFieldSubject") %></a>
			</div></td>
             <td class="bodyText" ><div align="left"><a href="#" onclick="GetFiles('<%=rst1.getString("TheFieldDataDateTime")%>','6469')">View Image</a></div></td>
			<%
			i++;
		}
		
		%>
		</table>
		</td>
		</tr>
		</table>
		<br>
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
</div>
</form>
</div>



</html>
</jsp:useBean>
<%@ include file="footernew.jsp" %>