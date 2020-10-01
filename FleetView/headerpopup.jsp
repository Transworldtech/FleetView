<html>
<head>

<script src="searchhi.js" type="text/javascript"></script>
<script src="sorttable.js" type="text/javascript"></script>
<link href="css/css.css" rel="StyleSheet" type="text/css"></link> 
<link href="css/erratic.css" rel="StyleSheet" type="text/css"></link>
<script src="js/elabel.js" type="text/javascript"></script>
<script src="js/sorttable.js" type="text/javascript"></script>
<style type="text/css">@import url(jscalendar-1.0/calendar-blue.css);</style>
<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>
<script src="js/searchhi.js" type="text/javascript"></script>
<!--<link rel="stylesheet" type="text/css" href="css/cpanel_002.css"> -->
<link rel="stylesheet" type="text/css" href="css/cpanel_colors.css">
<script type="text/javascript">
function openpopup(PageName)
{
	 try{
		 //alert(e);
	 testwindow=window.open("RegisterComplaint.jsp?PageName="+PageName,"RegisterComplaint","width=730,height=400,scrollbars=yes");
	 testwindow.moveTo(200,200);
	 }catch(e)
	 {
		 alert(e);
	 }
}
</script>
<%@ include file="Connections/conn.jsp" %>
<%
Connection sessionconn=null;
Statement strno =null;
String PageName1=this.getClass().getName();
String reportno = "";
PageName1=PageName1.substring(PageName1.lastIndexOf(".")+1,PageName1.length());
System.out.println(PageName1);
PageName1=PageName1.replace("_",".");
PageName1=PageName1.replace(".005f","_");
System.out.println(PageName1);

try{
	Class.forName(MM_dbConn_DRIVER);
	sessionconn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	strno = sessionconn.createStatement();
	
	String sql = "select ReportNo from db_gps.t_reportnumber where PageName = '"+PageName1+"'";
	ResultSet rs = strno.executeQuery(sql);
	if(rs.next())
	{
		reportno = rs.getString("ReportNo");
	}
	System.out.println(reportno);
}catch(Exception e)
{
	System.out.println("******* Exception "+e);
}
finally
{
 strno.close();
 sessionconn.close();
}
%>
</head>
<body id="mainbody" >
<div align="left">
<font face="Arial" size="2">
		 <a href="#" onclick="javascript:openpopup('<%=PageName1 %>');" title="Register Complaint">Register Complaint</a>
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<font color="black"> Report No.: <%=reportno %></font>
		</font>
		</div>
		<br>
</body>
</html>