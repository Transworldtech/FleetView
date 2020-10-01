 <%@ include file="airtelheader.jsp"%> 
<%@page import="java.util.Date"%> 
<%
classes fleetview=new classes();
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
//fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>	



<%@page import="com.fleetview.beans.classes"%><style>
<!-- 
    SPAN.searchword { background-color:cyan; }
    
// -->
</style>

<style>

SPAN.super 
{
	text-decoration: blink;
	text-align: center; 
}

</style>

<body onLoad="JavaScript:loadSearchHighlight();" bgcolor="#FFE4E1">

<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript">
function article(programName,width,height)
{

	var temp = "menubar=yes,toolbar=no,location=no,status=yes,scrollbars=yes,resizable=yes,width="+width+",height="+height; displayWindow=window.open(programName,"displayWindow",temp) ;
}
function fun(aa)
{
	//alert(aa.value);
	document.searchform.h.value=aa.value;
}


</script>
<script language="javascript">
function Validate()
{ 
    
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
function datevalidate()
{

	var date1=document.getElementById("data").value;
	var date2=document.getElementById("data1").value;
  
	var dm1,dd1,dy1,dm2,dd2,dy2;
	dy1=date1.substring(0,4);
	dy2=date2.substring(0,4);
	dm1=date1.substring(5,7);
	dm2=date2.substring(5,7);
	dd1=date1.substring(8,10);
	dd2=date2.substring(8,10);
    var d2date=date2.substring(0,2);
    var d1date=date1.substring(0,2);
    var date=new Date();
	var month=date.getMonth()+1;
	var day=date.getDate();
	var year=date.getFullYear();
    if(d2date>day)
	{
		alert("selected to date should not be greater than todays date");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}
if(dy1>year || dy2>year)
	{
		alert("selected date should not be greater than todays date");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;

		return false;
}
  else if(year==dy1 && year==dy2) if(dm1>month || dm2>month)
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
	else if(year==dy1 && year==dy2) if(dm1>dm2)
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



<style>
.popup {
background-color: #98AFC7;
position: absolute;
visibility: hidden;

.popupnew {
background-color: #98AFC7;
position: absolute;
visibility: visible;

.popupx {
background-color: #98AFC7;
position: absolute;
visibility: hidden;
}
</style>
<%!
	Connection conn,conn1;
	Statement st,st1,stx,st2;
	String aa,regno,sq,searchveh,sql;
%>
<%
try
{
	conn=fleetview.ReturnConnection();
	//conn1=fleetview.ReturnConnection1();
	st=conn.createStatement();
	stx=conn.createStatement();
	st1=conn.createStatement();
	//st2=conn1.createStatement();
	//out.print(session.getAttribute("usertypevalue").toString());
                Date dt=new  Date();
			    String  dt1=new SimpleDateFormat("yyyy-MM-dd").format(dt);
			 //   System.out.println("dt===>"+dt1);
                String datenew1,datenew2;
                  
          
                /* String sesveh=session.getAttribute("veh").toString();
                System.out.println("sesveh====>"+sesveh);*/
                String pveh=request.getParameter("vehc");
                String addrs1=request.getParameter("addrs");
            //    System.out.println(pveh);
                
              
                			                   
%>      
<%
datenew1=request.getParameter("data");
datenew2=request.getParameter("data1");
if(null==datenew1)
{
	datenew1=datenew2=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
}

%>
       <table border="0" bgcolor="white">
		<tr>
			<td><a href="airtelcurrentposition.jsp" title="Home"><img src="images/home.jpg" border="0"></a></td>
			<td><a href="javascript:history.go(-1)"> <img src="images/back.jpg" border="0"></a></td>
			<td><a href="logout.jsp" title="Logout"><img src="images/logout.jpeg" border="0"></a></td>
		</tr>
</table>
	
<table border="0" width="95%" bgcolor="white">  
<tr align="center">
<td>
<!-- <div align="left"><font size="3"><b>Report No:1.1</b></font></div>-->

 <div align="center"><font size="3"><b>GenSet Detail Report<b></font></div>
</td>

 

  	
</tr>
</table>
<form name="customdetail" method="get" action="" Onsubmit="return datevalidate()" >
	
	<div align="center">
	<table border="0">  
 	<tr>
 	<td align="right"><b>From&nbsp;&nbsp;</b>
		<input type="text" id="data" name="data" size="12" value="<%=datenew1%>" readonly/>
		<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data",         // ID of the input field
      ifFormat    : "%d-%b-%Y",     // the date format
      button      : "data"       // ID of the button
    }
  );
		</script>
		
  		</td>
<!--	<td align="left">-->
<!--		<input type="button" name="From Date" value="From Date" id="trigger">-->
<!--		-->
<!--	</td>-->
<td align="left"><b>To&nbsp;&nbsp;</b>
		<input type="text" id="data1" name="data1" value="<%=datenew2%>"  size="12" readonly/>
		<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data1",         // ID of the input field
      ifFormat    : "%d-%b-%Y",    // the date format
      button      : "trigger1"       // ID of the button
    }
  );
		</script>
		</td>
<!--		<td align="left">-->
<!--  		<input type="button" name="To Date" value="To Date" id="trigger1">-->
<!--		-->
<!--	</td>-->
	<td><div align="left" > 
		<!--<font color="Blue" size="1"> Note- Enter date in format(yyyy-mm-dd)</font>-->
	  <input type="hidden" name="vehc" value="<%=pveh%>"></input>	 
	   <input type="hidden" name="addrs" value="<%=addrs1%>"></input>	 
		<input type="submit" name="submit" value="Submit">
	</div></td>
	</tr></table></form>
		</div>
		<% 
		 String vehcod=request.getParameter("vehc");
		if(!(null==request.getParameter("data"))&&!(null==request.getParameter("data1")))
		{ 
		    String date1=request.getParameter("data");
            String date2=request.getParameter("data1");  
		
		    
		    String vehcd=request.getParameter("vehc");
		    String address=request.getParameter("addrs");
	
		  
	       String  ddate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(date1));
	       String  ddate2=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(date2));
		   String dat1=new SimpleDateFormat("yyyy-MMM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(date2));
		   String  dat2=new SimpleDateFormat("yyyy-MMM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(date2));
		
		
		%>	
			
			<br><br><br><br>
			<form name="report" action="">
			<table>
			<tr><div align="center"><font color="block" size="2" ><b>GenSet Report From <%=dat1%> To <%=dat2%></b></font></div></tr>
			</table>
			
			
			<table width="100%" border="1" align="center" class="sortable">
			<tr>
					<th id="tdp0" > <b>Sr.No</b></th>
					
					<th id="tdp0" > <b>Updated DateTime</b></th>
					<th id="tdp0" > <b>Site Adress</b></th>
					<th id="tdp0" > <b>Fuel Level(Ltr.)</b></th>
					<th id="tdp0" > <b>Battery Level(Voltage)</b></th>
					<th id="tdp0" > <b>Temp Level(Deg Cel.)</b></th>
					<th id="tdp0" > <b>ON/OF</b></th>
					</tr>	
			        <%
					int j=1;
					
			  
			        String date="",time="";
					int ccnt=0;	
			      
					String  fuel1="",temp1=""; 
						     String siteaddrs="",fuel="",battery="",temp="",noofgenset="",onof="";
							
							String sql3="select * from t_veh"+vehcd+"  where TheFieldDataDate>='"+ddate1+"' and TheFieldDataDate<='"+ddate2+"'";
						    //String sql3="select * from t_vehicledetails where VehicleRegNumber='"+vehregno+"'";
						//	System.out.println("sql3==>"+sql3);
						
						    ResultSet rs3=stx.executeQuery(sql3);
							while(rs3.next())
							{
							      
								   date=rs3.getString("TheFieldDataDate");
								   time=rs3.getString("TheFieldDataTime");
								   onof=rs3.getString("Sen1");
							       battery=rs3.getString("Sen2");
							       fuel=rs3.getString("Sen3");
							       temp=rs3.getString("Sen4");
							       int ind=fuel.indexOf(".");
							       if(ind>0)
							       {
	                                fuel1=fuel.substring(0,ind);
							       }
							       
	                               int ind1=temp.indexOf(".");
	                               if(ind1>0)
	                               {
	                                temp1=temp.substring(0,ind1);
	                               }
	                               
	                     if(!(battery.equalsIgnoreCase("-"))||!(fuel.equalsIgnoreCase("-"))||!(temp.equalsIgnoreCase("-")))						
	                       {
			             %>
			            <tr>
						<td align="left"><%=j%></td>
						<td align="left"><%=date+" "+time%></td>
						<td align="left"><%=address%></td>
						<td align="left"><%=fuel1%></td>
						<td align="left"><%=battery%></td>
						<td align="left"><%=temp1%></td>
						<td align="left"><%=onof%></td>
						</tr> 			
	<%		            
	                        j++;
							 }
						
				}
						
					
	                   %>
	                   </table></form>		

	
	<%
	
		}
		}catch(Exception e)
	{
		out.print("Exception -->"+e);
	}%>
	    
	<% 
	    fleetview.closeConnection();
	   fleetview.closeConnection1();
	%>
	<%@ include file="footernew.jsp" %>
