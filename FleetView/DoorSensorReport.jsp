	<%@ include file="headernew.jsp"%> 
<meta http-equiv="refresh" content="300">
<%@page import="java.util.Date"%> 
<%
classes fleetview=new classes();
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
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

<script LANGUAGE="JavaScript" TYPE="text/javascript">
function article(programName,width,height)
{
	var temp = "menubar=yes,toolbar=no,location=no,status=yes,scrollbars=yes,resizable=yes,width="+width+",height="+height; displayWindow=window.open(programName,"displayWindow",temp) ;
}
function fun(aa)
{
	//alert(aa.value);
	document.searchform.h.value=aa.value;
}

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
    
    document.CameraReport.action ="excel.jsp";
    document.forms["CameraReport"].submit();
} 

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
function showFTPImage1(imageName)
{	
	var url="cameraFtpImage.jsp?imageName=" +imageName;
	testwindow1 = window.open(url,"Image", "width=500,height=500");
    testwindow1.moveTo(250,100);
}
function popup22(vehcd,imeino)
{

	var url="shownewmap.jsp?Vehcode=" +vehcd+ "&imeino=" +imeino;
	testwindow = window.open(url,"Show on Map", "width=900,height=500");
    testwindow.moveTo(250,100);
}

function chk()
{
	//alert("Chk");
	
	
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
//         else if(date1 > currentDate)
//         {
//             alert("From Date should be less than current date");
//             return false; 
//         }
//         else if(date2 > currentDate) 
//         {
//             alert("To Date should be less than current date");
//             return false; 
//         }

return true;
	
}
</script>

<style> .popup {
background-color: #98AFC7;
position: absolute;
visibility: hidden;

.popupnew {
background-color: #98AFC7;
position: absolute;
visibility: visible;

.popupx{
background-color: #98AFC7;
position: absolute;
visibility: hidden;
}
</style>
<%!
	Connection conn,conn1;
	Statement st,st1,stx,st2,stmt;
	String aa,regno,sq,searchveh,sql;
	ResultSet rs_rh,rs_cnt;
	
	Statement st3 = null;
	Statement st4 = null;
	Statement st5 = null;
	
	String date1 = "";
	String date2 = "";
	String from ="";
	String to ="";
	String fromdate="";
	String todate="";
	
	String time1 = "";
	String time2 = "";
	String time3="";
	String time4="";
	
	String vehno="";
%>
<%
try
{
	conn=fleetview.ReturnConnection();
	 Calendar calendar = Calendar.getInstance();
	//conn1=fleetview.ReturnConnection1();
	st=conn.createStatement();
	stx=conn.createStatement();
	st1=conn.createStatement();
	stmt=conn.createStatement();
	//out.print(session.getAttribute("usertypevalue").toString());
                Date dt=new  Date();
			    String  dt1=new SimpleDateFormat("dd:MM:yyyy").format(dt);
			  //  System.out.println("dt===>"+dt1);
			  String exportFileName=session.getAttribute("user").toString()+"_DoorSensor.xls";  
			   
%>
<%
String vehlist = "";
try{
	
	String frompage = request.getParameter("frompage");
	
	//System.out.println("The vehicle list>>>>"+vehlist);

	if(frompage!=null && frompage.equalsIgnoreCase("OS"))
	{
		String thedate = request.getParameter("data");
		String thedate1 = request.getParameter("data1"	);
		date1 = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(thedate));
		time1 = new SimpleDateFormat("HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(thedate));
		date2 = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(thedate1));
		time2 = new SimpleDateFormat("HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(thedate1));
	}
	else
	{
	 System.out.println("In else date");
		 date1 = request.getParameter("data");
		 date2 = request.getParameter("data1");
		 from= request.getParameter("from");
		// fromdate= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(from));
		// time3= new SimpleDateFormat("HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(from));
		 
		 
		 to= request.getParameter("to");
		// todate= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(to));
		// time4= new SimpleDateFormat("HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(to));
		 
	 System.out.println("date1 "+date1);
	 System.out.println("date2 "+date2);
	 System.out.println("From "+from);
	 System.out.println("To "+to);
	// time1 =":00";
	 
	 
	 
	// time2 = ":59";
	}
	
	 Class.forName(MM_dbConn_DRIVER);
	 conn = DriverManager.getConnection(MM_dbConn_STRING, MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
	 st = conn.createStatement();
	 st1 = conn.createStatement();
	 st2 = conn.createStatement();
	 st3 = conn.createStatement();
	 
	 
	 //statusname=request.getParameter("status");
	 //System.out.println("statusname "+statusname);
// 	 if(statusname==null)
// 	 {
// 	 	statusname="All";
// 	 }
// 	 System.out.println("statusname "+statusname);
	 System.out.println("  Date1 ==>"+date1+ "Date2 ==>"+date2);

}catch(Exception e){
	System.out.println("Exception "+e);
}
int i=1;
String datenew1="";
String datenew2="";
String statVal = "";
String chbxAll = "";
String catval = "";
String VehNo1="",vehcode="";
int counter=0;
if(request.getParameter("data")!=null)
{
  datenew1=request.getParameter("data");
  datenew2=request.getParameter("data1");
  
   
   
}
else
{
	
	
	datenew1=datenew2=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
}

		 DateFormat df123= new SimpleDateFormat("dd-MMM-yyyy");
		DateFormat df1234= new SimpleDateFormat("yyyy-MM-dd");
		String dataDate1=df1234.format(df123.parse(datenew1));
		String dataDate2=df1234.format(df123.parse(datenew2));
		
%>

		<table border="0" cellpadding="0" width="100%" align="center" class="stats">
		<tr>
		<td>
		
		</td>
		</tr>
		</table>






<%
		 //String  exportFileName="Door_Sensor_report.xls";
		%>


	<form id="CameraReport" name="CameraReport" action="" method="post" onsubmit="return chk()">
    <div id="table1">
	<table border="0" width="100%" bgcolor="white" align="center"> 
	<tr>
	<td align="left"><a href="#" onclick="javascript:window.open('mapplot.jsp');"></a></td>
	
	</tr> 
			<tr align="center">
				<td>
				<!-- 	<div align="left"><font color="block" face="arial"  size="3" ><b>Report No: 1.0</b></font></div>-->
					<div align="center"><font size="3"  face="arial" color="black"><b>Door  Sensor  Report  From  <%=datenew1 %>  To <%=datenew2 %></b></font></div>
					
					
					<br>
 <div align="center">
 <table  style="width: 70%;">
<tr style="background-color: white;">
<td align = "right" colspan="8" style="background-color: white;"><div align="right" style="background-color: white;"><font size="2" face="Arial" ><a href="CameraImageReport.jsp?data=<%=date1+time1 %>&data1=<%= date2+time2%>" target="_blank" ></a></font></div></td>
</tr>
</table>
<table  style="width: 70%;">

<tr>

		<td id="frmDT" align="right" style="display:''"><font color="black" size="2" face="Arial">From &nbsp;&nbsp;</font>
					 <input type="text" id="data" name="data" size="12" value="<%=datenew1%>" 
					style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF;" readonly />
					<script type="text/javascript">
					  Calendar.setup(
					    {
					      inputField  : "data",         // ID of the input field
					      ifFormat    : "%d-%b-%Y",    // the date format
					      button      : "data"       // ID of the button
					    }
					  );
				</script>
				</td>
				
				<td id="toDT" align="right" style="display:''"><font color="black" size="2" face="Arial">&nbsp;&nbsp;To</font>
					 <input type="text" id="data1" name="data1" size="12" value="<%=datenew2%>" 
					style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF;" readonly />
					<script type="text/javascript">
					  Calendar.setup(
					    {
					      inputField  : "data1",         // ID of the input field
					      ifFormat    : "%d-%b-%Y",    // the date format
					      button      : "trigger1"       // ID of the button
					    }
					  );
				</script> &nbsp;
			 	 
				</td>
				
				<%
				VehNo1 = request.getParameter("Vehicle1");
				System.out.println("Vehicle1-------------------- "+VehNo1);
				
				
				%>
		<td align =left>
	<div align="center"><font color="black" size="2" face="Arial">Vehicle:
	<select name="Vehicle1" class="element select medium" style="width: 130px" id="Vehicle1" >
<%
	
	
	vehlist = session.getAttribute("VehList").toString();
	

	//  Change here
	///String unit = "Select a.VehicleRegNumber as vehno from db_gps.t_vehicledetails a,db_gps.t_jpgsnap b  where a.unitid = b.unitid and  a.VehicleCode in "+vehlist+" and a.status='-' group by a.VehicleRegNumber order by VehicleRegNumber ";
	String unit = "Select VehicleRegNumber as vehno from db_gps.t_vehicledetails where VehicleCode in "+vehlist+" group by VehicleRegNumber order by VehicleRegNumber";
	 
	System.out.println("taking vehicel list   "+unit);
	ResultSet rstunit=st1.executeQuery(unit);
	System.out.println("unit is "+unit);
	String tdydate1 = new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date());
	while(rstunit.next())
	{	
		
		
		vehno = rstunit.getString("vehno") ;
		//vehcode=rstunit.getString("VehicleCode") ;
		//System.out.println("Query veh no  "+vehno);

		if(null != VehNo1)
			{  //System.out.println("in IF veh no  "+vehno);
			%>
			<option value="<%=vehno%>" <% if(VehNo1.equals(vehno)){ %>Selected<% } %>><%=vehno%></option>
			<%
			} else
			{
				
			
				 %><option  value="<%=vehno%>" ><%=vehno %></option> <% 
				//VehNo1=vehno;
				//System.out.println("in else veh no  "+vehno);
			} 
		
	} %>
	</select>
	
	<td aligh="left"><div align="left"><input type="submit" name="button" id="button" value="Submit"></div></td>
	<!-- <td><input type="submit" name="button" value="Go" onclick="birt()"></td> -->
	</font>
	</div>
	</td></tr>
	
	        <div align="right">
                           <input type="hidden" id="tableHTML" name="tableHTML" value="" />  
                           <input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 
     
                           <a href="#" style="font-weight: bold; color: black; " onclick="gotoPrint('table1');">
                           <img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img></a> 
      
                           <a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('table1','tableHTML');">
                           <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img></a>
                           <%=tdydate1%>
                           
	       
	<%
	  Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
	  String sdt = fmt.format(new java.util.Date());
//	  out.print(sdt); 
	%></div></td></tr>
		    </table>  
		          
		    
		    <br>	
			
			
				
			        
			
			
				    				
			<% 
			if(VehNo1==null || VehNo1==" ")
			{
			%>
				 <font size="3"  face="arial" color="black"><b>No Data</b></font>  
				<% 
			}
			%>
			<table  border="1" cellpadding="0" cellspacing="0" align="center" class="sortable" style="width: 80em;">
			<tr>
			
			<th id="tdp0" align="right" style="width: 3px;"> <b>SrNo</b></th>
			<th id="tdp0" align="right" style="width: 3px;"> <b>Vehicle</b></th>
			<th id="tdp0" style="width: 100px;"> <b>Updated</b></th>
			<th id="tdp0" align="right" style="width: 75px;"> <b>Location</b></th>
			<th id="tdp0" style="width: 75px;"> <b>Status</b></th>
			<th id="tdp0" style="width: 75px;"> <b>ImageTime</b></th>
			<th id="tdp0" style="width: 75px;"> <b>Image</b></th>
			
			
		    </tr>
		    <% 
					int j=1;
			        int sr_no=0,r_cnt=0;
			        String rh_flg="N";
			        
			        String today="";
					int i_cnt=0, rw_cnt=0;
					long millisecdiff=0,miliseconds1=0,miliseconds2=0,ticks=0;
					double lat,lon;
			        String date="",time="",empname="",sensor="";
			        String imeino="";
					String flg="N";
					String Value1="",Value2="",Value3="";
					String stat, rh_stat, rh_st1, rh_st2, rh_date;
					String location="",filename="";
					String jpgfilename="",CaptureDateTime="";
		//			DateFormat df;
		//			java.util.Date rh_time;
			       String dt11 = new SimpleDateFormat("yyyy-MM-dd")
		.format(new SimpleDateFormat("dd-MMM-yyyy")
				.parse(datenew1));
		
		String dt111 = new SimpleDateFormat("yyyy-MM-dd")
		.format(new SimpleDateFormat("dd-MMM-yyyy")
				.parse(datenew2));
		
			       String online="select VehicleCode,VehicleRegNumber from db_gps.t_vehicledetails where VehicleRegNumber='"+VehNo1+"'";
			//		String online="select VehicleCode,Empname from t_vehicledetails where OwnerName='Airtel'";
					ResultSet onrs=st.executeQuery(online);
					System.out.println("**********"+online);
					
					while(onrs.next())
					{
						System.out.println("Hii");
						int ccnt=0;//initially 0
						long secdiff=0,mindiff=0,hrdiff=0;
						String timeInHHmm="00:00",final_time="";
						long sdiff=0,mdiff=0,hdiff=0;
						long rh_total_time=0;
						String UnitID="";
						//int UnitID=onrs.getInt("UnitID");;
						   DateFormat df =new SimpleDateFormat("HH 'hours', mm 'mins,' ss 'seconds'");
						   int vehcode1=onrs.getInt("VehicleCode");
					       System.out.println("vehcode1***>"+vehcode1);
					       //empname=onrs.getString("Empname");
					       imeino=onrs.getString("VehicleRegNumber");
					     // sql="SELECT * FROM db_gps.t_veh"+vehcode1+"  where Sen1 <> '-' order by TheFieldDataDate desc,TheFieldDataTime desc limit 1";
					       sql= "Select * from db_gps.t_veh"+vehcode1+" where TheFiledTextFileName in ('DO','DS','DO1','DS1','DO2','DS2') and TheFieldDataDate between '"+dt11+"' and '"+dt111+"' order by Thefielddatadatetime asc";
						   ResultSet rstnew1=stx.executeQuery(sql);
						   if(!rstnew1.next())
						   {
							   %>
								<font size="3"  face="arial" color="black"><b>No Data</b></font>
								<% 
						   }
						   System.out.println("VehCode sql======>"+sql);
						   while(rstnew1.next())
						   {
							   
							   date=rstnew1.getString("TheFieldDataDate");
						   
							      time=rstnew1.getString("TheFieldDataTime");
							      lat=rstnew1.getDouble("LatinDec");
								  lon=rstnew1.getDouble("LonginDec");
							      sensor=rstnew1.getString("TheFiledTextFileName");
							      //filename=rstnew1.getString("Sen1");
							      
							      String date1=new SimpleDateFormat("yyyy-MM-dd").format(rstnew1.getDate("TheFieldDataDate"));
									String time1=rstnew1.getString("TheFieldDataTime");
									
									//System.out.println("date----------"+date1);
									//System.out.println("Time----------"+time1);
							      if(sensor.equals("DO"))
							      {
							    	  sensor="Open";
							      }
							      else if(sensor.equals("DS"))
							      {
							    	  sensor="Close";
							      }
							      
							      else if(sensor.equals("DO1"))
							      {
							    	  sensor="Manhole Open";
							      }
							      else if(sensor.equals("DS1"))
							      {
							    	  sensor="Manhole Close";
							      }
							      else if(sensor.equals("DO2"))
							      {
							    	  sensor="Valve Open";
							      }
							      else if(sensor.equals("DS2"))
							      {
							    	  sensor="Valve Close";
							      }

							      
								  //lat=rstnew1.getDouble("LatinDec");
								 
								  location=rstnew1.getString("TheFieldSubject");
								  
	                              %>
	 						<tr>
	 						
<!--							<td><div align="left"></div></td>-->


                         
                            <%-- <td><div align="left"><a href="cameraDetailReport.jsp?imeino=<%=imeino%>&Vehcode=<%=vehcode1%>" target="_blank"><%=imeino%></a></div></td> --%>
                            <td style="text-align: right"><%=i %></td>
                            <td><div align="left"><%=imeino%></div></td>
                            <td class="bodyText"><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rstnew1.getDate("TheFieldDataDate"))%>  <%=" "+rstnew1.getString("TheFieldDataTime")%></div></td>
                           
             
                           <%
                           
                           
	   						   
	   						 if(location.equals("No GPS"))
							{
							%>
							<td><div align="left"><%=location%></div></td>
							<%} 
							else
							{%>
							<%-- <td><div align="left"><a href="#!" onclick="showFTPImage1('<%=location%>');"><img width="50" height="50" src="http://myfleetview.com:8080/images1/ProcessedCameraImages/<%=location%>"/></a></div></td> --%>
							<td><div align="left"><a href="#" onclick="javascript: poponclick(<%=lat%>,<%=lon%>)"><%=location%></a></div></td>
							<%} %>
							<td><div align="left"><%=sensor%></div></td>
							
							<%
							try{
			 				
							
							
							 String sqlcnt = " Select snapdatetime,jpgfilename from db_gps.t_jpgsnap where vehid="+vehcode1+" and  snapdatetime >= '"+date1+" "+time1+"' and category='Road' order by snapdatetime  limit 1";
							//String sqlcnt=" Select snapdatetime,jpgfilename from db_gps.t_jpgsnap where vehid=9631 and  snapdatetime > '2016-02-22 09:42:59' ";
							//select snapdatetime,jpgfilename from db_gps.t_jpgsnap where vehid=9631 and  snapdatetime > '2016-02-22 09:42:59' order by snapdatetime  limit 1;
							//Select snapdatetime,jpgfilename from db_gps.t_jpgsnap where vehid=9631 and  snapdatetime > '2016-02-22 09:42:59' limit 1
							ResultSet rs3 = st3.executeQuery(sqlcnt);
							System.out.println("Query for image==>"+sqlcnt);
							//System.out.println("sqlcount----------"+sqlcnt);
							
							if(rs3.next())
							{
								jpgfilename= rs3.getString("jpgfilename"); 
								CaptureDateTime= rs3.getString("snapdatetime");
								//CaptureDateTime= fmt.format(CaptureDateTime);	
								CaptureDateTime = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(CaptureDateTime));		
							} 
							}
							catch(Exception e)
							{
								e.printStackTrace();
							}
						 
%>	
							<td><div align="right"><%=CaptureDateTime%></div></td>
							<%-- <td><div align="left"><a href="#" onclick="showFTPImage1('<%=jpgfilename%>');"><%=jpgfilename%></a></div></td> --%>
							<td>
			    	<a href="#!" onclick="showFTPImage1('<%=jpgfilename%>');"><img width="50" height="50" src="http://myfleetview.com:8080/images1/ProcessedCameraImages/<%=jpgfilename%>"/></a>        			    
			    </td>		
							
							
							
				
				
				
				
				
				</tr>
				
			
				<%	
			i++;	
				counter=counter+i;	
								       
								  }
						   
					}
	                         %>
	                            </table>	
	                          
	                         </div>
	                          </td></tr></table></div></form>
					  				
	
	<%
					
					
					
}catch(Exception e)
	{
		System.out.print("Exception -->"+e);
		e.printStackTrace();
	}
	%>
	    
	<%
	    fleetview.closeConnection();
	   fleetview.closeConnection1();
	%>
	<%@ include file="footernew.jsp"%>