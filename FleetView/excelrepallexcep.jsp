<%@ include file="Connections/conn.jsp" %>

<%!
Connection con1, con2;
String firstdte="", prvdte="", getveh="", firstdte1="", prvdte1="", getdriv="";

%>

<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% response.setContentType("application/vnd.ms-excel");
//Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
//String showdatex = formatterx.format(new java.util.Date());

response.addHeader("Content-Disposition", "attachment;filename=allexceptionrep.xls");

%>



<%
try {
    
       try
      {    
         try
         {
            getdriv=session.getValue("driv").toString();
            //out.print("Driver is "+getdriv);
            
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
         
        	 java.util.Date datefrmdb=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(stdte);
        	 Format formatter=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
        	 String nwfrmtdte=formatter.format(datefrmdb);  
         
        	 java.util.Date datefrmdb1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(stdte);
        	 Format formatter1=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
        	 String nwfrmtdte1=formatter.format(datefrmdb1);         
         
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

         } catch(Exception f)
           {
               out.print("Exception>>>>>"+f);
           }
           finally
           {
             con1.close();
           }

 out.print("<br>");
 out.print("<br>");
out.print("<br>"); 
out.print("<br>");
     getveh=session.getValue("vehic").toString();
     //getdriv=session.getValue("driv").toString();
     //out.print("Driverrr is "+getdriv);
    
     
     //out.print("Veh="+getveh);
  
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
con2 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

Statement stmt1=con1.createStatement(), stmt2=con1.createStatement(), stmt3=con1.createStatement(), stmt4=con1.createStatement(), stmt5=con2.createStatement();
ResultSet rs1=null, rs2=null, rs8=null, rs9=null, rs10=null, rs11=null, rs12=null, rs13=null, rs14=null;
String sql="", sql1="", sql2="", sql3="", sql4="", sql5="", sql6="", sql7="", sql8="", sql9="", sql10="", sql11="", sql12="", sql13="", sql14="";

String nd="";
int vehcode=0;
int cn=1,dis=0,d1=0,d2=0;
int oscount=0, account=0, dccount=0, stcount=0;
long hours=0, minutes=0;
String user=session.getValue("usertypevalue").toString(); 

java.util.Date ddd=new java.util.Date();
long dateMillis2 = ddd.getTime();
long dayInMillis2 = 1000 * 60 * 60 *24;

Format NewFormatter1 = new SimpleDateFormat("yyyy-MM-dd");
String data1 = NewFormatter1.format(ddd);
 
/*
dateMillis2 = dateMillis2 - dayInMillis2;
ddd.setTime(dateMillis2);

out.print(data1); */


/********start code for waiting time ***********/
sql="select * from t_vehicledetails where VehicleRegNumber='"+getveh+"' ";
ResultSet rst=stmt1.executeQuery(sql);
if(rst.next())
{
  vehcode=rst.getInt("VehicleCode");
}


   sql2="select concat(TheFieldDataDate,' ',TheFieldDataTime) as dt,Distance from t_veh"+vehcode+" where TheFiledTextFileName='SI' order by concat(TheFieldDataDate,TheFieldDataTime) desc limit 1";
 
 
   ResultSet rst1=stmt2.executeQuery(sql2);
   if(rst1.next())
   {
       firstdte=rst1.getString("dt");
      
       sql3="select concat(TheFieldDataDate,' ',TheFieldDataTime) as dt,Distance from t_veh"+vehcode+" where TheFiledTextFileName='SI' and "+rst1.getInt("Distance")+"- Distance >=2 order by concat(TheFieldDataDate,TheFieldDataTime) desc limit 1";
      //out.print(sql3);
       ResultSet rst2=stmt3.executeQuery(sql3);
       if(rst2.next())
       {
           prvdte=rst2.getString("dt");
 
           java.util.Date NewDate = new SimpleDateFormat("yyyy-MM-ddHH:mm:ss").parse(rst1.getString("dt"));
           long dateMillis = NewDate.getTime();

           java.util.Date NewDate1 = new SimpleDateFormat("yyyy-MM-ddHH:mm:ss").parse(rst2.getString("dt"));
           long dateMillis1 = NewDate1.getTime();


           long temptime=dateMillis-dateMillis1;
           temptime=temptime/1000;
           hours=(temptime /60)/60;
           minutes=((temptime /60)%60);
           //out.print(hours);
           //out.print(minutes);


        } 
    }
 /********end code for waiting time ***********/  


/********start code for OS, AC, DC count time ***********/
java.util.Date NewDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(firstdte);
long dateMillis = NewDate.getTime();
long dayInMillis = 1000 * 60 * 60 *24;
dateMillis = dateMillis - dayInMillis;
NewDate.setTime(dateMillis);
Format formatter5 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String lastdate = formatter5.format(NewDate);
//out.print(firstdte);
//out.print(lastdate);

sql4="select * from t_veh"+vehcode+" where concat(TheFieldDataDate,' ',TheFieldDataTime) <='"+firstdte+"' and concat(TheFieldDataDate,' ',TheFieldDataTime)>='"+lastdate+"' ";
ResultSet rst3=stmt3.executeQuery(sql4);
//out.print(sql4);


while(rst3.next())
{

String stamp=rst3.getString("TheFiledTextFileName");

if(stamp.equals("OS"))
{
	oscount++;
}

if(stamp.equals("AC"))
{
	if (rst3.getInt("Distance")>5)
	{
	account++;
	
	}

}

if(stamp.equals("DC"))
{
	if (rst3.getInt("Distance")<120)
	{

	dccount++;
	}
}

if(stamp.equals("SI"))
{
	if(cn==1)
	{
		 d1=rst3.getInt("Distance");
		 cn++;
	}
	else
	{
		 d2=rst3.getInt("Distance");
	}
}
dis=d2-d1;
}

/******** code ends for OS, AC, DC count time ***********/

/******************code for stops***************/

sql5="select *, (HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) as time1 from t_veh"+vehcode+" where TheFiledTextFileName='SP' and concat(TheFieldDataDate,' ',TheFieldDataTime) <='"+firstdte+"' and concat(TheFieldDataDate,' ',TheFieldDataTime)>='"+lastdate+"' order by concat(TheFieldDataDate,' ',TheFieldDataTime) asc";
//out.print(sql5);
ResultSet rst4= stmt3.executeQuery(sql5);
stcount=0;
while(rst4.next())
{
sql6="select *,(HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) as time2 from t_veh"+vehcode+" where TheFiledTextFileName='ST' and concat(TheFieldDataDate,' ',TheFieldDataTime) <='"+firstdte+"' and concat(TheFieldDataDate,' ',TheFieldDataTime)>='"+lastdate+"' and TheFieldDataDate='"+rst4.getString("TheFieldDataDate")+"' and (HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) > "+Double.parseDouble(rst4.getString("time1"))+" and abs(LatinDec - "+rst4.getString("LatinDec")+") <=0.5 order by concat(TheFieldDataDate,' ',TheFieldDataTime) asc limit 1";
//out.print(sql6); 
ResultSet rst5= stmt4.executeQuery(sql6);
if(rst5.next())
{
if(rst5.getDouble("time2")-rst4.getDouble("time1") >=Integer.parseInt(session.getAttribute("stop11").toString()))
{
double duration=(Double.parseDouble(rst5.getString("time2"))-Double.parseDouble(rst4.getString("time1")));
int hrs=(int)duration/60;
int min=(int)duration%60;
String html2="ST "+rst4.getString("TheFieldDataDate")+"  "+rst4.getString("TheFieldDataTime")+"<br> "+hrs+"hrs "+min+"min  "+rst4.getString("TheFieldSubject");
stcount++;
}
}
}


/******************code for stops***************/

/**************** code for Night Driving ***************/
sql7="select * from t_veh"+vehcode+"_nd where concat(FromDate,' ',FromTime) <='"+firstdte+"' and concat(FromDate,' ',FromTime)>='"+lastdate+"' order by concat(FromDate,' ',FromTime) asc";
ResultSet rst6=stmt5.executeQuery(sql7);
if(rst6.next())
{
  nd="Yes";
}
else
{
  nd="No";
}
/***********end of Code for Night Driving ************/

 out.print("<table class='stats'>");
 out.print("<tr> <td> <div align='center'> <font color='maroon'> <b>");
 out.print("Last 24 Hours Exception Report of Vehicle "); 
 out.print(getveh);
 out.print("</b>");
 out.print("</font> </div> </td> </tr>");
 out.print("</table>");

 out.print("<table class='stats'>");
 out.print("<tr> <th> Waiting Time </th> <th> OS </th> <th> AC </th> <th> DC </th> <th> CD </th> <th> DT </th> <th> Stops </th> <th> ND </th> </tr> ");
 out.print("<tr> <td>");
 out.print(hours);
 out.print("hrs ");
 
 out.print(minutes);
 out.print("mins");
 out.print("</td> <td>");
 out.print(oscount);
 out.print("</td> <td>");
 out.print(account);
 out.print("</td> <td>");
 out.print(dccount);
 out.print("</td> <td>");
 out.print("0");
 out.print("</td> <td>");
 out.print(dis);
 out.print("</td> <td>");
 out.print(stcount);
 out.print("</td> <td>");
 out.print(nd);
 out.print("</td> </tr>");
 out.print("</table>");



/**************** code for Over Speed ********************/
 out.print("<table class='stats'>");
  out.print("<tr> <td colspan='4'> <div align='center'> <font color='maroon'> <b> Description of OS Exception/s </b> </font> </div> </td></tr>");
 out.print("<tr> <th> Date-Time </th> <th> Speed </th> <th> Distance </th> <th> Location </th> </tr> ");

sql8="SELECT * FROM t_veh"+vehcode+" where concat(TheFieldDataDate,' ',TheFieldDataTime) <='"+firstdte+"' and concat(TheFieldDataDate,' ',TheFieldDataTime) >='"+lastdate+"' and TheFiledTextFileName='OS' order by concat(TheFieldDataDate,' ',TheFieldDataTime) desc";

rs8=stmt1.executeQuery(sql8);
while(rs8.next())
{
	
out.print("<tr>");
out.print("<td class='bodyText'>");

java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(rs8.getString("TheFieldDataDate"));
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
String showdate1 = formatter1.format(ShowDate1);
 out.print(showdate1+" ");

 out.print(rs8.getString("TheFieldDataTime"));
 out.print("</td>");
	out.print("<td class='bodyText'>");
	out.print(rs8.getString("Speed"));
	out.print("</td>");
	out.print("<td class='bodyText'>");
	out.print(rs8.getString("Distance"));
	out.print("</td>");
	out.print("<td class='bodyText'> <div align='left'>");
	out.print(rs8.getString("TheFieldSubject"));
	out.print("</div></td> </tr>");
	
}
out.print("</table>");

/*************** end of code for Over Speed **************/

/**************** Start code for Rapid Acceleration *********************/

 out.print("<table class='stats'>");
  out.print("<tr> <td colspan='4'> <div align='center'> <font color='maroon'> <b> Description of AC Exception/s </b> </font> </div> </td></tr>");
 out.print("<tr> <th> Date-Time </th> <th> From Speed </th> <th> To Speed </th> <th> Location </th> </tr> ");

 sql9="SELECT * FROM t_veh"+vehcode+" where  concat(TheFieldDataDate,' ',TheFieldDataTime)<='"+firstdte+"' and concat(TheFieldDataDate,' ',TheFieldDataTime)>='"+lastdate+"' and TheFiledTextFileName='AC' order by TheFieldDataDate desc,TheFieldDataTime desc";
 rs9=stmt1.executeQuery(sql9);
while(rs9.next())
{
  if(rs9.getInt("Distance")>5)
  { 
    out.print("<tr>");
    out.print("<td class='bodyText'>");
    
    java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(rs9.getString("TheFieldDataDate"));
    Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
    String showdate1 = formatter1.format(ShowDate1);
    out.print(showdate1+" ");
    out.print(rs9.getString("TheFieldDataTime"));
    out.print("</td>");
    out.print("<td class='bodyText'>");
    out.print(rs9.getString("Distance"));
    out.print("</td>");
	 out.print("<td class='bodyText'>");
	 out.print(rs9.getString("Speed"));
	 out.print("</td>");
	 out.print("<td class='bodyText'><div align='left'>");
	 out.print(rs9.getString("TheFieldSubject"));
	 out.print("</div> </td> </tr>");
  }
}
out.print("</table>");
/**************** End Rapid Acceleration *********************/

/****************Start code for Rapid Deceleraion *************************/
  out.print("<table class='stats'>");
  out.print("<tr> <td colspan='4'> <div align='center'> <font color='maroon'> <b> Description of DC Exception/s </b> </font> </div> </td></tr>");
  out.print("<tr> <th> Date-Time </th> <th> From Speed </th> <th> To Speed </th> <th> Location </th> </tr> ");

  sql10="SELECT * FROM t_veh"+vehcode+" where concat(TheFieldDataDate,' ',TheFieldDataTime)<='"+firstdte+"' and concat(TheFieldDataDate,' ',TheFieldDataTime)>='"+lastdate+"' and TheFiledTextFileName='DC' order by TheFieldDataDate desc,' ',TheFieldDataTime desc";
 //out.print(sql10);
 rs10=stmt1.executeQuery(sql10);
while(rs10.next())
{
  if(rs10.getInt("Distance")<120)
  {
     out.print("<tr>");
     out.print("<td class='bodyText'>");
     
     java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(rs10.getString("TheFieldDataDate"));
     Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
     String showdate1 = formatter1.format(ShowDate1);
     out.print(showdate1+" ");
     
     out.print(rs10.getString("TheFieldDataTime"));
     out.print("</td>");
     out.print("<td class='bodyText'>");
     out.print(rs10.getString("Distance"));
     out.print("</td>");
     out.print("<td class='bodyText'>");
     out.print(rs10.getString("Speed"));
     out.print("</td>");
     out.print("<td class='bodyText'><div align='left'>");
     out.print(rs10.getString("TheFieldSubject"));
     out.print("</div></td> </tr>");
	}
}
out.print("</table>");
/***************** End of Rapid Deceleration ****************/

/******************code for stops***************/

out.print("<table class='stats'>");
  out.print("<tr> <td colspan='4'> <div align='center'> <font color='maroon'> <b> Description of Stop/s </b> </font> </div> </td></tr>");
 out.print("<tr> <th>Start Date-Time</th> <th> End Date-Time</th> <th> Duration </th> <th> Location </th> </tr> ");

sql11="select *, (HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) as time1 from t_veh"+vehcode+" where TheFiledTextFileName='SP' and concat(TheFieldDataDate,' ',TheFieldDataTime) <='"+firstdte+"' and  concat(TheFieldDataDate,' ',TheFieldDataTime) >='"+lastdate+"'  order by concat(TheFieldDataDate,TheFieldDataTime) asc";
rs11= stmt1.executeQuery(sql11);

while(rs11.next())
{
	sql12="select *,(HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) as time2 from t_veh"+vehcode+" where TheFiledTextFileName='ST' and concat(TheFieldDataDate,' ',TheFieldDataTime) <='"+firstdte+"' and TheFieldDataDate='"+rs11.getString("TheFieldDataDate")+"' and (HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) > "+Double.parseDouble(rs11.getString("time1"))+" and abs(LatinDec - "+rs11.getString("LatinDec")+") <=0.5 order by concat(TheFieldDataDate,' ',TheFieldDataTime) asc limit 1"; 
	rs12= stmt2.executeQuery(sql12);
	if(rs12.next())
	{
	if(rs12.getDouble("time2")-rs11.getDouble("time1") >=Integer.parseInt(session.getAttribute("stop11").toString()))
		{
			double duration=(Double.parseDouble(rs12.getString("time2"))-Double.parseDouble(rs11.getString("time1")));
			int hrs=(int)duration/60;
			int min=(int)duration%60;
			
         out.print("<tr> <td class='bodyText'><div align='left'> ");

         java.util.Date ShowDate3 = new SimpleDateFormat("yyyy-MM-dd").parse(rs11.getString(1));
         Format formatter3 = new SimpleDateFormat("dd-MMM-yyyy");
         String showdate3 = formatter3.format(ShowDate3);
         out.print(showdate3+" ");

         out.print(rs11.getString(2));
         out.print("</div></td>");

         out.print("<td class='bodyText'><div align='left'>");
         
         java.util.Date ShowDate4 = new SimpleDateFormat("yyyy-MM-dd").parse(rs12.getString(1));
         Format formatter4 = new SimpleDateFormat("dd-MMM-yyyy");
         String showdate4 = formatter4.format(ShowDate4);
         out.print(showdate4+" ");
         out.print(rs12.getString(2)); 
         out.print("</div></td>");
         out.print("<td class='bodyText'><div align='left'>");
         out.print(hrs+"hrs");
         out.print(" ");
         out.print(min+"min");
         out.print("</div></td>");
         out.print("<td class='bodyText'><div align='left'>");
         out.print(rs11.getString("TheFieldSubject"));
         out.print("</div></td></tr>");
    	}

	}
}
out.print("</table>");
/******************code for stops ENDS***************/

/*****************code for Night Driving STARTS*******/

out.print("<table class='stats'>");
  out.print("<tr> <td colspan='4'> <div align='center'> <font color='maroon'> <b> Description of Night Driving </b> </font> </div> </td></tr>");
 out.print("<tr> <th>Start Date-Time</th> <th> End Date-Time</th> <th> Distance </th> <th> Location </th> </tr> ");

sql13="select * from t_veh"+vehcode+"_nd where concat(FromDate,' ',FromTime) <='"+firstdte+"' and concat(FromDate,' ',FromTime)>='"+lastdate+"' order by concat(FromDate,' ',FromTime) asc";
rs13=stmt5.executeQuery(sql13);
while(rs13.next())
{
   out.print("<tr> <td class='bodyText'> ");

    java.util.Date ShowDate4 = new SimpleDateFormat("yyyy-MM-ddHH:mm:ss").parse(rs13.getString("FromDate")+"  "+rs13.getString("FromTime"));
    Format formatter4 = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss"); 
    String showdate4 = formatter4.format(ShowDate4);
    out.print(showdate4);
    out.print("</td> <td class='bodyText'>");
 
    java.util.Date ShowDate6 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs13.getString("ToDate")+"  "+rs13.getString("ToTime"));
    Format formatter6 = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
    String showdate6 = formatter6.format(ShowDate6);
    out.print(showdate6);

    out.print("</td> <td class='bodyText'>");
    out.print(rs13.getString("Distance"));
    out.print("</td> <td class='bodyText'>");

    sql14="select * from t_veh"+vehcode+" where concat(TheFieldDataDate,' ',TheFieldDataTime)='"+rs13.getString("FromDate")+rs13.getString("FromTime")+"'";

   rs14=stmt2.executeQuery(sql14);
   if(rs14.next())
   {
      out.print("<div align='left'>"+rs14.getString("TheFieldSubject")+"</div>");
   }

   out.print("</td></tr>");

}
out.print("</table>");
/***************** End of code for Night Driving *******/
con1.close();
con2.close();

} catch(Exception e)
      {
         out.print("Exception---->"+e);
      } 

  
 

} catch(Exception e) {out.println(e);}

/*finally
{
con1.close();
con2.close();
} */

%>



