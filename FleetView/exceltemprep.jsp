<%@ include file="Connections/conn.jsp" %>

<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>

<% response.setContentType("application/vnd.ms-excel");
response.addHeader("Content-Disposition", "attachment;filename=tempreport.xls");
%>

<%!
Connection con1, con2;
String today,today1;
%>

<%
try {

Driver MM_driverUser = (Driver)Class.forName(MM_dbConn_DRIVER).newInstance();

con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

Statement stmt1=con1.createStatement(), stmt2=con1.createStatement(), stmt3=con1.createStatement();
ResultSet rs1=null, rs2=null, rs3=null, rs4=null, rs5=null, rs6=null;
String sql1="", sql2="", sql3="", sql4="", sql5="", sql6="";
String veh="", frmdte="", todte="", vehcode="", distdte="", dte1="", dte2="";       
int cntr=0, noofdys=0;
double avgtemp1=0, avgtemp2=0, avgtemp3=0, avgtemp4=0;

String user=session.getAttribute("usertypevalue").toString();

sql1="select VehicleRegNumber from t_vehicledetails where OwnerName='"+user+"' and Description='TEMPSENSOR' order by VehicleRegNumber asc ";
rs1=stmt1.executeQuery(sql1);

Format formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
today= formatter.format(new java.util.Date());

%>




<% veh=request.getParameter("veh");
   frmdte=request.getParameter("calender");
   todte=request.getParameter("calender1");
   

   if(veh==null || veh.equals("Select"))
   {
   }
   else
   { 
      
      
      sql2="select VehicleCode from t_vehicledetails where VehicleRegNumber='"+veh+"' ";
      //out.println(sql2);
      rs2=stmt1.executeQuery(sql2);
      while(rs2.next())
      {
         vehcode=rs2.getString("VehicleCode");
      }
      //out.println(vehcode);

  java.util.Date tdydte = new java.util.Date();
	Format formatter11 = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
	String s=formatter11.format(tdydte);
   
%>      
<table class="stats">
	 <tr>
           <td colspan="7"><font size="2"> <B>Temperature Report for the Vehicle <%=veh %> from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(frmdte)) %> To <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todte)) %> </B> </font> 	 </td>
       </tr>
	<tr>
		<td align="right" colspan="7">  <B> <%=s%>  </B>  </td>
	</tr>     
       <tr>
           <th> Date </th>
           
           <th> Sensor1 </th>
           <th> Sensor2 </th>
           <th> Sensor3 </th>
           <th> Sensor4 </th>
           
       </tr>   

<%   
   sql4="select distinct(TheFieldDataDate) from t_veh"+vehcode+" where TheFieldDataDate>='"+frmdte+"' and TheFieldDataDate<='"+todte+"'  ";
    //out.println(sql4);
    rs4=stmt1.executeQuery(sql4);
    while(rs4.next())
    {
      distdte=rs4.getString(1);
      
      sql5="select * from t_timeslots where concat('"+distdte+"',' ',slot2)<='"+today+"'";
      rs5=stmt2.executeQuery(sql5);
      while(rs5.next())
      {
         dte1=distdte+" "+rs5.getString(1);
         dte2=distdte+" "+rs5.getString(2);

        sql6="select avg(Sen1) as sen1, avg(Sen2) as sen2, avg(Sen3) as sen3, avg(Sen4) as sen4   from t_veh"+vehcode+" where concat(TheFieldDataDate,' ',TheFieldDataTime)>='"+dte1+"' and concat(TheFieldDataDate,' ',TheFieldDataTime)<='"+dte2+"'";
         //out.println(sql6);
         rs6=stmt3.executeQuery(sql6);
         if(rs6.next())
         {
           avgtemp1=rs6.getDouble("sen1");
           String s1=""+avgtemp1;
           s1=s1.substring(0,(s1.indexOf(".")+2));

           avgtemp2=rs6.getDouble("sen2");
           String s2=""+avgtemp2;
           s2=s2.substring(0,(s2.indexOf(".")+2));

           avgtemp3=rs6.getDouble("sen3");
           String s3=""+avgtemp3;
           s3=s3.substring(0,(s3.indexOf(".")+2));

           avgtemp4=rs6.getDouble("sen4");
           String s4=""+avgtemp4;
           s4=s4.substring(0,(s4.indexOf(".")+2));

          
 %>
            <tr>
               <td class="bodyText"><%
java.util.Date sd1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(dte2);
Format fmt1 = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String sh1 = fmt1.format(sd1);
 out.print(sh1);%></td>
               <td class="bodyText"><% if(s1.equals("0.0")) {out.print("xxxx");} else { out.print(s1); } %>  </td>
               <td class="bodyText"><% if(s2.equals("0.0")) {out.print("xxxx"); } else { out.print(s2); } %>  </td>
               <td class="bodyText"> <% if(s3.equals("0.0")) {out.print("xxxx"); } else { out.print(s3); } %></td>
               <td class="bodyText"> <% if(s4.equals("0.0")) {out.print("xxxx"); } else { out.print(s4); }%> </td>
               
            </tr>
  
      <% }
         
         
      }      
    }
    //out.println(avgtemp);
%>

     </table>       
<% }

} catch(Exception e) { out.println("Exception----->" +e); }

finally
{
con1.close();

}
%>

<table border="1" width="100%" >
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>


