<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.util.Date"
    import="java.sql.*"%>
     <%@ include file="Connections/conn.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%!Connection conn,conn1,conn2;
Statement st,st1,st2;
%>
<%
String driverId=request.getParameter("driverid");
//System.out.println(driverId);
String prevDay1="",secondDay1="",thirdDay1="",fourthDay1="",fifthDay1="",sixthDay1="",seventhDay1="";
Calendar calendar = Calendar.getInstance();
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
String today= dateFormat.format(calendar.getTime());
//System.out.println("Today: " + dateFormat.format(calendar.getTime()));

calendar.add(Calendar.DATE, -1);
String prevDay=dateFormat.format(calendar.getTime());
//System.out.println("1st: " + dateFormat.format(calendar.getTime()));

calendar.add(Calendar.DATE, -1);
String secondDay=dateFormat.format(calendar.getTime());
//System.out.println("2nd: " + dateFormat.format(calendar.getTime()));

calendar.add(Calendar.DATE, -1);
String thirdDay=dateFormat.format(calendar.getTime());
//System.out.println("3rd: " + dateFormat.format(calendar.getTime()));

calendar.add(Calendar.DATE, -1);
String fourthDay=dateFormat.format(calendar.getTime());
//System.out.println("4th: " + dateFormat.format(calendar.getTime()));

calendar.add(Calendar.DATE, -1);
String fifthDay=dateFormat.format(calendar.getTime());
//System.out.println("5th: " + dateFormat.format(calendar.getTime()));

calendar.add(Calendar.DATE, -1);
String sixthDay=dateFormat.format(calendar.getTime());
//System.out.println("6th: " + dateFormat.format(calendar.getTime()));

calendar.add(Calendar.DATE, -1);
String seventhDay=dateFormat.format(calendar.getTime());
//System.out.println("6th: " + dateFormat.format(calendar.getTime()));


String tripid="",vehicleCode="";
int runhrs=0;
double last7daysHrs=0.0,totalDistanceTravelled=0.0;
double hours1=0.0,hours2=0.0,hours3=0.0,hours4=0.0,hours5=0.0,hours6=0.0,hours7=0.0;
double distance1=0.0,distance2=0.0,distance3=0.0,distance4=0.0,distance5=0.0,distance6=0.0,distance7=0.0;
double distance=0;
final NumberFormat nf = DecimalFormat.getNumberInstance();
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);	
nf.setGroupingUsed(false);
try{
	//gps
	//Class.forName(MM_dbConn_DRIVER);
	//conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	//Exception
	Class.forName(MM_dbConn_DRIVER);
	conn1= DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	
//st=conn.createStatement();
st1=conn1.createStatement();
String date="";
int i=1;
for(int count=0;count<7;count++){
if(i==1){
	date=prevDay;
}
else if(i==2){
	date=secondDay;
}
else if(i==3){
	date=thirdDay;
}
else if(i==4){
	date=fourthDay;
}
else if(i==5){
	date=fifthDay;
}
else if(i==6){
	date=sixthDay;
}
else if(i==7){
	date=seventhDay;
}
String one="",two="",three="",four="",five="",six="",seven="";

prevDay1=new SimpleDateFormat("dd-MMM-yy").format(new SimpleDateFormat("yyyy-MM-dd").parse(prevDay));
secondDay1=new SimpleDateFormat("dd-MMM-yy").format(new SimpleDateFormat("yyyy-MM-dd").parse(secondDay));
thirdDay1=new SimpleDateFormat("dd-MMM-yy").format(new SimpleDateFormat("yyyy-MM-dd").parse(thirdDay));
fourthDay1=new SimpleDateFormat("dd-MMM-yy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fourthDay));
fifthDay1=new SimpleDateFormat("dd-MMM-yy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fifthDay));
sixthDay1=new SimpleDateFormat("dd-MMM-yy").format(new SimpleDateFormat("yyyy-MM-dd").parse(sixthDay));
seventhDay1=new SimpleDateFormat("dd-MMM-yy").format(new SimpleDateFormat("yyyy-MM-dd").parse(seventhDay));

String sql="select RDurationinHrs,Last7DayRDurationinHrs,Distance from t_driver_ds where DCode='"+driverId+"' and TheDate='"+date+"'";
//System.out.println("sql-->"+sql);
ResultSet rst= st1.executeQuery(sql);
if(rst.next())
{
	if(i==1){
		//hours1=Integer.parseInt(rst.getString("RDurationinHrs"));
		hours1=rst.getDouble("RDurationinHrs");
		//System.out.println("hours1-->"+hours1);
		distance1=rst.getDouble("Distance");
		//last7daysHrs=rst.getDouble("Last7DayRDurationinHrs");
		
	}
	else if(i==2){
		hours2=Double.parseDouble(rst.getString("RDurationinHrs"));
		distance2=rst.getDouble("Distance");
		//System.out.println("hours2-->"+hours2);
	}
	else if(i==3){
		hours3=Double.parseDouble(rst.getString("RDurationinHrs"));
		distance3=rst.getDouble("Distance");
	}
	else if(i==4){
		hours4=Double.parseDouble(rst.getString("RDurationinHrs"));
		distance4=rst.getDouble("Distance");
	}
	else if(i==5){
		hours5=Double.parseDouble(rst.getString("RDurationinHrs"));
		distance5=rst.getDouble("Distance");
	//	System.out.println("hours5-->"+hours5);
	}
	else if(i==6){
		hours6=Double.parseDouble(rst.getString("RDurationinHrs"));
		distance6=rst.getDouble("Distance");
	}
	else if(i==7){
		hours7=Double.parseDouble(rst.getString("RDurationinHrs"));
		distance7=rst.getDouble("Distance");
	}
}
else{
	
	if(i==1){
		one="NO DATA";
	}
	else if(i==2){
		two="NO DATA";
	}
	else if(i==3){
		three="NO DATA";
	}
	else if(i==4){
		four="NO DATA";
	}
	else if(i==5){
		five="NO DATA";
	}
	else if(i==6){
		six="NO DATA";
	}
	else if(i==7){
		seven="NO DATA";
	}
}
i++;
}
last7daysHrs=hours1+hours2+hours3+hours4+hours5+hours6+hours7;
totalDistanceTravelled=distance1+distance2+distance3+distance4+distance5+distance6+distance7;
//totalDistanceTravelled=45.2365;
int totDist=Double.valueOf(totalDistanceTravelled).intValue();
//System.out.println("last7daysHrs-->"+last7daysHrs);
%>
	<script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script type="text/javascript">
      google.load("visualization", "1", {packages:["corechart"]});
      google.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Date');
        data.addColumn('number', 'Run Hours');
      //  data.addColumn('number', 'Distance');
       	var runHoursData=[[' <%=hours1%>','<%=hours2%>','<%=hours3%>','<%=hours4%>','<%=hours5%>','<%=hours6%>','<%=hours7%>']];
		//alert(runHoursData);
		 
           
        data.addRows(7);
        data.setValue(0, 0, '<%=prevDay1%>');
        data.setValue(0, 1, <%=hours1%>);
     //   data.setValue(0, 2, 400);
        
        data.setValue(1, 0, '<%=secondDay1%>');
        data.setValue(1, 1, <%=hours2%>);
    //    data.setValue(1, 2, 460);
        
        data.setValue(2, 0, '<%=thirdDay1%>');
        data.setValue(2, 1, <%=hours3%>);
    //    data.setValue(2, 2, 1120);
        
        data.setValue(3, 0, '<%=fourthDay1%>');
        data.setValue(3, 1, <%=hours4%>);
   //     data.setValue(3, 2, 540);
      
        data.setValue(4, 0, '<%=fifthDay1%>');
        data.setValue(4, 1, <%=hours5%>);
  //      data.setValue(4, 2, 540);
        
        data.setValue(5, 0, '<%=sixthDay1%>');
        data.setValue(5, 1, <%=hours6%>);
  //      data.setValue(5, 2, 540);
        
        data.setValue(6, 0, '<%=seventhDay1%>');
        data.setValue(6, 1, <%=hours7%>);
   //     data.setValue(6, 2, 540);

       // hideColumns([3]);
        
        var red='ff0000'; 
		var blue='0276FD';
		var green='8FD8D8';
		var colors=[];
		var colors1="blue";
		//color=blue;
           for(var j=0; j<runHoursData.length;++j){
              // alert(j);
        	   for (var k = 1; k  < runHoursData[j].length; ++k) {
        		   //alert(k);
        		   var value = data.getValue(k-1, j+1);
        		   //alert("value: "+value);
                   var color = value > 10 ? red : blue; 
                  // alert("color: "+color);
                   colors.push(color);
                 } 
           }
           colors = colors.join('|');

        var options = {chco: colors};
        var mm=10;
        /*if(mm>=10){
            alert("hi");
           // var color1=''
            colors.push(green);
            alert(colors);
        }*/
           
        var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
        chart.draw(data, {width: 600, height: 240, title: 'Driver Run Hours',colors:[{color:colors1}],
                          hAxis: {title: 'Date', titleTextStyle: {color: 'red'},minValue:0},
                          vAxis:{minValue:0}
                         });


        
      }
    //  document.getElementById('tab').style.display='';
    </script>
	
	
	<script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script type="text/javascript">
    
      google.load("visualization", "1", {packages:["corechart"]});
      google.setOnLoadCallback(drawChart);
      function drawChart() {
    	  var i=0;
    	    var color1="blue";
    	     i=<%=last7daysHrs%>;
    	    if(i>=40 && i<=60){
    				color1="yellow";
    	    }
    	    else if(i>60){
    	    		color1="red";
    	    }
        var data1 = new google.visualization.DataTable();
        data1.addColumn('string', 'Date');
        data1.addColumn('number', 'Run Hours');
       // data.addColumn('number', 'Expenses');
        data1.addRows(1);
      //  data1.setValue(0, 0, '2004');
        data1.setValue(0, 0, <%=last7daysHrs%>);
        var tothrs="<%=last7daysHrs%>";
        var str="<%=totDist%>"
             var chart1 = new google.visualization.BarChart(document.getElementById('chart_progbar'));
        chart1.draw(data1, {width: 600, height: 80, title: 'Fatigue Meter (Last 7 days Run Hours)          Total Distance Travelled : '+str+' km     Total Run Hrs : '+tothrs, colors:[{color:color1}],
                          vAxis: {title: 'Run Hrs', titleTextStyle: {color: 'red'},minValue:0},
        					hAxis:{minValue:0}
                         });
      }
    </script>
	
	<table>
	<tr><td style="background-color:#FFFFFF"><div id="chart_div"></div></td>
	<td style="background-color:#e3e9ff">
	
	<table class="stats" border="0">
		<tr>
			<td class="hed">Date</td>
			<td class="hed">Dist</td>
			<td class="hed">RunHrs</td>
		</tr>
		<tr>
			<td><%=prevDay1 %></td>
			<td align="right"><%=Double.valueOf(distance1).intValue() %></td>
			<td align="right"><%=String.valueOf(hours1).toString() %></td>
		</tr>
		<tr>
			<td><%=secondDay1 %></td>
			<td align="right"><%=Double.valueOf(distance2).intValue() %></td>
			<td align="right"><%=String.valueOf(hours2).toString() %></td>
		</tr>
		<tr>
			<td><%=thirdDay1 %></td>
			<td align="right"><%=Double.valueOf(distance3).intValue() %></td>
			<td align="right"><%=String.valueOf(hours3).toString() %></td>
		</tr>
		<tr>
			<td><%=fourthDay1 %></td>
			<td align="right"><%=Double.valueOf(distance4).intValue() %></td>
			<td align="right"><%=String.valueOf(hours4).toString() %></td>
		</tr>
		<tr>
			<td><%=fifthDay1 %></td>
			<td align="right"><%=Double.valueOf(distance5).intValue() %></td>
			<td align="right"><%=String.valueOf(hours5).toString() %></td>
		</tr>
		<tr>
			<td><%=sixthDay1 %></td>
			<td align="right"><%=Double.valueOf(distance6).intValue() %></td>
			<td align="right"><%=String.valueOf(hours6).toString() %></td>
		</tr>
		<tr>
			<td><%=seventhDay1 %></td>
			<td align="right"><%=Double.valueOf(distance7).intValue() %></td>
			<td align="right"><%=String.valueOf(hours7).toString() %></td>
		</tr>
	</table>
	
	</td></tr>
	<tr><td style="background-color:#FFFFFF"><div id="chart_progbar"></div></td></tr>
	</table>
<%
}
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