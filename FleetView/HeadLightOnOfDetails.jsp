<%@ include file="headernew.jsp" %>
<link href="css/css.css" rel="StyleSheet" type="text/css">
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">

<html>
<head>
</head>

<%
	Connection conn;
	Statement st0=null,st=null, st1=null, st2,st3,st4;
	String user;
	int count=1;
	fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	ResultSet rst1;
    String vehiclecode="";
    String data1, data2,showdate,showdate1;
    int total=0;
    
    Class.forName(MM_dbConn_DRIVER); 
    conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
    st1=conn.createStatement();
	
	vehiclecode = request.getParameter("VehicleRegNo");
	String date1 = request.getParameter("data1");
	//Sytem.out.println("date1----------------->" + date1);
	String date2 = request.getParameter("data2");
	//System.out.println("date2----------------->" + date2);
	
	
	NumberFormat nf = DecimalFormat.getInstance();
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2); 
	
	String sql1="", sql2="";
	String StartDate="",EndDate="",EndTime="",StartTime="",fromdate="",todate="",thedate="",thedate1="",MyFromDate="",MyToDate="";
	String fromdate1="",todate1="",vcode="";
	int diff=0;
			
	String str= "select * from t_veh"+ vehiclecode+ " where TheFieldDataDate>='"+request.getParameter("data1")+ "' and TheFieldDataDate <='"+ request.getParameter("data2") +"' and TheFiledTextFileName in ('OF','ON','SI') order by TheFieldDataDate asc";
	rst1 = st1.executeQuery(str);
	//System.out.println("str------>" + str);
	user=session.getAttribute("usertypevaluemain").toString();
	
%>
	
	
<tr width="100%">

<table class="stats">

	<th colspan="5" align= "center">Disconnected Report for <%=user%> Vehicle t_veh<%=vehiclecode %> from date
		<%= request.getParameter("data1")%> to <%= request.getParameter("data2")%> 
		<div align="right">
				<div align="right">
		<a href="#" onclick="javascript:window.open('HeadLightOnOf_printdetail.jsp?VehicleRegNo=<%=vehiclecode%>&data=<%=request.getParameter("data1")%>&data1=<%=request.getParameter("data2")%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; <a href="HeadLightOnOf_exceldetail.jsp?VehicleRegNo=<%=vehiclecode%>&data=<%=request.getParameter("data1")%>&data1=<%=request.getParameter("data2")%>&Total=<%=total%>"  title="Export to Excel">
	<img src="images/excel.jpg" width="15px" height="15px"></a><th>
	<div align="right">
	
	<tr>		 
	
		<table width="100%" border="1" align="center">
			<tr align="center">
				<th> <b> Sr. </b></th>
				<th> <b>From-Date-Time</b></th>
				<th> <b>To-Date-Time</b></th>
				<th> <b>Duration (hh:mm)</b></th>
				<th> <b>Location - Click To View On Map.</b></th>
			</tr>	
			
			<% 
			 while(rst1.next())
			 {
				 
				 if(rst1.getString("TheFiledTextFileName").equals("HF"))
					{
					 	//System.out.println("i got OF");
						String long1,long2,lat1,lat2,loc1,loc2;
						int ds1,tm1;
						String dt3="", dt4="";
						
						//java.util.Date dt1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst1.getString("TheFieldDataDate")+" "+rst1.getString("TheFieldDataTime"));
						
						java.util.Date dt1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst1.getString("TheFieldDataDate")+" "+rst1.getString("TheFieldDataTime"));
						Format formatter4 = new SimpleDateFormat("dd-MMM-yyyy HH:mm");
						String DT1 = formatter4.format(dt1);
						//System.out.println("-------DT1------>" + DT1);
						
						
						
						
						
						//java.util.Date mydate1 = new SimpleDateFormat("DD-MON-yyyy").parse(rst1.getString("TheFieldDataDate"));
						//out.println("mydate1--------->" + mydate1);
						String abc = rst1.getString("TheFieldDataDate");
						//out.println("rst1.getString(TheFieldDataDate)----------------->" + abc);
						
						String xyz = rst1.getString("TheFieldDataTime");
						//out.println("rst1.getString(TheFieldDataTime)----------------->" + xyz);
					
						if(rst1.next())
						{
							
							if(rst1.getString("TheFiledTextFileName").equals("HN"))
							{
								//System.out.println("i got ON");
								//java.util.Date dt2=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst1.getString("TheFieldDataDate")+" "+rst1.getString("TheFieldDataTime"));
								
								java.util.Date dt2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst1.getString("TheFieldDataDate")+" "+rst1.getString("TheFieldDataTime"));
								Format formatter3 = new SimpleDateFormat("dd-MMM-yyyy HH:mm");
								String DT2 = formatter3.format(dt2);
								//System.out.println("-------DT1------>" + DT2);
								
								long mils1=dt1.getTime();
								//System.out.println("mils1------------------>" + mils1);
								long mils2=dt2.getTime();
								//System.out.println("mils2------------------>" + mils2);
								long mils3=mils2-mils1;
								//System.out.println("mils2------------------>" + mils2);
								mils3=mils3/1000/60;
																
								if(mils3 > 15 && mils3%60!=0)
								{
								
									%>
									<tr>
									<td> <div align="center"><%=count %></div></td>
									<td> <div align="center"><%=DT1%> </div></td>
									<td> <div align="center"><%=DT2%></div></td>
									<%
									long hh = mils3/60;
									long mm = mils3%60;
									if (mm < 10)
									{
										String temp =  hh + ":0"+ mm;
									%>
									<td colspan="1"> <div align="center" ><%=temp %></div></td>
									<%
									} else {
										String temp =  hh + ":"+ mm;
									%>
									<td colspan="1"> <div align="center" ><%=temp %></div></td>
									<% } %>
									<td> <div align="center"><%=fleetview.ShowOnMapOnlyByDateTime(vehiclecode, abc,xyz)%></div> </td>
									</tr>	
									<%
									count ++;
									
								}//end of if(mils3 > 20)
									
							} // end of if(rst1.getString("TheFiledTextFileName").equals("ON"))
							
						}//end of 	if(rst1.next())
						
					}//end of  if(rst1.getString("TheFiledTextFileName").equals("OF"))
						
			 }//end of  while(rst1.next())
			
	%>
	
	
<%
fleetview.closeConnection1();
fleetview.closeConnection();
%>

</table>

</tr>
<tr>
<td colspan="4"> 
</jsp:useBean>
<%@ include file="footernew.jsp" %>
</td>
</tr>
</table>
</html>