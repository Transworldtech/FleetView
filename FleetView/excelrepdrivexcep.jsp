<%@ include file="Connections/conn.jsp" %>

<%!
Connection con1;
String firstdte="", prvdte="", getdriv="";
%>

<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% response.setContentType("application/vnd.ms-excel");
//Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
//String showdatex = formatterx.format(new java.util.Date());

getdriv=session.getValue("driv").toString();
response.addHeader("Content-Disposition", "attachment;filename=drivexceptionrep.xls");

%>

<%
try {
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

Statement stmt1=con1.createStatement();
ResultSet rs1=null;
String sql1="";

String user=session.getValue("usertypevalue").toString();

 out.print("<p> </p>");
 out.print("<table class='stats'>");
 out.print("<tr> <td> <div align='center'> <font color='maroon'> <b>");
 out.print("Last 10 Trip Exception Report of Driver "); 
 out.print(getdriv);
 out.print("</b>");
 out.print("</font> </div> </td> </tr>");
 out.print("</table>");
 
 int count=0;
 out.print("<table class='stats'>");
 out.print("<tr> <th> Sr. No.</th> <th> Trip Id </th> <th> Transp </th> <th> Veh. Reg </th> <th> Start Place </th> <th> Start Date - Time </th> <th> End Place </th> <th> End Date - Time </th> <th> OS </th> <th> AC </th> <th> DC </th> <th> DT </th> <th> ND </th> </tr> ");
 sql1="select * from t_completedjourney where DriverName='"+getdriv+"' order by StartDate desc limit 10 ";
 rs1=stmt1.executeQuery(sql1);
 while(rs1.next())
  { 
         String stdte=rs1.getString("StartDate");
         String enddte=rs1.getString("EndDate");
         count++;
         out.print("<tr> <td>");
         out.print(count+"</td>");
         out.print("<td>"+rs1.getString("TripId")+"</td>");
         out.print("<td>"+rs1.getString("OwnerName")+"</td>");
         out.print("<td>"+rs1.getString("VehRegNo")+"</td>");
         out.print("<td>"+rs1.getString("StartPlace")+"</td>");
         
         String nwfrmtdte="", nwfrmtdte1="";	
	try{
         
         java.util.Date datefrmdb=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(stdte);
         Format formatter=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
         nwfrmtdte=formatter.format(datefrmdb);  
 	} catch (Exception e)
	{
		try {
			 java.util.Date datefrmdb10=new SimpleDateFormat("yyyy-MM-dd").parse(stdte);
        	 	Format formatter10=new SimpleDateFormat("dd-MMM-yyyy");
			nwfrmtdte=formatter10.format(datefrmdb10); 
		     } catch(Exception ee)	
			{
				nwfrmtdte=stdte;
			}
	}
         
	try {
	
         java.util.Date datefrmdb1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(enddte);
         Format formatter1=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
         nwfrmtdte1=formatter1.format(datefrmdb1);         
	} catch(Exception e)
	  {
		try {
			java.util.Date datefrmdb11=new SimpleDateFormat("yyyy-MM-dd").parse(enddte);
        		 Format formatter11=new SimpleDateFormat("dd-MMM-yyyy");
        		 nwfrmtdte1=formatter11.format(datefrmdb11);         
		   } catch(Exception ee)
		     {
				nwfrmtdte1=enddte;	
   		     }		
  	  }  	
          
         
         out.print("<td>"+nwfrmtdte+"</td>");
         out.print("<td>"+rs1.getString("EndPlace")+"</td>");
         out.print("<td>"+nwfrmtdte1+"</td>");
         out.print("<td>"+rs1.getInt("OSCount")+"</td>");
         out.print("<td>"+rs1.getInt("RACount")+"</td>");
         out.print("<td>"+rs1.getInt("RDCount")+"</td>");
         out.print("<td>"+rs1.getString("Kmtravelled")+"</td>");
         out.print("<td>"+rs1.getString("NDCount")+"</td> </tr>");
 }
 out.print("</table>");

   
} catch(Exception e) {out.println(e);}

finally
{
con1.close();
}

%>
