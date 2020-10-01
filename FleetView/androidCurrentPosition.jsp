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
    
    document.AndroidReport.action ="excel.jsp";
    document.forms["AndroidReport"].submit();
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
			    String  dt1=new SimpleDateFormat("yyyy-MM-dd").format(dt);
			  //  System.out.println("dt===>"+dt1);
			   String exportFileName=session.getAttribute("user").toString()+"_CurrentPositionReport.xls";  
%>
	<form id="AndroidReport" name="AndroidReport" action="" method="post" >
    <div id="table1">
	<table border="0" width="100%" bgcolor="white" align="center"> 
	<tr>
	<td align="left"><a href="#" onclick="javascript:window.open('mapplot.jsp');">Map</a></td>
	</tr> 
			<tr align="center">
				<td>
				<!-- 	<div align="left"><font color="block" face="arial"  size="3" ><b>Report No: 1.0</b></font></div>-->
					<div align="center"><font size="3"  face="arial"><b>Current Position Report </b></font></div>
	        <div align="right">
	        <input type="hidden" id="tableHTML" name="tableHTML" value="" />  
            <input type="hidden" id="fileName" name="fileName" value="<%= exportFileName %>" /> 
	
	       
	<%
	  Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
	  String sdt = fmt.format(new java.util.Date());
//	  out.print(sdt); 
	%></div></td></tr>
		    </table>        
		    <form name="addveh" method="get" action="">	
			<table  border="1" cellpadding="0" cellspacing="0" align="center" class="sortable" style="width: 80em; margin-left: 20em;">
			
				<tr>
					<th id="tdp0" align="right" style="width: 3px;"> <b>Sr.No.</b></th>
					<th id="tdp0" align="right" style="width: 75px;"> <b>Owner</b></th>
					<th id="tdp0" align="right" style="width: 75px;"> <b>Updated DateTime</b></th>
					<th id="tdp0" style="width: 100px;"> <b>Location</b></th>
					<th id="tdp0" style="width: 75px;"> <b>File Name</b></th>
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
			        long imeino=0;
					String flg="N";
					
					String stat, rh_stat, rh_st1, rh_st2, rh_date;
					String location="",filename="";
		//			DateFormat df;
		//			java.util.Date rh_time;
			       String online="select VehicleCode,Empname,VehicleRegNumber from t_vehicledetails where OwnerName='android'";
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
						
						   DateFormat df =new SimpleDateFormat("HH 'hours', mm 'mins,' ss 'seconds'");
						   int vehcode1=onrs.getInt("VehicleCode");
					    //   System.out.println("vehcode1***>"+vehcode1);
					       empname=onrs.getString("Empname");
					       imeino=onrs.getLong("VehicleRegNumber");
					       sql="select * from t_onlinedata where VehicleRegNo='"+imeino+"'";
						   ResultSet rstnew1=stx.executeQuery(sql);
						//   System.out.println("sql==>"+sql);
						   if(rstnew1.next())
						   {
							  date=rstnew1.getString("TheDate");
						      time=rstnew1.getString("TheTime");
						     // Date dt1 = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).parse(date+" "+time);
							  vehcode=rstnew1.getString("VehicleCode");
							  lat=rstnew1.getDouble("LatitudePosition");
							  lon=rstnew1.getDouble("LongitudePosition");
							  location=rstnew1.getString("Location");
							  filename=rstnew1.getString("Sen4");
							  //System.out.println(lat);
							  //System.out.println(lon);
							 
						      String siteaddrs="",fuel="",battery="",temp="",noofgenset="",onof="";
							/*
							String sql3="select * from t_veh"+vehcode1+" where concat(TheFieldDataDate,'',TheFieldDataTime)=concat('"+date+"','','"+time+"')";
						//	String sql3="select * from t_vehicledetails where VehicleRegNumber='"+vehregno+"'";
						//	System.out.println("sql3==>"+sql3);
						
						    ResultSet rs3=st1.executeQuery(sql3);
							if(rs3.next())
							{*/
                               sr_no++;
                               %>
 						<tr>
 													
   						<td><div align="right"><%=sr_no%></div></td>
   						<%
   						if(String.valueOf(imeino).equals("910556000067041"))
   						{
   						%>
						<td><div align="left"><a href="imeiDetailReport.jsp?imeino=<%=vehcode%>">Reshma</a></div></td>
						<%}
   						else if(String.valueOf(imeino).equals("and_test"))
   						{
   							%>
   							<td><div align="left"><a href="imeiDetailReport.jsp?imeino=<%=vehcode%>">Mohit</a></div></td>
   							<%
   						}
   						else
   						{
   						%>
   						<td><div align="left"><a href="imeiDetailReport.jsp?imeino=<%=vehcode%>">Tanbir</a></div></td>
   						<%} %>
						<td><div align="left"><%=date%> <%=time%></div></td>
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
						</tr> 			
	<%		           
						j++;
						
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
