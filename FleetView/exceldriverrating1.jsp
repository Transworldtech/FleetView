<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());

String filename=session.getAttribute("user").toString()+showdatex+"driver_rating.xls";
    response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="Connections/conn.jsp" %>
<!-- code start-->
<%! 
Connection conn,conn1;
String data1,sql,sql1,data2,jcode,origin,destination,startdate;
Statement st,st1,st2,st3;
String trans;
%>
<table border="0" width="90%" bgcolor="white" align="center">
<tr><td>
<table class="stats">
<tr><th> <font size="3">Driver Rating report for the Date:  <%
java.util.Date NewDate =new java.util.Date();

long dateMillis = NewDate.getTime();
long dayInMillis = 1000 * 60 * 60 *24;
dateMillis = dateMillis - dayInMillis;
NewDate.setTime(dateMillis);

Format NewFormatter = new SimpleDateFormat("dd-MMM-yyyy");
Format NewFormatter1 = new SimpleDateFormat("yyyy-MM-dd");
data1 = NewFormatter.format(NewDate);
data2 = NewFormatter1.format(NewDate);
out.print(data1);
%> 
<div align="right">
Date : <%
Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String sdt = fmt.format(new java.util.Date());
 out.print(sdt); %></div>

</font></th></tr>
<tr>
<td>
<table border="0" width="90%" bgcolor="white" align="center">
<tr>
<td class="hed">Driver Name</td>
<td class="hed">Driver ID</td>
<td class="hed">Transporter</td>
<td class="hed">Start Date</td>
<td class="hed">Origin</td>
<td class="hed">Destination</td>
<td class="hed">OS Count</td>
<td class="hed">RA Count</td>
<td class="hed">DC Count</td>
<td class="hed">Distance</td>
<td class="hed">Rating</td>
</tr>
<%
try{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st1=conn1.createStatement();
	st2=conn1.createStatement();
	st3=conn1.createStatement();
	st=conn.createStatement();
	String GPName="",Transporter="";
	
	String RejectedBy=session.getAttribute("mainuser").toString();


	String usertypevalue=session.getAttribute("usertypevalue").toString();
	System.out.println(" User ");
	String typeofuser=session.getAttribute("TypeofUser").toString();
	String SrchTrans="";
	System.out.println(usertypevalue+" User "+typeofuser);
	if(typeofuser.equalsIgnoreCase("Group"))
	{System.out.println("IN Group ");
		sql="SELECT VehRegno FROM db_gps.t_group WHERE GPName='"+usertypevalue+"' group by VehRegno";
		System.out.println("*****8     "+sql);
		ResultSet rstGrp=st3.executeQuery(sql);
		

		SrchTrans="(";
		int k = 0;
		while(rstGrp.next())
		{
			SrchTrans=SrchTrans+"'"+rstGrp.getString("VehRegno")+"',";
			k++;
		}
		SrchTrans=SrchTrans.substring(0,SrchTrans.length()-1)+")";

	}
	else
	{
		System.out.println("IN Else ");
		SrchTrans="('"+usertypevalue+"')";	
	}
	
	
	
sql="select * from t_driver_ds where TheDate='"+data2+"' and Distance between 100 and 250 and nd<>'Yes' and Jcode <>'-' and transporter in "+SrchTrans+" order by Rating, Distance desc limit 20";
ResultSet rst=st1.executeQuery(sql);
%>
<tr><th colspan="11"><font size="3">Top 20 Drivers Distance 100-250 km.</font></th></tr>
<%
while(rst.next())
{
jcode=rst.getString("JCode");
%>
<tr>
<td class="bodyText" align="left"><div align="left" >
<%
sql1="select * from t_alljddata where DriverCode='"+rst.getString("Dcode")+"'";
ResultSet rst1=st.executeQuery(sql1);
if(rst1.next())
{
	out.print(rst1.getString("DriverName"));
}

%></div></td>
<td class="bodyText" align="right"><div align="right"><%=rst.getString("Dcode")%></div></td>
<td class="bodyText" align="left"><div align="left"><%=rst.getString("Transporter")%></div></td>
<%
if(!jcode.equals("-"))
{
sql="select * from t_startedjourney where TripId='"+jcode+"' and (TO_DAYS(CURDATE())-TO_DAYS(StartDate)) < 10";
ResultSet rs1=st.executeQuery(sql);
if(rs1.next())
{

	
	java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(rs1.getString("StartDate"));
	Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
	String showdate1 = formatter1.format(ShowDate1);
	startdate=showdate1;
	origin=rs1.getString("StartPlace");
	destination=rs1.getString("EndPlace");
}

else
{
	startdate="-";
	origin="-";
	destination="-";
}
}
%>
<td class="bodyText" align="left"><div align="left"><%=startdate%></div></td>
<td class="bodyText" align="left"><div align="left"><%=origin%></div></td>
<td class="bodyText" align="left"><div align="left"><%=destination%></div></td>

<td class="bodyText" align="right"><div align="right"><%=rst.getString("OSCount")%></div></td>
<td class="bodyText" align="right"><div align="right"><%=rst.getString("RACount")%></div></td>
<td class="bodyText" align="right"><div align="right"><%=rst.getString("RDCount")%></div></td>
<td class="bodyText" align="right"><div align="right"><%=rst.getString("Distance")%></div></td>
<td class="bodyText" align="right"><div align="right">
<%
String ss=""+rst.getDouble("Rating");

if(ss.length() > 4)
{
	out.print(ss.substring(0,4));
}
else
{
	out.print(ss);
}
%></div></td>

</tr>

<%
}
%>

<tr><th colspan="11"><font size="3">Bottom 20 Drivers Distance 100-250 km.</font></th></tr>
<%
String sql2="select * from t_driver_ds where TheDate='"+data2+"' and Distance between 100 and 250 and Jcode <>'-'  and transporter in "+SrchTrans+" order by Rating desc, Distance Asc limit 20";
ResultSet rst2=st2.executeQuery(sql2);
while(rst2.next())
{
jcode=rst2.getString("JCode");
%>
<tr>
<td class="bodyText" align="left"><div align="left">
<%
sql1="select * from t_alljddata where DriverCode='"+rst2.getString("Dcode")+"'";
ResultSet rst3=st.executeQuery(sql1);
if(rst3.next())
{
	out.print(rst3.getString("DriverName"));
}

%>
</div></td>
<td class="bodyText" align="right"><div align="right"><%=rst2.getString("Dcode")%></div></td>
<td class="bodyText" align="left"><div align="left"><%=rst2.getString("Transporter")%></div></td>

<%
if(!jcode.equals("-"))
{
sql="select * from t_startedjourney where TripId='"+jcode+"'  and (TO_DAYS(CURDATE())-TO_DAYS(StartDate)) < 10";
ResultSet rs2=st.executeQuery(sql);
if(rs2.next())
{
	java.util.Date ShowDate2 = new SimpleDateFormat("yyyy-MM-dd").parse(rs2.getString("StartDate"));
	Format formatter2 = new SimpleDateFormat("dd-MMM-yyyy");
	String showdate2 = formatter2.format(ShowDate2);
	startdate=showdate2;
	origin=rs2.getString("StartPlace");
	destination=rs2.getString("EndPlace");
}

else
{
	startdate="-";
	origin="-";
	destination="-";
}
}
%>
<td class="bodyText" align="left"><div align="left"><%=startdate%></div></td>
<td class="bodyText" align="left"><div align="left"><%=origin%></div></td>
<td class="bodyText" align="left"><div align="left"><%=destination%></div></td>


<td class="bodyText" align="right"><div align="right"><%=rst2.getString("OSCount")%></div></td>
<td class="bodyText" align="right"><div align="right"><%=rst2.getString("RACount")%></div></td>
<td class="bodyText" align="right"><div align="right"><%=rst2.getString("RDCount")%></div></td>
<td class="bodyText" align="right"><div align="right"><%=rst2.getString("Distance")%></div></td>
<td class="bodyText" align="right"><div align="right">
<%
String sss=""+rst2.getDouble("Rating");

if(sss.length() > 4)
{
	out.print(sss.substring(0,4));
}
else
{
	out.print(sss);
}
%></div></td>

</tr>

<%
}

sql="select * from t_driver_ds where TheDate='"+data2+"' and Distance > 250  and Distance < 500 and nd<>'Yes' and Jcode <>'-' and transporter in "+SrchTrans+" order by Rating, Distance desc limit 20";
ResultSet rst3=st1.executeQuery(sql);
%>
<tr><th colspan="11"><font size="3">Top 20 Drivers Distance > 250 km.</font></th></tr>
<%
while(rst3.next())
{
jcode=rst3.getString("JCode");
%>
<tr>
<td class="bodyText" align="left"><div align="left">
<%
sql1="select * from t_alljddata where DriverCode='"+rst3.getString("Dcode")+"'";
ResultSet rst4=st.executeQuery(sql1);
if(rst4.next())
{
	out.print(rst4.getString("DriverName"));
}

%>
</div></td>
<td class="bodyText" align="right"><div align="right"><%=rst3.getString("Dcode")%></div></td>
<td class="bodyText" align="left"><div align="left"><%=rst3.getString("Transporter")%></div></td>

<%
if(!jcode.equals("-"))
{
sql="select * from t_startedjourney where TripId='"+jcode+"' and (TO_DAYS(CURDATE())-TO_DAYS(StartDate)) < 10";
ResultSet rs3=st.executeQuery(sql);
if(rs3.next())
{
	java.util.Date ShowDate3 = new SimpleDateFormat("yyyy-MM-dd").parse(rs3.getString("StartDate"));
	Format formatter3 = new SimpleDateFormat("dd-MMM-yyyy");
	String showdate3 = formatter3.format(ShowDate3);
	startdate=showdate3;
	origin=rs3.getString("StartPlace");
	destination=rs3.getString("EndPlace");
}

else
{
	startdate="-";
	origin="-";
	destination="-";
}
}
%>
<td class="bodyText" align="left"><div align="left"><%=startdate%></div></td>
<td class="bodyText" align="left"><div align="left"><%=origin%></div></td>
<td class="bodyText" align="left"><div align="left"><%=destination%></div></td>


<td class="bodyText" align="right"><div align="right"><%=rst3.getString("OSCount")%></div></td>
<td class="bodyText" align="right"><div align="right"><%=rst3.getString("RACount")%></div></td>
<td class="bodyText" align="right"><div align="right"><%=rst3.getString("RDCount")%></div></td>
<td class="bodyText" align="right"><div align="right"><%=rst3.getString("Distance")%></div></td>
<td class="bodyText" align="right"><div align="right">
<%
String ssss=""+rst3.getDouble("Rating");

if(ssss.length() > 4)
{
	out.print(ssss.substring(0,4));
}
else
{
	out.print(ssss);
}
%></div></td>

</tr>
<%
}

%>
<tr><th colspan="11"><font size="3">Bottom 20 Drivers Distance > 250 km.</font></th></tr>
<%
sql="select * from t_driver_ds where TheDate='"+data2+"' and Distance > 250 and Distance < 500  and Jcode <>'-' and transporter in "+SrchTrans+"  order by Rating desc, Distance Asc limit 20";

ResultSet rst5=st1.executeQuery(sql);
while(rst5.next())
{
jcode=rst5.getString("JCode");
%>
<tr>
<td class="bodyText" align="left"><div align="left">
<%
sql1="select * from t_alljddata where DriverCode='"+rst5.getString("Dcode")+"'";
ResultSet rst6=st.executeQuery(sql1);
if(rst6.next())
{
	out.print(rst6.getString("DriverName"));
}

%>
</div></td>
<td class="bodyText" align="right"><div align="right"><%=rst5.getString("Dcode")%></div></td>
<td class="bodyText" align="left"><div align="left"><%=rst5.getString("Transporter")%></div></td>

<%
if(!jcode.equals("-"))
{
sql="select * from t_startedjourney where TripId='"+jcode+"' and (TO_DAYS(CURDATE())-TO_DAYS(StartDate)) < 10";
ResultSet rs4=st.executeQuery(sql);
if(rs4.next())
{
	java.util.Date ShowDate4 = new SimpleDateFormat("yyyy-MM-dd").parse(rs4.getString("StartDate"));
	Format formatter4 = new SimpleDateFormat("dd-MMM-yyyy");
	String showdate4 = formatter4.format(ShowDate4);
	startdate=showdate4;
	origin=rs4.getString("StartPlace");
	destination=rs4.getString("EndPlace");
}

else
{
	startdate="-";
	origin="-";
	destination="-";
}
}
%>
<td class="bodyText" align="left"><div align="left"><%=startdate%></div></td>
<td class="bodyText" align="left"><div align="left"><%=origin%></div></td>
<td class="bodyText" align="left"><div align="left"><%=destination%></div></td>


<td class="bodyText" align="right"><div align="right"><%=rst5.getString("OSCount")%></div></td>
<td class="bodyText" align="right"><div align="right"><%=rst5.getString("RACount")%></div></td>
<td class="bodyText" align="right"><div align="right"><%=rst5.getString("RDCount")%></div></td>
<td class="bodyText" align="right"><div align="right"><%=rst5.getString("Distance")%></div></td>
<td class="bodyText" align="right"><div align="right">
<%
String sssss=""+rst5.getDouble("Rating");

if(sssss.length() > 4)
{
	out.print(sssss.substring(0,4));
}
else
{
	out.print(sssss);
}
%>
</div></td>
</tr>
<%
}

}catch(Exception e)
{
	out.print("Exception "+e);
}
finally
{
	conn.close();
	conn1.close();
}


%>



</table>
</td>

</tr>
<tr><td align="center"><input type="button" name="Print" Value="Print" class="formElement" onclick="javascript:window.print();"></td></tr>
</table>


</td></tr>
</table>
