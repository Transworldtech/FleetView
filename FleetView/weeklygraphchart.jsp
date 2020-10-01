<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
<%@ include file="Connections/conn.jsp" %> 
<html>
<head>
<title>Graph Analysis</title>
<script type="text/javascript" src="http://www.google.com/jsapi"></script>
 <link href="layout.css" rel="stylesheet" type="text/css"></link>
 <script language="javascript" type="text/javascript" src="js/jquery.js"></script>
 <script language="javascript" type="text/javascript" src="js/jquery.flot.js"></script>
</head>
<body>
<%!
String vehregno, cnt1,cnt2,cnt3,cnt4,cnt5,cnt6,thedate,vehcode,thedate1;
Connection conn;
	String os="",ra="",rd="",sp="";
%>

<table border="0" width="100%" align="center">
<tr>
<td align="center"><font color="brown" size="2">
The Exception Analysis On Graph 
</font>
</td>
</tr>
<tr>
<td align="center">
<div id="chart_div" order="1"></div>
<div id="placeholder" style="width:600px;height:400px;"></div>
<script id="source" language="javascript" type="text/javascript">
//alert("hiiiiiii");
$(function () {
	//alert("hiiiiiii");
 	<%
	try{
		Class.forName("org.gjt.mm.mysql.Driver"); 
		conn = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		Statement st=conn.createStatement();
		
		String sql="select * from t_veh3210_ds where TheDate between '2010-02-01' and '2010-02-07'";
		ResultSet rst=st.executeQuery(sql);
		os="[";
		ra="[";
		rd="[";
		sp="[";
		int i=1;
		int km=0;
		while(rst.next())
		{
			
			//os=rst.getString("OSCount");
			//ra=rst.getString("RACount");
			//rd=rst.getString("RDCount");
			//sp=rst.getString("StopCount");
			
			os=os+"["+rst.getString("OSCount")+","+rst.getString("TheDate")+"],";
			ra=ra+"["+rst.getString("RACount")+","+rst.getString("TheDate")+"],";
			//rd=rd+"["+rst.getString("RDCount")+"],";
			//sp=sp+"["+rst.getString("StopCount")+"],";
		//System.out.print("os2-->"+os);	
			
			
			i++;
		}
				
			os=os.substring(0,os.length()-1)+"]";
			//System.out.print("OS String-->"+os);
			//System.out.print("os3 string-->"+os);
			ra=ra.substring(0,ra.length()-1)+"]";
			//rd=rd.substring(0,rd.length()-1)+"]";	
			//sp=sp.substring(0,sp.length()-1)+"]";
		
		conn.close();	
	}catch(Exception e)
	{
		%>
			alert(":Exception:");
		<%
	}
	%>
    
	var overspeed = <%=os%>;
	
	var rapidacc = <%=ra%>;
	
   //	var rapiddeacc = < %=rd%>;
   
   	//var sp = < %=sp%>;
   	alert("("+overspeed+")("+rapidacc+")");

    $.plot($("#placeholder"),
           [ { data: [[100,2],[200,100],[300,19],[410,10]]
, label: "OS" },
             { data: [[10,22],[30,6],[33,19],[41,10]], label: "RA"}      
           ],
           { xaxis: { mode: 'minute' },
             yaxis: { min: 0 },
             y2axis: { tickFormatter: function (v, axis) { return v.toFixed(axis.tickDecimals)}},
             legend: { position: 'nw' } });
});
</script>
<div align="center"><input type="button" name="Print" value="Print" onclick="javascript:window.print();"></div>
</td>
</tr>
</table>
</body>
</html>