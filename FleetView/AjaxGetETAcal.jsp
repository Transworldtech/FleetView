<%@ include file="Connections/conn.jsp" %>
<%!
Connection con1;
%>

<%
try {
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

Statement stmt1=con1.createStatement();
ResultSet rs1=null;
String sql="";
String username,Rcode,strtdte,strttmehrs,strttmemin;
Rcode=request.getParameter("Rcode");
strtdte=request.getParameter("strtdte");
strttmehrs=request.getParameter("strttmehrs");
strttmemin=request.getParameter("strttmemin");
username=session.getAttribute("user").toString();

String ShowDate =strtdte+" "+strttmehrs+":"+strttmemin+":00";
ShowDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(ShowDate));
java.util.Date ShowDate1 =new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(ShowDate);

long strmils=ShowDate1.getTime();
sql="select FixedTime from t_routedetails where RCode='"+Rcode+"'";
ResultSet rst=stmt1.executeQuery(sql);
int i=1;
String FixedTime="";
if(rst.next())
{
	
	FixedTime=rst.getString("FixedTime");
	
	//i++;
}
//System.out.println(FixedTime);
java.util.Date stdtm=new SimpleDateFormat("HH").parse(FixedTime);
long stdtmils=stdtm.getTime();
//System.out.println("stdtmils****--->"+stdtmils);
long totmils=strmils+stdtmils;
java.util.Date etatime=new java.util.Date();
etatime.setTime(totmils);

String ETA="";
String sqleta="SELECT '"+ShowDate+"' + INTERVAL '"+FixedTime+"' HOUR as ETA";
ResultSet rstt=stmt1.executeQuery(sqleta);
if(rstt.next())
{
	
	ETA=rstt.getString("ETA");
	
	//i++;
}

String etadate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(ETA));
String etahrs=new SimpleDateFormat("HH").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(ETA));
String etamin=new SimpleDateFormat("mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(ETA));

out.print("#"+etadate+"#"+etahrs+"#"+etamin+"#");

} catch(Exception e) {out.println(e);}

finally
{
con1.close();
}

%>