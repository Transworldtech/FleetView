<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<%@page import="java.util.Date"%>
<%@page import="java.sql.*"%>

<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());
int cnt= 0;
String filename="";
cnt = filename.indexOf(' ');
if(cnt>1)
{
	filename = filename.substring(0,cnt)+"_DriverIncentiveForPrimaryAndSecondaryReport.xls";
	filename=filename.replace(" ","_");
}
else
{
	filename =session.getAttribute("user").toString()+"_DriverIncentiveForPrimaryAndSecondaryReport.xls";
	filename=filename.replace(" ","_");
}
//String filename=session.getAttribute("user").toString()+"_detail_report.xls";
System.out.println("Filename"+filename);
response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="Connections/conn.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<%!
Connection con=null;
Statement st=null;
Statement st1=null;
Statement st2=null;
%>
<%
String Mon=request.getParameter("data1");
String Yer=request.getParameter("data2");
String Mon1=request.getParameter("data3");
String Yer1=request.getParameter("data4");
String user=session.getAttribute("user").toString();
String usertypevalue=session.getAttribute("usertypevalue").toString();
String QueryDate=Yer+"-"+Mon+"-01";
String QueryDate1 =Yer1+"-"+Mon1+"-01";
try
{
System.out.println("*********     hfgsbhdvfdsm");
Class.forName(MM_dbConn_DRIVER);
con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=con.createStatement();
st1=con.createStatement();
st2=con.createStatement();	
%>

	<table border="1" width="100%" align="center">
	<tr>
<td align="center" colspan="11" ><font size="3"><b>Driver Incentive Report For Primary And Secondary Trips From  <%=new SimpleDateFormat("MMM-yyyy").format(new SimpleDateFormat("MM-yyyy").parse(Mon+"-"+Yer))  %>  To <%=new SimpleDateFormat("MMM-yyyy").format(new SimpleDateFormat("MM-yyyy").parse(Mon1+"-"+Yer1))  %></b></font></td>
</tr>
<tr>
<td align="left" colspan="11">
       <br>
       <font size="2" color="black" face="Arial"><b> Disclaimer : The Calculated Amount may change if there is a change in the status or count of Violation</b></font>
       </td>
</tr>
</table>
<table class="sortable" width="100%" align="center" border="1">
<tr>
<th style="width: 10px">Sr No</th>
<th style="width: 50px">Driver Id</th>
<th style="width: 160px">Driver Name</th>
<th style="width: 160px">Transporter </th>
<th style="width: 25px">Total Trips</th>
<th style="width: 40px">Total Km</th>
<!--<th>Trips Point</th>-->
<th style="width: 25px">Trips with Zero DVI</th>
<!--<th>Primary / Secondary Trips</th>-->

<!--<th>Primary / Secondary Rate</th>-->
<th style="width: 60px">Km Category</th>
<th style="width: 40px">Actual Incentive</th>
<th style="width: 40px">Entitled Price</th>
<th style="width: 50px">Month</th>

</tr>
<%
String sql = "";
if(usertypevalue.equalsIgnoreCase("ALL") || usertypevalue.equals("Castrol"))
{
 	sql="select * from db_gps.t_driverincentivedetails where tankertrips=0 and formonth>='"+QueryDate+"'  and formonth <= '"+QueryDate1+"' ORDER BY finalIncentive DESC,driverid ";
}
else
{
 	sql="select * from db_gps.t_driverincentivedetails where tankertrips=0 and formonth>='"+QueryDate+"'  and formonth <= '"+QueryDate1+"'  and transporter = '"+usertypevalue+"' ORDER BY finalIncentive DESC,driverid ";
}
System.out.println("sql  "+sql);
ResultSet rs= st.executeQuery(sql);


int i=1;
while(rs.next())
{
    String kmCategory = "";
    String sql1 = "select KmsCategory from db_gps.t_DriverIncentive WHERE MinValue<='"+rs.getString("totaldist")+"' AND MaxValue>='"+rs.getString("totaldist")+"' AND `ScoreCategory`='MaxIncentiveKM' AND GPName='Castrol'";
    ResultSet rs1 = st2.executeQuery(sql1);
    if(rs1.next())
    {
    	kmCategory = rs1.getString("KmsCategory");
    }
    
%>
<tr>   
<td style="text-align: right;" align="right"><%=i++ %></td>
<td style="text-align: right;" align="right" ><%=rs.getString("driverid") %></td>
<td style="text-align: left;" align="left" ><%=rs.getString("drivername") %></td>
<td style="text-align: left;" align="left"><%=rs.getString("transporter") %></td>
<td style="text-align: right;" align="right"><%=rs.getString("totaltrips") %></td>
<td style="text-align: right;" align="right"><%=rs.getString("totaldist") %></td>
<!--<td style="text-align: right:" align="right">< %=rs.getString("tripsPoint") %></td>-->
<td style="text-align: right;" align="right"><%=rs.getString("tripswithzerodvi") %></td>
<!--<td style="text-align: right:" align="right">< %=rs.getString("primarytrips") %></td>-->
<!--<td style="text-align: right:" align="right">< %=rs.getString("primaryrate") %></td>	-->
<!--<td style="text-align: right:" align="right">< %=rs.getString("totalincentive") %></td>-->
<td style="text-align: center;" align="center"><%=kmCategory %></td>
<td style="text-align: right;" align="right"><%=rs.getString("totalincentive") %></td>
<td style="text-align: right;" align="right"><%=rs.getString("finalIncentive") %></td>
<td style="text-align: center;" align="center"><% if(rs.getString("formonth")==null || rs.getString("formonth").equalsIgnoreCase("null"))
			{
	out.print("-");
			} 
else{out.print(new SimpleDateFormat("MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("formonth"))));} %></td>
</tr>
<%}
%>
</table>
	<%
}
catch(Exception e)
{
	//out.print("Exception "+e);
	e.printStackTrace();
}
finally
{
	try
	{
		con.close();
	}catch(Exception e)
	{e.printStackTrace();}
	try
	{
		fleetview.closeConnection();
	}catch(Exception e)
	{e.printStackTrace();}
}
%>
</jsp:useBean>