<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
<%@ include file="Connections/conn.jsp" %> 
<html>
<head>
<title>Day Speed Chart</title>
<script type="text/javascript" src="http://www.google.com/jsapi"></script>
 <link href="layout.css" rel="stylesheet" type="text/css"></link>
 <script language="javascript" type="text/javascript" src="js/jquery.js"></script>
 <script language="javascript" type="text/javascript" src="js/jquery.plot.js"></script>
</head>
<body>
<%!
String vehregno, cnt1,cnt2,cnt3,cnt4,cnt5,cnt6,cnt7,thedate,vehcode,thedate1;
Connection conn;
	String sp="";
	String dis="";
%>
<%
	vehregno=request.getParameter("vehregno");
	cnt1=request.getParameter("cnt1");
	cnt2=request.getParameter("cnt2");
	cnt3=request.getParameter("cnt3");
	cnt4=request.getParameter("cnt4");
	cnt5=request.getParameter("cnt5");
	cnt6=request.getParameter("cnt6");
	cnt7=request.getParameter("cnt7");
	thedate=request.getParameter("thedate");
	vehcode=request.getParameter("vehcode");
	thedate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(thedate));
%>
<table border="0" width="100%" align="center">
<tr>
<td align="center"><font color="brown" size="2">
The Speed Analysis chart for vehicle <%=vehregno%> on date <%=thedate%>
</font>
</td>
</tr>
<tr>
<td>
<script type="text/javascript">
		   	  	// Load the Visualization API and the piechart package.
      			google.load('visualization', '1', {'packages':['piechart']});
            	// Set a callback to run when the API is loaded.
      			google.setOnLoadCallback(drawChart);
      	      // Callback that creates and populates a data table, 
      			// instantiates the pie chart, passes in the data and
      			// draws it.
      			function drawChart() {
        			var data = new google.visualization.DataTable();
        			data.addColumn('string', 'Task');
        			data.addColumn('number', 'Hours per Day');
        			data.addRows(7);
        			data.setValue(0, 0, 'Below 15 Kmph');
        			data.setValue(0, 1, <%=cnt1%>);
        			data.setValue(1, 0, '15 to 30 Kmph');
        			data.setValue(1, 1, <%=cnt2%>);
        			data.setValue(2, 0, '30 to 40 Kmph');
        			data.setValue(2, 1, <%=cnt3%>);
        			data.setValue(3, 0, '40 to 50 Kmph');
        			data.setValue(3, 1, <%=cnt4%>);
        			data.setValue(4, 0, '50 to 60 Kmph');
        			data.setValue(4, 1, <%=cnt5%>);
        			data.setValue(5, 0, '60 to 80 Kmph');
        			data.setValue(5, 1, <%=cnt6%>);
        			data.setValue(6, 0, 'Above 80 Kmph');
        			data.setValue(6, 1, <%=cnt7%>);
        			var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
        			chart.draw(data, {width: 700, height: 340, is3D: true, title: 'Speed Statistics'});
      			}
    			</script>
				 <div id="chart_div" order="1"></div>
				 <div id="placeholder" style="width:1600px;height:300px;"></div>
<script id="source" language="javascript" type="text/javascript">
$(function () {
 	<%
	try{
		Class.forName(MM_dbConn_DRIVER);
		conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		Statement st=conn.createStatement();
		
		String sql="select * from t_veh"+vehcode+" where TheFieldDataDate='"+thedate1+"' and TheFiledTextFileName='SI' order by TheFieldDataTime ";
		ResultSet rst=st.executeQuery(sql);
		sp="[";
		dis="[";
		int i=1;
		int km=0;
		while(rst.next())
		{
			if(i==1)
			{
				km=rst.getInt("Distance");
			}
			java.util.Date dt= new SimpleDateFormat("HH:mm:ss").parse(rst.getString("TheFieldDataTime"));
			//System.out.println("time"+dt);
			
			Double tm1=Double.valueOf(dt.getHours());//+dt.getMinutes()/60;//*60+dt.getMinutes();
			
			//System.out.println("hrs"+tm1);
			int mins=dt.getMinutes();
			Double min=Double.valueOf(mins)/Double.valueOf(60);
			
			//System.out.println("mins"+min);
			int secs=dt.getSeconds();
			Double sec=Double.valueOf(secs)/Double.valueOf(3600);
			//System.out.println("secs"+sec);
			Double tm=tm1+min+sec;
			//System.out.println("total-->"+tm);
			sp=sp+"["+tm+","+rst.getString("Speed")+"],";
			dis=dis+"["+tm+","+(rst.getInt("Distance")-km)+"],";
			i++;
		}
			sp=sp.substring(0,sp.length()-1)+"]";
			dis=dis.substring(0,dis.length()-1)+"]";
						
		
	}catch(Exception e)
	{
		%>
			alert(":Exception:");
		<%
	}
	finally{
		try{
			conn.close();	
		}
		catch(Exception e)
		{
			
		}
	}
	%>
    
	var speed = <%=sp%>;
    	var distance = <%=dis%>;

    $.plot($("#placeholder"),
           [ { data: speed, label: "Speed" },
             { data: distance, label: "Distance", yaxis: 2 }],
           { xaxis: { mode: 'hours' },
             yaxis: { min: 0 },
             y2axis: { tickFormatter: function (v, axis) { return v.toFixed(axis.tickDecimals)+" km" }},
             legend: { position: 'nw' } });
});
</script>


</td>
</tr>
<tr><td align="center"><b><font color="BROWN" size="3"><----  HOURS ----></font></b>

<div align="center"><input type="button" name="Print" value="Print" onclick="javascript:window.print();"></div></td></tr>

</table>
</body>
</html>