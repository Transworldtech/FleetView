<%/*@ include file="headernew.jsp" */%>
<%/*page import="com.fleetview.beans.classes"*/ %>

<%@ include file="Connections/conn.jsp" %> 
<%@ page import="com.fleetview.beans.classes"%>
<%@page import="com.transworld.fleetview.framework.ZoneIdentificationForLocation" %>
	
	

<%!
Connection conn, conn1,conn00;
String date1,date2,mode,rvehid,hvrno,fff,ttt,mydate1,mydate2;
%>
<%! 
String sql100, sql200;
ResultSet rst100, rst200,rst00;
Statement st00,st100;
%>
<%

//System.out.println("In Ajax page");
fff=session.getAttribute("fff").toString();
//System.out.println("ffffffffffffff   " +fff);
 String fff1=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(fff));
//System.out.println("ffffffffffffff   " +fff1);
ttt=session.getAttribute("ttt").toString();
String ttt1=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(ttt));
//System.out.println("ffffffffffffff   " +ttt1);
date1=session.getAttribute("hdate1").toString();
date2=session.getAttribute("hdate2").toString();
//mode=session.getAttribute("mode").toString();
rvehid=session.getAttribute("hvid").toString();
hvrno=session.getAttribute("hvrno").toString();

//System.out.println("rvehid"+rvehid);
%>
<% 
String dd,aa;
String output="";
String msg="";
mydate1= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date1));
mydate2= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date2));

output+="<table border='1' width='100%'  class='stats'><tr><td class='hed'>Stops Report For "+msg+" "+hvrno+" From "+mydate1+" "+fff1+" to "+mydate2+" "+ttt1+ "</td></tr><tr><td><table width='100%' border='1' class='sortable'><tr><th>Sr. No </th><th>From Date time </th><th>To Date Time</th><th>Duration</th><th>Location</th></tr>";
	int i=1;
	String stopdatefrom="-",stopdateto="-";
	String duration="";
	//boolean flag=true;
	java.util.Date spdate=null,stdate=null;
	int stcount=1;
try{
	
	
Class.forName(MM_dbConn_DRIVER);
conn00 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st00=conn00.createStatement();
st100=conn00.createStatement();

Statement stGPS=conn00.createStatement();

String sql00="select * from db_gpsExceptions.t_veh"+rvehid+"_stsp where  CONCAT( Fromdate,' ',FromTime ) >='"+date1+" "+fff+"' and CONCAT( Fromdate,' ',FromTime ) <='"+date2+" "+ttt+"' order by Fromdate, FromTime asc";

//System.out.println("Query 1:-"+sql00);
rst00= st00.executeQuery(sql00);

boolean flag=true;
int j=0;
List<ZoneIdentificationForLocation> zoneColor = null;
int numRecords=0;
String bgColor="background-color:#FFFFFF";
while(rst00.next())
{
		double lat1=0;
		double lon1=0;
		String disc="";
		

	
			stopdatefrom=rst00.getString("Fromdate")+" "+rst00.getString("FromTime");
			stopdateto=rst00.getString("ToDate")+" "+rst00.getString("ToTime");
			duration=rst00.getString("Duration");
			String location=rst00.getString("Location");
			
			
	//		System.out.println("duration"+duration);
	//		System.out.println("location"+location);
		
	
		
		if(!(stopdatefrom.equals("-")))
		{
			 spdate=new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(stopdatefrom);//stopd/t
			 stdate=new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(stopdateto);//startd/t
			 
		
				String sql="select * from t_veh"+rvehid+" where TheFieldDataDateTime='"+stopdatefrom+"'";
				System.out.println("Query 2:-"+sql);
				ResultSet rst=stGPS.executeQuery(sql);
				if(rst.next())
				{
					lat1=rst.getDouble("LatinDec");
					lon1=rst.getDouble("LonginDec");
					disc=rst.getString("TheFieldSubject");
				}
				
				try{
					//zoneColor = vehicleDao.getZoneColor(lat1,lon1);
					//numRecords = zoneColor.size();
				}
				catch(Exception e){
					e.printStackTrace();
				}
					
			
				DecimalFormat twoDForm1 = new DecimalFormat("00");
				String spdate1=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(spdate);
				String stdate1 =new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(stdate);
				String stamp="ST";
				output+="<tr>"+
					"<td style='"+bgColor+"; text-align: right'>"+stcount+"</td>"+
					"<td style='"+bgColor+"; text-align: right'>"+spdate1+"</td>"+
					"<td style='"+bgColor+"; text-align: right'>"+stdate1+"</td>"+
					"<td style='"+bgColor+"; text-align: right'>"+new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(duration))+"</td>"+
					"<td class='bodyText' style='"+bgColor+"; text-align: left'><div align='left'><a href='javascript:zoomtoloc("+j+","+lat1+","+lon1+")'>"+disc+"</a></div></td>"+
					"</tr>";
				//	System.out.println("output==>"+output);	
				stcount++;
				i++;
				j++;
				stopdatefrom="-";
				lat1=0;
				lon1=0;
			//}//duration
		}
	

}
	output+="</table></td></tr></table>";
}catch(Exception e)
{
	out.print("Exception-- "+e);
	e.printStackTrace();
}

finally
{
	
try
{
	st00.close();
	st100.close();
	conn00.close();
}
catch(Exception e){
	e.printStackTrace();
}
}

out.print(output+"$");
%>
