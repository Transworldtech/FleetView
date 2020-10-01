<%@ include file="header.jsp" %>
<%!
Connection conn;
Statement st,st1;
String sql,sql1,startdate,vehid,tripid,enddate,sql2;
String sdate,edate,vehcode,stime,etime,transporter,vehregno;
long time1,time2,time3,time4,timex;
String startx,stopx;
int startdist,stopdist;
%>
<%
startdate="2008-06-2015:30:30";
enddate="2008-06-2115:30:30";
try{
Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st = conn.createStatement();
	st1 = conn.createStatement();

sql="select * from t_veh"+136+" where concat(TheFieldDataDate,TheFieldDataTime) >='"+startdate+"' and concat(TheFieldDataDate,TheFieldDataTime) <='"+enddate+"' and TheFiledTextFileName='SI' order by concat(TheFieldDataDate,TheFieldDataTime) asc";
ResultSet rst=st.executeQuery(sql);
int a=1;
while(rst.next())
{	
java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("TheFieldDataDate")+" "+session.getAttribute("stoptime").toString());

java.util.Date ShowDate2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("TheFieldDataDate")+" "+"23:59:59");

java.util.Date ShowDate3 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("TheFieldDataDate")+" "+session.getAttribute("starttime").toString());

java.util.Date ShowDate4 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("TheFieldDataDate")+" "+rst.getString("TheFieldDataTime"));

timex=ShowDate4.getTime();
time1=ShowDate1.getTime();
time2=ShowDate2.getTime();
time3=ShowDate2.getTime()+2;
time4=ShowDate3.getTime();

if(timex > time1 && timex < time2 || timex >time3 && timex< time4)
{
if(a==1)
{
stopx="<br>"+rst.getString("TheFieldDataDate")+" "+rst.getString("TheFieldDataTime");
a++;
startdist=rst.getInt("Distance");
}
else
{
startx="<br>"+rst.getString("TheFieldDataDate")+" "+rst.getString("TheFieldDataTime");
stopdist=rst.getInt("Distance");
}
}		
	
}
out.print(stopx+"<br>"+startx+"<br>"+(stopdist-startdist));

}catch(Exception e)
{
out.print("Exception ---------->"+e);
}
finally
{
conn.close();
}
%>
