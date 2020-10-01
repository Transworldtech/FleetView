
<%@page import="java.math.BigDecimal,java.text.*,java.util.Date"%>
<%@ include file="Connections/conn.jsp" %>
<%
Connection con1=null;
Statement st=null;
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=con1.createStatement();

//fixedkm="+fixedkm+"&tripexpence="+tripexpence+"&ratekm="+ratekm+"&ratehr="+ratehr+"&cal="+cal+"&sttime1="+sttime1+"&sttime2="+sttime1+"";
String fixedkm=request.getParameter("fixedkm");
String tripexpence=request.getParameter("tripexpence");
String ratekm=request.getParameter("ratekm");
String ratehr=request.getParameter("ratehr");
String startdate=request.getParameter("startdate");
String sttime1=request.getParameter("sttime1");
String sttime2=request.getParameter("sttime2");

String startdatetime=startdate+" "+sttime1+":"+sttime2;
startdatetime=new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm").parse(startdatetime));
System.out.println("StartDateTIme:-"+startdatetime);

System.out.println("fixedkm:-"+fixedkm);
System.out.println("tripexpence:-"+tripexpence);

float frk=Float.parseFloat(fixedkm)*Float.parseFloat(ratekm);
System.out.println("frk:-"+frk);
float tefrk=Float.parseFloat(tripexpence)-frk;
System.out.println("tefrk:-"+tefrk);
float eta=tefrk/Float.parseFloat(ratehr);
System.out.println("eta:-"+eta);
BigDecimal finalprice=new BigDecimal(eta).setScale(2,BigDecimal.ROUND_HALF_UP);

System.out.println("eta:-"+finalprice);
SimpleDateFormat df = new SimpleDateFormat("HH:mm");
SimpleDateFormat df1 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
int HH=0,MM=0;
String finalprice1=finalprice.toString();
finalprice1=finalprice1.replace(".", ":");
StringTokenizer stk = new StringTokenizer(finalprice1, ":");
	if(stk.hasMoreTokens()){
		 HH= Integer.parseInt((String) stk.nextElement());
		 MM= Integer.parseInt((String) stk.nextElement());
		System.out.println("HH:-"+HH);
		System.out.println("MM:-"+MM);
	}

System.out.println("finalprice1:-"+finalprice1);
/* Date d=df.parse(finalprice1);
System.out.println("D:-"+d);
Long time = d.getTime(); 
System.out.println("Time:-"+time); */
//  Logic for adding hour and min to startdatetime
String fixedtime="";
fixedtime=Integer.toString(HH)+":"+Integer.toString(MM);
String startdate1="";

try{
 Date date2 = df1.parse(startdatetime);

 
//
//time logic
Calendar cal1 = Calendar.getInstance(); // creates calendar
   // cal1.setTime(new Date()); // sets calendar time/date
   cal1.setTime(date2);
    cal1.add(Calendar.HOUR_OF_DAY, HH); // adds one hour
    cal1.add(Calendar.MINUTE, MM);
    cal1.getTime();
    System.out.println("DateTime:-"+df1.format(cal1.getTime()));
    SimpleDateFormat df2 = new SimpleDateFormat("dd-MMM-yyyy HH:mm");
    SimpleDateFormat df3 = new SimpleDateFormat("HH");
    SimpleDateFormat df4 = new SimpleDateFormat("MM");
    startdate=df2.format(cal1.getTime());
     startdate1=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm").parse(startdate));
    sttime1=new SimpleDateFormat("HH").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm").parse(startdate));
    sttime2=new SimpleDateFormat("mm").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm").parse(startdate));
    System.out.println(startdate);
    System.out.println(sttime1);
    System.out.println(sttime2);
    session.setAttribute("Minute",sttime2);
 	/* Time timediff=null;
    String sql="select TIMEDIFF('" + df1.format(cal1.getTime()) + "','" +startdatetime+ "')";
    System.out.println(sql);
    ResultSet rs=st.executeQuery(sql);
    if(rs.next())
    {
    	timediff=rs.getTime(1);
    } 
    System.out.println("TImediff: "+timediff);
     */
    
}catch(Exception e){
	e.printStackTrace();
}
out.println(fixedtime+"#"+startdate1+"#"+sttime1+"#"+sttime2);
/* out.println(startdate);
out.println(sttime1);
out.println(sttime2); */
//out.println()
%>