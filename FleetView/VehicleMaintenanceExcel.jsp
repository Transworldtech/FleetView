<%@ page contentType="application/vnd.ms-excel; charset=gb2312" import="java.sql.*" import="java.util.*" import=" java.text.*" %>
<%@page import="com.transworld.fleetview.framework.VehicleDao"
        import="com.transworld.fleetview.framework.VehicleMentananceData"
        import="com.transworld.fleetview.framework.Utilities"
        import="com.transworld.fleetview.framework.VehicleRegistrationNumberList"%>

<jsp:useBean id="vehicleDao"
        type="com.transworld.fleetview.framework.VehicleDao"
        scope="application"></jsp:useBean>
        
        <%@ include file="Connections/conn.jsp" %>
        
<% response.setContentType("application/vnd.ms-excel"); 
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());
String filename=session.getAttribute("user").toString()+showdatex+"VehicleMaintenanceReport.xls";
response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>

<%!/// Only Class Level Declarations here
        final NumberFormat numberformat = new DecimalFormat("#0.00");
        final SimpleDateFormat yyyy_MM_ddFormatter = new SimpleDateFormat(
                        "yyyy-MM-dd");
        final SimpleDateFormat dd_MM_yyyyParser = new SimpleDateFormat(
                        "dd-MM-yyyy");
        
  %> 


<%
System.out.println("====Inside Excel====");
double kmTravelled = 0, averageRunningspeed = 0, averageDaySpeed = 0;
        
%>

<%
Connection con1;
Statement stmt1,stmt2,st;
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
stmt1=con1.createStatement();
stmt2=con1.createStatement();
st=con1.createStatement();
String datex1="", datex2="", data1="", data2="";
String dateformat="",dataDate1 = "",dataDate2 = "",mentstatus="",vehicles="",chbxAll="",chkbox="";
String enterdate="";
%>

<%
try {
String ddx=request.getQueryString();
System.out.println("-------string ddx is--->>>"+ddx);

datex1=request.getParameter("data");
System.out.println("--datex1------>>>"+datex1);

datex2=request.getParameter("data1");
System.out.println("--datex2------>>>"+datex2);





mentstatus=request.getParameter("status");
System.out.println("--mentstatus------>>>"+mentstatus);

vehicles=request.getParameter("vehicle");
String vehicle1=vehicles;
System.out.println("--vehicle is ------>>>"+  vehicles);

chbxAll=request.getParameter("extAll");
System.out.println("--check box is  ------>>>"+chbxAll);

String VehRegNo=request.getParameter("VehicleRegNo");
System.out.println("--vehicleRegNo is ------>>>"+  VehRegNo);

if(datex1==null || datex1.equalsIgnoreCase("null"))
{
        System.out.println("-------in if loop----");
        datex1=datex2=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
          data1=data2=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
          mentstatus="All";       
          vehicles="All";

}

data1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex1));
data2=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex2)); 



DateFormat df123= new SimpleDateFormat("dd-MMM-yyyy");
DateFormat df1234= new SimpleDateFormat("yyyy-MM-dd");

dataDate1=df1234.format(df123.parse(datex1));
System.out.println("--datex1 in(yyy-mm-dd)------>>>"+dataDate1);

 dataDate2=df1234.format(df123.parse(datex2));
System.out.println("--datex2 in(yyy-mm-dd)------>>>"+dataDate2);

if(mentstatus=="All" || mentstatus.equals("All"))
{
    mentstatus="('Pending','Processed','Closed')";
        
}

        if(mentstatus=="Pending" || mentstatus.equals("Pending"))
        {
                
                mentstatus="('Pending')";
        }

        if(mentstatus=="Processed" || mentstatus.equals("Processed"))
        {
                
                mentstatus="('Processed')";
        }

        if(mentstatus=="Closed" || mentstatus.equals("Closed"))
        {
                
                mentstatus="('Closed')";
        }
        

if(vehicles=="All" ||vehicles.equalsIgnoreCase("All"))
{
        vehicles=session.getAttribute("VehList").toString();
        System.out.println("Vehilces in if :-"+vehicles);
}
else
{
	vehicles="("+vehicle1+")";
        System.out.println("*****Vehicle in excel"+vehicles);
}




//session.setAttribute("data1",data1);
//session.setAttribute("data2",data2);
String user,usertypevalue;

//user=session.getAttribute("user").toString();
//System.out.println("--user------>>>"+user);

usertypevalue=session.getAttribute("usertypevalue").toString();
System.out.println("--usertypevalue------>>>"+usertypevalue);

dateformat = session.getAttribute("dateformat").toString();
System.out.println("--dateformat------>>>"+dateformat);

System.out.println("--mentstatus------>>>"+  mentstatus);
System.out.println("--veh------>>>"+ vehicles);

System.out.println("--check box is  ------>>>"+chbxAll);

}
        catch(Exception e){
                
        }
%>
        <table border="0" width="100%">
                <tr>
                        <td>



<%
try{
        String dd=request.getQueryString();
        if(dd==null)
        {
        out.println("<center ><font size='2' color='blue'>Please select the required options to display the maintainance report.</font></center>");
        }else{


        Class.forName(MM_dbConn_DRIVER);
        con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
        stmt1=con1.createStatement();
        stmt2=con1.createStatement();
    
    

String vehid="",list="";
String status="",vehcode="",servicetype="",servicedate="",altsts="",vehregno="",nextserviceDate="",alertdate=""; 
vehid=request.getParameter("vehicle");
String inserted=request.getParameter("inserted");
String inserted2=request.getParameter("inserted1");
String inserted3=request.getParameter("inserted3");
//session.setAttribute("reportno","");
//session.setAttribute("reportname","maintainance report");

String  sql="select * from t_vehicledetails where VehicleCode in "+session.getAttribute("VehList").toString()+" order by VehicleCode";
//String  sql="select * from t_vehicledetails where VehicleCode="+Vehicles';
ResultSet rst=stmt1.executeQuery(sql);
while(rst.next()){
        
        vehid=rst.getString("VehicleCode");
        
        java.util.Date dt=new java.util.Date();
        String dt1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(dt);      
        
}


%>

                <table width="100%" border="1" align="center" >
        <tr>
                <td colspan="21">
                <div id="report_heding" align="center"><font face="Arial" size="3">Vehicle Maintenance Report for <%=session.getValue("user").toString()%></font></div>
                </td>
        </tr>
</table>




<table width="100%" border="1" align="center" >
        <tr>
                <th class="hed">Sr.</th>
                <th class="hed">VehRegNo</th>
                <th class="hed">Transporter</th>
                <th class="hed">ServiceDate</th>
                <th class="hed">SrviceName</th>
                <th class="hed">ServiceKm</th>
                <th class="hed">NextServiceDate</th>
                <th class="hed">NextServiceAfterKm</th>
                <th class="hed">VendorName</th>
                <th class="hed">Amount</th>
                <th class="hed">Reciept No</th>
                <th class="hed">Document ID</th>
                <th class="hed">AlertBeforedays</th>
                <th class="hed">Alertdate</th>
                <th class="hed">AlertKm</th>
                <th class="hed">AlertAfterKm</th>
                <th class="hed">AlertStatus</th>
                <th class="hed">EmailTo</th>
                <th class="hed">EntDate</th>
                <th class="hed">EntBy</th>
                <th class="hed">Attached File</th> 
        </tr>
                        
                                <%
                                                                
if(vehicles=="All" ||vehicles.equalsIgnoreCase("All"))
{
        vehicles=session.getAttribute("VehList").toString();
}
else
{
        vehicles="("+vehicles+")";
}
                        List<VehicleMentananceData> vehicleMentananceData = null;
                    int numRecords = 0;
                        try {
                                
                                
                                //System.out.println("dataDate1===>"+dataDate1);
                                //System.out.println("dataDate2===>"+dataDate2);
                                //System.out.println("mentstatus===>"+mentstatus);
                                //System.out.println("chbxAll===>"+chbxAll);
                                System.out.println("vehicles===>"+vehicles);  
                                System.out.println("first changes==>"+dataDate1);
                                System.out.println("send date#####===>"+dataDate2);
                                
                                vehicles = vehicles.substring(1,vehicles.length()-1);
                                vehicleMentananceData = vehicleDao.getVehicleMentananceData(vehicles,dataDate1,dataDate2,mentstatus,chbxAll);
                                numRecords = vehicleMentananceData.size();
                            System.out.println("numRecords"+numRecords);
                        
                        } catch (Exception e) {
                                e.printStackTrace();
                        }
%>


        <%
                
        for (int counter1 = 0; counter1 < numRecords; counter1++) {
                //final StopAnalysisData currentRecord = stopAnalysisData.get(counter);
                int i = counter1+1;
                
                final VehicleMentananceData currentRecord1 = vehicleMentananceData.get(counter1);
                
                String currentRecordDate = "";
                final String serviceTye = currentRecord1.getServiceType();
                //System.out.println("servicetype==>"+serviceTye);
                final String serviceDate = currentRecord1.getServiceDate();
                //System.out.println("servicedate==>"+serviceDate);
            final String alertStatus = currentRecord1.getAlertStatus();
        //System.out.println("alertstatus==>"+alertStatus);
                        
                                                  
%>
<%



if(alertStatus.equalsIgnoreCase("pending"))
{%>

<tr>
<td align ="right" ><%=i%></td>
<td align ="right">
<%=currentRecord1.getVehicleRegistrationNumber() %>


<%
}else{

%>

<tr>
<td align ="right"><%=i%></td>
<td align ="right">     
<%=currentRecord1.getVehicleRegistrationNumber() %>

<%      }

%>
</td>
<td align ="left"><%=currentRecord1.getTransporter()%>
</td>
<%
//serviceDate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(serviceDate));

%>
<%try{ %>
<td align ="right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("dd-MM-yyyy").parse(serviceDate))%></td>
<%}
catch(Exception e)
{
        %>
        <td style="text-align: right"><%="NA"%></td>

<%
         
}
%>

<td align ="left"><%=currentRecord1.getSrviceName()%>
</td>
<%
if(currentRecord1.getServiceKm().equalsIgnoreCase("-"))
{
%>
                <td align ="right"><%="NA"%></td>

<%
}
else{
%>
<td align ="right" ><%=currentRecord1.getServiceKm()%></td>
<%
}
try{
nextserviceDate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("dd-MM-yyyy").parse(currentRecord1.getNextServiceDate()));
}catch(Exception e)
{
nextserviceDate="NA";   
}
%>
<td align ="right"><%=nextserviceDate%>
</td>
<%
if(currentRecord1.getNextServiceAfterKm().equalsIgnoreCase("-"))
{
%>
        <td align ="right"><%="NA"%></td>

<%      
}
else{
%>
<td align ="right"><%=currentRecord1.getNextServiceAfterKm()%>
</td>
<%
}
%>
<%
if(currentRecord1.getVendorname().equalsIgnoreCase("-"))
{%>
<td align ="left"><%="NA"%></td>
<% 
}
else
{
%>
<td align ="left"><%=currentRecord1.getVendorname()%>
</td>
<%
}
%>
<%
if(currentRecord1.getAmount().equalsIgnoreCase("-"))
{%>
        <td align ="right"><%="NA"%></td>

<% 

}
else
{
%>
<td align ="right"><%=currentRecord1.getAmount()%>
</td>
<%
}
%>
<%
if(currentRecord1.getReciept().equalsIgnoreCase("-"))
{%>
<td align ="right"><%="NA"%></td>
<%
}
else
{
%>
<td align ="right"><%=currentRecord1.getReciept()%>
</td>
<%
}
%>
<% 
if(currentRecord1.getDocId().equalsIgnoreCase("-"))
{%>

<td align ="right"><%="NA"%></td>

<%

}
else
{
%>

<td align ="right"><%=currentRecord1.getDocId()%>
</td>   
<%
}
%>
<%
if(currentRecord1.getAlertBeforedays().equalsIgnoreCase("-"))
{%>
        <td align ="right" ><%="NA"%></td>


<%
}
else
{
%>
<td align ="right" ><%=currentRecord1.getAlertBeforedays()%>
</td>
<%
}
try{
alertdate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("dd-MM-yyyy").parse(currentRecord1.getAlertdate()));
}
catch(Exception e)
{
        alertdate="NA";
        }
%>
<td align ="right" ><%=alertdate%></td>
<%
if(currentRecord1.getAlertKm().equalsIgnoreCase("-"))
{
%>
        <td align ="right" ><%="NA"%></td>

<%      
}
else
{
%>
<td align ="right" ><%=currentRecord1.getAlertKm()%>
</td>
<%
}
%>
<%
if(currentRecord1.getAlertAfterKm().equalsIgnoreCase("-"))
{
%>
                <td align ="right" ><%="NA"%></td>

<%
}
else
{
%>

<td align ="right" ><%=currentRecord1.getAlertAfterKm()%>
</td>
<%
}
%>
<%
if (alertStatus.equalsIgnoreCase("pending")) {

%>

<td align ="left"><%=alertStatus%></td>

<%
} else {
%>
<td align ="left"><%=alertStatus%></td>
<% 
}
%>
<td align ="left"><%=currentRecord1.getEmailTo()%></td>

<%
if (currentRecord1.getEnteredDate()==null || currentRecord1.getEnteredDate().equals(null) || currentRecord1.getEnteredDate()=="" || currentRecord1.getEnteredDate().equals("") || currentRecord1.getEnteredDate()=="-" || currentRecord1.getEnteredDate().equals("-")) 
{

%>

<td align ="right"><%="NA"%></td>

<%
} else {
try{
 enterdate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(currentRecord1.getEnteredDate()));
}
catch(Exception e)
{
System.out.println("-------Exception in Date."+e);
}
    %>
<td align ="right" ><%=enterdate%></td>
<% 
}
%>


<!--            <td style="text-align: right">< %=currentRecord1.getEnteredDate()%></td>-->
<%
if(currentRecord1.getEnteredBy().equalsIgnoreCase("-"))
{%>

        <td align ="left" ><%="NA"%></td>

<% 

}
else
{
%>

<td align ="left" ><%=currentRecord1.getEnteredBy()%></td>
<%
}
%>
<%
 String newaddfile="";
 String SrDate = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MM-yyyy").parse(serviceDate));
 try
        {
                String Sqllink="SELECT AttachedFile FROM db_gps.t_lastservice WHERE VehRegNo='"+currentRecord1.getVehicleRegistrationNumber()+"' and ServiceDate='"+SrDate+"'";
        System.out.println("Sql Link "+Sqllink);
      ResultSet rsvideo=stmt1.executeQuery(Sqllink);
        System.out.println("1111");
      if(rsvideo.next())
      {
          System.out.println("In recordset  ");
                
        newaddfile=rsvideo.getString("AttachedFile");
        System.out.println("^^^^^^^^^^^^^^^^^^VideoLink ::"+newaddfile);
         
         
        if(newaddfile=="" || newaddfile.equals("")||newaddfile=="-" || newaddfile.equals("-"))
        {
        %>
                                        <td align="left"><div align="left">No Image</div></td>
        
        <%
        }
        else{
                %>
        <td align="left"><div align="left">
        <a href="#" onclick="getFTPImage('<%=newaddfile%>')">View Image</a></div></td>
                
                <%
        }
        


      }
      else
      {
          %>
                        <td align="left"><div align="left">No Image</div></td>

<%
      }
        }
        catch(Exception e)
        {
                e.printStackTrace();
                System.out.println(">>>>>>>>>Exceptrion In Link :"+e);
        }
%>


</tr>

<%
}
        %>

</table>
<%
                                                        }
        } catch (Exception e) {
                 e.printStackTrace();
        }
        %>
<%@ include file="footernew.jsp"%>