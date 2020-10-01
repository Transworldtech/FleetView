
<%@ include file="headernew.jsp" %>
 <%@page import="com.fleetview.beans.classes"%>
 <%
classes fleetview=new classes(); 
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
System.out.println("in the geofence paeg");
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);

%>

<%@page import="com.fleetview.beans.classes"%>

<html xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml">
  <head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <title>OpenLayers MapGuide Layer Example</title>
    <link rel="stylesheet" href="../theme/default/style.css" type="text/css">
    <link rel="stylesheet" href="style.css" type="text/css">

    <style type="text/css">
        #map {
            width: 100%;
            height: 800px;
            border: 1px solid black;
            float:left;
        }
        #map2 {
            width: 400px;
            height: 400px;
            border: 1px solid black;
            float:left;
        }
    </style>
  <script src="OpenLayers-2.10/OpenLayers.js"></script>
    <script type="text/javascript" src="OpenLayers-2.10/binaryajax.js"></script>
<script type="text/javascript" src="OpenLayers-2.10/binarywrapper.js"></script>
<script type="text/javascript" src="OpenLayers-2.10/shapefile.js"></script>
<script type="text/javascript" src="OpenLayers-2.10/dbf.js"></script>
<script src="elabel.js" type="text/javascript"></script>
  
<style type="text/css">
.elabelstyle {color:black; padding: 1px; font-size: 1.1em;}
.origelabelstyle {color:#000000; background-color:#ffffaa; border:0px #006699 solid; padding: 2px; font-size: 0.7em;}
</style>
    </head>
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
	           document.custreport.action ="excel.jsp";
	           document.forms["custreport"].submit();
	            
	  }
	
		function chk()
		{
			var chkf="";
			var chkt="";
			var objFromDate = document.getElementById("data").value;
			var fdate=objFromDate.split("-");
			if(fdate[1]=="Jan")
			{
				chkf="01";
			}
			if(fdate[1]=="Feb")
			{
				chkf="02";
			}
			if(fdate[1]=="Mar")
			{
				chkf="03";
			}
			if(fdate[1]=="Apr")
			{
				chkf="04";
			}
			if(fdate[1]=="May")
			{
				chkf="05";
			}
			if(fdate[1]=="Jun")
			{
				chkf="06";
			}
			if(fdate[1]=="Jul")
			{
				chkf="07";
			}
			if(fdate[1]=="Aug")
			{
				chkf="08";
			}
			if(fdate[1]=="Sep")
			{
				chkf="09";
			}
			if(fdate[1]=="Oct")
			{
				chkf="10";
			}
			if(fdate[1]=="Nov")
			{
				chkf="11";
			}
			if(fdate[1]=="Dec")
			{
				chkf="12";
			}
			var objFromDate1=""+fdate[2]+"-"+chkf+"-"+fdate[0]+"";
		    var objToDate = document.getElementById("data1").value;
		    var tdate=objToDate.split("-");
		    if(tdate[1]=="Jan")
			{
		    	chkt="01";
			}
			if(tdate[1]=="Feb")
			{
				chkt="02";
			}
			if(tdate[1]=="Mar")
			{
				chkt="03";
			}
			if(tdate[1]=="Apr")
			{
				chkt="04";
			}
			if(tdate[1]=="May")
			{
				chkt="05";
			}
			if(tdate[1]=="Jun")
			{
				chkt="06";
			}
			if(tdate[1]=="Jul")
			{
				chkt="07";
			}
			if(tdate[1]=="Aug")
			{
				chkt="08";
			}
			if(tdate[1]=="Sep")
			{
				chkt="09";
			}
			if(tdate[1]=="Oct")
			{
				chkt="10";
			}
			if(tdate[1]=="Nov")
			{
				chkt="11";
			}
			if(tdate[1]=="Dec")
			{
				chkt="12";
			}
		    var objToDate1=""+tdate[2]+"-"+chkt+"-"+tdate[0]+"";
		   // alert("Entry from date > "+objFromDate1+" Todate > "+objToDate1);
		     
		    var date1 = new Date(objFromDate1);
		    var date2 = new Date(objToDate1);
		    
		    //alert("from > "+date1+" Todate > "+date2);
		    
		    var date3 = new Date();
		    var date4 = date3.getMonth() + "-" + date3.getDay() + "-" + date3.getYear();
		    var currentDate = new Date(date4);
		     
		        if(date1 > date2)
		        {
		            alert("From Date Should be Less Than To Date");
		            return false; 
		        }
//		         else if(date1 > currentDate)
//		         {
//		             alert("From Date should be less than current date");
//		             return false; 
//		         }
//		         else if(date2 > currentDate) 
//		         {
//		             alert("To Date should be less than current date");
//		             return false; 
//		         }

		        return true;
			
		}
		
		function allSelected(allVal)
		{
			//alert("In AllSelected");
			
			if(document.getElementById("extAll").checked==true)  
			{	
				document.getElementById("data").style.display='none';
		    	document.getElementById("data1").style.display='none';
		    	document.getElementById("fromdt").style.display='none';
		     	document.getElementById("todt").style.display='none';
		     	//document.getElementById("data").value='';
		     	//document.getElementById("data1").value='';
		     	
		     	//return false;
		    }
			else 
			{
				document.getElementById("data").style.display="";
		    	document.getElementById("data1").style.display="";
		    	document.getElementById("fromdt").style.display="";
		     	document.getElementById("todt").style.display="";
		     	
		     	//return true;
			}
			
			
			/* if(document.dateform.extAll.checked) 
			{
				document.getElementById("frmDT").style.display='none';
		    	document.getElementById("toDT").style.display='none';
		    }
			else 
			{
				document.getElementById("frmDT").style.display="";
		    	document.getElementById("toDT").style.display="";
			} */
		}
	 function birt(){
			
			//alert("Hi");
			//var vehicle1=document.getElementById("vehlist").value;
			var a=chk();
			//alert("GetValidate------->"+a);
			if(a==true)
				{
			var User=document.getElementById("user").value;
			//alert(userid);
			var status=document.getElementById("Status").value;
			var date1= document.getElementById("data").value;
			var date2= document.getElementById("data1").value;
			//var date2= document.getElementById("date4").value;
			//var date2= document.getElementById("data1").value;
			var ChkValue=document.getElementById("extAll").checked;
		//alert(al);
		 
		if(ChkValue==true)
			{
			ChkValue="All";
				
			}
		else
			{
			ChkValue="no";			
			}
				
			//vehicle="2811,3300,6251";
			
			//date1=date1+" 00:00:00";
			//date2=date2+" 23:59:59";
			
		//alert(status);
			//alert(date1);
			//alert(date2);
			var date = date1.split("-");
			var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun','Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
			for(var j=0;j<months.length;j++)
			{
			    if(date[1]==months[j])
			    {
			         date[1]=months.indexOf(months[j])+1;
			    }                      
			} 
			if(date[1]<10)
			{
			    date[1]='0'+date[1];
			}                        
			var formattedDate1 = date[2]+'-'+date[1]+'-'+date[0];
			formattedDate1=formattedDate1+" 00:00:00";
			//alert(date[1]);
			//alert(date[0]);
			
			var dat = date2.split("-");
			var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun','Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
			for(var j=0;j<months.length;j++){
			    if(dat[1]==months[j]){
			         dat[1]=months.indexOf(months[j])+1;
			     }                      
			} 
			if(dat[1]<10){
			    dat[1]='0'+dat[1];
			}                        
			var formattedDate2 = dat[2]+'-'+dat[1]+'-'+dat[0];
			formattedDate2=formattedDate2+" 23:59:59";
			
			//alert(userid);
			//alert(formattedDate1);
			//alert(formattedDate2);
			document.getElementById("myIframe").src="http://103.8.126.138:8080/birt/frameset?__report=GeofenceLocationReport_rptdesign.rptdesign&Owner="+User+"&Status="+status+"&Chk="+ChkValue+"&Date="+formattedDate1+"&Date1="+formattedDate2+"&dt="+date1+"&dt1="+date2+"&__showtitle=false";
//			document.getElementById('myIframe').src="http://103.8.126.138:8080/birt/frameset?__report=driverreport1.rptdesign&_title='My Viewer'&date1=2015-03-01&date2=2015-08-28&drivername="+driver+"";
			document.getElementById("reportData").style.display="";
			//document.getElementById("footer").style.display="none";
			return true;
			
				}
			else
				{
					return false;
				}
		}  
	 
  </script>
<!-- JavaScript for export to excel and export to PDF -->  
  <%!
		Connection conn;
		Statement st,st1,st2,st3,st4,stgeo,stlogo;
		String datex1, datex2, data1, data2;
%>
<%
//Class.forName("org.gjt.mm.mysql.Driver");
String wareHouseCode="-",wareHouse="-",owner="-",html1=null,wtype="-",PolygonCoordinates="-",fwUser="",selecteduser="";//,rad="";
conn = fleetview.ReturnConnection();
 st = conn.createStatement();
 st1 = conn.createStatement();
 st2 = conn.createStatement();
 st3 = conn.createStatement();
 st4=conn.createStatement();
 stgeo = conn.createStatement();
 stlogo = conn.createStatement();
 String smap="",smap1="",geoname="",geotrans="",logoname="",logotrans="";
 
%>
    <%
String rfname=session.getAttribute("rfname").toString(); //user name  //.setAttribute("rfname",fnamelist);
String rlname=session.getAttribute("rlname").toString();
//System.out.println("31 firstname "+rfname+ "lastname " +rlname);
	selecteduser= (String) session.getAttribute("selecteduser");
	
	System.out.println("name----------------- "+selecteduser);
	fwUser = (String) session.getAttribute("user");
	
	String name=(String)session.getAttribute("mainuser");
	
	//session.setAttribute("selecteduser1",selecteduser);
	//System.out.println("34 selecteduser "+selecteduser+ "fwUser " +fwUser);	
	Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
	String Date = fmt.format(new java.util.Date());
	String Date1=fmt.format(new java.util.Date());
	String Date2=fmt.format(new java.util.Date());
	//System.out.println("37" +Date);
//out.println(fwUser);
	String sqlgeoinfo="select * from db_gps.t_geouserinfo where Transporter ='"+selecteduser+"' and Status='Yes'";
	//System.out.println("38 sqlgeoinfo "+sqlgeoinfo);
	ResultSet rstgeo=stgeo.executeQuery(sqlgeoinfo);
	System.out.println("Query no 1"+sqlgeoinfo);
	if(rstgeo.next())
	{
		geoname="Yes";
	}
	
	String sqllogo="select * from db_gps.t_logouserinfo where Transporter ='"+selecteduser+"' and Status='Yes'";
	//System.out.println("46 sqllogo "+sqllogo);
	ResultSet rstlogo=stlogo.executeQuery(sqllogo);
	System.out.println("Query no 2"+sqlgeoinfo);
	if(rstlogo.next())
	{
		//logoname=rstlogo.getString("User");
		logotrans=rstlogo.getString("Transporter");
	}
	
		
	%>
	<%
		String ddx = request.getQueryString();
			
			if (ddx == null) {
				datex1 = datex2 = new SimpleDateFormat("dd-MMM-yyyy")
						.format(new java.util.Date());
				data1 = data2 = new SimpleDateFormat("yyyy-MM-dd")
						.format(new java.util.Date());
			} else {
				data1 = new SimpleDateFormat("yyyy-MM-dd")
						.format(new SimpleDateFormat("dd-MMM-yyyy")
								.parse(request.getParameter("data")));
				data2 = new SimpleDateFormat("yyyy-MM-dd")
						.format(new SimpleDateFormat("dd-MMM-yyyy")
								.parse(request.getParameter("data1")));

				datex1 = request.getParameter("data");
				datex2 = request.getParameter("data1");
			}

	System.out.println(" datex1 "+datex1+" datex2 "+datex2);
	
	
	
	%>
	
	<% 
	//String UserID=session.getAttribute("UserID").toString();
	String User=session.getAttribute("usertypevalue").toString();
	System.out.println("User-----"+User);
	%>
	
	<input type="hidden" id="user" name="user" value="<%=User%>" />
	
	
	<table border="0" width=600 align="center" class="stats">
		<tr>
			<td colspan="5" align="center"><div align="left"><font size="3"></font></div>
			<font face="Arial" color="black" size="3"><b style= "font:normal 16px Arial,Helvtica,sans-serif;"><b> Geofence Location Report </b></font></td>
		</tr>
	</table>
	
	
	

	<!-- Select date and time from calendar -->

	<div style="margin-left: 25%;">
	<table border="0" width=600 align="center">
		<!-- <form action="" method="get" onsubmit="return validate();"> -->
		<%-- <input	type="hidden" id="PageName" name="PageName" value="<%=PageName%>" />
		<br></br> --%>

			<tr>
			<td>
         <font face="Arial" color="black" size="2">Status:</font></td>
			<td><select name="Status" id="Status"  style="width: 87px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;">
				  <option value="All">All</option> 
		<%
            String status="";
       	String sql6 = "SELECT Distinct Status FROM  db_gps.t_warehousedata order by Status asc";
		System.out.println("*******"+sql6);
        ResultSet rs5 = st4.executeQuery(sql6);
		while(rs5.next())
		{
			 
			 status=rs5.getString("status");
			 System.out.println("Status-->"+status);
			 
			%>
			<option value="<%=status%>"><%=status%></option>
	         <%
			
      }
		%>
			 	
			    </select>
			   </td> 
			
			<td><font face="Arial" color="black" size="2">
			All</font></td><td> <input type="checkbox" name="extAll" id="extAll" value="Yes"  onclick="allSelected(this.value);"></input>
				</td>
				
				
				
			<td align="right" id="fromdt"><font face="Arial" color="black" size="2">From: </font></td>&nbsp;&nbsp;
			<td> <input type="text" id="data" name="data" value="<%=datex1%>" size="15" readonly  class="element text medium" style="width: 125px; height: 16px;"  /> <script
				type="text/javascript">
			  Calendar.setup(
			    {
			      inputField  : "data",         // ID of the input field
			      ifFormat    : "%d-%b-%Y",     // the date format
			      button      : "data"       // ID of the button
			    }
			  );
			</script></td>
			<td align="right" id="todt"><font face="Arial" color="black" size="2">To
			:</font></td>&nbsp;&nbsp; <td><input type="text" id="data1" name="data1" value="<%=datex2%>" size="15" readonly   class="element text medium" style="width: 125px; height: 16px;"  /> 
			<script	type="text/javascript">
			  Calendar.setup(
			    {
			      inputField  : "data1",         // ID of the input field
			      ifFormat    : "%d-%b-%Y",    // the date format
			      button      : "data1"       // ID of the button
			    }
			  );
			</script></td> 
			
			
			
			<td>&nbsp;&nbsp;<input type="submit" name="submit" id="submit" onclick="birt()" value="submit"></td>
			
		</tr>
		<!-- </form> -->
	</table>
	<br>
	</div>
	<div align="right">
	<td  bgcolor="#FFFFFF"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())%></td></div>
	<%
	
	
	String dt = new SimpleDateFormat("yyyy-MM-dd")
    .format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex1));

dt=dt+" 00:00:00";

String dt1 = new SimpleDateFormat("yyyy-MM-dd")
   .format(new SimpleDateFormat("dd-MMM-yyyy")
      .parse(datex2));

dt1=dt1+" 23:59:59";
	
		
	%>
	
	<div id="reportData">
<iframe id="myIframe" width="100%" height="850px" src="http://myfleetview.com:8080/birt/frameset?__report=GeofenceLocationReport_rptdesign.rptdesign&Owner=<%=User%>&Status=<%=status%>&Chk=All&Date=<%=dt%>&Date1=<%=dt1%>&dt=<%=datex1%>&dt1=<%=datex2%>&__showtitle=false"> 
<!-- <iframe id="myIframe" width="100%" height="850px" src=""> --> 
</iframe> 

 </div>
	
	<%
		String Bt=request.getParameter("button");
		if(Bt=="Submit")
		{
%>
	
	
	<div id="reportData1">
<%-- <iframe id="myIframe" width="100%" height="850px" src="http://myfleetview.com:8080/birt/frameset?__report=JRM_report.rptdesign&userid=<%=UserID%>&__showtitle=false"> --%> 
<iframe id="myIframe" width="100%" height="850px" src=""> 
</iframe> 

 </div>
 
 <%
		}
%>
	