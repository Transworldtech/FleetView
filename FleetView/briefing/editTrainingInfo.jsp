<%-- 
    Document   : editTrainingInfo
    Created on : May 16, 2009, 10:45:37 AM
    Author     : yogesh
    Last Modified on: May 18, 2009, 10:48 AM
    Modified by: Ayaz A.
--%>

<%@ include file="../Connections/conn.jsp" %>
<link href="../css/css.css" rel="StyleSheet" type="text/css">
<%!
Connection conn;
Statement st,st1,st2,st3,st4;

%>
<%
String sql=null,sql1=null,sql2=null,sql3=null,sql4=null;


String driverfather="", DOBB="", drivername="",Transporter="", licenceno = "", licnExpiryDate  = "", MedicalExam  = "", MediclExpDate  = "", Place  = "", Basic  = "", Module1 = "", Module2  = "",Module3  = "",Module4  = "", remark  = "", FTTraining = "" , LastTraining = "", LastTrainingDate = "", driverid = "";
driverid=request.getParameter("driverid"); 
	//System.out.println(request.getParameter("drivername"));
	if(request.getParameter("drivername")!=null)
	{
	  drivername= (String)request.getParameter("drivername");
	}
	else
	{
		drivername="-";
	}
	if(request.getParameter("driverfather")!=null)
	{
		driverfather= (String)request.getParameter("driverfather");
	}
	else
	{
		driverfather="-";
	}
	//System.out.println(request.getParameter("DOB"));
	if(request.getParameter("DOB")!=null)
	{
		DOBB= (String)request.getParameter("DOB").trim();
	}
	else
	{
		DOBB="-";
	}
	if(request.getParameter("Transporter")!=null)
	{
		Transporter= (String)request.getParameter("Transporter");
	}
	else
	{
		Transporter="-";
	}
	if(request.getParameter("licenceno")!=null)
	{
		licenceno = (String)request.getParameter("licenceno");
	}
	else
	{
		licenceno="-";
	}
	if(request.getParameter("licnExpiryDate")!=null)
	{
		licnExpiryDate= (String)request.getParameter("licnExpiryDate").trim();
	}
	else
	{
		licnExpiryDate="-";
	}
	
	 if(request.getParameter("MedicalExam")!=null)
	 {
		 MedicalExam = (String)request.getParameter("MedicalExam");
	 }
	 else
	 {
		 MedicalExam = "-";
	 }
	 
	 if(request.getParameter("MediclExpDate")!=null)
	 {
		 MediclExpDate= (String)request.getParameter("MediclExpDate").trim();
	 }
	 else
	 {
		 MediclExpDate = "-";
	 }
	 
	 if(request.getParameter("Place")!=null)
	 {
		 Place= (String)request.getParameter("Place");
	      
	 }
	 else
	 {
		 Place = "-";
	 }
	 if(request.getParameter("Basic")!=null)
	 {
		 Basic= (String)request.getParameter("Basic");
	      
	 }
	 else
	 {
		 Basic = "-";
	 }
	 if(request.getParameter("Module1")!=null)
	 {
		 Module1= (String)request.getParameter("Module1");
	     
	 }
	 else
	 {
		 Module1 = "-";
	 }
	 if(request.getParameter("Module2")!=null)
	 {
		 Module2= (String)request.getParameter("Module2");
	      
	 }
	 else
	 {
		 Module2 = "-";
	 }
	 if(request.getParameter("Module3")!=null)
	 {
		 Module3= (String)request.getParameter("Module3");
	 }
	 else
	 {
		 Module3 = "-";
	 }
     
      
	 if(request.getParameter("Module4")!=null)
	 {
		 Module4= (String)request.getParameter("Module4");
	 }
	 else
	 {
		 Module4 = "-";
	 }
	 if(request.getParameter("remark")!=null)
	 {
		 remark= (String)request.getParameter("remark");
	 }
	 else
	 {
		 remark = "-";
	 }
     
	 if(request.getParameter("FTTraining")!=null)
	 {
		 FTTraining= (String)request.getParameter("FTTraining");
	 }
	 else
	 {
		 FTTraining = "-";
	 }
	 if(request.getParameter("LastTraining")!=null)
	 {
		 LastTraining= (String)request.getParameter("LastTraining");
	 }
	 else
	 {
		 LastTraining = "-";
	 }
	 if(request.getParameter("LastTrainingDate")!=null)
	 {
		 LastTrainingDate= (String)request.getParameter("LastTrainingDate");
	 }
	 else
	 {
		 LastTrainingDate = "-";
	 }
	 if(request.getParameter("driverid")!=null)
	 {
		 driverid= (String)request.getParameter("driverid");
	 }
	 else
	 {
		 driverid = "-";
	 }

try{
			Class.forName(MM_dbConn_DRIVER);
			conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
			st=conn.createStatement();
			st1=conn.createStatement();
			st2=conn.createStatement();
			st3=conn.createStatement();
			st4=conn.createStatement();
			int maxid=0;
			
			java.util.Date dte = new java.util.Date();
			Format formatter = new SimpleDateFormat("yyyy-MM-dd");
			String today=formatter.format(dte);
                        
		//	String OldTransporter="",licenceno1 = "", licnExpiryDate11  = "", MedicalExam1  = "", MediclExpDate11  = "", Place1  = "", Basic1  = "", Module11 = "", Module21  = "",Module31  = "",Module41  = "", remark1  = "", FTTraining1 = "" , LastTraining1 = "", LastTrainingDate11 = "", driverid1 = "";
			sql1="select * FROM t_drivertraining where Dcode = '"+driverid+"' ";
			 //System.out.println(sql1);
			ResultSet rst1=st1.executeQuery(sql1);
			if(rst1.next())
			{
				String DOB="",OldLastTrainingDate="",Oldbasicdate="",OldModule1date="",OldModule2date="",OldFTTrainingdate="";
				String Oldpassport="",OldExpiryDate="",OldModule3date="",OldModule4date="",OldMedicalExamdate="";
				String OldExpiryDate1="",OldExpiryDate2="";
				String OldDecode=rst1.getString("dcode");
				String DriverName=rst1.getString("DriverName");
				String DriverFatherName =rst1.getString("DriverFatherName");
				try
				{
				 DOB =rst1.getString("DOB").trim();
				}
				catch(Exception e)
				{
					DOB =rst1.getString("DOB");
				}
				String OldTransporter=rst1.getString("Transporter");
				String Oldlicenceno=rst1.getString("licenceno");
				//System.out.println("harshal");
				try
				{
					Oldpassport=rst1.getString("passport").trim();
				}catch(Exception e)
				{
					Oldpassport=rst1.getString("passport");
				}
								
				try
				{
					OldExpiryDate=rst1.getString("ExpiryDate").trim();
				}catch(Exception e)
				{
					OldExpiryDate=rst1.getString("ExpiryDate");
				}
				 
				String OldPlace=rst1.getString("Place");
				try
				{
					Oldbasicdate=rst1.getString("basicdate").trim();
				}catch(Exception e)
				{
					Oldbasicdate=rst1.getString("basicdate");
				}
				 
				String OldBasic=rst1.getString("Basic");
				try
				{
					OldModule1date=rst1.getString("Module1date").trim();
				}catch(Exception e)
				{
					OldModule1date=rst1.getString("Module1date");
				}
				 
				// System.out.println("hiiiiiiii");
				String OldModule1=rst1.getString("Module1");
				try
				{
					 OldModule2date=rst1.getString("Module2date").trim();
				}catch(Exception e)
				{
					 OldModule2date=rst1.getString("Module2date");
				}
				
				String OldModule2=rst1.getString("Module2");
				try
				{
					 OldModule3date=rst1.getString("Module3date").trim();
				}catch(Exception e)
				{
					 OldModule3date=rst1.getString("Module3date");
				}
				
				String OldModule3=rst1.getString("Module3");
				try
				{
					 OldModule4date=rst1.getString("Module4date").trim();
				}catch(Exception e)
				{
					 OldModule4date=rst1.getString("Module4date");
				}
				
				// System.out.println("hiiiiiiii11111");
				String OldModule4=rst1.getString("Module4");
				String Oldremark=rst1.getString("remark");
				try
				{
					 OldMedicalExamdate=rst1.getString("MedicalExamdate").trim();
				}catch(Exception e)
				{
					 OldMedicalExamdate=rst1.getString("MedicalExamdate");
				}
				
				String OldMedicalExam=rst1.getString("MedicalExam");
				try
				{
					 OldFTTrainingdate=rst1.getString("FTTrainingdate").trim();
				}catch(Exception e)
				{
					 OldFTTrainingdate=rst1.getString("FTTrainingdate");
				}
				
				String OldFTTraining=rst1.getString("FTTraining");
				try
				{
					 OldExpiryDate1=rst1.getString("ExpiryDate1").trim();
				}catch(Exception e)
				{
					 OldExpiryDate1=rst1.getString("ExpiryDate1");
				}
				
				 //System.out.println("hiiiiiiii22222222");
				 try
					{
					  OldExpiryDate2=rst1.getString("ExpiryDate2").trim();
					}catch(Exception e)
					{
						 OldExpiryDate2=rst1.getString("ExpiryDate2").trim();
					}
				
				//System.out.println("hiiiiiiii333333333");
				
				try
				{
				 OldLastTrainingDate=rst1.getString("LastTrainingDate").trim();
				}
				catch(Exception e){
					OldLastTrainingDate=rst1.getString("LastTrainingDate");

				}
				 
				String OldLastTraining=rst1.getString("LastTraining");
				
				//sql2="INSERT INTO `t_drivertrainingHistory` (dcode,DriverName,DriverFatherName,DOB,OldTransporter,licenceno,Oldpassport,OldExpiryDate,OldPlace,Oldbasicdate,OldBasic,OldModule1date,OldModule1,OldModule2date,OldModule2,OldModule3date,OldModule3,OldModule4date,OldModule4,Oldremark,OldMedicalExamdate,OldMedicalExam,OldFTTrainingdate,OldFTTraining,OldExpiryDate1,OldExpiryDate2,OldLastTrainingDate,OldLastTraining,NewTransporter,Newlicenceno,NewExpiryDate,NewPlace,NewBasic,NewModule1,NewModule2,NewModule3,NewModule4,Newremark,NewMedicalExam,NewFTTraining,NewExpiryDate2,NewLastTrainingDate,NewLastTraining,Updated)VALUES('"+OldDecode+"','"+DriverName+"','"+DriverFatherName+"','"+DOB+"','"+OldTransporter+"','"+Oldlicenceno+"','"+Oldpassport+"','"+OldExpiryDate+"','"+OldPlace+"','"+Oldbasicdate+"','"+OldBasic+"','"+OldModule1date+"','"+OldModule1+"','"+OldModule2date+"','"+OldModule2+"','"+OldModule3date+"','"+OldModule3+"','"+OldModule4date+"','"+OldModule4+"','"+Oldremark+"','"+OldMedicalExamdate+"','"+OldMedicalExam+"','"+OldFTTrainingdate+"','"+OldFTTraining+"','"+OldExpiryDate1+"','"+OldExpiryDate2+"','"+OldLastTrainingDate+"','"+OldLastTraining+"','"+Transporter+"','"+licenceno+"','"+licnExpiryDate+"','"+Place+"','"+Basic+"','"+Module1+"','"+Module2+"','"+Module3+"','"+Module4+"','"+remark+"','"+MedicalExam+"','"+FTTraining+"','"+MediclExpDate+"','"+LastTrainingDate+"','"+LastTraining+"','"+today+"')";
				PreparedStatement drivertrainingHistory = conn.prepareStatement("INSERT INTO t_drivertrainingHistory (dcode,DriverName,DriverFatherName,DOB,OldTransporter,licenceno,Oldpassport,OldExpiryDate,OldPlace,Oldbasicdate,OldBasic,OldModule1date,OldModule1,OldModule2date,OldModule2,OldModule3date,OldModule3,OldModule4date,OldModule4,Oldremark,OldMedicalExamdate,OldMedicalExam,OldFTTrainingdate,OldFTTraining,OldExpiryDate1,OldExpiryDate2,OldLastTrainingDate,OldLastTraining,NewTransporter,Newlicenceno,NewExpiryDate,NewPlace,NewBasic,NewModule1,NewModule2,NewModule3,NewModule4,Newremark,NewMedicalExam,NewFTTraining,NewExpiryDate2,NewLastTrainingDate,NewLastTraining,Updated)VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				drivertrainingHistory.setString(1, OldDecode);
				drivertrainingHistory.setString(2, DriverName);
				drivertrainingHistory.setString(3, DriverFatherName);
				drivertrainingHistory.setString(4, DOB);
				drivertrainingHistory.setString(5, OldTransporter);
				drivertrainingHistory.setString(6, Oldlicenceno);
				drivertrainingHistory.setString(7, Oldpassport);
				drivertrainingHistory.setString(8, OldExpiryDate);
				drivertrainingHistory.setString(9, OldPlace);
				drivertrainingHistory.setString(10, Oldbasicdate);
				drivertrainingHistory.setString(11, OldBasic);
				drivertrainingHistory.setString(12, OldModule1date);
				drivertrainingHistory.setString(13, OldModule1);
				drivertrainingHistory.setString(14, OldModule2date);
				drivertrainingHistory.setString(15, OldModule2);
				drivertrainingHistory.setString(16, OldModule3date);
				drivertrainingHistory.setString(17, OldModule3);
				drivertrainingHistory.setString(18, OldModule4date);
				drivertrainingHistory.setString(19, OldModule4);
				drivertrainingHistory.setString(20, Oldremark);
				drivertrainingHistory.setString(21, OldMedicalExamdate);
				drivertrainingHistory.setString(22, OldMedicalExam);
				drivertrainingHistory.setString(23, OldFTTrainingdate);
				drivertrainingHistory.setString(24, OldFTTraining);
				drivertrainingHistory.setString(25, OldExpiryDate1);
				drivertrainingHistory.setString(26, OldExpiryDate2);
				drivertrainingHistory.setString(27, OldLastTrainingDate);
				drivertrainingHistory.setString(28, OldLastTraining);
				drivertrainingHistory.setString(29, Transporter);
				drivertrainingHistory.setString(30, licenceno);
				drivertrainingHistory.setString(31, licnExpiryDate);
				drivertrainingHistory.setString(32, Place);
				drivertrainingHistory.setString(33, Basic);
				drivertrainingHistory.setString(34, Module1);
				drivertrainingHistory.setString(35, Module2);
				drivertrainingHistory.setString(36, Module3);
				drivertrainingHistory.setString(37, Module4);
				drivertrainingHistory.setString(38, remark);
				drivertrainingHistory.setString(39, MedicalExam);
				drivertrainingHistory.setString(40, FTTraining);
				drivertrainingHistory.setString(41, MediclExpDate);
				drivertrainingHistory.setString(42, LastTrainingDate);
				drivertrainingHistory.setString(43, LastTraining);
				drivertrainingHistory.setString(44, today);
				
			drivertrainingHistory.executeUpdate();
				
				// System.out.println(sql2);
				//st2.executeUpdate(sql2);
				//out.print(sql2);
				//sql="update t_drivertraining set DriverName='"+drivername+"',Transporter='"+Transporter+"', licenceno='"+licenceno+"', ExpiryDate='"+licnExpiryDate+"' , Place ='"+Place+"' , Basic ='"+Basic+"', Module1 = '"+Module1+"' , Module2 = '"+Module2+"', Module3 = '"+Module3+"', Module4 = '"+Module4+"',remark = '"+remark+"', MedicalExam ='"+MedicalExam+"', FTTraining = '"+FTTraining+"', ExpiryDate2='"+MediclExpDate+"',LastTraining='"+LastTraining+"', LastTrainingDate ='"+LastTrainingDate+"', InsrtDt='"+today+"' where Dcode = '"+driverid+"' ";//TripClass_debrief  GPSPercent_debrief
				
				PreparedStatement updatetraining = conn.prepareStatement("update t_drivertraining set DriverName=?,Transporter=?, licenceno=?, ExpiryDate=? , Place =? , Basic =?, Module1 =?, Module2 =?, Module3 =?, Module4 =?,remark =?, MedicalExam =?, FTTraining =?, ExpiryDate2=?,LastTraining=?, LastTrainingDate =?, InsrtDt=? where Dcode =? ");
				//updatetraining.setInt(1, maxid);
				//updatetraining.setString(2, driverid);
				updatetraining.setString(1, drivername);//'"+drivername+"'
				updatetraining.setString(2, Transporter);
				updatetraining.setString(3, licenceno);
				updatetraining.setString(4, licnExpiryDate);
				updatetraining.setString(5, Place);
				updatetraining.setString(6, Basic);
				updatetraining.setString(7, Module1);
				updatetraining.setString(8, Module2);
				updatetraining.setString(9, Module3);
				updatetraining.setString(10, Module4);
				updatetraining.setString(11, remark);
				updatetraining.setString(12, MedicalExam);
				updatetraining.setString(13, FTTraining);
				updatetraining.setString(14, MediclExpDate);
				updatetraining.setString(15, LastTrainingDate);
				updatetraining.setString(16, LastTraining);
				updatetraining.setString(17, today);
				updatetraining.setString(18, driverid);
				
			updatetraining.executeUpdate();

				
				//System.out.println("brifing/editTraingingInfo...sql :: "+sql);
				//ResultSet rst=st.executeQuery(sql);
		        //st.executeUpdate(sql);
			}
			
			else
			{
				sql4="select max( Sr ) AS srnum from t_drivertraining";
				ResultSet rst4=st4.executeQuery(sql4);
				if(rst4.next())
				{
					maxid=rst4.getInt("srnum");
				}
				maxid=maxid+1;
				//sql3="INSERT INTO t_drivertraining(Sr ,dcode ,DriverName ,DriverFatherName ,DOB ,Transporter ,licenceno ,ExpiryDate ,Place ,Basic ,Module1 ,Module2 ,Module3 ,Module4 ,remark ,MedicalExam ,FTTraining ,ExpiryDate2 ,LastTrainingDate, LastTraining,InsrtDt) VALUES ('"+maxid+"','"+driverid+"','"+drivername+"','"+driverfather+"','"+DOBB+"','"+Transporter+"','"+licenceno+"','"+licnExpiryDate+"','"+Place+"','"+Basic+"','"+Module1+"','"+Module2+"','"+Module3+"','"+Module4+"','"+remark+"','"+MedicalExam+"','"+FTTraining+"','"+MediclExpDate+"','"+LastTrainingDate+"','"+LastTraining+"','"+today+"')"
				//,dcode ,DriverName ,DriverFatherName ,DOB ,Transporter ,licenceno ,ExpiryDate ,Place ,Basic ,Module1 ,Module2 ,Module3 ,Module4 ,remark ,MedicalExam ,FTTraining ,ExpiryDate2 ,LastTrainingDate, LastTraining,InsrtDt	
				//'"+driverid+"','"+drivername+"','"+driverfather+"','"+DOBB+"','"+Transporter+"','"+licenceno+"','"+licnExpiryDate+"'
				//,'"+Place+"','"+Basic+"','"+Module1+"','"+Module2+"','"+Module3+"','"+Module4+"','"+remark+"','"+MedicalExam+"','"+FTTraining+"','"+MediclExpDate+"','"+LastTrainingDate+"','"+LastTraining+"','"+today+"'
				PreparedStatement inserttraining = conn.prepareStatement("INSERT INTO t_drivertraining(Sr,dcode,DriverName ,DriverFatherName ,DOB ,Transporter ,licenceno ,ExpiryDate ,Place ,Basic ,Module1 ,Module2 ,Module3 ,Module4 ,remark ,MedicalExam ,FTTraining ,ExpiryDate2 ,LastTrainingDate, LastTraining,InsrtDt) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					inserttraining.setInt(1, maxid);
					inserttraining.setString(2, driverid);
					inserttraining.setString(3, drivername);
					inserttraining.setString(4, driverfather);
					inserttraining.setString(5, DOBB);
					inserttraining.setString(6, Transporter);
					inserttraining.setString(7, licenceno);
					inserttraining.setString(8, licnExpiryDate);
					inserttraining.setString(9, Place);
					inserttraining.setString(10, Basic);
					inserttraining.setString(11, Module1);
					inserttraining.setString(12, Module2);
					inserttraining.setString(13, Module3);
					inserttraining.setString(14, Module4);
					inserttraining.setString(15, remark);
					inserttraining.setString(16, MedicalExam);
					inserttraining.setString(17, FTTraining);
					inserttraining.setString(18, MediclExpDate);
					inserttraining.setString(19, LastTrainingDate);
					inserttraining.setString(20, LastTraining);
					inserttraining.setString(21, today);
					
				inserttraining.executeUpdate();

			}
			
		
                            out.print("Data saved successfully.");

}catch(Exception e)
{
	System.out.print("Exception--->"+e);
    //    out.print("Data Not Saved Please Fill The form Properly.");
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