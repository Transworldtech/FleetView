<%@ include file="headerpopup.jsp"%>

<%@page import="java.util.Date"%>


<%!
Connection con;
%>
<html>
<head>
</head>
<body>
<script>
function showFTPImage(imageName)
{	
	var url="cameraFtpImage.jsp?imageName=" +imageName;
	testwindow1 = window.open(url,"Image", "width=500,height=500");
    testwindow1.moveTo(250,100);
}

function hidetitle()
{
	
}
</script>
<%
try
{
	// MM_dbConn_DRIVER="org.gjt.mm.mysql.Driver";
	// MM_dbConn_USERNAME="java";
//	MM_dbConn_PASSWORD="transjava!1";
 //MM_dbConn_STRING="jdbc:mysql://182.18.129.62/db_gps";
Class.forName(MM_dbConn_DRIVER); 
	con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement s = con.createStatement();
	Statement s1 = con.createStatement();
	Statement s2 = con.createStatement();
	Statement s3 = con.createStatement();	
	String datetime = request.getParameter("DateTime");
	String vehid = request.getParameter("vehid");
	String serverid="",usernm="",passwd="";	
	//datetime = "2013-04-08 17:43:57";
	//vehid = "6469";
	String plus1hr = "",minus10sec = "";
	String sql = "select AddTime('"+datetime+"','01:00:00') as plus1hr";
	ResultSet rs = s.executeQuery(sql);
	if(rs.next())
	{
		plus1hr = rs.getString("plus1hr");
	}
	
	sql = "select SubTime('"+datetime+"','10') as minus10sec";
	 rs = s.executeQuery(sql);
	if(rs.next())
	{
		minus10sec = rs.getString("minus10sec");
	}
	
	System.out.println("plus10sec   "+plus1hr);
	System.out.println("minus10sec   "+minus10sec);
	/*String sqlftp="select * from db_leaveapplication.t_ftpconnection";
	ResultSet rsftp=s1.executeQuery(sqlftp);
	if(rsftp.next())
	{
	serverid=rsftp.getString("ServerID");
	usernm=rsftp.getString("Username");
	passwd=rsftp.getString("Password");
	}*/
	
	
    sql = "select * from db_gps.t_jpgsnap where rawfiledatetime >= '"+datetime+"' and rawfiledatetime <= '"+plus1hr+"' and vehid = '"+vehid+"' ";
	rs = s.executeQuery(sql);
	System.out.println("sql ---->    "+sql);
	%>
	<table border="0" style="width: 80%;" align="center" >
<tr>

<td align="center" id="title"><font size="3" face = "Arial"><b> Battery Theft Images at <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(datetime)) %></b></font>
</td>
</tr>
</table>

	<table style="width: 80%;" align="center" ><tr>
	<%
	int rwCnt=0;
	while(rs.next())
	{
		rwCnt++;
		String w=rs.getString("jpgfilename").trim();
		%>
		<td align="center"><br></br><b>
<!--		<a href="#" onclick="showFTPImage('< %=w%>');">-->
<!--		<object data="ftp://dota:ku45ma23@ftp.mobileeye.in/processed_images/< %=rs.getString("jpgfilename")%>" height="200" width="200" ><embed src="ftp://dota:ku45ma23@ftp.mobileeye.in/processed_images/< %=rs.getString("jpgfilename")%>">-->
<!--		</embed>-->
<!--		</object>-->
<img src="ftp://dota:ku45ma23@ftp.mobileeye.in/processed_images/<%=w%>" height="200" width="250"></img> 
		<br><%=rs.getString("jpgfilename")%>
<!--		</a>-->
		</b></td>
		<%
		if(rwCnt%2==0)
    	{
    		%>
    		</tr>
    		<%
    	}
	}
	
%>

</table>
<%
if(rwCnt == 0)
{
	%>
	<script>
	document.getElementById("title").style.display = "none";
//hidetitle();
	</script>
<table style="width: 500px;" align="center" border="0"><tr>
<td align="center"><font size="3"><b>No Images Available at <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(datetime)) %></b></font></td>
</tr>
</table>
	<%
}

}
catch(Exception e)
{
	e.printStackTrace();
	System.out.println("Exception---------->     "+e);
}

%>
</body>