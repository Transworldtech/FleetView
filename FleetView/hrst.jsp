<%@ include file="Connections/conn.jsp" %> 
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">

<%!
Connection conn, conn1;
String date1,date2,mode,rvehid,hvrno,fff,ttt;
%>
<%! 
String sql100, sql200;
ResultSet rst100, rst200,rst00;
Statement st00,st100;
%>
<%
fff=session.getAttribute("fff").toString();
//System.out.println("fff--->"+fff);
ttt=session.getAttribute("ttt").toString();
//System.out.println("ttt--->"+ttt);
date1=session.getAttribute("hdate1").toString();
//System.out.println("hdate1--->"+date1);
date2=session.getAttribute("hdate2").toString();
//System.out.println("hdate2--->"+date2);
mode=session.getAttribute("mode").toString();
//System.out.println("mode--->"+mode);
rvehid=session.getAttribute("hvid").toString();
//System.out.println("rvehid--->"+rvehid);
hvrno=session.getAttribute("hvrno").toString();
//System.out.println("hvrno--->"+hvrno);

//String ll="?calender="+session.getAttribute("hdate1").toString()+"&calender1="+session.getAttribute("hdate2").toString()+"&mode="+session.getAttribute("mode").toString()+"&rvehid="+session.getAttribute("hvid").toString();

String ll="?calender="+session.getAttribute("hdate1").toString()+"&calender1="+session.getAttribute("hdate2").toString()+"&mode="+session.getAttribute("mode").toString()+"&rvehid="+session.getAttribute("hvid").toString()+"&fromtime1="+session.getAttribute("fromtime1").toString()+"&fromtime2="+session.getAttribute("fromtime2").toString()+"&totime1="+session.getAttribute("totime1").toString()+"&totime2="+session.getAttribute("totime2").toString();
%>
<%! String dd,aa; %>



<table border="1" width="100%">
<tr><th class="hed">Stops Report For <%=hvrno %> From <%=session.getAttribute("HisShowDate").toString()%> to <%=session.getAttribute("HisShowDate1").toString()%> 
</th></tr>

<tr><td>

<table width="100%" border="1" class="sortable">
<tr><th>From Date time </th><th>To Date Time</th><th>Duration</th><th>Location</th></tr>
<%
//if(session.getAttribute("usertypevalue").toString().equals("Om"))
//{
	int i=1;
	String stopdatetime="-",startdatetime="-";
	//boolean flag=true;
	java.util.Date spdate=null,stdate=null;
	int stcount=0;
	String hrs;
	String min;
try{
	
	
Class.forName(MM_dbConn_DRIVER);
Connection conn00 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st00=conn00.createStatement();
st100=conn00.createStatement();
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

String sql00="select * from t_veh"+rvehid+" where TheFiledTextFileName='SI' and concat(TheFieldDataDate,' ',TheFieldDataTime) >='"+date1+" "+fff+"' and concat(TheFieldDataDate,' ',TheFieldDataTime) <='"+date2+" "+ttt+"' order by TheFieldDataDate, TheFieldDataTime asc";
//System.out.println("SQL00:>>"+sql00);
//String sql00="select * from t_veh"+rvehid+" where concat(TheFieldDataDate,' ',TheFieldDataTime) >='"+date1+" "+fff+"' and concat(TheFieldDataDate,' ',TheFieldDataTime) <='"+date2+" "+ttt+"' and TheFiledTextFileName='SI' order by concat(TheFieldDataDate,TheFieldDataTime) asc ";
rst00= st00.executeQuery(sql00);

boolean flag=true;
int j=1;

while(rst00.next())
{	//System.out.println("rst00.getInt(Speed)-->"+rst00.getInt("Speed"));
	if(rst00.getInt("Speed")==0)
	{
		if(flag)
		{
			//System.out.println("in flag--->"+stopdatetime);
			//System.out.println("flag---->"+flag);
			stopdatetime=rst00.getString("TheFieldDataDate")+" "+rst00.getString("TheFieldDataTime");
			//System.out.println(stopdatetime);
			flag=false;
			//System.out.println("flag---->"+flag);
		}
	}
	else
	{
		flag=true;
		startdatetime=rst00.getString("TheFieldDataDate")+" "+rst00.getString("TheFieldDataTime");
		if(!(stopdatetime.equals("-")))
		{
			//System.out.println(stopdatetime);
			 spdate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(stopdatetime);//stopd/t
			 stdate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(startdatetime);//startd/t
			//System.out.println("spdate"+spdate);
			//System.out.println("stdate"+stdate);
			
			//System.out.println("stdate"+stdate.getTime());
			//System.out.println("spdate"+spdate.getTime());
			
			long mils=(stdate.getTime()-spdate.getTime());
			System.out.println("mils-->"+mils);
			long mins=mils/1000/60;
			//System.out.println("mins--->"+mins);
			if(mins >= Integer.parseInt(session.getAttribute("stop11").toString()))
			{
				
				//System.out.println("mins-->"+mins);
				hrs=""+mins/60;
				min="00";
				try{
				 min=""+mins%60;
				 //System.out.println("mins%60-->"+min);
				}catch(Exception ee)
				{
					min="00";
				}
				%>
				<tr>
					
					<td class="bodyText" style="text-align: left"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(spdate) %></td>
					<td class="bodyText" style="text-align: left"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(stdate) %></td>
					<td class="bodyText" style="text-align: left"><%=hrs+" hrs "%><%=min+" min "%></td>
					<td class="bodyText" ><div align="left"><%=fleetview.ShowOnMapOnlyByDateTime(rvehid,rst00.getString("TheFieldDataDate"),rst00.getString("TheFieldDataTime")) %></div></td>
					
					</tr>
				<%
				stcount++;
				
			}//duration
			
			stopdatetime="-";
			//System.out.println(stopdatetime);
		}
	}

}
//System.out.println(stcount);
conn00.close();
}catch(Exception e)
{
	out.print("Exception "+e);
}

%>
</table>




</td></tr>


</table>

<%
//fleetview.closeConnection1();
fleetview.closeConnection();
%>
</jsp:useBean>


<P></P>
</body>
</html>
