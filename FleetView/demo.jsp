<%@ include file="header.jsp" %>
<%! 
String sql100, sql200;
ResultSet rst100, rst200,rst00;
Statement st00,st100;
int stcount2=0;
%>
<%
try{
Class.forName(MM_dbConn_DRIVER);
Connection conn00 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st00=conn00.createStatement();
st100=conn00.createStatement();
String sql00="select *, (HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) as time1 from t_veh5 where TheFiledTextFileName='SP' and TheFieldDataDate >='2008-03-30' and TheFieldDataDate <='2008-03-30' order by TheFieldDataDate, TheFieldDataTime asc";
rst00= st00.executeQuery(sql00);
while(rst00.next())
{
sql100="select *,(HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) as time2 from t_veh5 where TheFiledTextFileName='ST' and TheFieldDataDate >='2008-03-30' and TheFieldDataDate <='2008-03-30' and TheFieldDataDate='"+rst00.getString("TheFieldDataDate")+"' and (HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) > "+Double.parseDouble(rst00.getString("time1"))+"and abs(LatinDec - "+rst00.getString("LatinDec")+") <=0.5 order by TheFieldDataDate, TheFieldDataTime asc limit 1"; 
rst100= st100.executeQuery(sql100);
if(rst100.next())
{
if(rst100.getDouble("time2")-rst00.getDouble("time1") >=30)
{
double duration=(Double.parseDouble(rst100.getString("time2"))-Double.parseDouble(rst00.getString("time1")));
int hrs=(int)duration/60;
int min=(int)duration%60;
String html2="ST "+rst00.getString("TheFieldDataDate")+"  "+rst00.getString("TheFieldDataTime")+"<br> "+hrs+"hrs"+min+"min  "+rst00.getString("TheFieldSubject");
stcount2++;


%> 
            var point1 = new GLatLng(<%=rst00.getString("LatinDec")%>,<%=rst00.getString("LonginDec")%>);
	var marker = createMarker(point1,"<%= html2%>","<%= html2%>","<%="ST"%>");
      map.addOverlay(marker);

	
<%
}
}
}
%>
side_bar_html +='<br><font color="red" face="arial" size="1"><b>Total Stop Count  : </b></font> <font color="#B22222" face="arial" size="1"><b><%= stcount2%> </b></font><br><br>';
<%

conn00.close();
}catch(Exception e)
{
	out.print("Exception "+e);
}
%>
