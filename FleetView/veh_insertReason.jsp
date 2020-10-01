<%@ include file="Connections/conndriver.jsp" %>
<%! 
Connection con ;
%>

<%
      

        String todaysDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());

        String vehregno = request.getParameter("vehregno");
        String vid= request.getParameter("vid");
        String tripId  = request.getParameter("tripid");
     
        String stDate  = request.getParameter("startdatetime");
        String endDate= request.getParameter("enddatetime");
        
        String name= request.getParameter("entersname");
        String reason= request.getParameter("reason");
        String comments=request.getParameter("comments");

try{           
Class.forName(MM_dbConn_DRIVER);
con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt=con.createStatement();



String Add="insert into db_gpsExceptions.t_ndpostintimation(VehRegNo,Vehcode,TripId,NdStartDateTime,NdEndDateTime,EnterBy,EnterDateTime,Reason,Comments)values('"+vehregno+"','"+vid+"','"+tripId+"','"+stDate+"','"+endDate+"','"+name+"','"+todaysDateTime+"','"+reason+"','"+comments+"')";
System.out.println(">>>>>>>>Add:"+Add); 
int cnt=stmt.executeUpdate(Add);
System.out.println(">>>>>>>>cnt:"+cnt);

out.println("#Yes");

//response.sendRedirect("veh_report_ndfeedback.jsp?msg="+msg);



}catch(Exception e){
out.println( "Exception ::"+e );
}
%>
