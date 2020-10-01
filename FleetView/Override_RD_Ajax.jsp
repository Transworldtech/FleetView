
<%@ include file="Connections/conn.jsp" %>

	

<%!
Connection con1;
Statement st,st1,st2,st3,stVehDetails,stgetVehRD,stVehDetailsRD,stVehCountRD,stVehAllDSRD,stupdateVehDSRD,stdeleteVehRD,stdeleteVehCodeRD,stnew,stnew1,stnew2,stbackup;
%>
<% 
try {
	System.out.println("in rd page ");
	
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=con1.createStatement();
st1=con1.createStatement();
st2=con1.createStatement();
st3=con1.createStatement();
stgetVehRD=con1.createStatement();
stVehDetails=con1.createStatement();
stVehDetailsRD=con1.createStatement();
stVehCountRD=con1.createStatement();
stVehAllDSRD=con1.createStatement();
stupdateVehDSRD=con1.createStatement();
stdeleteVehCodeRD=con1.createStatement();
stdeleteVehRD=con1.createStatement();
stnew=con1.createStatement();
stnew1=con1.createStatement();
stnew2=con1.createStatement();
stbackup=con1.createStatement();
ResultSet rst=null;
String sql="",sql1="";
boolean flag=false;
int element=99;


DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
Calendar now123=Calendar.getInstance();
String sysdate22 = dateFormat.format(now123.getTime());
System.out.println(">>>>>>>>>>>>>>>n "+sysdate22);
String tripstart=request.getParameter("tripstart");
String tripend=request.getParameter("tripend");

System.out.println("tripstart:-"+tripstart);
System.out.println("tripend:-"+tripend);


String vehid=request.getParameter("vehid");
System.out.println("value of vehid********"+vehid);
String date=request.getParameter("date");
System.out.println("Value of date is******"+date);
String comment=request.getParameter("comment");
System.out.println("Value of comment is****"+comment);
String userid=session.getAttribute("mainuser").toString();
System.out.println("Value of userid"+userid);

String otherreason="";
String other=request.getParameter("otherrson");
System.out.println("Value of other is "+other);
String usertypevalue=session.getAttribute("usertypevalue").toString();
System.out.println("Value of usertypevalue"+usertypevalue);

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
	String sqloth="insert into db_gps.t_violationclose(Reason,category,Owner,GPName,EntryBy)values('"+otherreason.replaceAll("'"," ")+"','RD','"+usertypevalue+"','Castrol','"+userid+"')";
     st1.executeUpdate(sqloth);
	
    System.out.println("insert for other query"+sqloth);
    }}

else
{
	otherreason=comment;
}

if(other.equalsIgnoreCase("GPSJitter")||(comment.equalsIgnoreCase("GPSJitter")))
{
	System.out.println("in the elseifblock");
	otherreason=other;
	if(otherreason==null || otherreason==""){
		System.out.println("aSIGN COMMENT");
		otherreason=comment;
	}
	
//	UpdateViolationCount1.calculateRDCount(date,vehid);
String VehCode = "";
 try
    {
      /* String getVehicleDetails = "select VehicleCode, VehicleRegNumber,unitid from db_gps.t_vehicledetails where Status='-' order by VehicleCode";
      System.out.println(" getVehicleDetails " + getVehicleDetails);
      ResultSet rs1 = stVehDetails.executeQuery(getVehicleDetails); */
     // while (rs1.next())
      {
       // String vehDetailsVehCode = rs1.getString("VehicleCode");
      String  vehDetailsVehCode=vehid;
        System.out.println(" vehicle Code " + vehDetailsVehCode);
        try
        {
        	DateFormat df= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        	
        	String fromDate=date.substring(0, date.indexOf(" "));
        	System.out.println("Value of fromDate===>"+fromDate);
           // String toDate = fromDate.substring((date.lastIndexOf(" ")+1));
           // System.out.println("value of toDate======>"+toDate);	
        	java.util.Date d1=null;
             d1 =df.parse(date);
             SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
             String toDate =sdf.format(d1);
          String getVehRD = "select  * from db_gpsExceptions.t_vehall_rd where  TheDate='" + fromDate + "' and TheTime='"+toDate+"' and OverrideStatus='Open' and VehCode='" + vehDetailsVehCode + "'";
          System.out.println(" getVehRD " + getVehRD);
          ResultSet rs2 = stgetVehRD.executeQuery(getVehRD);
          while (rs2.next())
          {
            int RDCount = 0;
            
            VehCode = rs2.getString("VehCode");
            String TheDate = rs2.getString("TheDate");
            String TheTime = rs2.getString("TheTime");
            String FromSpeed= rs2.getString("FromSpeed");
            String ToSpeed =rs2.getString("ToSpeed");
            String JCode= rs2.getString("JCode");
            String DCode= rs2.getString("DCode");
            String Transporter= rs2.getString("Transporter");
            String violationstatus= rs2.getString("violationstatus");
            String ClosingComment= rs2.getString("ClosingComment");
            String ClosedBy= rs2.getString("ClosedBy");
            String Closedatetime= rs2.getString("Closedatetime");
            String FromDatetime= rs2.getString("TheDatetime");
            
            
            System.out.println(" VehCode " + VehCode + " TheDate " + TheDate + " TheTime " + TheTime);
            
            String updateVehCode = "update db_gps.t_veh" + VehCode + " set TheFiledTextFileName='DCOV' where TheFiledTextFileName='DC' and TheFieldDataDate='" + TheDate + "' and  TheFieldDataTime='" + TheTime + "' ";
            System.out.println(" updateVehCode " + updateVehCode);
            stVehDetailsRD.executeUpdate(updateVehCode);
            
            String getVehCountRD = "select count(DISTINCT(TheFieldDataTime)) as RDCount from db_gps.t_veh" + VehCode + " where TheFiledTextFileName='DC' and TheFieldDataDate='" + TheDate + "'";
            System.out.println(" getVehCountRD " + getVehCountRD);
            ResultSet rs3 = stVehCountRD.executeQuery(getVehCountRD);
            if (rs3.next()) {
              RDCount = rs3.getInt("RDCount");
            }
            String updateVehAllDS = "update db_gpsExceptions.t_vehall_ds set RDCount='" + RDCount + "' where  TheDate='" + TheDate + "' and VehCode='" + VehCode + "' ";
            System.out.println(" updateVehAllDS " + updateVehAllDS);
            stVehAllDSRD.executeUpdate(updateVehAllDS);
            
            String updateVehDS = "update db_gpsExceptions.t_veh" + VehCode + "_ds set RDCount='" + RDCount + "' where  TheDate='" + TheDate + "' and VehCode='" + VehCode + "' ";
            System.out.println(" updateVehDS " + updateVehDS);
            stupdateVehDSRD.executeUpdate(updateVehDS);
            
            String sqlbackup="insert into db_gpsExceptions.t_override_rd (VehCode,TheDate,TheTime,FromSpeed,ToSpeed,JCode,DCode,Transporter,violationstatus,ClosingComment,ClosedBy,Closedatetime,TheDatetime,OverrideStatus,OverrideComents,OverrideBy,OverrideDateTime) values ('"+VehCode+"','"+TheDate+"','"+TheTime+"','"+FromSpeed+"','"+ToSpeed+"','"+JCode+"','"+DCode+"','"+Transporter+"','"+violationstatus+"','"+ClosingComment+"','"+ClosedBy+"','"+Closedatetime+"','"+FromDatetime+"','Close','"+otherreason+"','"+userid+"','"+sysdate22+"')";
            System.out.println(sqlbackup);
            stbackup.executeUpdate(sqlbackup);
            
            
             String deleteVehRA = "delete from  db_gpsExceptions.t_veh" + VehCode + "_rd where  TheDate='" + TheDate + "' and  TheTime='" + TheTime + "' and  VehCode='" + VehCode + "' ";
            System.out.println(" deleteVehRA " + deleteVehRA);
            stdeleteVehRD.executeUpdate(deleteVehRA); 
            
             String deleteVehCodeRA = "delete from  db_gpsExceptions.t_vehall_rd where  TheDate='" + TheDate + "' and  TheTime='" + TheTime + "' and VehCode='" + VehCode + "' ";
            System.out.println(" deleteVehCodeRA " + deleteVehCodeRA);
            stdeleteVehCodeRD.executeUpdate(deleteVehCodeRA); 
           /*  String sqlup1="update db_gpsExceptions.t_veh" + VehCode + "_rd set OverrideComents='"+otherreason+"', OverrideStatus='Close',OverrideBy='"+userid+"',OverrideDateTime='"+sysdate22+"' where VehCode='"+vehid+"' and  TheDatetime='"+date+"'";
            stdeleteVehCodeRD.executeUpdate(sqlup1); */
            
            
          /*  String sqlup="update db_gpsExceptions.t_vehall_rd set OverrideComents='"+otherreason+"', OverrideStatus='Close',OverrideBy='"+userid+"',OverrideDateTime='"+sysdate22+"' where VehCode='"+vehid+"' and  TheDatetime='"+date+"'";
            stdeleteVehRD.executeUpdate(sqlup); */
            //update rd count
            
            int rdcount=0;
            String getracount="select count(*)  as RDCount from db_gpsExceptions.t_vehall_rd where VehCode='" + VehCode + "' and concat(TheDate,' ',TheTime) >='"+tripstart+"' and concat(TheDate,' ',TheTime)<='"+tripend+"' and OverrideComents <>'GPSJitter'";
           System.out.println(getracount);
           ResultSet rsnew=stnew.executeQuery(getracount);
           if(rsnew.next()){
         	  rdcount=rsnew.getInt(1);
           }
           
           double os=0.0D,ra=0.0D,rd=0.0D,Rating=0.0,distance=0.0D,AC=0.0D,DC=0.0D,osdur=0.0D; 

           String chkrate="select RACount,RDCount,OSDuration,KmTravelled from db_gps.t_completedjourney where Vehid='" + VehCode + "' and StartDate='"+tripstart+"' and EndDate='"+tripend+"'";
           ResultSet rsrate=stnew2.executeQuery(chkrate);
           if(rsrate.next()){
        		ra=rsrate.getInt("RACount");   
        		//rd=rsrate.getInt("RDCount");
        		osdur=rsrate.getInt("OSDuration");
        		distance=rsrate.getInt("KmTravelled");
           }
           if (distance > 0.0D)
           {
             AC = ra / distance * 100.0D;
             DC = rdcount / distance * 100.0D;
             os = osdur / 10.0D / distance * 100.0D;
             Rating = AC + DC + os;
           }
           else
           {
             Rating = 0.0D;
           }
           
           
           String updateVehAllND = "update db_gps.t_completedjourney set RDCount='" + rdcount + "',TripRating='" + Rating + "' where Vehid='" + VehCode + "' and StartDate='"+tripstart+"' and EndDate='"+tripend+"'";
           System.out.println(" updateVehAllND " + updateVehAllND);
           stnew1.executeUpdate(updateVehAllND);
             
            
          }
        }
        catch (Exception e)
        {
          System.out.println("Exception in while " + e.getMessage());
        }
      }
    }
    catch (Exception e)
    {
      System.out.println("Exception in calRA " + e.getMessage());
    }

	System.out.println("KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK");	
}
	


//date=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(date));



String buffer;



sql="update db_gpsExceptions.t_vehall_rd set OverrideComents='"+otherreason+"', OverrideStatus='Close',OverrideBy='"+userid+"',OverrideDateTime='"+sysdate22+"' where VehCode='"+vehid+"' and  TheDatetime='"+date+"'";
System.out.println("$$$$$$"+sql);
// int ins=0;	/*****************************/

con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st3=con1.createStatement();
st2=con1.createStatement();
int ins=st3.executeUpdate(sql);

	buffer="Updates"+"-"+otherreason;
	System.out.println("Updates : "+sql);
	out.print(buffer); 
//	if(ins>0)
{
	
	sql = "Update db_gps.t_completedjourney set DIStatus = 'Pending'  where startdate <= '"+date+"'  and enddate >= '"+date+"'  and vehid = '"+vehid+"' ";
	st2.executeUpdate(sql);
	/* 
	buffer="Updates"+"-"+otherreason;
		System.out.println("Updates : "+sql);
		out.print(buffer); */

		
		//buffer=null;
}



}
 catch(Exception e) { 
	out.print("NotDone");
	}
	finally
	{
		st.close();
		con1.close();
	}

%>
