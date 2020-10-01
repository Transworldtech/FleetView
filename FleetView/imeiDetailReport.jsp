<%@ include file="headernew.jsp"%> 
<%@ page  import="java.util.Date"%>


<%
classes fleetview=new classes();
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
//fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>	
<%@page import="com.fleetview.beans.classes"%><style>
<!-- 
    SPAN.searchword { background-color:cyan; }
    
//-->
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
    
    document.IMEIDetailReport.action ="excel.jsp";
    document.forms["IMEIDetailReport"].submit();
} 

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
					if(days=='May')
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

function datevalidate()
{
	var date1=document.getElementById("data").value;
	var date2=document.getElementById("data1").value;
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
	var year=date.getFullYear();
	if(yy11>year || yy22>year)
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
//}

function poponclick(lat,lon)
{	
	var url="shownewmap.jsp?lat=" +lat+ "&long=" +lon;
	testwindow = window.open(url,"Show on Map", "width=900,height=500");
    testwindow.moveTo(250,100);
}
function showFTPImage(imageName)
{	
	var url="androidFtpImage.jsp?imageName=" +imageName;
	testwindow1 = window.open(url,"Image", "width=500,height=500");
    testwindow1.moveTo(250,100);
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
   
                // *****           String imeino=request.getParameter("imeino");
                
                
               // String addrs1=request.getParameter("addrs");
            //    System.out.println(pveh);
                
              
                			                   
%>  
    
<%
datenew1=request.getParameter("data");
datenew2=request.getParameter("data1");
System.out.println("232datenew1= "+datenew1);
System.out.println("233datenew2= "+datenew2);

if(null==datenew1)
{
	datenew1=datenew2=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
}


%>

<table border="0" width="95%" bgcolor="white">  
<tr align="center">
<td>
<!-- <div align="left"><font size="3"><b>Report No:1.1</b></font></div>-->

 <div align="center"><font size="3"><b>Detail Report<b></font></div>
</td>
</tr>
</table>

<form name="customdetail" method="get" action="" Onsubmit="return datevalidate()" >
	 <%String imeino =request.getParameter("imeino");
	 System.out.println("----------------------->>"+imeino);
	 %>
	 <input type="hidden" name="imeino" value="<%=imeino%>"></input>
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
	<%System.out.println("275datenew1= "+datenew1); %>	
  		</td>

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
		<%System.out.println("289datenew2= "+datenew2); %>	
		</td>

      <td><div align="left" > 
		
		<input type="submit" name="submit" value="Submit">
	</div></td>
	</tr></table>
		</div>
		</form>

<% 
       //  System.out.println("imeino= "+imeino1);
		 if(!(null==request.getParameter("data"))&&!(null==request.getParameter("data1")))
		  { 
		    String date1=request.getParameter("data");
            String date2=request.getParameter("data1");  
		
            System.out.println("310date1= "+date1);
            System.out.println("311date2= "+date2);
		    //String vehcd=request.getParameter("vehc");
		   // String address=request.getParameter("addrs");
 
		
		    
		   // String vehcd=request.getParameter("vehc");
		    //String address=request.getParameter("addrs");
	
		  
	       String  ddate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(date1));
	       String  ddate2=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(date2));
		   String dat1=new SimpleDateFormat("yyyy-MMM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(date1));
		   String  dat2=new SimpleDateFormat("yyyy-MMM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(date2));
		   
		   System.out.println(dat1+"===================="+dat2);
		   
		   String exportFileName=session.getAttribute("user").toString()+"_DetailReport.xls";
		%>	
		
		    <br>
			<form id="IMEIDetailReport" name="IMEIDetailReport" action="" method="post" >
			
			<%String imeino1 =request.getParameter("imeino");
			System.out.println("**************************>>"+imeino1);%>
            
            <div id="table1">
            <table style="margin-right: 0px;" align="right">
			<tr><div align="center"><font size="3" color="block" size="2" ><b>Detail  Report  for  <%=imeino1 %>  From  <%=datenew1%>  To  <%=datenew2%></b></font>
			</div>
			</tr>
			<tr>
			<div align="right">
			
			<input type="hidden" id="tableHTML" name="tableHTML" value="" />  
	
			</div>
    		<div>
	<%
	  Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
	  String sdt = fmt.format(new java.util.Date());
//	  out.print(sdt); 
	%></div>
			
			</tr>
			</table>
			<br>
			
			<div align="center" style="width: 60em;text-align: center;margin-left: 20em;">
			<table width="70%" border="1" cellpadding="0" cellspacing="0" align="center" class="sortable">
			<tr>
					<th id="tdp0" style="width: 7px;"> <b>Sr.No</b></th>
					<th id="tdp0" style="width: 230px;"> <b>Updated DateTime</b></th>
					<th id="tdp0" style="width: 1000px;"> <b>Location</b></th>
					<th id="tdp0" style="width: 500px;"> <b>File Name</b></th>
					</tr>	
			        <%
					int j=1;
			        String date="",time="";
					int ccnt=0;
					String location="",filename="";
					double lat=0.0,lon=0.0;
			      
				    
							
							String sql3="select * from t_veh"+imeino1+"  where TheFieldDataDate between '"+ddate1+"' and '"+ddate2+"' order by TheFieldDataDate,TheFieldDataTime asc";	
							System.out.println(sql3);
							ResultSet rs3=stx.executeQuery(sql3);
							while(rs3.next())
							{
							      
								   date=rs3.getString("TheFieldDataDate");
								   time=rs3.getString("TheFieldDataTime");
								   location=rs3.getString("TheFieldSubject");
			                       lat=rs3.getDouble("Latitude");
			                       lon=rs3.getDouble("Longitude");
			                       filename=rs3.getString("Sen4");
			             %>
			            <tr>
						<td><div align="right"><%=j%></div></td>
						<td><div align="right"><%=date+" "+time%></div></td>
						<%if(location.equals("No GPS"))
						{
						%>
						<td><div align="left"><%=location%></div></td>
						<%} 
						else
						{%>
						<td><div align="left"><a href="#" onclick="javascript: poponclick(<%=lat%>,<%=lon%>)"><%=location%></a></div></td>
						<%} %>
						
						<td><div align="left"><a href="#" onclick="showFTPImage('<%=filename%>');"><%=filename%></a></div></td>
						</tr> 			
	<%		            
	                        j++;
							 }
						
				}
						
					
	                   %>
	                   </table></div></div></form>		
</body>

	
	<%
	
		
		}catch(Exception e)
	{
		//out.print("Exception -->"+e);
	}%>
	    
	<% 
	    fleetview.closeConnection();
	   fleetview.closeConnection1();
	%>
	<%@ include file="footernew.jsp" %>

