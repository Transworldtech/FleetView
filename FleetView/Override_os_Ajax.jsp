
<%@ include file="Connections/conn.jsp" %>

	
	

<%!
Connection con1;
Statement st,st1,st2,st3,stVehDetails,stgetVehOS,stVehDetailsOS,stVehCountOS,stVehAllDSOS,stupdateVehDSOS,stdeleteVehOS,stdeleteVehCodeOS,stnew,stnew1,stnew2,stnew3,stbackup;	
%>
<% 
try {
	
System.out.println("UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU****************************************************************************&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");	

System.out.println("in OS page");
		
	
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=con1.createStatement();
st1=con1.createStatement();
st2=con1.createStatement();
st3=con1.createStatement();
stVehDetails=con1.createStatement();
stdeleteVehOS=con1.createStatement();
stdeleteVehCodeOS=con1.createStatement();
stVehDetailsOS=con1.createStatement();
stupdateVehDSOS=con1.createStatement();
stgetVehOS=con1.createStatement();
stVehCountOS=con1.createStatement();
stVehCountOS=con1.createStatement();
stVehAllDSOS=con1.createStatement();
stnew=con1.createStatement();
stnew1=con1.createStatement();
stnew2=con1.createStatement();
stnew3=con1.createStatement();
stbackup=con1.createStatement();
ResultSet rst=null;
String sql="",sql1="";
boolean flag=false;

int element=99;


DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
DateFormat df= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
Calendar now123=Calendar.getInstance();
String sysdate22 = dateFormat.format(now123.getTime());
System.out.println(">>>>>>>>>>>>>>>n "+sysdate22);

String tripstart=request.getParameter("tripstart");
String tripend=request.getParameter("tripend");

System.out.println("tripstart:-"+tripstart);
System.out.println("tripend:-"+tripend);

String tripstartdate ="";
String otherreason="";
String vehid=request.getParameter("vehid");
System.out.println("Value of vehid"+vehid);
String date=request.getParameter("date");
System.out.println("Value of date is"+date);
String comment=request.getParameter("comment");
System.out.println("value of comment"+comment);
String other=request.getParameter("otherrson");
System.out.println("VALUE of other is "+other);
String usertypevalue=session.getAttribute("usertypevalue").toString();
System.out.println("value of usertypevalue is "+usertypevalue);
String userid=session.getAttribute("mainuser").toString();
System.out.println("value of userid is "+userid);


if(comment=="Other" || comment.equalsIgnoreCase("Other"))
{
	otherreason=other;
	String sqlck="select * from db_gps.t_violationclose where Reason='"+otherreason+"'";
    System.out.println("NON insert for other query"+sqlck);

	ResultSet rs=st.executeQuery(sqlck);
	if(rs.next())
	{
		
	    System.out.println("NON insert for other query");

	}else{
	String sqloth="insert into db_gps.t_violationclose(Reason,category,Owner,GPName,EntryBy)values('"+otherreason.replaceAll("'"," ")+"','OS','"+usertypevalue+"','Castrol','"+userid+"')";
     st1.executeUpdate(sqloth);
	
    System.out.println("insert for other query"+sqloth);
    }
	
}	
else
{
	otherreason=comment;
}



if(other.equalsIgnoreCase("GPSJitter")||(comment.equalsIgnoreCase("GPSJitter")))
{
	otherreason=other;
	//otherreason=other;
	if(otherreason==null || otherreason==""){
		System.out.println("aSIGN COMMENT");
		otherreason=comment;
	}
//	UpdateViolationCount1.calculateOSCount(date,vehid);

 try
    {
      System.out.println("inside os function");
     /*  String getVehicleDetails = "select VehicleCode, VehicleRegNumber,unitid from db_gps.t_vehicledetails where Status='-' order by VehicleCode";
      System.out.println(" getVehicleDetails " + getVehicleDetails);
      ResultSet rs1 = stVehDetails.executeQuery(getVehicleDetails); */
     // while (rs1.next())
      {
        System.out.println("inside os function 1");
      //  String vehDetailsVehCode = rs1.getString("VehicleCode");
        
      String  vehDetailsVehCode=vehid;
        System.out.println(" vehicle Code " + vehDetailsVehCode);
        try
        {
        	/*this changes has to be done in every program*/String fromDate=date.substring(0, date.indexOf(" "));
        	System.out.println("Value of fromDate===>"+fromDate);
             // String toDate = fromDate.substring((date.indexOf(" ")+1),date.length());
             java.util.Date d1=null;
             d1 =df.parse(date);
             SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
             String toDate =sdf.format(d1);
              System.out.println("value of toDate======>"+toDate);/*this changes has to be done in every program*/
        	
        	
          //String getVehOS = "select  VehCode,FromDate,FromTime from db_gpsExceptions.t_vehall_overspeed where  FromDate='" + fromDate + "' and FromTime='"+toDate+"' and OverrideStatus='Open' and VehCode='" + vehDetailsVehCode + "'";
              String getVehOS = "select  * from db_gpsExceptions.t_vehall_overspeed where  FromDate='" + fromDate + "' and FromTime='"+toDate+"' and OverrideStatus='Open' and VehCode='" + vehDetailsVehCode + "'";
          System.out.println(" getVehOS " + getVehOS);
          ResultSet rs2 = stgetVehOS.executeQuery(getVehOS);
          while (rs2.next())
          {
            System.out.println("inside os function2");
            int OSCount = 0;
            double osduration=0.0;
            String VehCode = rs2.getString("VehCode");
            String TheDate = rs2.getString("FromDate");
            String TheTime = rs2.getString("FromTime");
            String todate= rs2.getString("ToDate");
            String totime= rs2.getString("ToTime");
            String speed= rs2.getString("Speed");
            String Duration= rs2.getString("Duration");
            String JCode= rs2.getString("JCode");
            String DCode= rs2.getString("DCode");
            String Transporter= rs2.getString("Transporter");
            String Zone= rs2.getString("Zone");
            String violationstatus= rs2.getString("violationstatus");
            String ClosingComment= rs2.getString("ClosingComment");
            String ClosedBy= rs2.getString("ClosedBy");
            String Closedatetime= rs2.getString("Closedatetime");
            String FromDatetime= rs2.getString("FromDatetime");
            
            System.out.println(" VehCode " + VehCode + " TheDate " + TheDate + " TheTime " + TheTime);
            
            String updateVehCodeOS = "update db_gps.t_veh"+VehCode+" set TheFiledTextFileName='OSOV' where TheFiledTextFileName='OS' and TheFieldDataDate='" + TheDate + "' and  TheFieldDataTime='" + TheTime + "' ";
            System.out.println(" updateVehCodeOS " + updateVehCodeOS);
            stVehDetailsOS.executeUpdate(updateVehCodeOS);
            
            String getVehCountOS = "select count(DISTINCT(TheFieldDataTime)) as OSCount,sum(Distance) As osduration from db_gps.t_veh" + VehCode + " where TheFiledTextFileName='OS' and TheFieldDataDate='" + TheDate + "'";
            System.out.println(" getVehCountOS " + getVehCountOS);
            ResultSet rs3 = stVehCountOS.executeQuery(getVehCountOS);
            if (rs3.next()) {
              OSCount = rs3.getInt("OSCount");
              osduration=rs3.getDouble("osduration");
              System.out.println("osduration=====>*******************"+osduration);
              
              
            }
            
            String updateVehAllOS = "update db_gpsExceptions.t_vehall_ds set OSCount='" + OSCount + "',Osduration='"+osduration+"' where  TheDate='" + TheDate + "' and   VehCode='" + VehCode + "' ";
            System.out.println(" updateVehAllOS " + updateVehAllOS);
            stVehAllDSOS.executeUpdate(updateVehAllOS);
            
            String updateVehOS = "update db_gpsExceptions.t_veh" + VehCode + "_ds set OSCount='" + OSCount + "',OSDuration='"+osduration+"' where  TheDate='" + TheDate + "' and  VehCode='" + VehCode + "' ";
            System.out.println(" updateVehOS " + updateVehOS);
            stupdateVehDSOS.executeUpdate(updateVehOS);
            
            
            String sqlbackup="insert into db_gpsExceptions.t_override_overspeed (VehCode,FromDate,FromTime,ToDate,ToTime,Speed,Duration,JCode,DCode,Transporter,Zone,violationstatus,ClosingComment,ClosedBy,Closedatetime,FromDatetime,OverrideStatus,OverrideComents,OverrideBy,OverrideDateTime) values ('"+VehCode+"','"+TheDate+"','"+TheTime+"','"+todate+"','"+totime+"','"+speed+"','"+Duration+"','"+JCode+"','"+DCode+"','"+Transporter+"','"+Zone+"','"+violationstatus+"','"+ClosingComment+"','"+ClosedBy+"','"+Closedatetime+"','"+FromDatetime+"','Close','"+otherreason+"','"+userid+"','"+sysdate22+"')";
            System.out.println(sqlbackup);
            stbackup.executeUpdate(sqlbackup);
            
            
             String deleteVehOS = "delete from  db_gpsExceptions.t_veh" + VehCode + "_overspeed where  FromDate='" + TheDate + "' and  FromTime='" + TheTime + "' and  VehCode='" + VehCode + "' ";
            System.out.println(" deleteVehOS " + deleteVehOS);
           stdeleteVehOS.executeUpdate(deleteVehOS); 
            
           //new logic to update violation 
          /*   String sqlup1="update db_gpsExceptions.t_veh" + VehCode + "_overspeed set OverrideComents='"+otherreason+"', OverrideStatus='Close',OverrideBy='"+userid+"',OverrideDateTime='"+sysdate22+"' where VehCode='"+vehid+"' and  FromDatetime='"+date+"'";
          	System.out.println("sqlup1->"+sqlup1);
          	stdeleteVehCodeOS.executeUpdate(sqlup1); */
           
          /*   String sqlup="update db_gpsExceptions.t_vehall_overspeed set OverrideComents='"+otherreason+"', OverrideStatus='Close',OverrideBy='"+userid+"',OverrideDateTime='"+sysdate22+"' where VehCode='"+vehid+"' and  FromDatetime='"+date+"'";
          	System.out.println("sqlup->"+sqlup);
           	stdeleteVehOS.executeUpdate(sqlup);
            */
         
            
             String deleteVehCodeOS = "delete from  db_gpsExceptions.t_vehall_overspeed where  FromDate='" + TheDate + "' and  FromTime='" + TheTime + "' and VehCode='" + VehCode + "' ";
            System.out.println(" deleteVehCodeOS " + deleteVehCodeOS);
           stdeleteVehCodeOS.executeUpdate(deleteVehCodeOS); 
            
            //update OS count
            int oscount=0;
            String getracount="select count(*) as OSCount from db_gpsExceptions.t_vehall_overspeed where VehCode='" + VehCode + "' and concat(FromDate,' ',FromTime) >='"+tripstart+"' and concat(FromDate,' ',FromTime)<='"+tripend+"' and OverrideComents <>'GPSJitter'";
           System.out.println(getracount);
           ResultSet rsnew=stnew.executeQuery(getracount);
           if(rsnew.next()){
         	  oscount=rsnew.getInt(1);
           }
           double osduration1=0.0D;
           
           String getoscount="select sum(duration) As osduration from db_gpsExceptions.t_vehall_overspeed where VehCode='" + VehCode + "' and concat(FromDate,' ',FromTime) >='"+tripstart+"' and concat(FromDate,' ',FromTime)<='"+tripend+"' and OverrideComents <>'GPSJitter'";
           System.out.println(getoscount);
           ResultSet rsnew1=stnew.executeQuery(getoscount);
           if(rsnew1.next()){
        	   osduration1=rsnew1.getInt(1);
           }
           
           double os=0.0D,ra=0.0D,rd=0.0D,Rating=0.0,distance=0.0D,AC=0.0D,DC=0.0D,osdur=0.0D; 

           String chkrate="select RACount,RDCount,OSDuration,KmTravelled from db_gps.t_completedjourney where Vehid='" + VehCode + "' and StartDate='"+tripstart+"' and EndDate='"+tripend+"'";
           ResultSet rsrate=stnew2.executeQuery(chkrate);
           if(rsrate.next()){
        		ra=rsrate.getInt("RACount");   
        		rd=rsrate.getInt("RDCount");
        		//osdur=osduration1;
        		distance=rsrate.getInt("KmTravelled");
           }
           if (distance > 0.0D)
           {
             AC = ra / distance * 100.0D;
             DC = rd / distance * 100.0D;
             os = osduration1 / 10.0D / distance * 100.0D;
             Rating = AC + DC + os;
           }
           else
           {
             Rating = 0.0D;
           }
           
           
           
           String updateVehAllND = "update db_gps.t_completedjourney set OSCount='" + oscount + "',OSDuration='"+osduration1+"',TripRating='" + Rating + "' where Vehid='" + VehCode + "' and StartDate='"+tripstart+"' and EndDate='"+tripend+"'";
           System.out.println(" updateVehAllND " + updateVehAllND);
           stnew1.executeUpdate(updateVehAllND);
           
          
           
           
         /*   String updateVehAllND1 = "update db_gps.t_completedjourney set TripRating='" + Rating + "' where Vehid='" + VehCode + "' and StartDate='"+tripstart+"' and EndDate='"+tripend+"'";
           System.out.println(" updateVehAllND1 " + updateVehAllND1);
           stnew1.executeUpdate(updateVehAllND1); */
           
            
          }
        }
        catch (Exception e)
        {
          System.out.println("Exception in while OS Calcluation " + e.getMessage());
        }
      }
    }
    catch (Exception e)
    {
      System.out.println("Exception in calOS " + e.getMessage());
    }
   
	System.out.println("KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK");	
	
}
	


//date=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(date));
//System.out.println("Date is =========="+date);

String buffer;


try{
sql="update db_gpsExceptions.t_vehall_overspeed set OverrideComents='"+otherreason+"', OverrideStatus='Close',OverrideBy='"+userid+"',OverrideDateTime='"+sysdate22+"' where VehCode='"+vehid+"' and  FromDatetime='"+date+"'";
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st3=con1.createStatement();
st2=con1.createStatement();
System.out.println("$$$$$$"+sql+"  and st3:- "+st3);


int ins=st3.executeUpdate(sql);
System.out.println("*******Here is"+ins);
buffer="Updates"+"-"+otherreason;
System.out.println("Updates : "+sql);
out.print(buffer); 

//if(ins>0)
{
System.out.println("*****hello****");	
	sql = "Update db_gps.t_completedjourney set DIStatus = 'Pending'  where startdate <= '"+date+"'  and enddate >= '"+date+"'  and vehid = '"+vehid+"' ";
	//System.out.print("nxbcjh    "+sql);
	st2.executeUpdate(sql);
	System.out.print("nxbcjh    "+sql);
	
		/* buffer="Updates"+"-"+otherreason;
		System.out.println("Updates : "+sql);
		out.print(buffer); */

		
		//buffer=null;
}
}catch(Exception ee)
{
	System.out.println("Exception********"+ee.getMessage());
}


}
 catch(Exception e) { 
	out.print("NotDone");
	e.printStackTrace();
	}
	finally
	{
		st.close();
		con1.close();
	}

%>
