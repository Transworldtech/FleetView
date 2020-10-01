
<%@ include file="Connections/conn.jsp" %>



<%!
Connection con1;
Statement st,st1,st2,st3,stVehDetails,stgetVehND,stVehDetailsND,stdeleteVehCodeCD,stVehCountND,stupdateVehDSND,stVehAllDSND;
%>
<% 
try {
	
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=con1.createStatement();
st1=con1.createStatement();
st2=con1.createStatement();
st3=con1.createStatement();
stVehDetails=con1.createStatement();
stgetVehND=con1.createStatement();
stVehDetailsND=con1.createStatement();
stdeleteVehCodeCD=con1.createStatement();
stVehCountND=con1.createStatement();
stupdateVehDSND=con1.createStatement();
stVehAllDSND=con1.createStatement();
ResultSet rst=null;
String sql="",sql1="";
boolean flag=false;
int element=99;

DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
Calendar now123=Calendar.getInstance();
String sysdate22 = dateFormat.format(now123.getTime());
System.out.println(">>>>>>>>>>>>>>>n "+sysdate22);



String vehid=request.getParameter("vehid");
System.out.println("Value of vehid"+vehid);
String date=request.getParameter("date");
System.out.println("Value of date is"+date);
String date1=request.getParameter("date1");
System.out.println("Value of date1 is"+date1);
String comment=request.getParameter("comment");
System.out.println("value of comment"+comment);
String userid=session.getAttribute("mainuser").toString();
System.out.println("value of userid"+userid);

String tripid=request.getParameter("tripid");
String otherreason="";
String other=request.getParameter("otherrson");
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
	String sqloth="insert into db_gps.t_violationclose(Reason,category,Owner,GPName,EntryBy)values('"+otherreason.replaceAll("'"," ")+"','DV','"+usertypevalue+"','Castrol','"+userid+"')";
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
//	UpdateViolationCount1.calculateNDCount(date,vehid);
try
    {
     /*  String getVehicleDetails = "select VehicleCode, VehicleRegNumber,unitid from db_gps.t_vehicledetails where Status='-' order by VehicleCode";
      System.out.println(" getVehicleDetails " + getVehicleDetails);
      ResultSet rs1 = stVehDetails.executeQuery(getVehicleDetails); */
     // while (rs1.next())
      {
       // String vehDetailsVehCode = rs1.getString("VehicleCode");
       String  vehDetailsVehCode=vehid;
        System.out.println(" vehicle Code " + vehDetailsVehCode);
        try
        {
        //	DateFormat df= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        	///*this changes has to be done in every program*/String fromDate=date.substring(0, date.indexOf(" "));
        //	System.out.println("Value of fromDate===>"+fromDate);
          //    String toDate = fromDate.substring((date.lastIndexOf(" ")+1));
            //  System.out.println("value of toDate======>"+toDate);/*this changes has to be done in every program*/
        //	java.util.Date d1=null;
         //    d1 =df.parse(date);
          //   SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
           //  String fromtime =sdf.format(d1);
            // String todate=date1.substring(0, date1.indexOf(" "));
            // System.out.println("Value of fromDate===>"+todate);
             //java.util.Date d2=null;
             //d2 =df.parse(date1);
            // String totime=sdf.format(d2);
             
            
            
          String getVehDV = "select  VehCode,FromDateTime,ToDateTime from db_gpsExceptions.t_vehall_dv where  FromDateTime='" + date + "' and  ToDateTime='"+date1+"' and OverrideStatus='Open' and VehCode='" + vehDetailsVehCode + "'";
          System.out.println(" getVehDV " + getVehDV);
          ResultSet rs2 = stgetVehND.executeQuery(getVehDV);
          while (rs2.next())
          {
            int DVCount = 0;
            
            String VehCode = rs2.getString("VehCode");
            String FromDate = rs2.getString("FromDateTime");
            String ToDate = rs2.getString("ToDateTime");
            
        //   System.out.println(" VehCode " + VehCode + " TheDate " + TheDate + " TheTime " + TheTime);
            
         
            
          /*   String deleteVehCodeCDcrcopy = "delete from  db_gpsExceptions.t_vehall_dv where  FromDateTime='" + FromDate + "' and VehCode='" + VehCode + "' ";
            System.out.println(" deleteVehCodeCDcrcopy " + deleteVehCodeCDcrcopy);
            stdeleteVehCodeCD.executeUpdate(deleteVehCodeCDcrcopy);
             */
             sql="update db_gpsExceptions.t_vehall_dv set OverrideComents='"+otherreason+"', OverrideStatus='Close',OverrideBy='"+userid+"',OverrideDateTime='"+sysdate22+"' where VehCode='"+vehid+"' and  FromDatetime='"+date+"'";
             stdeleteVehCodeCD.executeUpdate(sql);
             
             
            String getVehCountND = "select count(*)  as DVCount from db_gpsExceptions.t_vehall_dv where tripid='" + tripid + "' and VehCode='" + VehCode + "' and OverrideComents <>'GPSJitter'";
            System.out.println(" getVehCountND " + getVehCountND);
            ResultSet rs3 = stVehCountND.executeQuery(getVehCountND);
            if (rs3.next())
            {
              DVCount = rs3.getInt("DVCount");
              
              
              
              /* String updateVehOS = "update db_gpsExceptions.t_veh" + VehCode + "_ds set DV='YES' where  TheDate='" + new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(FromDate)) + "' and VehCode='" + VehCode + "' ";
              System.out.println(" updateVehOS " + updateVehOS);
              stupdateVehDSND.executeUpdate(updateVehOS); */
            }
            else
            {
            /*   String updateVehOS = "update db_gpsExceptions.t_veh" + VehCode + "_ds set DV='NO' where  TheDate='" + new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(FromDate)) + "' and VehCode='" + VehCode + "' ";
              System.out.println(" updateVehOS " + updateVehOS);
              stupdateVehDSND.executeUpdate(updateVehOS); */
            }
            System.out.println(" DVCount " + DVCount);
           
            String updateVehAllND = "update db_gps.t_completedjourney set DVCount='" + DVCount + "' where tripid='"+tripid+"' and Vehid='" + VehCode + "'";
            System.out.println(" updateVehAllND " + updateVehAllND);
            stVehAllDSND.executeUpdate(updateVehAllND);
            /*  String updateVehAllND = "update db_gpsExceptions.t_vehall_ds set DVCount='" + DVCount + "' where  TheDate='" + new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(FromDate)) + "' and VehCode='" + VehCode + "'";
            System.out.println(" updateVehAllND " + updateVehAllND);
            stVehAllDSND.executeUpdate(updateVehAllND); */
          }
        }
        catch (Exception e)
        {
          System.out.println("Exception in while ND Calcluation " + e.getMessage());
        }
      }
    }
    catch (Exception e)
    {
      System.out.println("Exception in calND " + e.getMessage());
    }


	System.out.println("KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK");	
}
	

//date=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(date));

String buffer;



sql="update db_gpsExceptions.t_vehall_dv set OverrideComents='"+otherreason+"', OverrideStatus='Close',OverrideBy='"+userid+"',OverrideDateTime='"+sysdate22+"' where VehCode='"+vehid+"' and  FromDatetime='"+date+"'";
System.out.println("$$$$$$"+sql);
// int ins=0;	/*****************************/

con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st3=con1.createStatement();
st2=con1.createStatement();
st3.executeUpdate(sql);
//if(ins>0)
{
	
/* 	sql = "Update db_gps.t_completedjourney set DIStatus = 'Pending'  where startdate <= '"+date+"'  and enddate >= '"+date+"'  and vehid = '"+vehid+"' ";
	st2.executeUpdate(sql); */
	
	buffer="Updates"+"-"+otherreason;
	//	System.out.println("Updates : "+sql);
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
