<%@ include file="headernew.jsp"%>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%@page import="java.util.Date"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.BufferedWriter"%>
<%@ page import="javax.imageio.ImageIO"%>
<%@ page import="javax.imageio.stream.ImageInputStream"%>
<%@ page import="java.awt.image.BufferedImage"%>
<%@ page import="com.lowagie.text.Image"%>

<link rel="stylesheet" type="text/css" href="css/view.css" media="all">
<%
System.out.println("11111");

%>
<script type="text/javascript">
function gotoExcel(elemId, frmFldId)  
{  
	      
          var obj = document.getElementById(elemId);
          var oFld = document.getElementById(frmFldId);
          oFld.value = obj.innerHTML;
          document.camera_jpg_report.action ="excel.jsp";
          document.forms["camera_jpg_report"].submit();
}
function showFTPImage(imageName)
{	
	var url="cameraFtpImage.jsp?imageName=" +imageName;
	testwindow1 = window.open(url,"Image", "width=500,height=500");
    testwindow1.moveTo(250,100);
}
</script>




<%! Connection conn = null;
	Statement st = null;

	String date1 = "";
	String date2 = "";
	String VehNo1 = "";
	String category = "";
	String type="";
	%>	

<%
try{
	 
	System.out.println("11111");
	
	date1 = request.getParameter("data");
	 date2 = request.getParameter("data1");
	 VehNo1 =  request.getParameter("VehNo1");
	 category =  request.getParameter("category");
	 type= request.getParameter("type");
	 conn = DriverManager.getConnection(MM_dbConn_STRING, MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
	 st = conn.createStatement();
	 
	 //System.out.println("  Date1 ==>"+date1+ "Date2 ==>"+date2);

}catch(Exception e){
	System.out.println("Exception "+e);
}
%>	
<img id="top" src="newimages/top.png" alt="" style="width: 600px;">

	<div id="form_container" style="width: 800px;" align="center">

<form id="camera_jpg_report" name="camera_jpg_report" action="" method="post" onsubmit="return validateDate(); ">
<div class="form_container" style="text-align: center;" align="center">
	<div  align="center" style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff ;text-align: center;">
<table>
</table>

		<%
		 String  exportFileName="camera_images_report.xls";
		%>
		
<table border="0" width="100%" class="stats">
<tr>
</tr>
	<tr>
		<td align="center">	
				<font size="3"><b>Detailed Camera Report</b></font>
		</td>
	</tr>
	<tr>
		<td align="right">	
							<input type="hidden" id="tableHTML" name="tableHTML" value="" /> 
			 				<input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" />  
							<div style="text-align: right"><a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('table1','tableHTML');">
                           <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img></a>&nbsp;<%= new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new Date()) %></div>
		</td>
	</tr>
</table>	
<div style="width:100%;" align="left" id="table1" >	
<table border="0" class="stats" align ="center">
	<tr>
		<td>
			<table class="sortable">
			<tr>
			<th width ="10%">Sr No</th>
			<th>File Name</th>
			<th>File Date & Time</th>
			<th>Image</th>
			
			</tr>
			
	<%
	
	
	System.out.println("@@@@@@@@==>"+category);
	System.out.println("Type"+type);
	
	if(category.contains(")")  || category.contains("("))
	{
		category=category.trim();
		category=category.replace(")","");
		category=category.replace("(","");
		category=category.replace("'","");
		category=category.replace("-","");
		category=category.replace(",","");
		category=category.trim();
	}
	if(type.contains(")")  || type.contains("("))
	{
		type=type.trim();
		type=type.replace(")","");
		type=type.replace("(","");
		type=type.replace("'","");
		type=type.replace("-","");
		type=type.replace(",","");
		type=type.trim();
	}
	
	System.out.println("@@@@@@@@==AFTER>"+category);
	
	try{  
		
		
		String condition = "And unitid in (select unitid from db_gps.t_vehicledetails where VehicleRegNumber = '"+VehNo1+"'  and status='-') ";	
		
		System.out.println("Tconditione==>"+condition);
		
		
	     int cnt = 0;
	     String sql="";
	     if(category.equals("Cabin,Road")){
		 sql = "Select unitid,jpgfilename,snapdatetime from db_gps.t_jpgsnap where snapdatetime >= '"+date1+"' AND snapdatetime <= '"+date2+"' AND jpgfilename not like  '%pod%'   "+condition+" Order by snapdatetime DESC";
	     }else
	     sql = "Select unitid,jpgfilename,snapdatetime from db_gps.t_jpgsnap where snapdatetime >= '"+date1+"' AND snapdatetime <= '"+date2+"' AND category in ('"+category+"') and type in ('"+type+"')  AND jpgfilename not like  '%pod%'   "+condition+" Order by snapdatetime DESC";
		System.out.println("The sql is before==>"+sql);
		ResultSet rs = st.executeQuery(sql);
		System.out.println("The sql is  After==>"+sql);
		while(rs.next()){
			
			String  unitid = rs.getString("unitid");
			String  jpgfilename = rs.getString("jpgfilename");
			String  snapdatetime = rs.getString("snapdatetime");
			
	
				//add the data into the table
			%>
				<tr>
				
				<td  width ="10%"><div align="right"><%= ++cnt %></div></td>
				
				<%if(jpgfilename.contains("S")) { %>
				<td>
<%-- 				<div align="left"><a href="#!" onclick="showPODImage('<%=jpgfilename%>');"><%=jpgfilename%></a></div> --%>
					<div align="left"><%=jpgfilename%></div>
				</td>
				<%} else {%>
				<td><div align="left"><%=jpgfilename%></div></td>
				<%} %>
				<td><div align="right"><%=  new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(snapdatetime))%></div></td>	
			   <%
			  // System.out.println("Filename---> " +jpgfilename);
			   String newjpeg="homepage11.jpg";
			  // System.out.println("newjpeg---> " +newjpeg);

			   %>
			    <td>
			    	<a href="#!" onclick="showFTPImage('<%=jpgfilename%>');"><img width="50" height="50" src="http://myfleetview.com:8080/images1/ProcessedCameraImages/<%=jpgfilename%>"/></a>        			    
			    </td>
				</tr>
			<%
			
		}
	}catch(Exception e1){
		System.out.println(e1.getMessage());
		e1.printStackTrace();
	}
	%>
</table>
</td>
</tr>
</table>
</div>
</div>
</div>
</form>
</div>
</jsp:useBean>
 <table border="0" width="100%" align="center" style="padding-bottom: 56px">
<tr><td  bgcolor="#0B2161" >
<ui><li><center><font color="white" >Copyright &copy; 2008-2015 by Transworld Technologies Ltd. All Rights Reserved.</font></center></li></ui>
</td></tr>
</table>

    </body>
</html>
