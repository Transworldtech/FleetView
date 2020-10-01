
<%@ include file="Connections/conn.jsp" %>


<%!
Connection con1;
Statement st,st1,st2,st3,stVehDetails,stgetVehCD,stVehDetailsCD,stdeleteVehCodeCD,stVehCountCD,stVehAllDSCD,stupdateVehDSCD,stnew,stnew1,stbackup;
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
stgetVehCD=con1.createStatement();
stVehDetailsCD=con1.createStatement();
stdeleteVehCodeCD=con1.createStatement();
stVehCountCD=con1.createStatement();
stVehAllDSCD=con1.createStatement();
stupdateVehDSCD=con1.createStatement();
stnew=con1.createStatement();
stnew1=con1.createStatement();
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
String date=request.getParameter("date");
String date1=request.getParameter("date1");
System.out.println("Value of date1 is"+date1);
String comment=request.getParameter("comment");
String userid=session.getAttribute("mainuser").toString();


String otherreason="";
String other=request.getParameter("otherrson");
String usertypevalue=session.getAttribute("usertypevalue").toString();

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
	String sqloth="insert into db_gps.t_violationclose(Reason,category,Owner,GPName,EntryBy)values('"+otherreason.replaceAll("'"," ")+"','CD','"+usertypevalue+"','Castrol','"+userid+"')";
     st1.executeUpdate(sqloth);
	
    System.out.println("insert for other query"+sqloth);
    }}
else
{
	otherreason=comment;
}


if(other.equalsIgnoreCase("GPSJitter")||(comment.equalsIgnoreCase("GPSJitter")))
{
	otherreason=other;
	if(otherreason==null || otherreason==""){
		System.out.println("aSIGN COMMENT");
		otherreason=comment;
	}
	System.out.println("in the elseifblock");
// 	UpdateViolationCount1.calculateCDCount(date,vehid);
	try
    {
	      System.out.println("in cd function");	
	     /*  String getVehicleDetails = "select VehicleCode, VehicleRegNumber,unitid from db_gps.t_vehicledetails where Status='-' order by VehicleCode";
	      System.out.println(" getVehicleDetails " + getVehicleDetails);
	      
	      ResultSet rs1 = stVehDetails.executeQuery(getVehicleDetails); */
	     // while (rs1.next())
	      {
	       // String vehDetailsVehCode = rs1.getString("VehicleCode");
	       /*this changes has to be done in every program*/String vehDetailsVehCode=vehid;
	        System.out.println(" vehicle Code " + vehDetailsVehCode);
	        try
	        {
	        	DateFormat df= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	        	/*this changes has to be done in every program*/String fromDate=date.substring(0, date.indexOf(" "));
	        	System.out.println("Value of fromDate===>"+fromDate);
	        	java.util.Date d1=null;
	             d1 =df.parse(date);
	             SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
	             String fromtime =sdf.format(d1);
	             String todate=date1.substring(0, date1.indexOf(" "));
	             System.out.println("Value of fromDate===>"+todate);
	             java.util.Date d2=null;
	             d2 =df.parse(date1);
	             String totime=sdf.format(d2);
	             
	          String getVehCD = "select  * from db_gpsExceptions.t_vehall_crcopy where  FromDate='" + fromDate + "' and FromTime='"+fromtime+"' and ToDate='"+todate+"' and ToTime='"+totime+"' and OverrideStatus='Open' and VehCode ='" + vehDetailsVehCode + "'";
	          System.out.println(" getVehCD " + getVehCD);
	          ResultSet rs2 = stgetVehCD.executeQuery(getVehCD);
	          while (rs2.next())
	          {
	            int CDCount = 0;
	            
	            String VehCode = rs2.getString("VehCode");
	            String vehregno= rs2.getString("vehregno");
	            String avg=rs2.getString("avg");
	            String TheDate = rs2.getString("FromDate");
	            String TheTime = rs2.getString("FromTime");
	            String NoofStops= rs2.getString("NoofStops");
	            String stopduration= rs2.getString("stopduration");
	            String Todate= rs2.getString("ToDate");
	            String Totime= rs2.getString("ToTime");
	            String Distance=rs2.getString("Distance");
	           // String speed= rs2.getString("Speed");
	            String Duration= rs2.getString("Duration");
	            String JCode= rs2.getString("JCode");
	            String DCode= rs2.getString("DCode");
	            String Transporter= rs2.getString("Transporter");
	            String intrip= rs2.getString("intrip");
	            String tripstartdatetime= rs2.getString("tripstartdatetime");
	            String tripstopdatetime= rs2.getString("tripstopdatetime");
	            String gpname= rs2.getString("gpname");
	            String violationstatus= rs2.getString("violationstatus");
	            String ClosingComment= rs2.getString("ClosingComment");
	            String ClosedBy= rs2.getString("ClosedBy");
	            String Closedatetime= rs2.getString("Closedatetime");
	            String FromDatetime= rs2.getString("FromDatetime");
	            
	            System.out.println(" VehCode " + VehCode + " TheDate " + TheDate + " TheTime " + TheTime);
	            
	            String sqlbackup="insert into db_gpsExceptions.t_override_cd (VehCode,vehregno,avg,FromDate,FromTime,ToDate,ToTime,Duration,NoofStops,stopduration,Distance,JCode,DCode,Transporter,intrip,tripstartdatetime,tripstopdatetime,gpname,violationstatus,ClosingComment,ClosedBy,Closedatetime,FromDatetime,OverrideStatus,OverrideComents,OverrideBy,OverrideDateTime) values ('"+VehCode+"','"+vehregno+"','"+avg+"','"+TheDate+"','"+TheTime+"','"+todate+"','"+totime+"','"+Duration+"','"+NoofStops+"','"+stopduration+"','"+Distance+"','"+JCode+"','"+DCode+"','"+Transporter+"','"+intrip+"','"+tripstartdatetime+"','"+tripstopdatetime+"','"+gpname+"','"+violationstatus+"','"+ClosingComment+"','"+ClosedBy+"','"+Closedatetime+"','"+FromDatetime+"','Close','"+otherreason+"','"+userid+"','"+sysdate22+"')";
	            System.out.println(sqlbackup);
	            stbackup.executeUpdate(sqlbackup);
	            
	             String updateVehCodeCD = "delete from  db_gpsExceptions.t_veh" + VehCode + "_cr where   FromDate='" + TheDate + "' and  FromTime='" + TheTime + "' and VehCode='" + VehCode + "' ";
	            System.out.println(" updateVehCodeCD " + updateVehCodeCD);
	            stVehDetailsCD.executeUpdate(updateVehCodeCD); 
	            
	          //  String updateVehCodeCD2 = "update  db_gpsExceptions.t_veh" + VehCode + "_cr set  TheFiledTextFileName='CDOV' where TheFiledTextFileName='CD' and TheFieldDataDate='" + TheDate + "' and  TheFieldDataTime='" + TheTime + "' ";
	            //System.out.println(" VehCodeCD " + updateVehCodeCD2);
	          //  stVehDetailsCD.executeUpdate(updateVehCodeCD2);
	            
	             String deleteVehCodeCDcrcopy = "delete from  db_gpsExceptions.t_vehall_crcopy where  FromDate='" + TheDate + "' and  FromTime='" + TheTime + "' and VehCode='" + VehCode + "' ";
	            System.out.println(" deleteVehCodeCDcrcopy " + deleteVehCodeCDcrcopy);
	            stdeleteVehCodeCD.executeUpdate(deleteVehCodeCDcrcopy); 
	            
	           /* String sqln="update db_gpsExceptions.t_veh" + VehCode + "_cr set OverrideComents='"+otherreason+"', OverrideStatus='Close',OverrideBy='"+userid+"',OverrideDateTime='"+sysdate22+"' where VehCode='"+vehid+"' and  FromDatetime='"+date+"'";
	            stVehDetailsCD.executeUpdate(sqln); */
	            
	            /* sql="update db_gpsExceptions.t_vehall_crcopy set OverrideComents='"+otherreason+"', OverrideStatus='Close',OverrideBy='"+userid+"',OverrideDateTime='"+sysdate22+"' where VehCode='"+vehid+"' and  FromDatetime='"+date+"'";
	            stdeleteVehCodeCD.executeUpdate(sql); */
	            
	            
	          //  String getVehCountCD = "select count(*) as CDCount from db_gpsExceptions.t_veh" + VehCode + "_cr where  FromDate='" + fromDate + "' ";
	          String getVehCountCD = "select count(*) as CDCount from db_gpsExceptions.t_vehall_crcopy where vehcode='"+VehCode+"' FromDate='" + fromDate + "' and OverrideComents <>'GPSJitter' ";
	            System.out.println(" getVehCountCD " + getVehCountCD);
	            ResultSet rs3 = stVehCountCD.executeQuery(getVehCountCD);
	            if (rs3.next()) {
	              CDCount = rs3.getInt("CDCount");
	            }
	            String updateVehAllCD = "update db_gpsExceptions.t_vehall_ds set CRCount='" + CDCount + "' where  TheDate='" + TheDate + "' and VehCode='" + VehCode + "' ";
	            System.out.println(" updateVehAllCD " + updateVehAllCD);
	            stVehAllDSCD.executeUpdate(updateVehAllCD);
	            
	            String updateVehCD = "update db_gpsExceptions.t_veh" + VehCode + "_ds set CrCount='" + CDCount + "' where  TheDate='" + TheDate + "' and VehCode='" + VehCode + "' ";
	            System.out.println(" updateVehCD " + updateVehCD);
	            stupdateVehDSCD.executeUpdate(updateVehCD);
	            
	            
	            //update CRcount
	            
	            int crcount=0;
	            String getracount="select count(*)  as CDCount from db_gpsExceptions.t_vehall_crcopy where VehCode='" + VehCode + "' and concat(FromDate,' ',FromTime) >='"+tripstart+"' and concat(FromDate,' ',FromTime)<='"+tripend+"' and OverrideComents <>'GPSJitter'";
	           System.out.println(getracount);
	           ResultSet rsnew=stnew.executeQuery(getracount);
	           if(rsnew.next()){
	         	  crcount=rsnew.getInt(1);
	           }
	           
	           String updateVehAllND1 = "update db_gps.t_completedjourney set CRCount='" + crcount + "' where Vehid='" + VehCode + "' and StartDate='"+tripstart+"' and EndDate='"+tripend+"'";
	           System.out.println(" updateVehAllND " + updateVehAllND1);
	           stnew1.executeUpdate(updateVehAllND1);
	            
	            
	            
	          }
	        }
	        catch (Exception e)
	        {
	          System.out.println("Exception in while CD Calcluation " + e.getMessage());
	        }
	      }
	    }
	    catch (Exception e)
	    {
	      System.out.println("Exception in calCD " + e.getMessage());
	    }
	
	
	
	
	
	
	
	
	
	
	
	
	
	System.out.println("KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK");	
}
	

//date=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(date));



String buffer;



sql="update db_gpsExceptions.t_vehall_crcopy set OverrideComents='"+otherreason+"', OverrideStatus='Close',OverrideBy='"+userid+"',OverrideDateTime='"+sysdate22+"' where VehCode='"+vehid+"' and  FromDatetime='"+date+"'";
System.out.println("$$$$$$"+sql);
int ins=0;	/*****************************/
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st3=con1.createStatement();
st2=con1.createStatement();
st3.executeUpdate(sql);
//if(ins>0)
{
 sql = "Update db_gps.t_completedjourney set DIStatus = 'Pending'  where startdate <= '"+date+"'  and enddate >= '"+date+"'  and vehid = '"+vehid+"' ";
 st2.executeUpdate(sql);
	
 buffer="Updates"+"-"+otherreason;
		System.out.println("Updates : "+sql);
		out.print(buffer);

		
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
