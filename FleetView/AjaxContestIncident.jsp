
<%@page import="org.apache.poi.hssf.record.formula.functions.Replace"%><%@ include file="Connections/conn.jsp" %>

<%!
Connection con1;
Statement st;
%>
<% 
try {

Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=con1.createStatement();
ResultSet rst=null;
String sql="";
boolean flag=false;
int element=99;
String transporter=request.getParameter("transporter");
transporter=transporter.replace(".","");
transporter=transporter.replace(" ","");
transporter=transporter.replace("-","");
transporter=transporter.replace("_","");
System.out.println("^^^^^^^^ "+transporter);
int cnt=0;
String A=request.getParameter("limitcount");
System.out.println(">>>>>>>>>>>>>>>>     "+A);
int limitcnt=0;
limitcnt=Integer.parseInt(A);
//String user=request.getParameter("user");
		
		sql="SELECT DISTINCT(OwnerName) as Owner FROM db_gps.t_vehicledetails WHERE STATUS = '-' and OwnerName like '%"+transporter+"%' order by OwnerName asc";		
System.out.println(sql);
rst=st.executeQuery(sql);
String buffer="<div style='height:110px;width:300px;overflow:auto; align:left;'><table style='display: block';>";
int i=1;
while(rst.next())
{
		 String transporter1=rst.getString("Owner");
		 buffer+="<tr><td><div  align='left'><a style='color: black;' href='#' onclick='getTransporterDetails(\""+transporter1+"\");'>"+transporter1.replaceAll("(?i)"+transporter,"<font color=blue><u>"+transporter.toUpperCase()+"</u></font>")+"</a></div></tr></td>";
		 i++;
}

System.out.println("limitcnt    "+limitcnt);
buffer+="<tr><td><input type='hidden'  name='element'  id='element'  value='"+limitcnt+"'/></td></tr>";

if(limitcnt!=0 && i>20)
{ 
	   buffer+="<tr><td align='right'><h3><a href='#' onclick='getTransporter(2);' >more..</a></h3></td></tr>";
      // buffer+="<tr><td><input type='hidden'  name='element'  id='element'  value='"+limitcnt+"'/></td></tr>";

}else{  
	   System.out.println("BUFFER HAS TO GO BLANK>>>>>>>>>>>>> .  ");
	   buffer+="<tr><td></td></tr>";
	      
}

buffer+="</table></div>";
out.println(buffer+"</select>");

buffer=null;

} catch(Exception e) { 
	out.print("<div style='height:110px;width:300px;overflow:auto; align:left;'><table style='display: block';></table></div>");
	}
	finally
	{
		st.close();
		con1.close();
	}

%>