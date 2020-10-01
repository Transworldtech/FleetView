<%@ include file="header.jsp" %>
<script language="javascript">
  function validate()
  {
  	if(document.getElementById("data").value=="")
  	{
  	
  		alert("Please select the from date");
  		return false;
  	}
  if(document.getElementById("data1").value=="")
  	{
  	
  		alert("Please select the to date");
  		return false;
  	}
  	return datevalidate();
  	
  }
  function datevalidate()
{	var date1=document.getElementById("data").value;
	var date2=document.getElementById("data1").value;
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
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;

		return false;
	
	}
	else if(dm1>month || dm2>month)
	{
		alert("selected date should not be greater than todays date");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;

		return false;
	
	}

	if(dm1==month){
		if(dd1>day || dd2>day)
		{
		alert("selected date should not be greater than todays date");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;

		return false;
	
		}
	}
	if(dy1>dy2)
	{
		alert("From date year is should not be greater than to date year");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}
	
	else if(dm1>dm2)
	{
		alert("From date month is should not be greater than to date month");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}
	if(dm1==dm2) {
	if(dd1 > dd2)
	{
		alert("From date is should not be greater than to date");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}
	}
	return true;
}

  </script>

<%!

Connection conn;
Statement st,st1,st2;
String fidDate1,sql,usertype,user,vehid,vehno,data1,data2,ftime1,ftime2,ttime1,ttime2,fff,ttt;
int hh,mm,i;
String sql1,sql2,sql3,tbname,loc,lat,lon;
int cntos, cntra, cntrd, cntcr, cntnd, cntst,cntdt;
int os,ra,rda,cd,nd,dt,sp;
%>
<%
try{
Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
	st2=conn.createStatement();
%>
<table border="1" width="100%" bgcolor="white">
<tr><td>
<table class="stats">
<tr><%
java.util.Date defoultdate = new java.util.Date();
Format formatter0 = new SimpleDateFormat("yyyy-MM-dd");
fidDate1 = formatter0.format(defoultdate);
hh=defoultdate.getHours();
mm=defoultdate.getMinutes();

%>

<td valign="top"> 
<table border="0" class="stats"><tr><td colspan="4" class="hed"><font color="red" size="2" ><center>Report With Time</center></font></td></tr>
<form action="" method="get" onsubmit="return validate();">
<td class="bodyText"> Vehicle : <%
usertype=session.getAttribute("TypeofUser").toString();
user=session.getAttribute("user").toString();
if(usertype.equals("GROUP"))
{
	sql="select Transporter as vehreg, VehCode as vehcode from t_group where GPName='"+user+"'";
}
else
{
	sql="select VehicleRegNumber as vehreg, VehicleCode as vehcode from t_vehicledetails where OwnerName='"+user+"'";
}
ResultSet rst=st.executeQuery(sql);
%>
<select name="vehregno" class="formElement">
<%
while(rst.next())
{
%>
<option value='<%=rst.getString("vehcode")%>,<%=rst.getString("vehreg")%>'><%=rst.getString("vehreg")%></option>
<%
}
%>
</select>
</td>
<td class="bodyText">

From Date :<input type="text" id="data" name="data" class="formElement"  size="10" value="<%=fidDate1%>" readonly/>
  HH :<select name="fromtime1" class="formElement">
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
</select> 
MM :<select name="fromtime2" class="formElement">
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
for(i=10;i<=59;i++)
{
%>
<option value='<%=i%>'><%=i%></option>
<%
}
%>
</select>
  <img src="images/calendar.png" id="trigger" ><script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data",         // ID of the input field
      ifFormat    : "%Y-%m-%d",     // the date format
      button      : "trigger"       // ID of the button
    }
  );
</script>
</td>
<td align="right" class="bodyText">

  To Date :  <input type="text" id="data1" name="data1" size="10" class="formElement" value="<%=fidDate1%>" readonly/>
HH :<select name="totime1" class="formElement">
<option value="00" <% if(hh==0) out.print("selected='selected'"); %>>00</option>
<option value="01" <% if(hh==1) out.print("selected='selected'"); %>>01</option>
<option value="02" <% if(hh==2) out.print("selected='selected'"); %>>02</option>
<option value="03" <% if(hh==3) out.print("selected='selected'"); %>>03</option>
<option value="04" <% if(hh==4) out.print("selected='selected'"); %>>04</option>
<option value="05" <% if(hh==5) out.print("selected='selected'"); %>>05</option>
<option value="06" <% if(hh==6) out.print("selected='selected'"); %>>06</option>
<option value="07" <% if(hh==7) out.print("selected='selected'"); %>>07</option>
<option value="08" <% if(hh==8) out.print("selected='selected'"); %>>08</option>
<option value="09" <% if(hh==9) out.print("selected='selected'"); %>>09</option>
<option value="10" <% if(hh==10) out.print("selected='selected'"); %>>10</option>
<option value="11" <% if(hh==11) out.print("selected='selected'"); %>>11</option>
<option value="12" <% if(hh==12) out.print("selected='selected'"); %>>12</option>
<option value="13" <% if(hh==13) out.print("selected='selected'"); %>>13</option>
<option value="14" <% if(hh==14) out.print("selected='selected'"); %>>14</option>
<option value="15" <% if(hh==15) out.print("selected='selected'"); %>>15</option>
<option value="16" <% if(hh==16) out.print("selected='selected'"); %>>16</option>
<option value="17" <% if(hh==17) out.print("selected='selected'"); %>>17</option>
<option value="18" <% if(hh==18) out.print("selected='selected'"); %>>18</option>
<option value="19" <% if(hh==19) out.print("selected='selected'"); %>>19</option>
<option value="20" <% if(hh==20) out.print("selected='selected'"); %>>20</option>
<option value="21" <% if(hh==21) out.print("selected='selected'"); %>>21</option>
<option value="22" <% if(hh==22) out.print("selected='selected'"); %>>22</option>
<option value="23" <% if(hh==23) out.print("selected='selected'"); %>>23</option>
</select>
 
MM :<select name="totime2" class="formElement">
<option value="00" <% if(mm==0) out.print("selected='selected'"); %>>00</option>
<option value="01" <% if(mm==1) out.print("selected='selected'"); %>>01</option>
<option value="02" <% if(mm==2) out.print("selected='selected'"); %>>02</option>
<option value="03" <% if(mm==3) out.print("selected='selected'"); %>>03</option>
<option value="04" <% if(mm==4) out.print("selected='selected'"); %>>04</option>
<option value="05" <% if(mm==5) out.print("selected='selected'"); %>>05</option>
<option value="06" <% if(mm==6) out.print("selected='selected'"); %>>06</option>
<option value="07" <% if(mm==7) out.print("selected='selected'"); %>>07</option>
<option value="08" <% if(mm==8) out.print("selected='selected'"); %>>08</option>
<option value="09" <% if(mm==9) out.print("selected='selected'"); %>>09</option>
<%
for(i=10;i<=59;i++)
{
%>
<option value='<%=i%>'<% if(mm==i) out.print("selected='selected'"); %>><%=i%></option>
<%
}
%>

</select> 
<img src="images/calendar.png" id="trigger1" >
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data1",         // ID of the input field
      ifFormat    : "%Y-%m-%d",    // the date format
      button      : "trigger1"       // ID of the button
    }
  );
</script> 
</td><td><input type="submit" name="submit" id="submit" value="submit" class="formElement"></td>
</tr>
</form>

</table>

</td></tr>
<tr><td colspan="4">
<%
String dd=request.getQueryString();
if(dd==null)
{
out.println("<center class='bodyText'><font color='red'>Please select the Vehicle, Date and Time to display the report.</font></center>");
}
else
{
cntos=0;
cntra=0;
cntrd=0;
cntcr=0;
cntnd=0;
cntst=0;
cntdt=0;
data1=request.getParameter("data");
data2=request.getParameter("data1");
ftime1=request.getParameter("fromtime1");
ftime2=request.getParameter("fromtime2");
ttime1=request.getParameter("totime1");
ttime2=request.getParameter("totime2");
fff=ftime1+":"+ftime2+":00";
ttt=ttime1+":"+ttime2+":00";
StringTokenizer stk = new StringTokenizer(request.getParameter("vehregno"),",");
    vehid=stk.nextToken();
    vehno=stk.nextToken();
tbname="t_veh"+vehid;
%>

<table class="stats">
<tr><td class="hed"><a href="javascript: history.go(-1)">Back</a></td><td colspan="8" class="hed">
<center> Exception Analysis Report For AVL Mobile Eye 2000 For <%=user.toUpperCase() %>  - 
<%=vehno %> For The Period :  <%=request.getParameter("data")%> to <%=request.getParameter("data1").toString()%></center>
</td></tr>

</table>
<table border="1" width="100%" bgcolor="#F5FFFA" class="stats">
<tr bgcolor="#FAFAD2"><td align="center" class="hed"><b>Date</b></td><td class="hed" align="center"><b>OS</b></td><td align="center" class="hed"><b>RA</b></td><td align="center" class="hed"><b>RD</b></td><td align="center" class="hed"><b>CD</b></td><td class="hed" align="center"><b>ND</b></td><td align="center" class="hed"><b>Distance Traveled</b></td><td align="center" class="hed"><b>Location at EOD</b></td><td align="center" class="hed">No.Of Stops </td></tr>
<%
sql1="select distinct(TheFieldDataDate) from "+tbname+" where concat(TheFieldDataDate,TheFieldDataTime)>=concat('"+data1+"','"+fff+"') and concat(TheFieldDataDate,TheFieldDataTime)<=concat('"+data2+"','"+ttt+"') order by concat(TheFieldDataDate,TheFieldDataTime) asc"; 

ResultSet rst1=st.executeQuery(sql1);
while(rst1.next())
{
os=0;
ra=0;
rda=0;
cd=0;
nd=0;
dt=0;
sp=0;
sql2="select * from "+tbname+" where TheFieldDataDate='"+rst1.getString("TheFieldDataDate")+"' and concat(TheFieldDataDate,TheFieldDataTime)>=concat('"+data1+"','"+fff+"') and concat(TheFieldDataDate,TheFieldDataTime)<=concat('"+data2+"','"+ttt+"') order by concat(TheFieldDataDate,TheFieldDataTime) asc";
ResultSet rst2=st1.executeQuery(sql2);
while(rst2.next())
{
String stamp=rst2.getString("TheFiledTextFileName");
//over speed stamp.
if(rst2.getString("TheFiledTextFileName").equals("OS"))
{
os++;
}//end if. over speed
//Rapid accelaration.
if(rst2.getString("TheFiledTextFileName").equals("AC"))
{
ra++;
}//end if. Rapid accelaration.

if(rst2.getString("TheFiledTextFileName").equals("DC"))
{
rda++;
}//end if. Rapid Deccelaration.


loc=rst2.getString("TheFieldSubject");
if(session.getAttribute("usertypevalue").toString().equals("Om"))
{
lat=rst2.getString("LatitudeDir");
lon=rst2.getString("LongitudeDir");
}// end if.
else
{
lat=rst2.getString("LatinDec");
lon=rst2.getString("LonginDec");
}//end else.

if(stamp.equals("SI") && rst2.getInt("Speed") >0)
{
cntsi++;
speed=speed+rst1.getInt("Speed");
}

}//end while rst2.
%>
<tr>
<td class="bodyText"><%=rst1.getString("TheFieldDataDate")%></td>
<td class="bodyText"><%=os%></td>
<td class="bodyText"><%=ra%></td>
<td class="bodyText"><%=rda%></td>
<td class="bodyText"></td>
<td class="bodyText"></td>
<td class="bodyText"></td>
<td class="bodyText"><div align="left">
<a href="shownewmap.jsp?lat=<%=lat%>&long=<%=lon%>&discription=<%=loc%>" onclick="popWin = open('shownewmap.jsp?lat=<%=lat%>&long=<%=lon%>&discription=<%=loc%>','myWin','width=500,height=500');popWin.focus();return false"><%=loc%></a></div></td>
<td class="bodyText"></td>
</tr>
<%

}//end of while rst1.
  

}//main else end
%>
</table>
</td></tr>
</table>
</td></tr>
</table>
<%
}catch(Exception e)
{
out.print("Exception "+e);
}
finally
{
	conn.close();
}

%>
<!-- footer start here -->
<table border="1" width="100%">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
<P></P>
</body>
</html>

