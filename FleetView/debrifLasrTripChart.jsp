<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

      <%@ include file="Connections/conn.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%!Connection conn,conn1,conn2;
Statement st,st1,st2; %>
<%
String driverId=request.getParameter("driverid");
String tripid=request.getParameter("tripid");
String tripstartDate=request.getParameter("startDate");
String tripendDate=request.getParameter("endDate");
//System.out.println("tripendDate="+tripendDate);
String startDate="";//request.getParameter("startDate");
double hours1=0.0;
int i=0;
String days="";
int day=0;
int rowcount=0;
String averageSpeedConsidered="";
try{
	//gps
	//Class.forName(MM_dbConn_DRIVER);
	//conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	//Exception
	Class.forName(MM_dbConn_DRIVER);
	conn1= DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	
//st=conn.createStatement();
st1=conn1.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);

String datsql="SELECT TO_DAYS('"+tripendDate+"') - TO_DAYS('"+tripstartDate+"') as daystravelled";
//System.out.println("datsql="+datsql);
ResultSet rstd=st1.executeQuery(datsql);
if(rstd.next())
{
	days=rstd.getString("daystravelled");
	//System.out.println("days="+days);
}
day=Integer.parseInt(days);

String dd1;
int count=0;
String s1=tripstartDate; 
java.util.Date dt11=new SimpleDateFormat("yyyy-MM-dd").parse(tripstartDate);
Calendar cal1=Calendar.getInstance();
cal1.setTime(new SimpleDateFormat("yyyy-MM-dd").parse(tripstartDate));
java.util.Date end1=new SimpleDateFormat("yyyy-MM-dd").parse(tripendDate);
/* get the number of days for the trip */
while(!(dt11.compareTo(end1)>0))
{
	java.util.Date dt=cal1.getTime();
	dd1=new SimpleDateFormat("yyyy-MM-dd").format(cal1.getTime());
	
	s1=dd1;

	cal1.add(Calendar.DATE,+1);
	dt11=new SimpleDateFormat("yyyy-MM-dd").parse(new SimpleDateFormat("yyyy-MM-dd").format(cal1.getTime()));
	count++;
	      } 
%>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript">
  google.load("visualization", "1", {packages:["corechart"]});
  google.setOnLoadCallback(drawChart);
  function drawChart() {
    var data = new google.visualization.DataTable();
    data.addColumn('string', 'Date');
    data.addColumn('number', 'Run Hours');
   // data.addColumn('number', 'Expenses');
    data.addRows(<%=count%>);
    
<% 
//System.out.println("rowcount--->"+rowcount);
/*String date1=new SimpleDateFormat("yyyy-MM").format(new SimpleDateFormat("yyyy-MM-dd").parse(tripstartDate));
System.out.println(date1);
String dd=new SimpleDateFormat("dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(tripstartDate));
int d=Integer.parseInt(dd);
String dd1="";
dd1=dd;
String paramDate=date1+dd1;
*/

List<String> distances = new ArrayList<String>();
List<String> dates = new ArrayList<String>();
List<String> avgSpeedConsidered = new ArrayList<String>();
String dist="";
String dd;
String s=tripstartDate; 
java.util.Date dt1=new SimpleDateFormat("yyyy-MM-dd").parse(tripstartDate);
Calendar cal=Calendar.getInstance();
cal.setTime(new SimpleDateFormat("yyyy-MM-dd").parse(tripstartDate));
java.util.Date end=new SimpleDateFormat("yyyy-MM-dd").parse(tripendDate);
while(!(dt1.compareTo(end)>0))
{
	java.util.Date dt=cal.getTime();
	dd=new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
	
	s=dd;
	//System.out.println(s+"==========="+dt1);
String sql="select RDurationinHrs,TheDate,Distance,AvgSpeedConsidered from t_driver_ds where DCode='"+driverId+"' and JCode='"+tripid+"' and thedate='"+s+"'";
//System.out.println(sql);
ResultSet rst= st1.executeQuery(sql);
if(rst.next()){
//	System.out.println("rec found");
	startDate=rst.getString("TheDate");
	hours1=rst.getDouble("RDurationinHrs");
	averageSpeedConsidered=rst.getString("AvgSpeedConsidered");
//	System.out.println("averageSpeedConsidered="+averageSpeedConsidered);
	dist = rst.getString("Distance");

	dates.add(startDate);
	distances.add(dist);
	avgSpeedConsidered.add(averageSpeedConsidered);
%>	
        data.setValue(<%=i%>, 0, '<%=startDate%>');
        data.setValue(<%=i%>, 1, <%=hours1%>);
        

<%
}
else{
//	System.out.println("no rec");

dist = "0";
averageSpeedConsidered="No";
//System.out.println("distance==>"+dist);
   dates.add(s);
  distances.add(dist);
 // averageSpeedConsidered=rst.getString("AvgSpeedConsidered");
  avgSpeedConsidered.add(averageSpeedConsidered);
	%>
	data.setValue(<%=i%>, 0, '<%=s%>');
    data.setValue(<%=i%>, 1, 0);
    
    	<%}
cal.add(Calendar.DATE,+1);
dt1=new SimpleDateFormat("yyyy-MM-dd").parse(new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime()));
i++;
      } 
  %>
  var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
  chart.draw(data, {width: 600, height: 160, title: 'Driver Run Hours',
                    hAxis: {title: 'Date', titleTextStyle: {color: 'red'}}
                   }); 
  }   
  
    </script>
    <table>
	<tr><td style="background-color:#FFFFFF"><div id="chart_div"></div></td>
	<td style="background-color:#e3e9ff">
	
	<table class="stats" border="0">
		<tr>
			<td class="hed"><b>Date</b></td>
			<td class="hed"><b>Dist</b></td>
		</tr>
<%
		int num = 0;
		num = distances.size();
		for(int cnt=0;cnt<num;cnt++){
			//System.out.println(dates.get(cnt));
			//System.out.println(distances.get(cnt));
%>

		<tr>
<%
		if("Yes".equalsIgnoreCase(avgSpeedConsidered.get(cnt))){
%>
			<td style="background-color:#00C000"><%=dates.get(cnt)%></td>
			<td style="background-color:#00C000" align="right"><%=Double.valueOf(distances.get(cnt)).intValue()+"*"%></td>
<%
		}
		else{
%>
			<td><%=dates.get(cnt)%></td>
			<td><%=Double.valueOf(distances.get(cnt)).intValue()%></td>
		</tr>
<%
		}
		}
%>
	
	
	</table>
	</td>
	</tr>
	</table>
<%
}//try end
catch(Exception e){
	e.printStackTrace();
}
finally{
	try
	{
		conn1.close();
	}catch(Exception ee)
	{
		
	}
}
%>
</body>
</html>
