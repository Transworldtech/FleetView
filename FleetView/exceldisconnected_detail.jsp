<%@ page contentType="application/vnd.ms-excel; charset=gb2312" import="java.sql.*" import="java.text.*"%>
<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());

String filename=session.getAttribute("user").toString()+showdatex+"exceldisconnected_detail.xls";
    response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>

<%
  response.setHeader("Cache-Control","no-cache");
  response.setHeader("Pragma","no-cache");
  response.setDateHeader ("Expires", 0);
  %>
<%@ include file="Connections/conn.jsp" %>
<link href="css/css.css" rel="StyleSheet" type="text/css">
<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/graph.js"></SCRIPT>
<%!
	Connection conn,conn1;
	Statement st0=null,st=null, st1=null, st2=null ,st3,st4, myst=null;
	String user;
	int count=1;
	
	ResultSet rst1;
    String vehiclecode="";
    String data1, data2,showdate,showdate1;
    int total=0;
  %>
  <% 
  
    Class.forName(MM_dbConn_DRIVER); 
    conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
    st1=conn.createStatement();
    st2=conn.createStatement();
    String sql1="", sql2="";
	String StartDate="",EndDate="",EndTime="",StartTime="",fromdate="",todate="",thedate="",thedate1="",MyFromDate="",MyToDate="";
	String fromdate1="",todate1="",vcode="";
	int diff=0;
	
	vehiclecode = request.getParameter("VehicleRegNo");
	String date1 = request.getParameter("data");
	String date2 = request.getParameter("data1");
	
	NumberFormat nf = DecimalFormat.getInstance();
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2); 
	
	
%>
 

<table border="1" width="100%" bgcolor="white">
<tr><td>
<!--Start of outer table -->
<table class="stats">
<tr><td colspan="5">
<%
String dd=request.getQueryString();

data1=request.getParameter("data");
data2=request.getParameter("data1");

user=session.getAttribute("usertypevalue").toString();

String regnumber = "select VehicleRegNumber from t_vehicledetails where VehicleCode = " + vehiclecode; 
ResultSet myrs = st2.executeQuery(regnumber);

String vehicle_reg_no="";
while(myrs.next())
{
	
	vehicle_reg_no = myrs.getString("VehicleRegNumber");
}


%>
<table class="stats">
<tr><th colspan="12">Fleet Disconnection Report for <%=user%> - vehicle <%=vehicle_reg_no %> from <%=data1%> to <%=data2%>. <div align="right">
</div></th></tr>
<tr align="center">
				<th> <b> Sr. </b></th>
				<th> <b>From-Date-Time</b></th>
				<th> <b>Location</b></th>
				<th> <b>To-Date-Time</b></th>
				<th> <b>Location</b></th>
				<th> <b>Duration (hh:mm)</b></th>
				
</tr>	
<%


//String str= "select * from t_veh"+ vehiclecode+ " where TheFieldDataDate>='"+request.getParameter("data1")+ "' and TheFieldDataDate <='"+ request.getParameter("data2") +"' order by concat(TheFieldDataDate,'  ',TheFieldDataTime) asc";

String str="select * from t_veh"+ vehiclecode+ " where TheFieldDataDate>='"+request.getParameter("data")+ "' and TheFieldDataDate <='"+ request.getParameter("data1") +"' order by concat(TheFieldDataDate,'  ',TheFieldDataTime) asc";

//System.out.println("str------>" + str);
rst1 = st1.executeQuery(str);



while(rst1.next())
{
	 
	 if(rst1.getString("TheFiledTextFileName").equals("OF"))
		{
		 	//System.out.println("i got OF");
			String long1,long2,lat1,lat2,loc1,loc2;
			int ds1,tm1;
			String dt3="", dt4="";
			
			//java.util.Date dt1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst1.getString("TheFieldDataDate")+" "+rst1.getString("TheFieldDataTime"));
			
			java.util.Date dt1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst1.getString("TheFieldDataDate")+" "+rst1.getString("TheFieldDataTime"));
			Format formatter4 = new SimpleDateFormat("dd-MMM-yyyy HH:mm");
			String DT1 = formatter4.format(dt1);
		
			String abc = rst1.getString("TheFieldDataDate");
			//out.println("rst1.getString(TheFieldDataDate)----------------->" + abc);
			
			String xyz = rst1.getString("TheFieldDataTime");
			//out.println("rst1.getString(TheFieldDataTime)----------------->" + xyz);
			
			loc1 = rst1.getString("TheFieldSubject");
			if(rst1.next())
			{
				
				if(!rst1.getString("TheFiledTextFileName").equals("OF"))
				{
					//System.out.println("i got ON");
					//java.util.Date dt2=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst1.getString("TheFieldDataDate")+" "+rst1.getString("TheFieldDataTime"));
					
					java.util.Date dt2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst1.getString("TheFieldDataDate")+" "+rst1.getString("TheFieldDataTime"));
					Format formatter3 = new SimpleDateFormat("dd-MMM-yyyy HH:mm");
					String DT2 = formatter3.format(dt2);
					//System.out.println("-------DT1------>" + DT2);
					loc2 = rst1.getString("TheFieldSubject");
					long mils1=dt1.getTime();
					//System.out.println("mils1------------------>" + mils1);
					long mils2=dt2.getTime();
					//System.out.println("mils2------------------>" + mils2);
					long mils3=mils2-mils1;
					//System.out.println("mils3------------------>" + mils3);
					mils3=mils3/1000/60;
					//System.out.println("mils3----------------->" + mils3);							
					if(mils3 > 15 && mils3%60!=0)
					{
					
						%>
						<tr>
						<td> <div align="right"><%=count %></div></td>
						<td> <div align="left"><%=DT1%> </div></td>
						<td> <div align="left">&nbsp;&nbsp;<%=loc1%> </div></td>
						<td> <div align="left"><%=DT2%></div></td>
						<td> <div align="left">&nbsp;&nbsp;&nbsp;&nbsp;<%=loc2%></div></td>
						<%
						long tt =0, yy=0;
						tt = mils3/60;
						String temp="";
						
						yy = mils3%60;
						
						if (yy < 10)
						{
						temp =  tt + ".0"+ yy;
						%>
						<td colspan="1"> <div align="right"  ><%=temp %></div></td>
						<%
						
						} else {
							
						temp =  tt + "."+ yy;
						%>
						<td colspan="1"> <div align="right"><%=temp %></div></td>
						<% } 
						%>
					
						</tr>	
						<%
						count ++;
						
					}//end of if(mils3 > 20)
						
				} // end of if(rst1.getString("TheFiledTextFileName").equals("ON"))
				
			}//end of 	if(rst1.next())
			
		}//end of  if(rst1.getString("TheFiledTextFileName").equals("OF"))
		
}//end of  while(rst1.next())

%>
	</div></td>
	</tr>
	
	<td class="hed"><div class="bodyText" align="right">
	
	

</td></tr>
</table>
<br>
<table>
<div style="font-size: 0.8em; text-align: center; margin-top: 1.0em; margin-bottom: 1.0em;">
Copyright &copy; 2009 by Transworld Compressor Technologies Ltd. All Rights Reserved.</div>
<div style="font-size: 0.8em; text-align: center; margin-top: 1.0em; margin-bottom: 1.0em;">
</div>
</table>
</body>

</html>