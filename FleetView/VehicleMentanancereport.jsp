<%@page import="com.transworld.fleetview.framework.VehicleDao"
        import="com.transworld.fleetview.framework.VehicleMentananceData"
        import="com.transworld.fleetview.framework.Utilities"
        import="com.transworld.fleetview.framework.VehicleRegistrationNumberList"%>
<%@ include file="headernew.jsp"%>
<jsp:useBean id="vehicleDao"
        type="com.transworld.fleetview.framework.VehicleDao"
        scope="application"></jsp:useBean>

<script type="text/javascript">


function getFTPImage(ftpFile)
{
        try
        {
                //alert("+++++"+ftpFile+"+++++");
                
                var fup = ftpFile;
                var ext = fup.substring(fup.lastIndexOf('.') + 1);
                
                //alert("+++++"+ext+"+++++");
                
                if(ext == "pdf" || ext == "PDF")                        
                {
                        //alert("in if");
                        window.open('http://myfleetview.com:8080/images1/vehmaintainance/'+ftpFile+'','mywindow','width=1000, height=600, toolbar=false, location=false, status=no, menubar=no, resizable=no, scrollbars=yes');
                }
                else 
                {
                        //alert("in if");
                        window.open('VehShowFTP.jsp?ftpFile='+ftpFile+'','mywindow','width=1000, height=600, toolbar=false, location=false, status=no, menubar=no, resizable=no, scrollbars=yes');
                }

        }
        catch(e)
        {
                alert(e);
        }
}
function SelectElement(valueToSelect)
{    
        try{
//      alert("--------------------->");
        //alert(valueToSelect);
    var element = document.getElementById('status');
    element.value = valueToSelect;
        }
        catch(e)
        {
        //      alert(e);
        }
}
        


function validate()
{
        if(document.getElementById("data").value=="")
        {
        
                alert("Please select the from date");
                return false;
        }
if(document.getElementById("data1").value=="")
        {
        
                alert("Please select the to date");
                return false;
        }
        
        return datevalidate();
        return true;
}


function datevalidate()
{       var date1=document.getElementById("data").value;
        var date2=document.getElementById("data1").value;
        var dm1,dd1,dy1,dm2,dd2,dy2;
        dy1=date1.substring(0,4);
        dy2=date2.substring(0,4);
        dm1=date1.substring(5,7);
        dm2=date2.substring(5,7);
        dd1=date1.substring(8,10);
        dd2=date2.substring(8,10);
        var date=new Date();
        var month=date.getMonth()+1;
        var day=date.getDate();
        var year=date.getFullYear();
        
        
        
        
        if(dy1>dy2)
        {
                alert("From date year is should not be greater than to date year");
                //document.getElementById("data").value="";
                //document.getElementById("data1").value="";
                document.getElementById("data").focus;
                return false;
        }
        
        else if(year==dy1 && year==dy2) if(dm1>dm2)
        {
                alert("From date month is should not be greater than to date month 5");
                //document.getElementById("data").value="";
                //document.getElementById("data1").value="";
                document.getElementById("data").focus;
                return false;
        }
        if(dm1==dm2) {
        if(dd1 > dd2)
        {
                alert("From date should not be greater than to date");
                //document.getElementById("data").value="";
                //document.getElementById("data1").value="";
                document.getElementById("data").focus;
                return false;
        }
        }
        return true;
}



function toggleDetails(id, show)
{       

        
        var popup = document.getElementById("popup"+id);
        
        if (show) {
        
                popup.style.visibility = "visible";
                popup.setfocus();
        } else {
                popup.style.visibility = "hidden";
        }
}

function allSelected(allVal)
{
        if(document.mentreport.extAll.checked) 
        {
                document.getElementById("frmDT").style.display='none';
        document.getElementById("toDT").style.display='none';
    }
        else 
        {
                document.getElementById("frmDT").style.display="";
        document.getElementById("toDT").style.display="";
        }
}

</script>
<style>
.popup {
         background-color : #98AFC7;
        position: absolute;
        visibility: hidden;
}
</style>

<%!/// Only Class Level Declarations here
        final NumberFormat numberformat = new DecimalFormat("#0.00");
        final SimpleDateFormat yyyy_MM_ddFormatter = new SimpleDateFormat(
                        "yyyy-MM-dd");
        final SimpleDateFormat dd_MM_yyyyParser = new SimpleDateFormat(
                        "dd-MM-yyyy");
        
  %> 

<%
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
String enterdate="",veh_new = "",date1_new = "",date2_new = "",status_new = "";
%>

<%
try {
String ddx=request.getQueryString();
System.out.println("-------string ddx is--->>>"+ddx);

/*if(ddx=="inserted=yes" || ddx.equals("inserted=yes"))
{
         datex1=datex2=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
          data1=data2=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
          mentstatus="All";       
          vehicles="All";

}*/


datex1=request.getParameter("data");
date1_new = datex1;
System.out.println("--datex1------>>>"+datex1);

datex2=request.getParameter("data1");
date2_new = datex2;
System.out.println("--datex2------>>>"+datex2);





mentstatus=request.getParameter("status");
status_new = mentstatus;
System.out.println("--mentstatus------>>>"+mentstatus);

vehicles=request.getParameter("vehicle");

veh_new = vehicles;
System.out.println("--vehicle is ------>>>"+  vehicles);

chbxAll=request.getParameter("extAll");
//chk_new=chbxAll;
System.out.println("--check box is  ------>>>"+chbxAll);

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
}
else
{
        vehicles="("+vehicles+")";
}


if( chbxAll==null||  chbxAll=="")
{
        chbxAll="No";
}
else
{
        chbxAll="Yes";
}

session.setAttribute("data1",data1);
session.setAttribute("data2",data2);
String user,usertypevalue;

user=session.getAttribute("user").toString();
System.out.println("--user------>>>"+user);

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

<!--<table border="0" width=600 align="center" >-->
<!--            <tr>-->
<!--                    <td colspan="5" align="center">
                         <div align="left"><font size="3">Report No:7.0</font></div>
                          <font size="3"><b>Vehicle Maintainance Report</b></font></td>-->
<!--            </tr>-->
<!--            </table>-->

<div style="font-size: 1.8em; text-align: center; margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em" align="center"><font face="Arial" size="3">
        Vehicle Maintainance Report</font></div>
                <div style="margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em" align="center">
                <form name="mentreport" action="" method="get" onsubmit="return validate();">
                <table align="center" border="0" style="text-align: center; margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em">
                
                <tr>
                
                <td>
         <b>Vehicle:</b>
           <select name="vehicle" id="vehicle" style="width: 125px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;">
            <option value="All">All</option>  
            <%
            
                String sqlregno = "select VehicleRegNumber,vehiclecode from db_gps.t_vehicledetails where vehiclecode in "+session.getAttribute("VehList").toString()+" order by VehicleRegNumber";
                ResultSet rsregno = st.executeQuery(sqlregno);
                while(rsregno.next())
                {
                        String vehiclecode1= rsregno.getString("vehiclecode");
                        String VehRegNo=rsregno.getString("VehicleRegNumber");
                        
                        vehicles=vehicles.replace("(","");
                        vehicles=vehicles.replace(")","");
                        
                        
                //      System.out.println("*******");
                        //System.out.println("*vehicles******"+vehicles);
                        //System.out.println("*VehRegNo******"+VehRegNo);
                        //System.out.println("-anil veh-------"+vehicles.equalsIgnoreCase(rsregno.getString("VehicleRegNumber")));
                        
                        if(vehicles==rsregno.getString("vehiclecode") || vehicles.equalsIgnoreCase(rsregno.getString("vehiclecode")))
                        {
                        %>
                    <option value="<%=rsregno.getString("vehiclecode")%>"selected="selected"><%=rsregno.getString("VehicleRegNumber")%></option>                        
                        <%
                        }
                        else
                        {%>
                                <option value="<%=rsregno.getString("vehiclecode")%>"><%=rsregno.getString("VehicleRegNumber")%></option>
                                <%      
                        }
      }
                %>
            
            
            
            
          </select>
           </td>
           
           <td>
           <b>Status:</b>
           <select name="status" id="status" style="width: 87px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;" >
                               <option value="All">All</option>
                               <option value="Pending">Pending</option>
                                    <option value="Processed">Processed</option>
                                     <option value="Closed">Closed</option>
          
          
          </select>  
                  <%
                  
                  if(mentstatus=="('Pending','Processed','Closed')")
                  {%>
                  <script type="text/javascript">
                  SelectElement('All');
                  
                  </script>
                  
                  <%                      
                  }
                  else if(mentstatus=="('Pending')")
                  {%>
                  <script type="text/javascript">
                  SelectElement('Pending');
                  
                  </script>
                  
                  <% 
                          
                  }
                  else if(mentstatus=="('Processed')")
                  {%>
                  <script type="text/javascript">
                  SelectElement('Processed');
                  
                  </script>
                  
                  <% 
                          
                  }
                  else if(mentstatus=="('Closed')")
                  {%>
                  <script type="text/javascript">
                  SelectElement('Closed');
                  
                  </script>
                  
                  <% 
                          
                  }
                  %>         
          </td>
           
           <td>&nbsp;&nbsp;
                                All <input type="checkbox" name="extAll" id="extAll" value="Yes"  onclick="allSelected(this.value);"></input>
                                </td>
                  
                  
                        <td id="frmDT" align="left" style="display:''"><b>From &nbsp;&nbsp; </b>
                        <input type="text" id="data" name="data" value="<%=datex1 %>" size="15" style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF;" readonly /></td>
                        <td align="left"><!--<input type="button" name="From Date" value="From Date" id="trigger">-->
                        <script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data",         // ID of the input field
      ifFormat    : "%d-%b-%Y",     // the date format
      button      : "data"       // ID of the button
    }
  );
</script></td>
                        <td id="toDT" align="left" style="display:''"><b>To&nbsp;&nbsp;</b> <input type="text"
                                id="data1" name="data1" value="<%=datex2 %>" size="15" style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF;" readonly /></td>
                        <td align="left"><!--  <input type="button" name="To Date" value="To Date" id="trigger1">-->
                        <script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data1",         // ID of the input field
      ifFormat    : "%d-%b-%Y",    // the date format
      button      : "data1"       // ID of the button
    }
  );
</script>&nbsp;&nbsp;&nbsp;</td>

          
          
          
                        <td><input type="submit" name="submit" id="submit" value="submit"></td>
                </tr>
        
        </table>
        
        </form>
        </div>
        
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
session.setAttribute("reportno","");
session.setAttribute("reportname","maintainance report");



if(chbxAll!=null)
{
        if(chbxAll.equalsIgnoreCase("yes"))
        {
                %>
                <script type="text/javascript">
//alert("chbxAll");
document.getElementById("extAll").checked=true;
document.getElementById("frmDT").style.display='none';
document.getElementById("toDT").style.display='none';
</script>
                <%
        }
        else
        {
                %>
                <script type="text/javascript">
//alert("chbxAll");
//document.getElementById("extAll").checked=false;
document.getElementById("frmDT").style.display="";
document.getElementById("toDT").style.display="";
</script>
                <%
        }
}
//String str1=("('");

//String str2=str1+vehiclecode1;
//System.out.println("------str2 is--"+str2);

//String str3=("')");

//String str4=str2+str3;
//System.out.println("------str2 is--"+str4);

if(inserted==null)
{
}
else
{ %>

<script language="javascript">

alert("Updated Successfully");

</script>



<%

}



if(inserted2==null)
{
}
else
{ %>

<script language="javascript">

alert(" Deleted  Successfully");

</script>



<%

}


if(inserted3==null)
{
}
else
{ 
        %>

<script language="javascript">

alert("Renewaled Successfully");

</script>



<%

}





String  sql="select * from t_vehicledetails where VehicleCode in "+session.getAttribute("VehList").toString()+" order by VehicleCode";
ResultSet rst=stmt1.executeQuery(sql);
while(rst.next()){
        
        vehid=rst.getString("VehicleCode");
        
        java.util.Date dt=new java.util.Date();
        String dt1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(dt);      
        
}


%>




<table border="0" width="100%" bgcolor="white">
                <tr>
                        <td>
                        <div align="left"><a href="javascript:history.go(-1)"> <img
                                src="images/arrow.bmp" width="20px" height="20px" border="0">
                         </a></div>
                        </td>
</tr>
</table>



<div class="bodyText" align="right">
 <%=Utilities.printDate()%>
<a href="#"
                                        onclick="javascript:window.open('PrintvehMentReport.jsp?vehid=<%=vehid %>');"
                                        title="Print Report"><img src="images/print.jpg" width="15px"
                                        height="15px"></a>&nbsp; &nbsp; <a
                                        href="VehicleMaintenanceExcel.jsp?data=<%=date1_new%>&data1=<%= date2_new%>&status=<%= status_new%>&vehicle=<%=veh_new %>&extAll=<%=chbxAll %>&inserted=<%=inserted %>&inserted1=<%=inserted2 %>&inserted3=<%= inserted3%>"
                                        title="Export to Excel"><img src="images/excel.jpg"
                                        width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp; 
                                </div>





                        <table width="100%" border="1" align="center" class="sortable">
        <tr>
                <td class="sorttable_nosort">
                <div id="report_heding"><font face="Arial" size="3">Vehicle Maintenance Report for <%=session.getValue("usertypevalue").toString()%></font></div>
                <!--  <div align="right"><a href="#"
                        onclick="javascript:window.open('PrintvehMentReport.jsp?vehicle=');"
                        title="Print Report"><img src="images/print.jpg" width="15px"
                        height="15px"></a>&nbsp; &nbsp; <a
                        href="excelvehMentReport.jsp?vehicle="
                        title="Export to Excel"><img src="images/excel.jpg" width="15px"
                        height="15px"></a> <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss")
                                                                        .format(new java.util.Date())%></div>-->
                </td>
        </tr>
</table>




<table width="100%" border="1" align="center" class="sortable">
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
                        //System.out.println("vehicles===>"+vehicles);  
                        //System.out.println("dataDate1===>"+dataDate1);
                        //System.out.println("dataDate2===>"+dataDate2);
                        //System.out.println("mentstatus===>"+mentstatus);
                        //System.out.println("chbxAll===>"+chbxAll);
                        //System.out.println("vehicles===>"+vehicles);  
                        List<VehicleMentananceData> vehicleMentananceData = null;
                    int numRecords = 0;
                        try {
                             
                                vehicleMentananceData = vehicleDao.getVehicleMentananceData(vehicles,dataDate1,dataDate2,mentstatus,chbxAll);
                                
                                numRecords = vehicleMentananceData.size();
                            System.out.println("numRecords"+numRecords);
                            session.setAttribute("vehicleMentananceData1",vehicleMentananceData);
                        
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
                System.out.println("servicetype==>"+serviceTye);
                final String serviceDate = currentRecord1.getServiceDate();
                System.out.println("servicedate==>"+serviceDate);
            final String alertStatus = currentRecord1.getAlertStatus();
        System.out.println("alertstatus==>"+alertStatus);
                        
                                                  
%>
<%



if(alertStatus.equalsIgnoreCase("pending"))
{%>

<tr>
<td style="text-align: right"><%=i%></td>
<td style="text-align: right">
<a href="javascript:toggleDetails(<%=i%>,true);" title="Click Option"><font size="2"><%=currentRecord1.getVehicleRegistrationNumber()%></font></a>
<div class="popup" id="popup<%=i%>">

        <table border="1" bgcolor="white">
                <tr>
        <td> <a href="VehicleMentananceDelete.jsp?vid=<%=currentRecord1.getVehicleCode()%>&VehicleRegNo=<%=currentRecord1.getVehicleRegistrationNumber() %>&servicetype=<%=serviceTye%>&servicedate=<%=serviceDate%>" onclick="toggleDetails(<%=i%>,false);">Delete</a>
        </td>
        </tr>
        <tr>
        <td> <a href="VehicleMentananceEdit.jsp?vid=<%=currentRecord1.getVehicleCode()%>&VehicleRegNo=<%=currentRecord1.getVehicleRegistrationNumber() %> &transpt=<%=currentRecord1.getTransporter()%>&nxtsrvkm=<%=currentRecord1.getNextServiceAfterKm()%>&srvkm=<%=currentRecord1.getServiceKm()%>&srvname=<%=currentRecord1.getSrviceName()%>&nxtsrvdate=<%=currentRecord1.getNextServiceDate()%>&altdate=<%=currentRecord1.getAlertdate()%>&entdate=<%=currentRecord1.getEnteredDate()%>&servicetype=<%=serviceTye%>&servicedate=<%=serviceDate%>&vehregno=<%=currentRecord1.getVehicleRegistrationNumber()%>&vendorname=<%=currentRecord1.getVendorname() %>&amount=<%=currentRecord1.getAmount() %>&recieptno=<%=currentRecord1.getReciept() %>&docid=<%=currentRecord1.getDocId()%>&alertdays=<%=currentRecord1.getAlertBeforedays()%>&nextdate=<%=currentRecord1.getNextServiceDate()%>&email=<%=currentRecord1.getEmailTo()%>" onclick="toggleDetails(<%=i%>,false);">Edit</a>
        </td>
        </tr>
        <tr>
        <td> <a href="javascript:toggleDetails(<%=i%>,false);">Close </a>
        </td>
        </tr>   


<%
}else{

%>

<tr>
<td style="text-align: right"><%=i%></td>
<td style="text-align: right">
<a href="javascript:toggleDetails(<%=i%>,true);" title="Click Option"><font size="2"><%=currentRecord1.getVehicleRegistrationNumber()%></font></a>
<div class="popup" id="popup<%=i%>">
        <table border="1" bgcolor="white">
        <tr>  
        <td> <a href="VehicleMentanancerenewal.jsp?vid=<%=currentRecord1.getVehicleCode()%>&transpt=<%=currentRecord1.getTransporter()%>&nxtsrvdate=<%=currentRecord1.getNextServiceDate()%>&email=<%=currentRecord1.getEmailTo()%>&alertdays=<%=currentRecord1.getAlertBeforedays()%> &nxtsrvkm=<%=currentRecord1.getNextServiceAfterKm()%>&srvkm=<%=currentRecord1.getServiceKm()%> &servicetype=<%=serviceTye%>&servicedate=<%=serviceDate%>&vendorname=<%=currentRecord1.getVendorname() %>&amount=<%=currentRecord1.getAmount() %>&recieptno=<%=currentRecord1.getReciept() %>&docid=<%=currentRecord1.getDocId()%>&vehregno=<%=currentRecord1.getVehicleRegistrationNumber()%>" onclick="toggleDetails(<%=i%>,false);">Renewal</a>
        </td>
        </tr>
        <tr>
        <td> <a href="VehicleMentananceDelete.jsp?vid=<%=currentRecord1.getVehicleCode()%> &VehicleRegNo=<%=currentRecord1.getVehicleRegistrationNumber() %>&servicetype=<%=serviceTye%>&servicedate=<%=serviceDate%>" onclick="toggleDetails(<%=i%>,false);">Delete</a>
        </td>
        </tr>
                <tr>
        <td> <a href="javascript:toggleDetails(<%=i%>,false);">Close </a>
        </td>
        </tr>





<%      }

%>

</table>
</div>
</td>
<td style="text-align: right"><%=currentRecord1.getTransporter()%>
</td>
<%
//serviceDate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(serviceDate));

%>
<%try{ %>
<td style="text-align: right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("dd-MM-yyyy").parse(serviceDate))%></td>
<%}
catch(Exception e)
{
        %>
        <td style="text-align: right"><%="NA"%></td>

<%
         
}
%>

<td style="text-align: right"><%=currentRecord1.getSrviceName()%>
</td>
<%
if(currentRecord1.getServiceKm().equalsIgnoreCase("-"))
{
%>
                <td style="text-align: right"><%="NA"%></td>

<%
}
else{
%>
<td style="text-align: right"><%=currentRecord1.getServiceKm()%></td>
<%
}
try{
nextserviceDate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("dd-MM-yyyy").parse(currentRecord1.getNextServiceDate()));
}catch(Exception e)
{
nextserviceDate="NA";   
}
%>
<td style="text-align: right"><%=nextserviceDate%>
</td>
<%
if(currentRecord1.getNextServiceAfterKm().equalsIgnoreCase("-"))
{
%>
        <td style="text-align: right"><%="NA"%></td>

<%      
}
else{
%>
<td style="text-align: right"><%=currentRecord1.getNextServiceAfterKm()%>
</td>
<%
}
%>
<%
if(currentRecord1.getVendorname().equalsIgnoreCase("-"))
{%>
<td style="text-align: right"><%="NA"%></td>
<% 
}
else
{
%>
<td style="text-align: right"><%=currentRecord1.getVendorname()%>
</td>
<%
}
%>
<%
if(currentRecord1.getAmount().equalsIgnoreCase("-"))
{%>
        <td style="text-align: right"><%="NA"%></td>

<% 

}
else
{
%>
<td style="text-align: right"><%=currentRecord1.getAmount()%>
</td>
<%
}
%>
<%
if(currentRecord1.getReciept().equalsIgnoreCase("-"))
{%>
<td style="text-align: right"><%="NA"%></td>
<%
}
else
{
%>
<td style="text-align: right"><%=currentRecord1.getReciept()%>
</td>
<%
}
%>
<% 
if(currentRecord1.getDocId().equalsIgnoreCase("-"))
{%>

<td style="text-align: right"><%="NA"%></td>

<%

}
else
{
%>

<td style="text-align: right"><%=currentRecord1.getDocId()%>
</td>   
<%
}
%>
<%
if(currentRecord1.getAlertBeforedays().equalsIgnoreCase("-"))
{%>
        <td style="text-align: right"><%="NA"%></td>


<%
}
else
{
%>
<td style="text-align: right"><%=currentRecord1.getAlertBeforedays()%>
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
<td style="text-align: right"><%=alertdate%></td>
<%
if(currentRecord1.getAlertKm().equalsIgnoreCase("-"))
{
%>
        <td style="text-align: right"><%="NA"%></td>

<%      
}
else
{
%>
<td style="text-align: right"><%=currentRecord1.getAlertKm()%>
</td>
<%
}
%>
<%
if(currentRecord1.getAlertAfterKm().equalsIgnoreCase("-"))
{
%>
                <td style="text-align: right"><%="NA"%></td>

<%
}
else
{
%>

<td style="text-align: right"><%=currentRecord1.getAlertAfterKm()%>
</td>
<%
}
%>
<%
if (alertStatus.equalsIgnoreCase("pending")) {

%>

<td style="text-align: right"><a href="javascript: flase;"
onClick="window.open ('Closestatus.jsp?VehicleRegNo=<%=currentRecord1.getVehicleRegistrationNumber()%>&vehcode=<%=currentRecord1.getVehicleCode()%>&servicetype=<%=serviceTye%>&servicedate=<%=serviceDate%>', 
                                        'win1', 'width=400, height=250, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0');"><%=alertStatus%></a></td>

<%
} else {
%>
<td style="text-align: right"><%=alertStatus%></td>
<% 
}
%>
<td style="text-align: right"><%=currentRecord1.getEmailTo()%></td>

<%
if (currentRecord1.getEnteredDate()==null || currentRecord1.getEnteredDate().equals(null) || currentRecord1.getEnteredDate()=="" || currentRecord1.getEnteredDate().equals("") || currentRecord1.getEnteredDate()=="-" || currentRecord1.getEnteredDate().equals("-")) 
{

%>

<td style="text-align: right"><%="NA"%></td>

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
<td style="text-align: right"><%=enterdate%></td>
<% 
}
%>


<!--            <td style="text-align: right">< %=currentRecord1.getEnteredDate()%></td>-->
<%
if(currentRecord1.getEnteredBy().equalsIgnoreCase("-"))
{%>

        <td style="text-align: right"><%="NA"%></td>

<% 

}
else
{
%>

<td style="text-align: right"><%=currentRecord1.getEnteredBy()%></td>
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