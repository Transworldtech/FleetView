
<%@ include file="Connections/conn.jsp" %>
	
<%!
Connection con1;
Statement st,st1,st2,st3,stVehDetails,stgetVehRA,stVehCountRA,stVehAllDS,stupdateVehDS,stdeleteVehRA, stdeleteVehCodeRA,stnew,stnew1,stnew2,stbackup;
%>
<% 
try {
	
	System.out.println("in ra page ");
	
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=con1.createStatement();
st1=con1.createStatement();
st2=con1.createStatement();
st3=con1.createStatement();
stVehDetails=con1.createStatement();
stgetVehRA=con1.createStatement();
stVehCountRA=con1.createStatement();
stVehAllDS=con1.createStatement();
stupdateVehDS=con1.createStatement();
stdeleteVehRA=con1.createStatement();
stdeleteVehCodeRA=con1.createStatement();
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
System.out.println("Value of vehid"+vehid);
String date=request.getParameter("date");
System.out.println("Value of date is"+date);
String comment=request.getParameter("comment");
System.out.println("value of comment"+comment);
String userid=session.getAttribute("mainuser").toString();
System.out.println("value of userid"+userid);

String otherreason="";
String other=request.getParameter("otherrson");
/* if(other=="" || other==null){
	System.out.println("Other-"+other);
	other=request.getParameter("commentsra");
} */
System.out.println("VALUE of other is "+other);
String usertypevalue=session.getAttribute("usertypevalue").toString();
System.out.println("value of usertypevalue is "+usertypevalue);

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
	String sqloth="insert into db_gps.t_violationclose(Reason,category,Owner,GPName,EntryBy)values('"+otherreason.replaceAll("'"," ")+"','RA','"+usertypevalue+"','Castrol','"+userid+"')";
     st1.executeUpdate(sqloth);
	
    System.out.println("insert for other query"+sqloth);
    }
}
else
{
	otherreason=comment;
}

System.out.println("after the if else blocks ");


if(other.equalsIgnoreCase("GPSJitter")||(comment.equalsIgnoreCase("GPSJitter")))
{
	otherreason=other;
	if(otherreason==null || otherreason==""){
		System.out.println("aSIGN COMMENT");
		otherreason=comment;
	}
	System.out.println("in the elseifblock");
// 	UpdateViolationCount1.calculateRACount(date,vehid);

    String VehCode = "";
    
    try
    {
      System.out.println("in RA function");	
     /*  String getVehicleDetails = "select VehicleCode, VehicleRegNumber,unitid from db_gps.t_vehicledetails where Status='-' order by VehicleCode";
      System.out.println(" getVehicleDetails " + getVehicleDetails);
      ResultSet rs1 = stVehDetails.executeQuery(getVehicleDetails); */
     // while (rs1.next())
      {
       // String vehDetailsVehCode = rs1.getString("VehicleCode");
        String vehDetailsVehCode=vehid;
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
          //String getVehRA = "select  VehCode,TheDate,TheTime from db_gpsExceptions.t_vehall_ra where  TheDate='" + fromDate + "' and TheTime='"+toDate+"' and OverrideStatus='Open' and VehCode='" + vehDetailsVehCode + "'";
          String getVehRA = "select  * from db_gpsExceptions.t_vehall_ra where  TheDate='" + fromDate + "' and TheTime='"+toDate+"' and OverrideStatus='Open' and VehCode='" + vehDetailsVehCode + "'";
          System.out.println(" getVehRA " + getVehRA);
          ResultSet rs2 = stgetVehRA.executeQuery(getVehRA);
          while (rs2.next())
          {
            int RACount = 0;
            
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
            
            String updateVehCode = "update db_gps.t_veh" + VehCode + " set TheFiledTextFileName='ACOV' where TheFiledTextFileName='AC' and TheFieldDataDate='" + TheDate + "' and  TheFieldDataTime='" + TheTime + "' ";
            System.out.println(" updateVehCode " + updateVehCode);
            stVehDetails.executeUpdate(updateVehCode);
            
            String getVehCountRA = "select count(DISTINCT(TheFieldDataTime)) as RACount from db_gps.t_veh" + VehCode + " where TheFiledTextFileName='AC' and TheFieldDataDate='" + TheDate + "'";
            System.out.println(" getVehCountRA " + getVehCountRA);
            ResultSet rs3 = stVehCountRA.executeQuery(getVehCountRA);
            if (rs3.next()) {
              RACount = rs3.getInt("RACount");
            }
            String updateVehAllDS = "update db_gpsExceptions.t_vehall_ds set RACount='" + RACount + "' where  TheDate='" + TheDate + "' and VehCode='" + VehCode + "' ";
            System.out.println(" updateVehAllDS " + updateVehAllDS);
            stVehAllDS.executeUpdate(updateVehAllDS);
            
            String updateVehDS = "update db_gpsExceptions.t_veh" + VehCode + "_ds set RACount='" + RACount + "' where  TheDate='" + TheDate + "' and VehCode='" + VehCode + "' ";
            System.out.println(" updateVehDS " + updateVehDS);
            stupdateVehDS.executeUpdate(updateVehDS);
            
            String sqlbackup="insert into db_gpsExceptions.t_override_ra (VehCode,TheDate,TheTime,FromSpeed,ToSpeed,JCode,DCode,Transporter,violationstatus,ClosingComment,ClosedBy,Closedatetime,TheDatetime,OverrideStatus,OverrideComents,OverrideBy,OverrideDateTime) values ('"+VehCode+"','"+TheDate+"','"+TheTime+"','"+FromSpeed+"','"+ToSpeed+"','"+JCode+"','"+DCode+"','"+Transporter+"','"+violationstatus+"','"+ClosingComment+"','"+ClosedBy+"','"+Closedatetime+"','"+FromDatetime+"','Close','"+otherreason+"','"+userid+"','"+sysdate22+"')";
            System.out.println(sqlbackup);
            stbackup.executeUpdate(sqlbackup);
            
            
            String deleteVehRA = "delete from  db_gpsExceptions.t_veh" + VehCode + "_ra where  TheDate='" + TheDate + "' and  TheTime='" + TheTime + "' and  VehCode='" + VehCode + "' ";
            System.out.println(" deleteVehRA " + deleteVehRA);
            stdeleteVehRA.executeUpdate(deleteVehRA); 
            
             String deleteVehCodeRA = "delete from  db_gpsExceptions.t_vehall_ra where  TheDate='" + TheDate + "' and  TheTime='" + TheTime + "' and VehCode='" + VehCode + "' ";
            System.out.println(" deleteVehCodeRA " + deleteVehCodeRA);
            stdeleteVehCodeRA.executeUpdate(deleteVehCodeRA);
             
            /*  String sqlupdate1="update db_gpsExceptions.t_veh" + VehCode + "_ra set OverrideComents='"+otherreason+"', OverrideStatus='Close',OverrideBy='"+userid+"',OverrideDateTime='"+sysdate22+"' where VehCode='"+vehid+"' and  TheDatetime='"+date+"'";
             stdeleteVehRA.executeUpdate(sqlupdate1); */
             
             
            /*  String sqlupdate="update db_gpsExceptions.t_vehall_ra set OverrideComents='"+otherreason+"', OverrideStatus='Close',OverrideBy='"+userid+"',OverrideDateTime='"+sysdate22+"' where VehCode='"+vehid+"' and  TheDatetime='"+date+"'";
             stdeleteVehRA.executeUpdate(sqlupdate); */
             
            int racount=0;
         //  String getracount="select count(*)  as RACount from db_gpsExceptions.t_veh" + VehCode + "_ra where VehCode='" + VehCode + "' and concat(TheDate,' ',TheTime) >='"+tripstart+"' and concat(TheDate,' ',TheTime)<='"+tripend+"'";
         String getracount="select count(*) as RACount from db_gpsExceptions.t_vehall_ra where VehCode='" + VehCode + "' and concat(TheDate,' ',TheTime) >='"+tripstart+"' and concat(TheDate,' ',TheTime)<='"+tripend+"' and OverrideComents <>'GPSJitter'";
          System.out.println("GetraCount: "+getracount);
          ResultSet rsnew=stnew.executeQuery(getracount);
          if(rsnew.next()){
        	  racount=rsnew.getInt(1);
          }
          System.out.println(racount);
          
          double os=0.0D,ra=0.0D,rd=0.0D,Rating=0.0,distance=0.0D,AC=0.0D,DC=0.0D,osdur=0.0D; 

          String chkrate="select RACount,RDCount,OSDuration,KmTravelled from db_gps.t_completedjourney where Vehid='" + VehCode + "' and StartDate='"+tripstart+"' and EndDate='"+tripend+"'";
          ResultSet rsrate=stnew2.executeQuery(chkrate);
          if(rsrate.next()){
       		//ra=rsrate.getInt("RACount");   
       		rd=rsrate.getInt("RDCount");
       		osdur=rsrate.getInt("OSDuration");
       		distance=rsrate.getInt("KmTravelled");
          }
          if (distance > 0.0D)
          {
            AC = racount / distance * 100.0D;
            DC = rd / distance * 100.0D;
            os = osdur / 10.0D / distance * 100.0D;
            Rating = AC + DC + os;
          }
          else
          {
            Rating = 0.0D;
          }
          
          
          
          String updateVehAllND = "update db_gps.t_completedjourney set RACount='" + racount + "',TripRating='" + Rating + "' where Vehid='" + VehCode + "' and StartDate='"+tripstart+"' and EndDate='"+tripend+"'";
          System.out.println(" updateVehAllND " + updateVehAllND);
          stnew1.executeUpdate(updateVehAllND);
            
           // 
            
          }
        }
        catch (Exception e)
        {
          System.out.println("Exception in while " + e.getMessage());
          e.printStackTrace();
        }
      }
    }
    catch (Exception e)
    {
      System.out.println("Exception in calRA " + e.getMessage());
    }









	
	/* 
	String vehDetailsVehCode, VehCode = "",TheDate, TheTime; 
    int RACount;
    			 
   try{	    
		  String getVehicleDetails = "select VehicleCode, VehicleRegNumber,unitid from db_gps.t_vehicledetails where Status='-' order by VehicleCode";
		  System.out.println(" getVehicleDetails "+getVehicleDetails);
	      ResultSet rs1 = stVehDetails.executeQuery(getVehicleDetails);
	      if (rs1.next())//while
      {
    	  vehDetailsVehCode = rs1.getString("VehicleCode");
    	  System.out.println(" vehicle Code "+vehDetailsVehCode); 
      
    	  vehDetailsVehCode=vehCode2;
     try{
    	 String fromDate1=fromDate.substring(0, fromDate.indexOf(" "));
          String fromtime = fromDate.substring((fromDate.lastIndexOf(" ")+1));
	      String getVehRA = "select  VehCode,TheDate,TheTime from db_gpsExceptions.t_vehall_ra where  TheDate='"+fromDate1+"' and TheTime='"+fromtime+"' and OverrideStatus='Close' and VehCode='"+vehDetailsVehCode+"'";
	      System.out.println(" getVehRA "+getVehRA);
	      ResultSet rs2 = stgetVehRA.executeQuery(getVehRA);
	      while (rs2.next())
	      {
	    	  RACount=0;
	    	  
	    	  VehCode = rs2.getString("VehCode");
	    	  TheDate= rs2.getString("TheDate");
	    	  TheTime= rs2.getString("TheTime");

	    	  System.out.println(" VehCode "+VehCode+" TheDate "+TheDate+" TheTime "+TheTime);
	    	  
	    	  String updateVehCode = "update db_gps.t_veh"+VehCode+" set TheFiledTextFileName='ACOV' where TheFiledTextFileName='AC' and TheFieldDataDate='"+TheDate+"' and  TheFieldDataTime='"+TheTime+"' ";
	    	  System.out.println(" updateVehCode "+updateVehCode);
	    	  stVehDetails.executeUpdate(updateVehCode);
	     
		      String getVehCountRA ="select count(DISTINCT(TheFieldDataTime)) as RACount from db_gps.t_veh"+VehCode+" where TheFiledTextFileName='AC' and TheFieldDataDate='"+TheDate+"'"; 
		      System.out.println(" getVehCountRA "+getVehCountRA);
		      ResultSet rs3 = stVehCountRA.executeQuery(getVehCountRA);
		      if(rs3.next())
		      {	
		    	  RACount=rs3.getInt("RACount");
		      }
	     
		      String updateVehAllDS = "update db_gpsExceptions.t_vehall_ds set RACount='"+RACount+"' where  TheDate='"+TheDate+"' and VehCode='"+VehCode+"' ";
		      System.out.println(" updateVehAllDS "+updateVehAllDS);
		      stVehAllDS.executeUpdate(updateVehAllDS);
		   
		      String updateVehDS = "update db_gpsExceptions.t_veh"+VehCode+"_ds set RACount='"+RACount+"' where  TheDate='"+TheDate+"' and VehCode='"+VehCode+"' ";
		      System.out.println(" updateVehDS "+ updateVehDS);
		      stupdateVehDS.executeUpdate(updateVehDS);
		   	      
		      String deleteVehRA = "delete from  db_gpsExceptions.t_veh"+VehCode+"_ra where  TheDate='"+TheDate+"' and  TheTime='"+TheTime+"' and  VehCode='"+VehCode+"' ";
		      System.out.println(" deleteVehRA "+ deleteVehRA);
		      stdeleteVehRA.executeUpdate(deleteVehRA);
		      
		      String deleteVehCodeRA = "delete from  db_gpsExceptions.t_vehall_ra where  TheDate='"+TheDate+"' and  TheTime='"+TheTime+"' and VehCode='"+VehCode+"' ";
		      System.out.println(" deleteVehCodeRA "+ deleteVehCodeRA);
		      stdeleteVehCodeRA.executeUpdate(deleteVehCodeRA);
	      }
	      
   }catch(Exception e)
   {
	   System.out.println("Exception in while "+e.getMessage());
   }
}		     

}
catch(Exception e)
{
System.out.println("Exception in calRA "+e.getMessage());
}
	
	
	 */
	
	
	
	
	
	System.out.println("KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK");
	
}
	

//date=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(date));

String buffer;



sql="update db_gpsExceptions.t_vehall_ra set OverrideComents='"+otherreason+"', OverrideStatus='Close',OverrideBy='"+userid+"',OverrideDateTime='"+sysdate22+"' where VehCode='"+vehid+"' and  TheDatetime='"+date+"'";
System.out.println("$$$$$$"+sql);
// int ins=0;	/*****************************/
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st3=con1.createStatement();
st2=con1.createStatement();
int ins=st3.executeUpdate(sql);

buffer="Updates"+"-"+otherreason;
System.out.println("Updates : "+sql);
out.print(buffer);
//if(ins>0)
{
	
	sql = "Update db_gps.t_completedjourney set DIStatus = 'Pending'   where startdate <= '"+date+"'  and enddate >= '"+date+"'  and vehid = '"+vehid+"' ";
	System.out.println(sql);
	st2.executeUpdate(sql);
	
	/* buffer="Updates"+"-"+otherreason;
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
