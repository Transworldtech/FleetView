<%-- 
    Document   : editTrainingInfo
    Created on : May 16, 2009, 10:45:37 AM
    Author     : yogesh
--%>

<%@ include file="../Connections/conn.jsp" %>
<link href="../css/css.css" rel="StyleSheet" type="text/css">
<%!
Connection conn;
Statement st,stquery;
String sql, driverid;
%>
<%
driverid=request.getParameter("driverid");

String licenceno = "", licnExpiryDate  = "", MedicalExam  = "", MediclExpDate  = "", Place  = "", Basic  = "", Module1 = "", Module2  = "",Module3  = "",Module4  = "", remark  = "", FTTraining = "" , LastTraining = "", LastTrainingDate = "", driverid = "";
licenceno = (String)request.getParameter("licenceno");
licnExpiryDate= (String)request.getParameter("licnExpiryDate");
    MedicalExam = (String)request.getParameter("MedicalExam");
      MediclExpDate= (String)request.getParameter("MediclExpDate");
      Place= (String)request.getParameter("Place");
      Basic= (String)request.getParameter("Basic");
      Module1= (String)request.getParameter("Module1");
      Module2= (String)request.getParameter("Module2");
      Module3= (String)request.getParameter("Module3");
      Module4= (String)request.getParameter("Module4");
      remark= (String)request.getParameter("remark");
      FTTraining= (String)request.getParameter("FTTraining");
      LastTraining= (String)request.getParameter("LastTraining");
      LastTrainingDate= (String)request.getParameter("LastTrainingDate");
      driverid= (String)request.getParameter("driverid");
      
      
      //new SimpleDateFormat("dd-MM-yyyy").format(rst.getDate("DOB"))
      
      //java.util.Date licnExpiryDate2 = new java.util.Date(licnExpiryDate);
      java.util.Date licnExpiryDate1 = new java.util.Date();
        java.util.Date MediclExpDate1 = new java.util.Date();
         java.util.Date LastTrainingDate1 = new java.util.Date();
        try{
            if(LastTrainingDate.equals(null)||LastTrainingDate.equals("")){
                LastTrainingDate1 = new java.util.Date("00-00-0000");
            }else{
                 LastTrainingDate1 = new SimpleDateFormat("dd-MM-yyyy").parse(LastTrainingDate);
            }
        
        }catch(Exception e){
        //System.out.println("Exception::"+e);
        }
         
         try{
            if(MediclExpDate1.equals(null)||MediclExpDate1.equals("")){
                MediclExpDate1 = new java.util.Date("00-00-0000");
            }else{
                 MediclExpDate1 = new SimpleDateFormat("dd-MM-yyyy").parse(MediclExpDate);
            }
        
        }catch(Exception e){
       // System.out.println("Exception::"+e);
        }
         
         try{
           
		
            if(licnExpiryDate1.equals(null)||licnExpiryDate1.equals("")){
                licnExpiryDate1 = new java.util.Date("00-00-0000");
            }else{
                 licnExpiryDate1 = new SimpleDateFormat("dd-MM-yyyy").parse(licnExpiryDate);
            }
        
        }catch(Exception e){
        //System.out.println("Exception::"+e);
        }
      
      // System.out.println(MediclExpDate+"licnExpiryDate1 ::"+licnExpiryDate1);
        // System.out.println(MediclExpDate+"MediclExpDate1 ::"+MediclExpDate1);
         //  System.out.println(LastTrainingDate+"LastTrainingDate1 ::"+LastTrainingDate1);

try{
			Class.forName(MM_dbConn_DRIVER);
			conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
			st=conn.createStatement();
			stquery=conn.createStatement();
			
                         sql="update t_drivertraining set licenceno='"+licenceno+"', ExpiryDate='"+licnExpiryDate+"' , Place ='"+Place+"' , Basic ='"+Basic+"', Module1 = '"+Module1+"' , Module2 = '"+Module2+"', Module3 = '"+Module3+"', Module4 = '"+Module4+"',remark = '"+remark+"', MedicalExam ='"+MedicalExam+"', FTTraining = '"+FTTraining+"', ExpiryDate2='"+MediclExpDate+"',LastTraining='"+LastTraining+"', LastTrainingDate ='"+LastTrainingDate+"' where Dcode = '"+driverid+"' ";//TripClass_debrief  GPSPercent_debrief
                        
                      /*Query to insert query in db_gps.t_sqlquery table*/
                     	String abcd=sql.replace("'","#");
                     	abcd=abcd.replace(",","$");
                     	stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
                     	
                     /*****************************/
                st.executeUpdate(sql);
		
                            out.print("Data saved successfully.");

}catch(Exception e)
{
	out.print("Exception--->"+e);
        out.print("Data not saved due to exception.");
}
finally
{
conn.close();

}
%>
<table border="1" width="100%">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>


</form>
</body>
</html>
