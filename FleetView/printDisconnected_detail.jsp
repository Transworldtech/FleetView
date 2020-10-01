<%@ page  import="java.sql.*" import="java.text.*"%>

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
	Statement st0=null,st=null, st1=null, st2=null,st3,st4;
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
	
	vehiclecode = request.getParameter("VehicleRegNo");
	String date1 = request.getParameter("data");
	String date2 = request.getParameter("data1");
	
	NumberFormat nf = DecimalFormat.getInstance();
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2); 
	
	String sql1="", sql2="";
	String StartDate="",EndDate="",EndTime="",StartTime="",fromdate="",todate="",thedate="",thedate1="",MyFromDate="",MyToDate="";
	String fromdate1="",todate1="",vcode="",vehicle_reg_no="";
	int diff=0;

			
	String str= "select * from t_veh"+vehiclecode+ " where TheFieldDataDate>='"+date1+ "' and TheFieldDataDate <='"+ date2 +"' order by TheFieldDataDate asc, TheFieldDataTime asc";
	rst1 = st1.executeQuery(str);
	//user=session.getAttribute("usertypevaluemain").toString();
	user = session.getAttribute("usertypevalue").toString();
%>
 
<%

try{

	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st0=conn.createStatement();
	st1=conn.createStatement();
	st2=conn.createStatement();
	st3=conn1.createStatement();
	st4=conn1.createStatement();
	}
	catch(Exception e)
	{
		out.print("Exception "+e);
	}

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
//System.out.println("usr-->"+usr);
	String regnumber = "select VehicleRegNumber from t_vehicledetails where VehicleCode =" + vehiclecode; 
	//System.out.println("user--->" +  user);
	MyFromDate= date1;
	fromdate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(MyFromDate));
	MyToDate = date2;
	todate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(MyToDate));
	//System.out.println("fromdate--->" + fromdate);
	ResultSet myrst = st2.executeQuery(regnumber);
	//String vehicle_reg_no="";
	while(myrst.next())
	{
		vehicle_reg_no = myrst.getString("VehicleRegNumber");
	}

//user=session.getAttribute("usertypevaluemain").toString();
//System.out.println("user-->"+user);
%>
<table class="stats">
<tr><th colspan="12">Fleet Disconnection Report for <%=user%> - Vehicle <%=vehicle_reg_no %> from 
		<%= fromdate %> to <%= todate%>. <div align="right">
</div></th></tr>
<tr>		

			<td class="hed"><div class="bodyText"><b> Sr. </b></div></td>
			<td class="hed"><div class="bodyText" align="left"><b>From-Date-Time</b></div></td>
			<td class="hed"><div class="bodyText"><b>Location</b></div></td>
			<td class="hed"><div class="bodyText" align="left"><b>To-Date-Time</b></div></td>
			<td class="hed"><div class="bodyText"><b>Location</b></div></td>
			<td class="hed"><div class="bodyText"><b>Duration (hh:mm)</b></div></td>
</tr>
<%

while(rst1.next())
{
	 
	 if(rst1.getString("TheFiledTextFileName").equals("OF"))
		{
			String long1,long2,lat1,lat2,loc1,loc2;
			int ds1,tm1;
			String dt3="", dt4="";
			
			//java.util.Date dt1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst1.getString("TheFieldDataDate")+" "+rst1.getString("TheFieldDataTime"));
			
			java.util.Date dt1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst1.getString("TheFieldDataDate")+" "+rst1.getString("TheFieldDataTime"));
			Format formatter4 = new SimpleDateFormat("dd-MMM-yyyy HH:mm");
			String DT1 = formatter4.format(dt1);
			String abc = rst1.getString("TheFieldDataDate");
			String xyz = rst1.getString("TheFieldDataTime");
			
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
					loc2 = rst1.getString("TheFieldSubject");
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
						<td> <div align="right"><%=count++ %></div></td>
						<td> <div align="left"><%=DT1%> </div></td>
						<td> <div align="left">&nbsp;&nbsp;<%=loc1%> </div></td>
						<td> <div align="left"><%=DT2%></div></td>
						<td> <div align="left">&nbsp;&nbsp;&nbsp;&nbsp;<%=loc2%></div></td>
						<%
						long hh = mils3/60;
						long mm = mils3%60;
						if (mm < 10)
						{
							String temp = hh + ":0"+ mm;
						%>
						<td colspan="1"> <div align="right" ><%=temp %></div></td>
						<%
						} else {
							String temp = hh + ":"+ mm;
						%>
						<td colspan="1"> <div align="right" ><%=temp %></div></td>
						<% } %>
						
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
	
	

</td></tr>
</table>
<table>
<div style="font-size: 0.8em; text-align: center; margin-top: 1.0em; margin-bottom: 1.0em;">
Copyright &copy; 2009 by Transworld Compressor Technologies Ltd. All Rights Reserved.</div>
<div style="font-size: 0.8em; text-align: center; margin-top: 1.0em; margin-bottom: 1.0em;">
</div>
</table>
</body>
</html>


