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
	Statement st0=null,st=null, st1=null, st2,st3,st4;
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
	String fromdate1="",todate1="",vcode="";
	int diff=0;
			
	String str= "select * from t_veh"+vehiclecode+ " where TheFieldDataDate>='"+date1+ "' and TheFieldDataDate <='"+ date2 +"' and TheFiledTextFileName in ('HF','HN') order by TheFieldDataDate asc";
	rst1 = st1.executeQuery(str);
	user=session.getAttribute("usertypevaluemain").toString();
	
%>
 
<%

try{

	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st0=conn.createStatement();
	st1=conn.createStatement();
	st2=conn1.createStatement();
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
String usr=request.getParameter("userval");
//System.out.println("usr-->"+usr);

user=session.getAttribute("usertypevaluemain").toString();
//System.out.println("user-->"+user);
%>
<table class="stats">
<tr><th colspan="12">Exception Report for <%=user%> transporters from date <%=data1%> to <%=data2%>. <div align="right">
</div></th></tr>
<tr>		
<th class="hed"><div class="bodyText"><b>From-Date-Time</b></div></th>
<th class="hed"><div class="bodyText"><b>To-Date-Time</b></div></th>
<th class="hed"><div class="bodyText"><b>Duration (hh:mm)</b></div></th>
<th class="hed"><div class="bodyText"><b>Location </b></div></th>
</tr>
<%

while(rst1.next())
{
	 
	 if(rst1.getString("TheFiledTextFileName").equals("HF"))
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
						<td> <div align="center"><%=DT1%> </div></td>
						<td> <div align="center"><%=DT2%></div></td>
						<%
						long hh = mils3/60;
						long mm = mils3%60;
						if (mm > 10)
						{
							String temp = "0"+ hh + ":"+ mm;
						%>
						<td colspan="1"> <div align="center" ><%=temp %></div></td>
						<%
						} else {
							String temp = "0"+ hh + ":0"+ mm;
						%>
						<td colspan="1"> <div align="center" ><%=temp %></div></td>
						<% } %>
						<td> <div align="center"><%=  rst1.getString("TheFieldSubject") %></div> </td>
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
<br>
<table>
<div style="font-size: 0.8em; text-align: center; margin-top: 1.0em; margin-bottom: 1.0em;">
Copyright &copy; 2009 by Transworld Compressor Technologies Ltd. All Rights Reserved.</div>
<div style="font-size: 0.8em; text-align: center; margin-top: 1.0em; margin-bottom: 1.0em;">
</div>
</table>
</body>

</html>


