<%-- 
    Document   : editTrainingInfo
    Created on : Sep 3/09/2010, 10:45:37 AM
    Author     : sujata

--%>

<%@ include file="../Connections/conn.jsp" %>

<%@page import="com.sun.java.swing.plaf.windows.resources.windows"%><link href="../css/css.css" rel="StyleSheet" type="text/css">
<%!
Connection conn;
Statement st,st1,st2,st3,st4,st5,st6,st7,stmtinsert,stmtinsert1,stmtinsert2,stmt;

%>

<body>
<form >
<%
String sql=null,sql1=null,sql2=null,sql3=null,sql4=null,sql5=null;


String driverfather1="",passportid="",Module4date1="", DOBB="",educationgrade1="",MedicalExamdate1="",LicenseType1="",DOB="",status="",Module3date1="",Module2date1="",Education1="",Module1date1="",vendor1="",BasicTrainerName1="",BasicTrainingCompany1="",BasicComments1="",Module1TrainerName1="",Module1TrainingCompany1="",Module1Comments1="",Module2TrainerName1="",Module2TrainingCompany1="",Module2Comments1="",Module3TrainerName1="",Module3TrainingCompany1="",Module3Comments1="",Module4TrainerName1="",Module4TrainingCompany1="",Module4Comments1="";
String status1="",PreTest40MM1="",basicdate1="",PreTestper1="",PostTest40MM1="",PostTestper1="",Typeofvehicle1="",Drivingschooleducationgrade1="",LicensePlace1="", drivername1="",Transporter1="", licenceno1 = "", licnExpiryDate1  = "", MedicalExam1  = "", MediclExpDate1  = "", Place  = "", Basic1  = "", Module11 = "", Module21  = "",Module31  = "",Module41  = "", remark1  = "", FTTraining1 = "" ,FTTrainingdate1="", LastTraining1 = "", LastTrainingDate1 = "", driverid = "";
String Module5date1="",Module5TrainerName1="",Module5TrainingCompany1="",Module5Comments1="",Module51= "";
driverid=request.getParameter("driverid"); 
passportid=request.getParameter("passid"); 
status="Updated";
status1="Inserted";
Object user=session.getAttribute("user");

	//System.out.println(request.getParameter("drivername"));
//	System.out.println(driverid);
		if(request.getParameter("drivername")!=null)
		{
		  drivername1= (String)request.getParameter("drivername");
		}
		else
		{
			drivername1="-";
		}
	
		if(request.getParameter("driverfather")!=null)
		{
			driverfather1= (String)request.getParameter("driverfather");
		}
		else
		{
			driverfather1="-";
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
		if(request.getParameter("Education")!=null)
		{
			Education1= (String)request.getParameter("Education");
		}
		else
		{
			Education1="-";
			}
		if(request.getParameter("vendor")!=null)
		{
			vendor1= (String)request.getParameter("vendor");
		}
		else
		{
			vendor1="-";
		}
		if(request.getParameter("transporter")!=null)
		{
			Transporter1= (String)request.getParameter("transporter");
		}
		else
		{
			Transporter1="-";
		}
		if(request.getParameter("licenceno")!=null)
		{
			licenceno1 = (String)request.getParameter("licenceno");
		}
		else
		{
			licenceno1="-";
		}
		if(request.getParameter("licnExpiryDate")!=null)
		{
			licnExpiryDate1= (String)request.getParameter("licnExpiryDate").trim();
		}
		else
		{
			licnExpiryDate1="-";
		}
	
		 if(request.getParameter("MedicalExam")!=null)
		 {
			 MedicalExam1 = (String)request.getParameter("MedicalExam");
		 }
		 else
		 {
			 MedicalExam1 = "-";
		 }
		 if(request.getParameter("MedicalExamdate")!=null)
		 {
			 MedicalExamdate1 = (String)request.getParameter("MedicalExamdate");
		 }
		 else
		 {
			 MedicalExamdate1 = "-";
		 }
		 
	 if(request.getParameter("MediclExpDate")!=null)
	 {
		 MediclExpDate1= (String)request.getParameter("MediclExpDate").trim();
	 }
	 else
	 {
		 MediclExpDate1 = "-";
	 }
	 
		 if(request.getParameter("BasicTrainerName")!=null)
		 {
			 BasicTrainerName1= (String)request.getParameter("BasicTrainerName");
		      
		 }
		 else
		 {
			 BasicTrainerName1 = "-";
		 }
		 
		 if(request.getParameter("BasicTrainingCompany")!=null)
		 {
			 BasicTrainingCompany1= (String)request.getParameter("BasicTrainingCompany");
		      
		 }
		 else
		 {
			 BasicTrainingCompany1 = "-";
		 }
		 
		 if(request.getParameter("BasicComments")!=null)
		 {
			 BasicComments1= (String)request.getParameter("BasicComments");
		      
		 }
		 else
		 {
			 BasicComments1 = "-";
		 }
		 
		 if(request.getParameter("Basic")!=null)
		 {
			 Basic1= (String)request.getParameter("Basic");
		      
		 }
		 else
		 {
			 Basic1 = "-";
		 }
		 
		 if(request.getParameter("basicdate")!=null)
		 {
			 basicdate1= (String)request.getParameter("basicdate");
		      
		 }
		 else
		 {
			 basicdate1 = "-";
		 }
	 
		 if(request.getParameter("Module1")!=null)
		 {
			 Module11= (String)request.getParameter("Module1");
		     
		 }
		 else
		 {
			 Module11 = "-";
		 }
		 
			 if(request.getParameter("Module1date")!=null)
			{
				Module1date1= (String)request.getParameter("Module1date");
			}
			else
			{
				Module1date1="-";
			}
			 
			if(request.getParameter("Module1TrainerName")!=null)
			{
				Module1TrainerName1= (String)request.getParameter("Module1TrainerName");
			}
			else
			{
				Module1TrainerName1="-";
			}
			
			if(request.getParameter("Module1TrainingCompany")!=null)
			{
				Module1TrainingCompany1= (String)request.getParameter("Module1TrainingCompany");
			}
			else
			{
				Module1TrainingCompany1="-";
			}
			
			if(request.getParameter("Module1Comments")!=null)
			{
				Module1Comments1= (String)request.getParameter("Module1Comments");
			}
			else
			{
				Module1Comments1="-";
			}
			
		 if(request.getParameter("Module2date")!=null)
		 {
			 Module2date1= (String)request.getParameter("Module2date");
		      
		 }
		 else
		 {
			 Module2date1 = "-";
		 }
		 
		 if(request.getParameter("Module2")!=null)
		 {
			 Module21= (String)request.getParameter("Module2");
		      
		 }
		 else
		 {
			 Module21 = "-";
		 }
			 
		 if(request.getParameter("Module2TrainerName")!=null)
		 {
			 Module2TrainerName1= (String)request.getParameter("Module2TrainerName");
		      
		 }
		 else
		 {
			 Module2TrainerName1 = "-";
		 }
		 
		 if(request.getParameter("Module2TrainingCompany")!=null)
		 {
			 Module2TrainingCompany1= (String)request.getParameter("Module2TrainingCompany");
		      
		 }
		 else
		 {
			 Module2TrainingCompany1 = "-";
		 }
			 
		 if(request.getParameter("Module2Comments")!=null)
		 {
			 Module2Comments1= (String)request.getParameter("Module2Comments");
		      
		 }
		 else
		 {
			 Module2Comments1 = "-";
		 }
	 
		 if(request.getParameter("Module3")!=null)
		 {
			 Module31= (String)request.getParameter("Module3");
		 }
		 else
		 {
			 Module31 = "-";
		 }
		 
		 if(request.getParameter("Module3date")!=null)
		 {
			 Module3date1= (String)request.getParameter("Module3date");
		 }
		 else
		 {
			 Module3date1 = "-";
		 }
		 
		 if(request.getParameter("Module3TrainerName")!=null)
		 {
			 Module3TrainerName1= (String)request.getParameter("Module3TrainerName");
		      
		 }
		 else
		 {
			 Module3TrainerName1 = "-";
		 }
		 
		 if(request.getParameter("Module3TrainingCompany")!=null)
		 {
			 Module3TrainingCompany1= (String)request.getParameter("Module3TrainingCompany");
		      
		 }
		 else
		 {
			 Module3TrainingCompany1 = "-";
		 }
		 
		 if(request.getParameter("Module3Comments")!=null)
		 {
			 Module3Comments1= (String)request.getParameter("Module3Comments");
		      
		 }
		 else
		 {
			 Module3Comments1 = "-";
		 }
	 
      
		 if(request.getParameter("Module4")!=null)
		 {
			 Module41= (String)request.getParameter("Module4");
		 }
		 else
		 {
			 Module41 = "-";
		 }
		 if(request.getParameter("Module4date")!=null)
		 {
			 Module4date1= (String)request.getParameter("Module4date");
		 }
		 else
		 {
			 Module4date1 = "-";
		 }
	 if(request.getParameter("Module4TrainerName")!=null)
	 {
		 Module4TrainerName1= (String)request.getParameter("Module4TrainerName");
	      
	 }
	 else
	 {
		 Module4TrainerName1 = "-";
	 }
	 if(request.getParameter("Module4TrainingCompany")!=null)
	 {
		 Module4TrainingCompany1= (String)request.getParameter("Module4TrainingCompany");
	      
	 }
	 else
	 {
		 Module3TrainingCompany1 = "-";
	 }
	 if(request.getParameter("Module4Comments")!=null)
	 {
		 Module4Comments1= (String)request.getParameter("Module4Comments");
	      
	 }
	 else
	 {
		 Module4Comments1 = "-";
	 }
	 //==================================================================================================================================
		  if(request.getParameter("Module5")!=null)
		 {
			 Module51= (String)request.getParameter("Module5");
		 }
		 else
		 {
			 Module51 = "-";
		 }
		 if(request.getParameter("Module5date")!=null)
		 {
			 Module5date1= (String)request.getParameter("Module5date");
		 }
		 else
		 {
			 Module5date1 = "-";
		 }
	 if(request.getParameter("Module5TrainerName")!=null)
	 {
		 Module5TrainerName1= (String)request.getParameter("Module5TrainerName");
	      
	 }
	 else
	 {
		 Module5TrainerName1 = "-";
	 }
	 if(request.getParameter("Module5TrainingCompany")!=null)
	 {
		 Module5TrainingCompany1= (String)request.getParameter("Module5TrainingCompany");
	      
	 }
	 else
	 {
		 Module5TrainingCompany1 = "-";
	 }
	 if(request.getParameter("Module5Comments")!=null)
	 {
		 Module5Comments1= (String)request.getParameter("Module5Comments");
	      
	 }
	 else
	 {
		 Module5Comments1 = "-";
	 }
	 //===================================================================================================================================
	 if(request.getParameter("remark")!=null)
	 {
		 remark1= (String)request.getParameter("remark");
	 }
	 else
	 {
		 remark1 = "-";
	 }
	 
	 if(request.getParameter("FTTraining")!=null)
	 {
		 FTTraining1= (String)request.getParameter("FTTraining");
	 }
	 else
	 {
		 FTTraining1 = "-";
	 }
	 if(request.getParameter("FTTrainingdate")!=null)
	 {
		 FTTrainingdate1= (String)request.getParameter("FTTrainingdate");
	 }
	 else
	 {
		 FTTrainingdate1 = "-";
	 }
	 if(request.getParameter("LastTraining")!=null)
	 {
		 LastTraining1= (String)request.getParameter("LastTraining");
	 }
	 else
	 {
		 LastTraining1 = "-";
	 }
	 if(request.getParameter("LastTrainingDate")!=null)
	 {
		 LastTrainingDate1= (String)request.getParameter("LastTrainingDate");
	 }
	 else
	 {
		 LastTrainingDate1 = "-";
	 }
	 if(request.getParameter("driverid")!=null)
	 {
		 driverid= (String)request.getParameter("driverid");
	 }
	 else
	 {
		 driverid = "-";
	 }
	 if(request.getParameter("PreTest40MM")!=null)
	 {
		 PreTest40MM1= (String)request.getParameter("PreTest40MM");
	 }
	 else
	 {
		 PreTest40MM1 = "-";
	 }
	 if(request.getParameter("PreTest%")!=null)
	 {
		 PreTestper1= (String)request.getParameter("PreTest%");
	 }
	 else
	 {
		 PreTestper1 = "-";
	 }
	 if(request.getParameter("PostTest40MM")!=null)
	 {
		 PostTest40MM1= (String)request.getParameter("PostTest40MM");
	 }
	 else
	 {
		 PostTest40MM1 = "-";
	 }
	 if(request.getParameter("PreTest%")!=null)
	 {
		 PostTestper1= (String)request.getParameter("PostTest%");
	 }
	 else
	 {
		 PostTestper1 = "-";
	 }
	 if(request.getParameter("Typeofvehicle")!=null)
	 {
		 Typeofvehicle1= (String)request.getParameter("Typeofvehicle");
	 }
	 else
	 {
		 Typeofvehicle1 = "-";
	 }
	 if(request.getParameter("Drivingschooleducationgrade")!=null)
	 {
		 Drivingschooleducationgrade1= (String)request.getParameter("Drivingschooleducationgrade");
	 }
	 else
	 {
		 Drivingschooleducationgrade1 = "-";
	 }
	// System.out.println(request.getParameter("LicensePlace"));
	 if(request.getParameter("LicensePlace")!=null)
	 {
		 LicensePlace1= (String)request.getParameter("LicensePlace");
	//	 System.out.println(LicensePlace1);
	 }
	 else
	 {
		 LicensePlace1 = "-";
	 }
	 if(request.getParameter("LicenseType")!=null)
	 {
		 LicenseType1= (String)request.getParameter("LicenseType");
		// System.out.println(LicenseType1);
	 }
	 else
	 {
		 LicenseType1 = "-";
	 }
	// System.out.println(vendor1);
	// System.out.println(Transporter1);
	int msg=0;
	Boolean insert=false;
	String existedDriver="",msg1="";
try{		
		
			Class.forName(MM_dbConn_DRIVER);
			conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
			st=conn.createStatement();
			st1=conn.createStatement();
			st2=conn.createStatement();
			st3=conn.createStatement();
			st4=conn.createStatement();
			st5=conn.createStatement();
			st7=conn.createStatement();
			st6=conn.createStatement();
			stmtinsert=conn.createStatement();
			stmtinsert1=conn.createStatement();
			stmtinsert2=conn.createStatement();
			stmt=conn.createStatement();
			int maxid=0;
			
			java.util.Date dte = new java.util.Date();
			Format formatter = new SimpleDateFormat("yyyy-MM-dd");
			String today=formatter.format(dte);
			System.out.println("passportid--->"+passportid);
			sql4="select max( Sr ) AS srnum from t_drivertraining";
			  ResultSet rst4=st4.executeQuery(sql4);
			  if(rst4.next())
			  {
			   	maxid=rst4.getInt("srnum");
			  }
				maxid=maxid+1;
			if(passportid==null||passportid.equals(""))
            {
				System.out.println("I am in try");
        	  String sql21="update t_irtedriver set DriverName='"+drivername1+"', fatherName='"+driverfather1+"',LicenseNo='"+licenceno1+"',DOB='"+DOBB+"',Owner='"+Transporter1+"' where rid='"+driverid+"'"; 
              System.out.println("sql21"+sql21);
        	  st5.executeUpdate(sql21);
        	  String abcd6=sql21.replace("'","#");	
	   			abcd6=abcd6.replace(",","$");								
	   			int msg2=stmtinsert.executeUpdate("Insert into t_sqlquery (dbname,query) values ('db_gps','"+abcd6+"')");
      		 System.out.println(msg2);
	   			sql5="select * from t_drivertraining where dcode='"+driverid+"'";
      		 System.out.println(sql5);
      		 ResultSet rst5=st6.executeQuery(sql5);
      		if(rst5.next())
      		{
      			String strupdatetraining="update t_drivertraining set dcode=?,DriverName=?,DriverFatherName=?,DOB=?,Transporter=?,Education=?,vendor=?,PreTest40MM=?,PreTestper=?,PostTest40MM=?,PostTestper=?,Typeofvehicle=?,educationgrade=?, licenceno=?,ExpiryDate=?,LicenseType=?,LicensePlace=?,basicdate=?, Basic =?,BasicTrainerName=?,BasicTrainingCompany=?,BasicComments=?, Module1 =?,Module1date=?,Module1TrainerName=?,Module1TrainingCompany=?,Module1Comments=?, Module2 =?,Module2date=?,Module2TrainerName=?,Module2TrainingCompany=?,Module2Comments=?, Module3 =?,Module3date=?,Module3TrainerName=?,Module3TrainingCompany=?,Module3Comments=?, Module4 =?,Module4date=?,Module4TrainerName=?,Module4TrainingCompany=?,Module4Comments=?,Module5 =?,Module5date=?,Module5TrainerName=?,Module5TrainingCompany=?,Module5Comments=?,remark =?, MedicalExam =?,MedicalExamdate=?, FTTraining =?,FTTrainingdate=?, ExpiryDate2=?,LastTrainingDate =?,LastTraining=?,status=?,user=?, InsrtDt=? where Dcode =? order by Sr asc limit 1";
      			PreparedStatement updatetraining = conn.prepareStatement(strupdatetraining);
				//updatetraining.setInt(1, maxid);
			//	System.out.println("updatetraining"+updatetraining);
				//System.out.println("if started");
				//System.out.println(Transporter1);
				updatetraining.setString(1, driverid);
				updatetraining.setString(2, drivername1);
				updatetraining.setString(3, driverfather1);
				updatetraining.setString(4, DOBB);
				updatetraining.setString(5, Transporter1);
				updatetraining.setString(6, Education1);
				updatetraining.setString(7, vendor1);
				updatetraining.setString(8, PreTest40MM1);
				updatetraining.setString(9, PreTestper1);
				updatetraining.setString(10, PostTest40MM1);
				updatetraining.setString(11, PostTestper1);
				updatetraining.setString(12, Typeofvehicle1);
				updatetraining.setString(13, Drivingschooleducationgrade1);
				updatetraining.setString(14, licenceno1);
				updatetraining.setString(15, licnExpiryDate1);
				updatetraining.setString(16, LicenseType1);
				updatetraining.setString(17, LicensePlace1);
				updatetraining.setString(18, basicdate1);
				updatetraining.setString(19, Basic1);
				updatetraining.setString(20, BasicTrainerName1);
				updatetraining.setString(21, BasicTrainingCompany1);
				updatetraining.setString(22, BasicComments1);
				updatetraining.setString(23, Module11);
				updatetraining.setString(24, Module1date1);
				updatetraining.setString(25, Module1TrainerName1);
				updatetraining.setString(26, Module1TrainingCompany1);
				updatetraining.setString(27, Module1Comments1);
				updatetraining.setString(28, Module21);
				updatetraining.setString(29, Module2date1);
				updatetraining.setString(30, Module2TrainerName1);
				updatetraining.setString(31, Module2TrainingCompany1);
				updatetraining.setString(32, Module2Comments1);
				updatetraining.setString(33, Module31);
				updatetraining.setString(34, Module3date1);
				updatetraining.setString(35, Module3TrainerName1);
				updatetraining.setString(36, Module3TrainingCompany1);
				updatetraining.setString(37, Module3Comments1);
				updatetraining.setString(38, Module41);
				updatetraining.setString(39, Module4date1);
				updatetraining.setString(40, Module4TrainerName1);
				updatetraining.setString(41, Module4TrainingCompany1);
				updatetraining.setString(42, Module4Comments1);
				updatetraining.setString(43, Module51);
				updatetraining.setString(44, Module5date1);
				updatetraining.setString(45, Module5TrainerName1);
				updatetraining.setString(46, Module5TrainingCompany1);
				updatetraining.setString(47, Module5Comments1);
				updatetraining.setString(48, remark1);
				updatetraining.setString(49, MedicalExam1);
				updatetraining.setString(50, MedicalExamdate1);
				updatetraining.setString(51, FTTraining1);
				updatetraining.setString(52, FTTrainingdate1);
				updatetraining.setString(53, MediclExpDate1);
				updatetraining.setString(54, LastTrainingDate1);
				updatetraining.setString(55, LastTraining1);
				updatetraining.setString(56, status);
				updatetraining.setObject(57, user);
				updatetraining.setString(58, today);
				updatetraining.setString(59, driverid);
				
			msg=updatetraining.executeUpdate();
			System.out.println("updatetraining=====>"+updatetraining);
			 String abcd=strupdatetraining.replace("'","#");	
	   			abcd=abcd.replace(",","$");								
	   			stmtinsert.executeUpdate("Insert into t_sqlquery (dbname,query) values ('db_gps','"+abcd+"')");
			response.sendRedirect("trininginfo2.jsp?passportid="+passportid+"&driverid="+driverid+"&father="+driverfather1+"&DOB="+DOBB+"&LicenseNo="+licenceno1+"&drivname="+drivername1+"&msg="+msg+"");
      		
      		}else{
      		 
      		 String stminserttraining="INSERT INTO t_drivertraining(Sr,dcode,DriverName,DriverFatherName,DOB,Transporter,Education,vendor,PreTest40MM,PreTestper,PostTest40MM,PostTestper,Typeofvehicle,educationgrade, licenceno, ExpiryDate,LicenseType,LicensePlace,basicdate, Basic,BasicTrainerName,BasicTrainingCompany,BasicComments, Module1,Module1date,Module1TrainerName,Module1TrainingCompany,Module1Comments, Module2,Module2date,Module2TrainerName,Module2TrainingCompany,Module2Comments, Module3,Module3date,Module3TrainerName,Module3TrainingCompany,Module3Comments,Module4,Module4date,Module4TrainerName,Module4TrainingCompany,Module4Comments,Module5,Module5date,Module5TrainerName,Module5TrainingCompany,Module5Comments,remark, MedicalExam,MedicalExamdate, FTTraining,FTTrainingdate,ExpiryDate2, LastTrainingDate,LastTraining,status,user, InsrtDt) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				//	sql3="INSERT INTO t_drivertraining(Sr ,dcode ,DriverName ,DriverFatherName ,DOB ,Transporter ,licenceno ,ExpiryDate ,Place ,Basic ,Module1 ,Module2 ,Module3 ,Module4 ,remark ,MedicalExam ,FTTraining ,ExpiryDate2 ,LastTrainingDate, LastTraining,InsrtDt) VALUES ('"+maxid+"','"+driverid+"','"+drivername+"','"+driverfather+"','"+DOBB+"','"+Transporter+"','"+licenceno+"','"+licnExpiryDate+"','"+Place+"','"+Basic+"','"+Module1+"','"+Module2+"','"+Module3+"','"+Module4+"','"+remark+"','"+MedicalExam+"','"+FTTraining+"','"+MediclExpDate+"','"+LastTrainingDate+"','"+LastTraining+"','"+today+"')"
				//	,dcode ,DriverName ,DriverFatherName ,DOB ,Transporter ,licenceno ,ExpiryDate ,Place ,Basic ,Module1 ,Module2 ,Module3 ,Module4 ,remark ,MedicalExam ,FTTraining ,ExpiryDate2 ,LastTrainingDate, LastTraining,InsrtDt	
				//	'"+driverid+"','"+drivername+"','"+driverfather+"','"+DOBB+"','"+Transporter+"','"+licenceno+"','"+licnExpiryDate+"'
				//	,'"+Place+"','"+Basic+"','"+Module1+"','"+Module2+"','"+Module3+"','"+Module4+"','"+remark+"','"+MedicalExam+"','"+FTTraining+"','"+MediclExpDate+"','"+LastTrainingDate+"','"+LastTraining+"','"+today+"'
				PreparedStatement inserttraining = conn.prepareStatement(stminserttraining);
					System.out.println("inserttraining"+inserttraining);
					inserttraining.setInt(1, maxid);
					inserttraining.setString(2, driverid);
					inserttraining.setString(3, drivername1);
					inserttraining.setString(4, driverfather1);
					inserttraining.setString(5, DOBB);
					inserttraining.setString(6, Transporter1);
					inserttraining.setString(7, Education1);
					inserttraining.setString(8, vendor1);
					inserttraining.setString(9, PreTest40MM1);
					inserttraining.setString(10, PreTestper1);
					inserttraining.setString(11, PostTest40MM1);
					inserttraining.setString(12, PostTestper1);
					inserttraining.setString(13, Typeofvehicle1);
					inserttraining.setString(14, Drivingschooleducationgrade1);
					inserttraining.setString(15, licenceno1);
					inserttraining.setString(16, licnExpiryDate1);
					inserttraining.setString(17, LicenseType1);
					inserttraining.setString(18, LicensePlace1);
					inserttraining.setString(19, basicdate1);
					inserttraining.setString(20, Basic1);
					inserttraining.setString(21, BasicTrainerName1);
					inserttraining.setString(22, BasicTrainingCompany1);
					inserttraining.setString(23, BasicComments1);
					inserttraining.setString(24, Module11);
					inserttraining.setString(25, Module1date1);
					inserttraining.setString(26, Module1TrainerName1);
					inserttraining.setString(27, Module1TrainingCompany1);
					inserttraining.setString(28, Module1Comments1);
					inserttraining.setString(29, Module21);
					inserttraining.setString(30, Module2date1);
					inserttraining.setString(31, Module2TrainerName1);
					inserttraining.setString(32, Module2TrainingCompany1);
					inserttraining.setString(33, Module2Comments1);
					inserttraining.setString(34, Module31);
					inserttraining.setString(35, Module3date1);
					inserttraining.setString(36, Module3TrainerName1);
					inserttraining.setString(37, Module3TrainingCompany1);
					inserttraining.setString(38, Module3Comments1);
					inserttraining.setString(39, Module41);
					inserttraining.setString(40, Module4date1);
					inserttraining.setString(41, Module4TrainerName1);
					inserttraining.setString(42, Module4TrainingCompany1);
					inserttraining.setString(43, Module4Comments1);
					inserttraining.setString(44, Module51);
					inserttraining.setString(45, Module5date1);
					inserttraining.setString(46, Module5TrainerName1);
					inserttraining.setString(47, Module5TrainingCompany1);
					inserttraining.setString(48, Module5Comments1);
					inserttraining.setString(49, remark1);
					inserttraining.setString(50, MedicalExam1);
					inserttraining.setString(51, MedicalExamdate1);
					inserttraining.setString(52, FTTraining1);
					inserttraining.setString(53, FTTrainingdate1);
					inserttraining.setString(54, MediclExpDate1);
					inserttraining.setString(55, LastTrainingDate1);
					inserttraining.setString(56, LastTraining1);
					inserttraining.setString(57, status1);
					inserttraining.setObject(58, user);
					inserttraining.setString(59, today);
	
				msg=inserttraining.executeUpdate();
				String abcd=stminserttraining.replace("'","#");	
	   			abcd=abcd.replace(",","$");								
	   			stmtinsert2.executeUpdate("Insert into t_sqlquery (dbname,query) values ('db_gps','"+abcd+"')");
				out.println("data inserted");
				response.sendRedirect("trininginfo2.jsp?passportid="+passportid+"&driverid="+driverid+"&father="+driverfather1+"&DOB="+DOBB+"&LicenseNo="+licenceno1+"&drivname="+drivername1+"&msg="+msg1+"");
      		}}
          else
          {
        	    int passportid1=Integer.parseInt(passportid);
        	    System.out.println("passportid1"+passportid1);
				String sqlChk = "select * from t_drivers where DriverID = '"+passportid+"' ";
				System.out.println("sqlChk"+sqlChk);
         	    ResultSet rs = stmt.executeQuery(sqlChk);
         	   System.out.println("sqlChk"+sqlChk);
         	    if(rs.next())
				{
					 existedDriver = rs.getString("DriverID");
					 msg1 = "F";
					 System.out.println("wrong passportID");
				}
				else
				{
					msg1 = "S";
					System.out.println("right passportID");
					if(passportid1!=0)
					{
					String sql13="insert into t_drivers(DriverID,DriverName,Owner,GPNAME,EntryBy) values ('"+passportid+"','"+drivername1+"','"+Transporter1+"','Castrol','IRTE')";
					st7.executeUpdate(sql13);
					System.out.println("sql13=====>"+sql13);
					String abcd=sql13.replace("'","#");	
		   			abcd=abcd.replace(",","$");								
		   			stmtinsert.executeUpdate("Insert into t_sqlquery (dbname,query) values ('db_gps','"+abcd+"')");
					}
					String sql12="update t_irtedriver set PassportID='"+passportid+"' , DriverName='"+drivername1+"', fatherName='"+driverfather1+"',LicenseNo='"+licenceno1+"',DOB='"+DOBB+"',Owner='"+Transporter1+"' where rid='"+driverid+"'"; 
		            st5.executeUpdate(sql12);
		            System.out.println("sql12=====>"+sql12);
		            String abcd=sql12.replace("'","#");	
		   			abcd=abcd.replace(",","$");								
		   			stmtinsert.executeUpdate("Insert into t_sqlquery (dbname,query) values ('db_gps','"+abcd+"')");
				}
				
			String sql6="select * from t_drivertraining where dcode='"+driverid+"'";
	      	ResultSet rst6=st6.executeQuery(sql6);
	      		if(rst6.next())
	      		{
				String stmtupdatetraining="update t_drivertraining set dcode=?,DriverName=?,DriverFatherName=?,DOB=?,Transporter=?,Education=?,vendor=?,PreTest40MM=?,PreTestper=?,PostTest40MM=?,PostTestper=?,Typeofvehicle=?,educationgrade=?, licenceno=?,ExpiryDate=?,LicenseType=?,LicensePlace=?,basicdate=?, Basic =?,BasicTrainerName=?,BasicTrainingCompany=?,BasicComments=?, Module1 =?,Module1date=?,Module1TrainerName=?,Module1TrainingCompany=?,Module1Comments=?, Module2 =?,Module2date=?,Module2TrainerName=?,Module2TrainingCompany=?,Module2Comments=?, Module3 =?,Module3date=?,Module3TrainerName=?,Module3TrainingCompany=?,Module3Comments=?, Module4 =?,Module4date=?,Module4TrainerName=?,Module4TrainingCompany=?,Module4Comments=?, Module5 =?,Module5date=?,Module5TrainerName=?,Module5TrainingCompany=?,Module5Comments=?,remark =?, MedicalExam =?,MedicalExamdate=?, FTTraining =?,FTTrainingdate=?, ExpiryDate2=?,LastTrainingDate =?,LastTraining=?,status=?,user=?, InsrtDt=? where Dcode =? order by Sr asc limit 1";
				PreparedStatement updatetraining = conn.prepareStatement(stmtupdatetraining);
				//updatetraining.setInt(1, maxid);
				//System.out.println("updatetraining"+updatetraining);
				//System.out.println("if started");
				//System.out.println(Transporter1);
				updatetraining.setString(1, passportid);
				updatetraining.setString(2, drivername1);
				updatetraining.setString(3, driverfather1);
				updatetraining.setString(4, DOBB);
				updatetraining.setString(5, Transporter1);
				updatetraining.setString(6, Education1);
				updatetraining.setString(7, vendor1);
				updatetraining.setString(8, PreTest40MM1);
				updatetraining.setString(9, PreTestper1);
				updatetraining.setString(10, PostTest40MM1);
				updatetraining.setString(11, PostTestper1);
				updatetraining.setString(12, Typeofvehicle1);
				updatetraining.setString(13, Drivingschooleducationgrade1);
				updatetraining.setString(14, licenceno1);
				updatetraining.setString(15, licnExpiryDate1);
				updatetraining.setString(16, LicenseType1);
				updatetraining.setString(17, LicensePlace1);
				updatetraining.setString(18, basicdate1);
				updatetraining.setString(19, Basic1);
				updatetraining.setString(20, BasicTrainerName1);
				updatetraining.setString(21, BasicTrainingCompany1);
				updatetraining.setString(22, BasicComments1);
				updatetraining.setString(23, Module11);
				updatetraining.setString(24, Module1date1);
				updatetraining.setString(25, Module1TrainerName1);
				updatetraining.setString(26, Module1TrainingCompany1);
				updatetraining.setString(27, Module1Comments1);
				updatetraining.setString(28, Module21);
				updatetraining.setString(29, Module2date1);
				updatetraining.setString(30, Module2TrainerName1);
				updatetraining.setString(31, Module2TrainingCompany1);
				updatetraining.setString(32, Module2Comments1);
				updatetraining.setString(33, Module31);
				updatetraining.setString(34, Module3date1);
				updatetraining.setString(35, Module3TrainerName1);
				updatetraining.setString(36, Module3TrainingCompany1);
				updatetraining.setString(37, Module3Comments1);
				updatetraining.setString(38, Module41);
				updatetraining.setString(39, Module4date1);
				updatetraining.setString(40, Module4TrainerName1);
				updatetraining.setString(41, Module4TrainingCompany1);
				updatetraining.setString(42, Module4Comments1);
				updatetraining.setString(43, Module51);
				updatetraining.setString(44, Module5date1);
				updatetraining.setString(45, Module5TrainerName1);
				updatetraining.setString(46, Module5TrainingCompany1);
				updatetraining.setString(47, Module5Comments1);
				updatetraining.setString(48, remark1);
				updatetraining.setString(49, MedicalExam1);
				updatetraining.setString(50, MedicalExamdate1);
				updatetraining.setString(51, FTTraining1);
				updatetraining.setString(52, FTTrainingdate1);
				updatetraining.setString(53, MediclExpDate1);
				updatetraining.setString(54, LastTrainingDate1);
				updatetraining.setString(55, LastTraining1);
				updatetraining.setString(56, status);
				updatetraining.setObject(57, user);
				updatetraining.setString(58, today);
				updatetraining.setString(59, driverid);
				msg=updatetraining.executeUpdate();
				
				String abcd=stmtupdatetraining.replace("'","#");	
	   			abcd=abcd.replace(",","$");								
	   			stmtinsert1.executeUpdate("Insert into t_sqlquery (dbname,query) values ('db_gps','"+abcd+"')");
		
	   			response.sendRedirect("trininginfo1.jsp?passportid="+passportid+"&driverFatherName="+driverfather1+"&DOB="+DOBB+"&LicenseNo="+licenceno1+"&driverName="+drivername1+"&msg="+msg1+"&transporter="+Transporter1);
		      	
	      		}else{
	      		String stmtinserttraining="INSERT INTO t_drivertraining(Sr,dcode,DriverName,DriverFatherName,DOB,Transporter,Education,vendor,PreTest40MM,PreTestper,PostTest40MM,PostTestper,Typeofvehicle,educationgrade, licenceno, ExpiryDate,LicenseType,LicensePlace,basicdate, Basic,BasicTrainerName,BasicTrainingCompany,BasicComments, Module1,Module1date,Module1TrainerName,Module1TrainingCompany,Module1Comments, Module2,Module2date,Module2TrainerName,Module2TrainingCompany,Module2Comments, Module3,Module3date,Module3TrainerName,Module3TrainingCompany,Module3Comments,Module4,Module4date,Module4TrainerName,Module4TrainingCompany,Module4Comments,Module5,Module5date,Module5TrainerName,Module5TrainingCompany,Module5Comments,remark, MedicalExam,MedicalExamdate, FTTraining,FTTrainingdate,ExpiryDate2, LastTrainingDate,LastTraining,status,user, InsrtDt) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
	      			PreparedStatement inserttraining = conn.prepareStatement(stmtinserttraining);
					System.out.println("inserttraining"+inserttraining);
					inserttraining.setInt(1, maxid);
					inserttraining.setString(2, driverid);
					inserttraining.setString(3, drivername1);
					inserttraining.setString(4, driverfather1);
					inserttraining.setString(5, DOBB);
					inserttraining.setString(6, Transporter1);
					inserttraining.setString(7, Education1);
					inserttraining.setString(8, vendor1);
					inserttraining.setString(9, PreTest40MM1);
					inserttraining.setString(10, PreTestper1);
					inserttraining.setString(11, PostTest40MM1);
					inserttraining.setString(12, PostTestper1);
					inserttraining.setString(13, Typeofvehicle1);
					inserttraining.setString(14, Drivingschooleducationgrade1);
					inserttraining.setString(15, licenceno1);
					inserttraining.setString(16, licnExpiryDate1);
					inserttraining.setString(17, LicenseType1);
					inserttraining.setString(18, LicensePlace1);
					inserttraining.setString(19, basicdate1);
					inserttraining.setString(20, Basic1);
					inserttraining.setString(21, BasicTrainerName1);
					inserttraining.setString(22, BasicTrainingCompany1);
					inserttraining.setString(23, BasicComments1);
					inserttraining.setString(24, Module11);
					inserttraining.setString(25, Module1date1);
					inserttraining.setString(26, Module1TrainerName1);
					inserttraining.setString(27, Module1TrainingCompany1);
					inserttraining.setString(28, Module1Comments1);
					inserttraining.setString(29, Module21);
					inserttraining.setString(30, Module2date1);
					inserttraining.setString(31, Module2TrainerName1);
					inserttraining.setString(32, Module2TrainingCompany1);
					inserttraining.setString(33, Module2Comments1);
					inserttraining.setString(34, Module31);
					inserttraining.setString(35, Module3date1);
					inserttraining.setString(36, Module3TrainerName1);
					inserttraining.setString(37, Module3TrainingCompany1);
					inserttraining.setString(38, Module3Comments1);
					inserttraining.setString(39, Module41);
					inserttraining.setString(40, Module4date1);
					inserttraining.setString(41, Module4TrainerName1);
					inserttraining.setString(42, Module4TrainingCompany1);
					inserttraining.setString(43, Module4Comments1);
					inserttraining.setString(44, Module51);
					inserttraining.setString(45, Module5date1);
					inserttraining.setString(46, Module5TrainerName1);
					inserttraining.setString(47, Module5TrainingCompany1);
					inserttraining.setString(48, Module5Comments1);
					inserttraining.setString(49, remark1);
					inserttraining.setString(50, MedicalExam1);
					inserttraining.setString(51, MedicalExamdate1);
					inserttraining.setString(52, FTTraining1);
					inserttraining.setString(53, FTTrainingdate1);
					inserttraining.setString(54, MediclExpDate1);
					inserttraining.setString(55, LastTrainingDate1);
					inserttraining.setString(56, LastTraining1);
					inserttraining.setString(57, status1);
					inserttraining.setObject(58, user);
					inserttraining.setString(59, today);
	
				msg=inserttraining.executeUpdate();
				String abcd=stmtinserttraining.replace("'","#");	
	   			abcd=abcd.replace(",","$");								
	   			stmtinsert1.executeUpdate("Insert into t_sqlquery (dbname,query) values ('db_gps','"+abcd+"')");
	   			response.sendRedirect("trininginfo1.jsp?passportid="+passportid+"&driverFatherName="+driverfather1+"&DOB="+DOBB+"&LicenseNo="+licenceno1+"&driverName="+drivername1+"&msg="+msg1+"&transporter="+Transporter1);
	      		}
	      		
          }
}catch(Exception e)
{
	e.printStackTrace();
    //    out.print("Data Not Saved Please Fill The form Properly.");
	response.sendRedirect("../driver_briefing1.jsp");
 
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
