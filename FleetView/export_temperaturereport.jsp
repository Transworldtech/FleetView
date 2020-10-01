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
	filename = filename.substring(0,cnt)+"_detail_report.xls";
	filename=filename.replace(" ","_");
}
else
{
	filename =session.getAttribute("user").toString()+"_detail_report.xls";
	filename=filename.replace(" ","_");
}
//String filename=session.getAttribute("user").toString()+"_detail_report.xls";
System.out.println("Filename"+filename);
response.addHeader("Content-Disposition", "attachment;filename="+filename);

   // response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="Connections/conn.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>	

<%!
String VehicleCode, fromdate, todate, desc,vehregno,fromtime,totime,ftime1,ftime2,ttime1,ttime2;
String datenew1,datenew2;
Connection conn;
Statement st,sttemp;
String sql;

%>
<%
String targetvalue1=session.getAttribute("usertypevaluemain").toString();
String dateformat="dd-MMM-yyyy";
dateformat=session.getAttribute("dateformat").toString();
ArrayList<String> target1=(ArrayList<String>)session.getAttribute("TargetList");
String empnamee="";

VehicleCode=request.getParameter("vehcode");
datenew1=request.getParameter("data");
datenew2=request.getParameter("data1");
fromtime=request.getParameter("fromtime");
totime=request.getParameter("totime");
/*System.out.println("datenew1"+datenew1);
System.out.println("datenew2"+datenew2);
System.out.println("fromtime"+fromtime);
System.out.println("totime"+totime);*/
try{
	conn = fleetview.ReturnConnection();
	st=conn.createStatement();
	sttemp=conn.createStatement();
	sql="select * from t_vehicledetails where VehicleCode='"+VehicleCode+"'";
	ResultSet rst=st.executeQuery(sql);
	if(rst.next())
	{
		vehregno=rst.getString("VehicleRegNumber");
		if(target1.contains(targetvalue1))
		{
			empnamee=rst.getString("EmpName");
		}
	}
	%>
<table border="0" width="100%" bgcolor="white">  
<tr align="center">
<td>
<div align="left"><font size="3">Report No:1.12</font></div>
 <font size="3"><div ><b>Temperature Detail Report<b></div></font></center>
<div class="bodyText" align="right">
</div>
</td>
</tr>
<tr><td>
<%

//if(!(null==request.getParameter("data")))
//{
/* all code comes here */
%>
<table border="0" width="100%" bgcolor="white">
<tr align="center" >
<td colspan="9"><div align="left"><font size="3">
<b> Temperature Report for Vehicle <%=vehregno%> from <%=datenew1 %> <%=fromtime%> to <%=datenew2%> <%=totime%></b>
</font>
</div>
<div class="bodyText" align="left">
&nbsp;&nbsp;&nbsp;<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())%>
</td></tr>
</table>
<table width="100%" align="center" class="sortable" border="1">
<tr>
<th>Sr.</th>
<th>Date-Time</th>
<th>Speed</th>
<th>Distance</th>
<th align="left">Location</th>
<%
String sqlchecksensorveh="select Vehiclecode from t_vehicledetails where Description='TEMPSENSOR' and vehiclecode='"+VehicleCode+"'";
ResultSet rsttemp=sttemp.executeQuery(sqlchecksensorveh);
if(rsttemp.next())
{
	%>
	<th>Sen1</th>
	<th>Sen2</th>
	<th>Sen3</th>
	<th>Sen4</th>
	<% 
}
%>
</tr>
<%

String sqlnew="select * from t_veh"+VehicleCode+" where TheFieldDataDateTime <='"+datenew1+" "+fromtime+"'  and TheFiledTextFileName in ('SI','OF','ON','ST','SP')  order by TheFieldDataDateTime desc limit 1";
ResultSet rstnew=st.executeQuery(sqlnew);
if(rstnew.next())
{
	datenew1=rstnew.getString("TheFieldDataDate");
	fromtime=rstnew.getString("TheFieldDataTime");
	//System.out.println("fromdate---->"+fromdate+"fromtime-->"+fromtime);
	
}

sql="select * from t_veh"+VehicleCode+" where TheFieldDataDateTime >='"+datenew1+" "+fromtime+"' and TheFieldDataDateTime <='"+datenew2+" "+totime+"' and TheFiledTextFileName in ('SI','OF','ON','ST','SP') order by TheFieldDataDateTime asc";
//System.out.println("sql"+sql);

ResultSet rst1=st.executeQuery(sql);
int i=1;
int x=0;
int dist=0;
int interval1=0;
interval1=Integer.parseInt(request.getParameter("interval"));
String chbx=request.getParameter("chbx");
System.out.println("in excel ^^^^^^^^^^  "+chbx);
java.util.Date date1=new java.util.Date();
java.util.Date date2=new java.util.Date();
long millis=0;
long millis1=0;
long millis2=0;
boolean flag=true;

if(rst1.first())
{
	if(i==1)
	{
		dist=rst1.getInt("Distance");
		//System.out.println("dist::>>"+dist);
	}
	flag=true;
	date1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst1.getString("TheFieldDataDateTime"));
	System.out.println("&&&&&&&&&&&   "+chbx);
	if(chbx.equals("null")||chbx.equals(" "))
	{
		System.out.println("&&&&&&&&&&&   is null ");
%>
	<tr>
		<td class="bodyText" align="right"><div align="right"><%=i%></div></td>
		<td class="bodyText" align="left"><div align="right"><%=new SimpleDateFormat(dateformat).format(rst1.getDate("TheFieldDataDate"))%> <%=rst1.getString("TheFieldDataTime")%></div></td>
		<td class="bodyText" align="right"><div align="right">&nbsp;&nbsp;<%=rst1.getInt("Speed")%></div></td>
	<%if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
	{
		 %>
		<td class="bodyText" align="right"><div align="right"><%=(int)fleetview.KM_TO_MILES1(rst1.getInt("Distance")-dist)%></div></td>
		
		<%
	}else
	{
		%>
		<td class="bodyText" align="right"><div align="right"><%=rst1.getInt("Distance")-dist%></div></td>
		
		<%
	}
	
	if(target1.contains(targetvalue1))
				{
						String d1=empnamee+"<br>"+rst1.getString("TheFieldSubject");
						%>
						<td class="bodyText" align="left"><%=rst1.getString("TheFieldSubject")%></td>
						
					<%
				}
				else
				{
					%>
		<td class="bodyText" align="left"><%=rst1.getString("TheFieldSubject")%></td>
		<%
				}
		
String sqlchecksensorveh1="select Vehiclecode from t_vehicledetails where Description='TEMPSENSOR' and vehiclecode='"+VehicleCode+"'";
ResultSet rsttemp1=sttemp.executeQuery(sqlchecksensorveh1);
if(rsttemp1.next())
{
	
	if(rst1.getString("Sen1").length()< 2 && !(rst1.getString("Sen1").equals("0")))
	{
		%>
		<td class="bodyText" align="right"><div align="right">xxxx</div></td>
		<%		
	}
	else
	{
	%>
	<td class="bodyText" align="right"><div align="right"><%=rst1.getString("Sen1")%></div></td>
	<%
	}
	if(rst1.getString("Sen2").length()< 2 && !(rst1.getString("Sen2").equals("0")))
	{
		%>
		<td class="bodyText" align="right"><div align="right">xxxx</div></td>
		<%		
	}
	else
	{
	%>
	<td class="bodyText" align="right"><div align="right"><%=rst1.getString("Sen2")%></div></td>
	<%
	}
	if(rst1.getString("Sen3").length()< 2 && !(rst1.getString("Sen3").equals("0")))
	{
		%>
		<td class="bodyText" align="right"><div align="right">xxxx</div></td>
		<%		
	}
	else
	{
	%>
	<td class="bodyText" align="right"><div align="right"><%=rst1.getString("Sen3")%></div></td>
	<%
	}
	if(rst1.getString("Sen4").length()< 2 && !(rst1.getString("Sen1").equals("0")))
	{
		%>
		<td class="bodyText" align="right"><div align="right">xxxx</div></td>
		<%		
	}
	else
	{
	%>
	<td class="bodyText" align="right"><div align="right"><%=rst1.getString("Sen4")%></div></td>
	<%
	}
	%>
	<% 
}
%>
	</tr>
<%
i++;
	}
}

while(rst1.next())
{
	//if(i==1)
	//{
	//	dist=rst1.getInt("Distance");
		//System.out.println("dist::>>"+dist);
	//}
	if(rst1.getString("TheFiledTextFileName").equals("SI")  || rst1.getString("TheFiledTextFileName").equals("ST") || rst1.getString("TheFiledTextFileName").equals("SP"))
	{
		
		if(rst1.getInt("Speed")==0)
		{
			
			if(flag)
			{
				//System.out.println("HIIIIIIIII");
				date1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst1.getString("TheFieldDataDate")+" "+rst1.getString("TheFieldDataTime"));
				flag=false;
				x=1;
				%>
				<tr >
					<td class="bodyText" align="right"><div align="right"><%=i%></div></td>
					<td class="bodyText" align="left"><div align="right"><%=new SimpleDateFormat(dateformat).format(rst1.getDate("TheFieldDataDate"))%>  <%=" "+rst1.getString("TheFieldDataTime")%></div></td>
					<td class="bodyText" align="right"><div align="right">&nbsp;&nbsp;<%="Stop"%></div></td>
				<%if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
	{
		 %>
		<td class="bodyText" align="right"><div align="right"><%=(int)fleetview.KM_TO_MILES1(rst1.getInt("Distance")-dist)%></div></td>
		
		<%
	}else
	{
		%>
		<td class="bodyText" align="right"><div align="right"><%=rst1.getInt("Distance")-dist%></div></td>
		
		<%
	}
					
					if(target1.contains(targetvalue1))
					{
						String d1=empnamee+"<br>"+rst1.getString("TheFieldSubject");
						%>
						<td class="bodyText" align="left"><%=rst1.getString("TheFieldSubject")%></td>
						<%
					}
					else
					{
					%>
					<td class="bodyText" align="left"><%=rst1.getString("TheFieldSubject")%></td>
					<%
					}
					%>
					<%
			String sqlchecksensorveh1="select Vehiclecode from t_vehicledetails where Description='TEMPSENSOR' and vehiclecode='"+VehicleCode+"'";
			ResultSet rsttemp1=sttemp.executeQuery(sqlchecksensorveh1);
			if(rsttemp1.next())
			{
				
				if(rst1.getString("Sen1").length()< 2 && !(rst1.getString("Sen1").equals("0")))
				{
					%>
					<td class="bodyText" align="right"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td class="bodyText" align="right"><div align="right"><%=rst1.getString("Sen1")%></div></td>
				<%
				}
				if(rst1.getString("Sen2").length()< 2 && !(rst1.getString("Sen2").equals("0")))
				{
					%>
					<td class="bodyText" align="right"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td class="bodyText" align="right"><div align="right"><%=rst1.getString("Sen2")%></div></td>
				<%
				}
				if(rst1.getString("Sen3").length()< 2 && !(rst1.getString("Sen3").equals("0")))
				{
					%>
					<td class="bodyText" align="right"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td class="bodyText" align="right"><div align="right"><%=rst1.getString("Sen3")%></div></td>
				<%
				}
				if(rst1.getString("Sen4").length()< 2 && !(rst1.getString("Sen1").equals("0")))
				{
					%>
					<td class="bodyText" align="right"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td class="bodyText" align="right"><div align="right"><%=rst1.getString("Sen4")%></div></td>
				<%
				}
				 
}
											
	%>
					
				</tr>
				<%
				i++;
			}
		}
		else if(rst1.getInt("Speed")>0 && x==1)
			{
				flag=true;
				date1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst1.getString("TheFieldDataDate")+" "+rst1.getString("TheFieldDataTime"));
				%>
				<tr>
					<td class="bodyText" align="right"><div align="right"><%=i%></div></td>
					<td class="bodyText" align="left"><div align="right"><%=new SimpleDateFormat(dateformat).format(rst1.getDate("TheFieldDataDate"))%>  <%=" "+rst1.getString("TheFieldDataTime")%></div></td>
					<td class="bodyText" align="right"><div align="right">&nbsp;&nbsp;<%="Start"%></div></td>
					<%if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
	{
		 %>
		<td class="bodyText" align="right"><div align="right"><%=(int)fleetview.KM_TO_MILES1(rst1.getInt("Distance")-dist)%></div></td>
		
		<%
	}else
	{
		%>
		<td class="bodyText" align="right"><div align="right"><%=rst1.getInt("Distance")-dist%></div></td>
		
		<%
	}
					if(target1.contains(targetvalue1))
					{
						String d1=empnamee+"<br>"+rst1.getString("TheFieldSubject");
						%>
						<td class="bodyText" align="left"><%=rst1.getString("TheFieldSubject")%></td>
						<%
					}
					else
					{
					%>
					<td class="bodyText" align="left"><%=rst1.getString("TheFieldSubject")%></td>
					<%
					}
					%>
					<%
			String sqlchecksensorveh1="select Vehiclecode from t_vehicledetails where Description='TEMPSENSOR' and vehiclecode='"+VehicleCode+"'";
			ResultSet rsttemp1=sttemp.executeQuery(sqlchecksensorveh1);
			if(rsttemp1.next())
			{
				
				if(rst1.getString("Sen1").length()< 2 && !(rst1.getString("Sen1").equals("0")))
				{
					%>
					<td class="bodyText" align="right"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td class="bodyText" align="right"><div align="right"><%=rst1.getString("Sen1")%></div></td>
				<%
				}
				if(rst1.getString("Sen2").length()< 2 && !(rst1.getString("Sen2").equals("0")))
				{
					%>
					<td class="bodyText" align="right"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td class="bodyText" align="right"><div align="right"><%=rst1.getString("Sen2")%></div></td>
				<%
				}
				if(rst1.getString("Sen3").length()< 2 && !(rst1.getString("Sen3").equals("0")))
				{
					%>
					<td class="bodyText" align="right"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td class="bodyText" align="right"><div align="right"><%=rst1.getString("Sen3")%></div></td>
				<%
				}
				if(rst1.getString("Sen4").length()< 2 && !(rst1.getString("Sen1").equals("0")))
				{
					%>
					<td class="bodyText" align="right"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td class="bodyText" align="right"><div align="right"><%=rst1.getString("Sen4")%></div></td>
				<%
				}
				%>
				<% 
}
											
	%>
				</tr>
				<%
				i++;
				x++;
		
			
			flag=true;	
			if(chbx.equals("null")||chbx.equals(" "))
			{
			%>
			<tr>
				<td class="bodyText" align="right"><div align="right"><%=i%></div></td>
				<td class="bodyText" align="left"><div align="right"><%=new SimpleDateFormat(dateformat).format(rst1.getDate("TheFieldDataDate"))%>  <%=" "+rst1.getString("TheFieldDataTime")%></div></td>
				<td class="bodyText" align="right"><div align="right">&nbsp;&nbsp;<%=rst1.getInt("Speed")%></div></td>
				
				<%if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
	{
		 %>
		<td class="bodyText" align="right"><div align="right"><%=(int)fleetview.KM_TO_MILES1(rst1.getInt("Distance")-dist)%></div></td>
		
		<%
	}else
	{
		%>
		<td class="bodyText" align="right"><div align="right"><%=rst1.getInt("Distance")-dist%></div></td>
		
		<%
	}
					if(target1.contains(targetvalue1))
					{
						String d1=empnamee+"<br>"+rst1.getString("TheFieldSubject");
						%>
						<td class="bodyText" align="left"><%=rst1.getString("TheFieldSubject")%></td>
						<%
					}
					else
					{
					%>
				
				<td class="bodyText" align="left"><%=rst1.getString("TheFieldSubject")%></td>
				<%
					}
				%>
				<%
			 sqlchecksensorveh1="select Vehiclecode from t_vehicledetails where Description='TEMPSENSOR' and vehiclecode='"+VehicleCode+"'";
			 rsttemp1=sttemp.executeQuery(sqlchecksensorveh1);
			if(rsttemp1.next())
			{
				
				if(rst1.getString("Sen1").length()< 2 && !(rst1.getString("Sen1").equals("0")))
				{
					%>
					<td class="bodyText" align="right"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td class="bodyText" align="right"><div align="right"><%=rst1.getString("Sen1")%></div></td>
				<%
				}
				if(rst1.getString("Sen2").length()< 2 && !(rst1.getString("Sen2").equals("0")))
				{
					%>
					<td class="bodyText" align="right"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td class="bodyText" align="right"><div align="right"><%=rst1.getString("Sen2")%></div></td>
				<%
				}
				if(rst1.getString("Sen3").length()< 2 && !(rst1.getString("Sen3").equals("0")))
				{
					%>
					<td class="bodyText" align="right"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td class="bodyText" align="right"><div align="right"><%=rst1.getString("Sen3")%></div></td>
				<%
				}
				if(rst1.getString("Sen4").length()< 2 && !(rst1.getString("Sen1").equals("0")))
				{
					%>
					<td class="bodyText" align="right"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td class="bodyText" align="right"><div align="right"><%=rst1.getString("Sen4")%></div></td>
				<%
				}
				%>
				<% 
}
											
	%>
			</tr>
			<%
			i++;
			}
			}
		else
		{
			if(chbx.equals("null")||chbx.equals(" "))
			{
			flag=true;
			date2=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst1.getString("TheFieldDataDate")+" "+rst1.getString("TheFieldDataTime"));
			millis=date1.getTime();
			millis1=date2.getTime();
		    millis2=millis1-millis;
		    millis2=millis2/1000/60;
			
			 if(millis2>=interval1)
			    {
				 System.out.println("\nSI********************** "+date1+" $$$$$$$$ "+date2);
					System.out.println("********************** "+millis2+" $$$$$$$$ "+i);
			    	date1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst1.getString("TheFieldDataDate")+" "+rst1.getString("TheFieldDataTime"));
		          System.out.println("&&&&&&&&&&&& "+date1);
			    	%>
			<tr>
				<td class="bodyText" align="right"><div align="right"><%=i%></div></td>
				<td class="bodyText" align="left"><div align="right"><%=new SimpleDateFormat(dateformat).format(rst1.getDate("TheFieldDataDate"))%>  <%=" "+rst1.getString("TheFieldDataTime")%></div></td>
				<td class="bodyText" align="right"><div align="right">&nbsp;&nbsp;<%=rst1.getInt("Speed")%></div></td>
				
				<%if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
	{
		 %>
		<td class="bodyText" align="right"><div align="right"><%=(int)fleetview.KM_TO_MILES1(rst1.getInt("Distance")-dist)%></div></td>
		
		<%
	}else
	{
		%>
		<td class="bodyText"  align="right"><div align="right"><%=rst1.getInt("Distance")-dist%></div></td>
		
		<%
	}
		
					if(target1.contains(targetvalue1))
					{
						String d1=empnamee+"<br>"+rst1.getString("TheFieldSubject");
						%>
						<td class="bodyText" align="left"><%=rst1.getString("TheFieldSubject")%></td>
						<%
					}
					else
					{
					%>
				
				<td class="bodyText" align="left"><%=rst1.getString("TheFieldSubject")%></td>
				<%
					}
			
				%>
				<%
			String sqlchecksensorveh1="select Vehiclecode from t_vehicledetails where Description='TEMPSENSOR' and vehiclecode='"+VehicleCode+"'";
			ResultSet rsttemp1=sttemp.executeQuery(sqlchecksensorveh1);
			if(rsttemp1.next())
			{
				
				if(rst1.getString("Sen1").length()< 2 && !(rst1.getString("Sen1").equals("0")))
				{
					%>
					<td class="bodyText" align="right"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td class="bodyText" align="right"><div align="right"><%=rst1.getString("Sen1")%></div></td>
				<%
				}
				if(rst1.getString("Sen2").length()< 2 && !(rst1.getString("Sen2").equals("0")))
				{
					%>
					<td class="bodyText" align="right"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td class="bodyText" align="right"><div align="right"><%=rst1.getString("Sen2")%></div></td>
				<%
				}
				if(rst1.getString("Sen3").length()< 2 && !(rst1.getString("Sen3").equals("0")))
				{
					%>
					<td class="bodyText" align="right"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td class="bodyText" align="right"><div align="right"><%=rst1.getString("Sen3")%></div></td>
				<%
				}
				if(rst1.getString("Sen4").length()< 2 && !(rst1.getString("Sen1").equals("0")))
				{
					%>
					<td class="bodyText" align="right"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td class="bodyText" align="right"><div align="right"><%=rst1.getString("Sen4")%></div></td>
				<%
				}
				%>
				<% 
}
			i++;
			    }
											
	%>
			</tr>
			<%
			
			}
		}
	}//ens of SI check
	else
    {
		if(rst1.getString("TheFiledTextFileName").equals("OF"))
		{
			date2=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst1.getString("TheFieldDataDate")+" "+rst1.getString("TheFieldDataTime"));
			millis=date1.getTime();
			millis1=date2.getTime();
		    millis2=millis1-millis;
		    millis2=millis2/1000/60;
		
			 if(millis2>=interval1)
			    {
			String long1,long2,long3,lat1,lat2,lat3,loc1,loc2,loc3;
			int ds1,ds2,ds3;
			java.util.Date dt1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst1.getString("TheFieldDataDate")+" "+rst1.getString("TheFieldDataTime"));
			loc1=rst1.getString("TheFieldSubject");
			lat1=rst1.getString("LatinDec");
			long1=rst1.getString("LonginDec");
			ds1=rst1.getInt("Distance");
			String speedof = rst1.getString("Speed");
			if(rst1.next())
			{
				if(rst1.getString("TheFiledTextFileName").equals("ON")||rst1.getString("TheFiledTextFileName").equals("SI") || rst1.getString("TheFiledTextFileName").equals("ST") || rst1.getString("TheFiledTextFileName").equals("SP"))
				{
					if(rst1.getString("TheFiledTextFileName").equals("SI") || rst1.getString("TheFiledTextFileName").equals("ST") || rst1.getString("TheFiledTextFileName").equals("SP"))
					{
						if(chbx.equals("null")||chbx.equals(" "))
						{
						java.util.Date dt2=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst1.getString("TheFieldDataDate")+" "+rst1.getString("TheFieldDataTime"));
						loc2=rst1.getString("TheFieldSubject");
						lat2=rst1.getString("LatinDec");
						long2=rst1.getString("LonginDec");
						ds2=rst1.getInt("Distance");
						String speedsi = rst1.getString("Speed");
						long hrs=00,mins=00;
						long mils1=dt1.getTime();
						long mils2=dt2.getTime();
						long mils3=mils2-mils1;
						mils3=mils3/1000/60;
						//flag=true;
						if(mils3 > 20)
						{
							date1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst1.getString("TheFieldDataDate")+" "+rst1.getString("TheFieldDataTime"));
							%>
							<tr>
						<td class="bodyText" align="right"><div align="right"><%=i%></div></td>
						<td class="bodyText" align="left"><div align="right"><%=new SimpleDateFormat(dateformat+" HH:mm:ss").format(dt1)%></div></td>
						<%
					/*	if(mils3>=60)
						{
							hrs=mils3/60;
							mins=mils3%60;*/
							%>
							<td class="bodyText" align="right"><div align="right">&nbsp;&nbsp;<%=speedof%></div></td>
							<%								
					/*	}
						
						else
						{*/
							
							%>
						<%
						//}
						if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
						{
						 %>
						
						<td class="bodyText" align="right"><div align="right"><%=(int)fleetview.KM_TO_MILES1(ds1-dist)%></div></td>
						<% }
						else
						{
							%>
							<td class="bodyText"><div align="right"><%=ds1-dist%></div></td>
							<%
						}
							if(target1.contains(targetvalue1))
							{
						String d1=empnamee+"<br>"+rst1.getString("TheFieldSubject");
						%>
						<td class="bodyText" align="left"><%=loc1%></td>
						<%
							
						}
						else
							{
							%>
							<td class="bodyText" align="left"><%=loc1%></td>
							<%
							}
							%>
							<%
			String sqlchecksensorveh1="select Vehiclecode from t_vehicledetails where Description='TEMPSENSOR' and vehiclecode='"+VehicleCode+"'";
			ResultSet rsttemp1=sttemp.executeQuery(sqlchecksensorveh1);
			if(rsttemp1.next())
			{
				
				if(rst1.getString("Sen1").length()< 2 && !(rst1.getString("Sen1").equals("0")))
				{
					%>
					<td class="bodyText" align="right"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td class="bodyText" align="right"><div align="right"><%=rst1.getString("Sen1")%></div></td>
				<%
				}
				if(rst1.getString("Sen2").length()< 2 && !(rst1.getString("Sen2").equals("0")))
				{
					%>
					<td class="bodyText" align="right"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td class="bodyText" align="right"><div align="right"><%=rst1.getString("Sen2")%></div></td>
				<%
				}
				if(rst1.getString("Sen3").length()< 2 && !(rst1.getString("Sen3").equals("0")))
				{
					%>
					<td class="bodyText" align="right"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td class="bodyText" align="right"><div align="right"><%=rst1.getString("Sen3")%></div></td>
				<%
				}
				if(rst1.getString("Sen4").length()< 2 && !(rst1.getString("Sen1").equals("0")))
				{
					%>
					<td class="bodyText" align="right"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td class="bodyText" align="right"><div align="right"><%=rst1.getString("Sen4")%></div></td>
				<%
				}
				%>
				<% 
}
											
	%>
									</tr>
									<%		
					i++;
					%>
					
					<tr>
												<td class="bodyText" align="right"><div align="right"><%=i%></div></td>
												<td class="bodyText" align="left"><div align="right"><%=new SimpleDateFormat(dateformat+" HH:mm:ss").format(dt2)%></div></td>
												<td class="bodyText" align="right"><div align="right">&nbsp;&nbsp;<%=speedsi%></div></td>
												<%if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
												{
												 %>
												<td class="bodyText" align="right"><div align="right"><%=(int)fleetview.KM_TO_MILES1(ds2-dist)%></div></td>
												<% }
												else
												{
												%>
												<td class="bodyText" align="right"><div align="right"><%=ds2-dist%></div></td>
												<%
												}
												if(target1.contains(targetvalue1))
												{
												String d3=empnamee+"<br>"+loc2;
											%>
											<td class="bodyText" align="left"><%=rst1.getString("TheFieldSubject")%></td>
											<%
											}
											else
												{
												%>
												<td class="bodyText" align="left"><%=rst1.getString("TheFieldSubject")%></td>
												<%
												}
														%>
														<%
			String sqlchecksensorveh11="select Vehiclecode from t_vehicledetails where Description='TEMPSENSOR' and vehiclecode='"+VehicleCode+"'";
			ResultSet rsttemp11=sttemp.executeQuery(sqlchecksensorveh11);
			if(rsttemp11.next())
			{
				
				if(rst1.getString("Sen1").length()< 2 && !(rst1.getString("Sen1").equals("0")))
				{
					%>
					<td class="bodyText" align="right"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td class="bodyText" align="right"><div align="right"><%=rst1.getString("Sen1")%></div></td>
				<%
				}
				if(rst1.getString("Sen2").length()< 2 && !(rst1.getString("Sen2").equals("0")))
				{
					%>
					<td class="bodyText" align="right"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td class="bodyText" align="right"><div align="right"><%=rst1.getString("Sen2")%></div></td>
				<%
				}
				if(rst1.getString("Sen3").length()< 2 && !(rst1.getString("Sen3").equals("0")))
				{
					%>
					<td class="bodyText" align="right"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td class="bodyText" align="right"><div align="right"><%=rst1.getString("Sen3")%></div></td>
				<%
				}
				if(rst1.getString("Sen4").length()< 2 && !(rst1.getString("Sen1").equals("0")))
				{
					%>
					<td class="bodyText" align="right"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td class="bodyText" align="right"><div align="right"><%=rst1.getString("Sen4")%></div></td>
				<%
				}
				%>
				<% 
}
											
	%>
													</tr>	
													<%		
					//i++;
					%>
					
					
					
					
								<%
								i++;
						}
						}
					}//end of SI check after OF stamp
					
					else if(rst1.getString("TheFiledTextFileName").equals("ON"))
					{
						java.util.Date dt2=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst1.getString("TheFieldDataDate")+" "+rst1.getString("TheFieldDataTime"));
						loc2=rst1.getString("TheFieldSubject");
						lat2=rst1.getString("LatinDec");
						long2=rst1.getString("LonginDec");
						ds2=rst1.getInt("Distance");
						String speedon = rst1.getString("Speed");
						long hrs=00,mins=00;
						long mils1=dt1.getTime();
						long mils2=dt2.getTime();
						long mils3=mils2-mils1;
						mils3=mils3/1000/60;
						
						if(mils3 > 20)
						{
							date1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst1.getString("TheFieldDataDate")+" "+rst1.getString("TheFieldDataTime"));
							if(rst1.next())
							{
								if(rst1.getString("TheFiledTextFileName").equals("SI") || rst1.getString("TheFiledTextFileName").equals("ST") || rst1.getString("TheFiledTextFileName").equals("SP"))
								{
									loc3=rst1.getString("TheFieldSubject");
									//System.out.println("Stamp::>>"+rst1.getString("TheFiledTextFileName"));
									lat3=rst1.getString("LatinDec");
									long3=rst1.getString("LonginDec");
									ds3=rst1.getInt("Distance");
									
									if(chbx.equals("null")||chbx.equals(" "))
									{
									%>
									<tr>
								<td class="bodyText" align="right"><div align="right"><%=i%></div></td>
								<td class="bodyText" align="left"><div align="right"><%=new SimpleDateFormat(dateformat+" HH:mm:ss").format(dt1)%></div></td>
								<%
							/*	if(mils3>=60)
								{
									hrs=mils3/60;
									mins=mils3%60;*/
									%>
									<td class="bodyText" align="right"><div align="right">&nbsp;&nbsp;<%=speedof%></div></td>
									<%								
							/*	}
								
								else
								{*/
									
									%>
								<%
								//}
								%>
								
								
								<%
						
						if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
						{
						 %>
						
						<td class="bodyText" align="right"><div align="right"><%=(int)fleetview.KM_TO_MILES1(ds1-dist)%></div></td>
						<% }
						else
						{
							%>
							<td class="bodyText" align="right"><div align="right"><%=ds1-dist%></div></td>
							<%
						}
									if(target1.contains(targetvalue1))
									{
								String d1=empnamee+"<br>"+rst1.getString("TheFieldSubject");
								%>
								<td class="bodyText" align="left"><%=loc1%></td>
								<%
									
								}
								else
									{
									%>
									<td class="bodyText" align="left"><%=loc1%></td>
									<%
									}
											%>
											<%
			String sqlchecksensorveh1="select Vehiclecode from t_vehicledetails where Description='TEMPSENSOR' and vehiclecode='"+VehicleCode+"'";
			ResultSet rsttemp1=sttemp.executeQuery(sqlchecksensorveh1);
			if(rsttemp1.next())
			{
				
				if(rst1.getString("Sen1").length()< 2 && !(rst1.getString("Sen1").equals("0")))
				{
					%>
					<td class="bodyText" align="right"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td class="bodyText" align="right"><div align="right"><%=rst1.getString("Sen1")%></div></td>
				<%
				}
				if(rst1.getString("Sen2").length()< 2 && !(rst1.getString("Sen2").equals("0")))
				{
					%>
					<td class="bodyText" align="right"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td class="bodyText" align="right"><div align="right"><%=rst1.getString("Sen2")%></div></td>
				<%
				}
				if(rst1.getString("Sen3").length()< 2 && !(rst1.getString("Sen3").equals("0")))
				{
					%>
					<td class="bodyText" align="right"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td class="bodyText" align="right"><div align="right"><%=rst1.getString("Sen3")%></div></td>
				<%
				}
				if(rst1.getString("Sen4").length()< 2 && !(rst1.getString("Sen1").equals("0")))
				{
					%>
					<td class="bodyText" align="right"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td class="bodyText" align="right"><div align="right"><%=rst1.getString("Sen4")%></div></td>
				<%
				}
				%>
				<% 
}
											
	%>
											</tr>
											<%		
									i++;
											%>
											<tr>
												<td class="bodyText" align="right"><div align="right"><%=i%></div></td>
												<td class="bodyText" align="right"><div align="left"><%=new SimpleDateFormat(dateformat+" HH:mm:ss").format(dt2)%></div></td>
												<td class="bodyText" align="right"><div align="right">&nbsp;&nbsp;<%=speedon%></div></td>
												<%
						
						if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
						{
						 %>
						
						<td class="bodyText" align="right"><div align="right"><%=(int)fleetview.KM_TO_MILES1(ds3-dist)%></div></td>
						<% }
						else
						{
							%>
							<td class="bodyText" align="right"><div align="right"><%=ds3-dist%></div></td>
							<%
						}
												if(target1.contains(targetvalue1))
												{
											String d3=empnamee+"<br>"+loc3;
											%>
											<td class="bodyText" align="left"><%=rst1.getString("TheFieldSubject")%></td>
											<%
											}
											else
												{
												%>
												<td class="bodyText" align="left"><%=rst1.getString("TheFieldSubject")%></td>
												<%
												}
														%>
														<%
			String sqlchecksensorveh2="select Vehiclecode from t_vehicledetails where Description='TEMPSENSOR' and vehiclecode='"+VehicleCode+"'";
			ResultSet rsttemp2=sttemp.executeQuery(sqlchecksensorveh2);
			if(rsttemp2.next())
			{
				
				if(rst1.getString("Sen1").length()< 2 && !(rst1.getString("Sen1").equals("0")))
				{
					%>
					<td class="bodyText" align="right"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td class="bodyText" align="right"><div align="right"><%=rst1.getString("Sen1")%></div></td>
				<%
				}
				if(rst1.getString("Sen2").length()< 2 && !(rst1.getString("Sen2").equals("0")))
				{
					%>
					<td class="bodyText" align="right"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td class="bodyText" align="right"><div align="right"><%=rst1.getString("Sen2")%></div></td>
				<%
				}
				if(rst1.getString("Sen3").length()< 2 && !(rst1.getString("Sen3").equals("0")))
				{
					%>
					<td class="bodyText" align="right"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td class="bodyText" align="right"><div align="right"><%=rst1.getString("Sen3")%></div></td>
				<%
				}
				if(rst1.getString("Sen4").length()< 2 && !(rst1.getString("Sen1").equals("0")))
				{
					%>
					<td class="bodyText" align="right"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td class="bodyText" align="right"><div align="right"><%=rst1.getString("Sen4")%></div></td>
				<%
				}
				%>
				<% 
}
											
	%>
													</tr>	
													<%
													i++;
									}
													
													if(rst1.getInt("Speed")==0)
													{
														flag=false;
														x=1;
													%>
														<tr>
														<td class="bodyText" align="right"><div align="right"><%=i%></div></td>
														<td class="bodyText" align="left"><div align="right"><%=new SimpleDateFormat(dateformat).format(rst1.getDate("TheFieldDataDate"))%>  <%=" "+rst1.getString("TheFieldDataTime")%></div></td>
														<td class="bodyText" align="right"><div align="right">&nbsp;&nbsp;<%="Stop"%></div></td>
																	<%
						
						if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
						{
						 %>
						
						<td class="bodyText" align="right"><div align="right"><%=(int)fleetview.KM_TO_MILES1(ds3-dist)%></div></td>
						<% }
						else
						{
							%>
							<td class="bodyText" align="right"><div align="right"><%=ds3-dist%></div></td>
							<%
						}
														if(target1.contains(targetvalue1))
														{
															String d1=empnamee+"<br>"+rst1.getString("TheFieldSubject");
															%>
															<td class="bodyText" align="left"><%=rst1.getString("TheFieldSubject")%></td>
															<%
														}
														else
														{
														%>
													<td class="bodyText" align="left"><%=rst1.getString("TheFieldSubject")%></td>
														<%
														}
														%>
														<%
			String sqlchecksensorveh3="select Vehiclecode from t_vehicledetails where Description='TEMPSENSOR' and vehiclecode='"+VehicleCode+"'";
			ResultSet rsttemp3=sttemp.executeQuery(sqlchecksensorveh3);
			if(rsttemp3.next())
			{
				
				if(rst1.getString("Sen1").length()< 2 && !(rst1.getString("Sen1").equals("0")))
				{
					%>
					<td class="bodyText" align="right"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td class="bodyText" align="right"><div align="right"><%=rst1.getString("Sen1")%></div></td>
				<%
				}
				if(rst1.getString("Sen2").length()< 2 && !(rst1.getString("Sen2").equals("0")))
				{
					%>
					<td class="bodyText" align="right"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td class="bodyText" align="right"><div align="right"><%=rst1.getString("Sen2")%></div></td>
				<%
				}
				if(rst1.getString("Sen3").length()< 2 && !(rst1.getString("Sen3").equals("0")))
				{
					%>
					<td class="bodyText" align="right"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td class="bodyText" align="right"><div align="right"><%=rst1.getString("Sen3")%></div></td>
				<%
				}
				if(rst1.getString("Sen4").length()< 2 && !(rst1.getString("Sen1").equals("0")))
				{
					%>
					<td class="bodyText" align="right"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td class="bodyText" align="right"><div align="right"><%=rst1.getString("Sen4")%></div></td>
				<%
				}
				%>
				<% 
}
											
	%>
													</tr>
													<%
													i++;
													}
							
								}
							}
						}
					}//end of ON stamp after OF stamp
				}//end of SI or ON stamp check
			}
			rst1.previous();
			    }
		}//end of OF stamp check
		//flag=true;
    }
}//end of while loop

				
					

		
if(rst1.last())
{
	if(chbx.equals("null")||chbx.equals(" "))
	{
%>
	<tr>
		<td class="bodyText" align="right"><div align="right"><%=i%></div></td>
		<td class="bodyText" align="left"><div align="right"><%=new SimpleDateFormat(dateformat).format(rst1.getDate("TheFieldDataDate"))%> <%=rst1.getString("TheFieldDataTime")%></div></td>
		<td class="bodyText" align="right"><div align="right">&nbsp;&nbsp;<%=rst1.getInt("Speed")%></div></td>
		<%if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
		{
			 %>
			<td class="bodyText" align="right"><div align="right"><%=(int)fleetview.KM_TO_MILES1(rst1.getInt("Distance")-dist)%></div></td>
		<%}else
		{
			%>
			<td class="bodyText" align="right"><div align="right"><%=rst1.getInt("Distance")-dist%></div></td>
		<%}
				if(target1.contains(targetvalue1))
				{
						String d1=empnamee+"<br>"+rst1.getString("TheFieldSubject");
						%>
						<td class="bodyText" align="left"><%=rst1.getString("TheFieldSubject")%></td>
						<%
				}
				else
				{
					%>
		
		
		<td class="bodyText" align="left"><%=rst1.getString("TheFieldSubject")%></td>
		<%
				}
				
				String sqlchecksensorveh1="select Vehiclecode from t_vehicledetails where Description='TEMPSENSOR' and vehiclecode='"+VehicleCode+"'";
				ResultSet rsttemp1=sttemp.executeQuery(sqlchecksensorveh1);
				if(rsttemp1.next())
				{
					
					if(rst1.getString("Sen1").length()< 2 && !(rst1.getString("Sen1").equals("0")))
					{
						%>
						<td class="bodyText" align="right"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td class="bodyText" align="right"><div align="right"><%=rst1.getString("Sen1")%></div></td>
					<%
					}
					if(rst1.getString("Sen2").length()< 2 && !(rst1.getString("Sen2").equals("0")))
					{
						%>
						<td class="bodyText" align="right"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td class="bodyText" align="right"><div align="right"><%=rst1.getString("Sen2")%></div></td>
					<%
					}
					if(rst1.getString("Sen3").length()< 2 && !(rst1.getString("Sen3").equals("0")))
					{
						%>
						<td class="bodyText" align="right"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td class="bodyText" align="right"><div align="right"><%=rst1.getString("Sen3")%></div></td>
					<%
					}
					if(rst1.getString("Sen4").length()< 2 && !(rst1.getString("Sen1").equals("0")))
					{
						%>
						<td class="bodyText" align="right"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td class="bodyText" align="right"><div align="right"><%=rst1.getString("Sen4")%></div></td>
					<%
					}
					%>
					<% 
}
		%>
	</tr>
<%
i++;
	}
}
%>
</table>
<%
/* code end here*/
//}

%>
</td></tr>

</table>
<%
}catch(Exception e)
{
	out.print("Exception "+e);
}
finally
{
	try
	{
		conn.close();
	}catch(Exception e)
	{}
	try
	{
		fleetview.closeConnection();
	}catch(Exception e)
	{}
}
%>
<% //fleetview.closeConnection(); %>
	</jsp:useBean>
<%@ include file="footernew.jsp" %>
