<%@page	 
	import="java.util.Date"
	import="java.lang.Math"	
	%>
<%@ include file="Connections/conn.jsp" %>

<%!
Connection con1=null;
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
String renderStart="",renderEnd="";

String projectName = request.getContextPath();
projectName = projectName.replace("\\","");
projectName = projectName.replace("/","");


final String User=(String) session.getAttribute("mainuser");
String PageName=request.getParameter("PageName");
int elapsed=Integer.parseInt(request.getParameter("elapsed")); // in milisec
elapsed=elapsed/1000; // converted milisec  into sec

try{

SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");	
long renDt=Long.parseLong(request.getParameter("renderStart"));
Date curr= new java.util.Date();
curr.setTime(renDt);


renderStart = dateFormat.format(curr);


long renDtE=Long.parseLong(request.getParameter("renderEnd"));
Date currE= new java.util.Date();
currE.setTime(renDtE);


renderEnd = dateFormat.format(currE);

}
catch(Exception e)
{
	e.printStackTrace();
}




String UserIp="-";
String sql7="select UserIp  from db_gps.t_sessions where UserName='"+User+"'";

			ResultSet rs7=st.executeQuery(sql7);
			
			if(rs7.next())
			{
				UserIp=rs7.getString("UserIp");
			}
			

sql="insert into db_gps.t_pageloadingtime (Userid,Page,Startdt,Enddt,Diff,ip,projectName) values ('"+User+"','"+PageName+"','"+renderStart+"','"+renderEnd+"','"+elapsed+"','"+UserIp+"','"+projectName+"')";
int ins=0;
ins=st.executeUpdate(sql);
if(ins>=1){
	
		System.out.println("t_pageloadingtime :Updates");
	
		out.print("Updated");
//buffer=null;
}

} catch(Exception e) { 
	out.print("NotDone");
	}
finally
{
con1.close();	
}

%>