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
function popup22(vehcd,imeino)
{

	var url="shownewmap.jsp?Vehcode=" +vehcd+ "&imeino=" +imeino;
	testwindow = window.open(url,"Show on Map", "width=900,height=500");
    testwindow.moveTo(250,100);
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
			   String exportFileName=session.getAttribute("user").toString()+"_CameraReport.xls";  
			   
%>


		<table border="0" cellpadding="0" width="100%" align="center" class="stats">
		<tr>
		<td>
		
		</td>
		</tr>
		</table>









	<form id="CameraReport" name="CameraReport" action="" method="post" >
    <div id="table1">
	<table border="0" width="100%" bgcolor="white" align="center"> 
	<tr>
	<td align="left"><a href="#" onclick="javascript:window.open('mapplot.jsp');"></a></td>
	</tr> 
			<tr align="center">
				<td>
				<!-- 	<div align="left"><font color="block" face="arial"  size="3" ><b>Report No: 1.0</b></font></div>-->
					<div align="center"><font size="3"  face="arial"><b>POD Report</b></font></div>
	        <div align="right">
                           <input type="hidden" id="tableHTML" name="tableHTML" value="" />  
                           <input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 
     
                           <a href="#" style="font-weight: bold; color: black; " onclick="gotoPrint('table1');">
                           <img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img></a> 
      
                           <a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('table1','tableHTML');">
                           <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img></a>
                           <%=fleetview.PrintDate() %>
                           
	       
	<%
	  Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
	  String sdt = fmt.format(new java.util.Date());
//	  out.print(sdt); 
	%></div></td></tr>
		    </table>        
		    <form name="addveh" method="get" action="">	
			<table  border="1" cellpadding="0" cellspacing="0" align="center" class="sortable" style="width: 80em; margin-left: 20em;">
			
				<tr>
					<th id="tdp0" align="right" style="width: 3px;"> <b>VehRegNo</b></th>
					<th id="tdp0" style="width: 100px;"> <b>UpdatedDateTime</b></th>
					<th id="tdp0" align="right" style="width: 75px;"> <b>Location</b></th>
					<th id="tdp0" style="width: 75px;"> <b>File Name</b></th>
					<th id="tdp0" style="width: 75px;"> <b>Value1</b></th>
					<th id="tdp0" style="width: 75px;"> <b>Value2</b></th>
					<th id="tdp0" style="width: 75px;"> <b>Value3</b></th>
					
				    </tr>	
			        <%
					int j=1;
			        int sr_no=0,r_cnt=0;
			        String rh_flg="N";
			        String today="";
					int i_cnt=0, rw_cnt=0;
					long millisecdiff=0,miliseconds1=0,miliseconds2=0,ticks=0;
					double lat,lon;
			        String date="",time="",vehcode="",empname="";
			        String imeino="";
					String flg="N";
					String Value1="",Value2="",Value3="";
					String stat, rh_stat, rh_st1, rh_st2, rh_date;
					String location="",filename="";
		//			DateFormat df;
		//			java.util.Date rh_time;
			       String
			       online="select VehicleCode,Empname,VehicleRegNumber,unitid from t_vehicledetails where description='camera' and vehiclecode = '5127'";
			//		String online="select VehicleCode,Empname from t_vehicledetails where OwnerName='Airtel'";
					ResultSet onrs=st.executeQuery(online);
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
					       empname=onrs.getString("Empname");
					       imeino=onrs.getString("VehicleRegNumber");
					      sql="SELECT * FROM db_gps.t_veh"+vehcode1+"  where Sen1 <> '-' order by TheFieldDataDate desc,TheFieldDataTime desc limit 1";
					       //sql= "SELECT UnitID,TheFieldDataDate,TheFieldDataTime,TheFieldSubject,LatinDec,LonginDec,Sen1,Sen2,Sen3,Sen4 FROM db_gps.t_veh0";
						   ResultSet rstnew1=stx.executeQuery(sql);
						//   System.out.println("sql==>"+sql);
						   if(rstnew1.next())
						   {
							   
							   

								  date=rstnew1.getString("TheFieldDataDate");
							      time=rstnew1.getString("TheFieldDataTime");
						   
						         // UnitID=rstnew1.getString("UnitID");
								  lat=rstnew1.getDouble("LatinDec");
								  lon=rstnew1.getDouble("LonginDec");
								  location=rstnew1.getString("TheFieldSubject");
								  filename=rstnew1.getString("Sen1");
								  Value1=rstnew1.getString("Sen2");
								  Value2=rstnew1.getString("Sen3");
								  Value3=rstnew1.getString("Sen4");
	                              %>
	 						<tr>
	 						
<!--							<td><div align="left"></div></td>-->


                         
                            <td><div align="left"><a href="cameraDetailReport.jsp?imeino=<%=imeino%>&Vehcode=<%=vehcode1%>" target="_blank"><%=imeino%></a></div></td>
                            <td class="bodyText"><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rstnew1.getDate("TheFieldDataDate"))%>  <%=" "+rstnew1.getString("TheFieldDataTime")%></div></td>
                           
             
                           <%
                           
                           
	   						   
	   						 if(location.equals("No GPS"))
							{
							%>
							<td><div align="left"><%=location%></div></td>
							<%} 
							else
							{%>
							<td><div align="left"><a href="#" onclick="javascript: poponclick(<%=lat%>,<%=lon%>)"><%=location%></a></div></td>
							<%} %>
							
							<td><div align="left"><a href="#" onclick="showFTPImage('<%=filename%>');"><%=filename%></a></div></td>
							<td><div align="left"><%=Value1%></div></td>
							<td><div align="left"><%=Value2%></div></td>
							<td><div align="left"><%=Value3%></div></td>
							</tr>
							
		                  <%		       
								  }
						   
				           	}
	                         %>
	                            </table>	
	                          </form>	
	                         </div>
	                          </form>
					  				
	
	<%
					
	}catch(Exception e)
	{
		System.out.print("Exception -->"+e);
	}
	%>
	    
	<%
	    fleetview.closeConnection();
	   fleetview.closeConnection1();
	%>
	<%@ include file="footernew.jsp"%>
