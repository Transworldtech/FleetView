<%-- 
    Document   : editTrainingInfo
    Created on : Sep 3/09/2010, 10:45:37 AM
    Author     : sujata

--%>

<%@ include file="../Connections/conn.jsp" %>
<link href="../css/css.css" rel="StyleSheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/view.css" media="all">
 
<%!
Connection conn;
Statement st,st1,st2,st3,st4,stmtinsert,stmtinsert1,stmtinsert2,stmtinsert3;

%>

<body>
<form > 
<%
String sql=null,sql1=null,sql2=null,sql3=null,sql4=null;


String driverfather1="",Module4date1="", DOBB="",educationgrade1="",MedicalExamdate1="",LicenseType1="",DOB="",status="",Module3date1="",Module2date1="",Education1="",Module1date1="",vendor1="",BasicTrainerName1="",BasicTrainingCompany1="",BasicComments1="",Module1TrainerName1="",Module1TrainingCompany1="",Module1Comments1="",Module2TrainerName1="",Module2TrainingCompany1="",Module2Comments1="",Module3TrainerName1="",Module3TrainingCompany1="",Module3Comments1="",Module4TrainerName1="",Module4TrainingCompany1="",Module4Comments1="";
String PreTest40MM1="",basicdate1="",PreTestper1="",PostTest40MM1="",PostTestper1="",Typeofvehicle1="",Drivingschooleducationgrade1="",LicensePlace1="", drivername1="",Transporter1="", licenceno1 = "", licnExpiryDate1  = "", MedicalExam1  = "", MediclExpDate1  = "", Place  = "", Basic1  = "", Module11 = "", Module21  = "",Module31  = "",Module41  = "", remark1  = "", FTTraining1 = "" ,FTTrainingdate1="", LastTraining1 = "", LastTrainingDate1 = "", driverid = "";
String Module5date1="",Module5TrainerName1="",Module5TrainingCompany1="",Module5Comments1="",Module51= "";

String Capsule1date="",Capsule1TrainerName="",Capsule1TrainingCompany="",Capsule1Comments="",Capsule1= "";
String Capsule2date="",Capsule2TrainerName="",Capsule2TrainingCompany="",Capsule2Comments="",Capsule2= "";
String Capsule3date="",Capsule3TrainerName="",Capsule3TrainingCompany="",Capsule3Comments="",Capsule3= "";
String BTDdate="",BTDTrainerName="",BTDTrainingCompany="",BTDComments="",BTD= "";
String ORAdate="",ORATrainerName="",ORATrainingCompany="",ORAComments="",ORA= "",ORAVehType="";





driverid=request.getParameter("driverid"); 
status="Updated";
Object user=session.getAttribute("user");
//System.out.println(user);
	//System.out.println(request.getParameter("drivername"));
	//System.out.println(driverid);
	
	
	
	if(request.getParameter("Capsule1")!=null)
	 {
		Capsule1= (String)request.getParameter("Capsule1");
	     
	 }
	 else
	 {
		 Capsule1 = "-";
	 }
	 if(request.getParameter("Capsule1date")!=null && !(request.getParameter("Capsule1date").equals("-")))
		{
		 //Capsule1date=request.getParameter("Capsule1date");
		 try{
		 Capsule1date=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("Capsule1date")));
		 }catch(Exception e)
		 {
			 Capsule1date=request.getParameter("Capsule1date");
		 }
		}
		else
		{
			Capsule1date="-";
		}
		if(request.getParameter("Capsule1TrainerName")!=null)
		{
			Capsule1TrainerName= (String)request.getParameter("Capsule1TrainerName");
			
		}
		else
		{
			Capsule1TrainerName="-";
		}
		if(request.getParameter("Capsule1TrainingCompany")!=null)
		{
			Capsule1TrainingCompany= (String)request.getParameter("Capsule1TrainingCompany");
		}
		else
		{
			Capsule1TrainingCompany="-";
		}
		if(request.getParameter("Capsule1Comments")!=null || request.getParameter("Capsule1Comments") !="-")
		{
			Capsule1Comments= (String)request.getParameter("Capsule1Comments");
		}
		else
		{
			Capsule1Comments="-";
		}
	
	
	
	
	
		if(request.getParameter("Capsule2")!=null)
		 {
			Capsule2= (String)request.getParameter("Capsule2");
		     
		 }
		 else
		 {
			 Capsule2 = "-";
		 }
		 if(request.getParameter("Capsule2date")!=null && !(request.getParameter("Capsule2date").equals("-")))
			{
			 try{
			 Capsule2date=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("Capsule2date")));
			 }catch(Exception e)
			 {
				 Capsule2date= (String)request.getParameter("Capsule2date");

			 }
			}
			else
			{
				Capsule2date="-";
			}
			if(request.getParameter("Capsule2TrainerName")!=null)
			{
				Capsule2TrainerName= (String)request.getParameter("Capsule2TrainerName");
			}
			else
			{
				Capsule2TrainerName="-";
			}
			if(request.getParameter("Capsule2TrainingCompany")!=null)
			{
				Capsule2TrainingCompany= (String)request.getParameter("Capsule2TrainingCompany");
			}
			else
			{
				Capsule2TrainingCompany="-";
			}
			if(request.getParameter("Capsule2Comments")!=null)
			{
				Capsule2Comments= (String)request.getParameter("Capsule2Comments");
			}
			else
			{
				Capsule2Comments="-";
			}
		
			if(request.getParameter("Capsule3")!=null)
			 {
				Capsule3= (String)request.getParameter("Capsule3");
			     
			 }
			 else
			 {
				 Capsule3 = "-";
			 }
			 if(request.getParameter("Capsule3date")!=null && !(request.getParameter("Capsule3date").equals("-")))
				{
				 try{
				 Capsule3date=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("Capsule3date")));
				 }
				 catch(Exception e)
				 {
					 Capsule3date= (String)request.getParameter("Capsule3date");

				 }
				}
				else
				{
					Capsule3date="-";
				}
				if(request.getParameter("Capsule3TrainerName")!=null)
				{
					Capsule3TrainerName= (String)request.getParameter("Capsule3TrainerName");
				}
				else
				{
					Capsule3TrainerName="-";
				}
				if(request.getParameter("Capsule3TrainingCompany")!=null)
				{
					Capsule3TrainingCompany= (String)request.getParameter("Capsule3TrainingCompany");
				}
				else
				{
					Capsule3TrainingCompany="-";
				}
				if(request.getParameter("Capsule3Comments")!=null)
				{
					Capsule3Comments= (String)request.getParameter("Capsule3Comments");
				}
				else
				{
					Capsule3Comments="-";
				}
			
			
	
	
	
	
	
	
				if(request.getParameter("BTD")!=null)
				 {
					BTD= (String)request.getParameter("BTD");
				     
				 }
				 else
				 {
					 BTD = "-";
				 }
				 if(request.getParameter("BTDdate")!=null && !(request.getParameter("BTDdate").equals("-"))){
					 try{
					 BTDdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("BTDdate")));
					 }catch(Exception e)
					 {
						 BTDdate= (String)request.getParameter("BTDdate");

					 }

					}
					else
					{
						BTDdate="-";
					}
					if(request.getParameter("BTDTrainerName")!=null)
					{
						BTDTrainerName= (String)request.getParameter("BTDTrainerName");
					}
					else
					{
						BTDTrainerName="-";
					}
					if(request.getParameter("BTDTrainingCompany")!=null)
					{
						BTDTrainingCompany= (String)request.getParameter("BTDTrainingCompany");
					}
					else
					{
						BTDTrainingCompany="-";
					}
					if(request.getParameter("BTDComments")!=null)
					{
						BTDComments= (String)request.getParameter("BTDComments");
					}
					else
					{
						BTDComments="-";
					}
				
				
		
					
					
					
					if(request.getParameter("ORA")!=null)
					 {
						ORA= (String)request.getParameter("ORA");
					     
					 }
					 else
					 {
						 ORA = "-";
					 }
					 if(request.getParameter("ORAdate")!=null && !(request.getParameter("ORAdate").equals("-")))
						{
						 try{
						 ORAdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("ORAdate")));
						 }catch(Exception e)
						 {
							 ORAdate= (String)request.getParameter("ORAdate");

						 }

						}
						else
						{
							ORAdate="-";
						}
						if(request.getParameter("ORATrainerName")!=null)
						{
							ORATrainerName= (String)request.getParameter("ORATrainerName");
						}
						else
						{
							ORATrainerName="-";
						}
						if(request.getParameter("ORATrainingCompany")!=null)
						{
							ORATrainingCompany= (String)request.getParameter("ORATrainingCompany");
						}
						else
						{
							ORATrainingCompany="-";
						}
						if(request.getParameter("ORAComments")!=null)
						{
							ORAComments= (String)request.getParameter("ORAComments");
						}
						else
						{
							ORAComments="-";
						}
						
						
						
						if(request.getParameter("ORAvehType")!=null)
						{
							ORAVehType= (String)request.getParameter("ORAvehType");
						}
						else
						{
							ORAVehType="-";
						}
						
						
						
						
						
						
						
					
						
	
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
	if(request.getParameter("DOB")!=null && !(request.getParameter("DOB").equals("-")))
	{
		try{
		DOBB=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("DOB").trim()));
		}catch(Exception e)
		{
			DOBB=request.getParameter("DOB").trim();
		}

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
	if(request.getParameter("licnExpiryDate")!=null && !(request.getParameter("licnExpiryDate").equals("-")))
	{
		try{
		licnExpiryDate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("licnExpiryDate")));
		}catch(Exception e)
		{
			licnExpiryDate1=request.getParameter("licnExpiryDate");
		}
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
	 if(request.getParameter("MedicalExamdate")!=null && !(request.getParameter("MedicalExamdate").equals("-")))
	 {
		 try{
		 MedicalExamdate1 =new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("MedicalExamdate")));
		 }catch(Exception e)
		 {
			 MedicalExamdate1=request.getParameter("MedicalExamdate");
		 }
	 }
	 else
	 {
		 MedicalExamdate1 = "-";
	 }
	 
	 if(request.getParameter("MediclExpDate")!=null && !(request.getParameter("MediclExpDate").equals("-")))
	 {
		try{
		 MediclExpDate1= new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("MediclExpDate")));
		}catch(Exception e)
		{
			MediclExpDate1=request.getParameter("MediclExpDate");
		}
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
	 if(request.getParameter("basicdate")!=null && !(request.getParameter("basicdate").equals("-")))
		{
		try{	
		 basicdate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("basicdate")));
		}catch(Exception e)
		{
			basicdate1= (String)request.getParameter("basicdate");
		}

	 
		// 
	      
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
	 if(request.getParameter("Module1date")!=null && !(request.getParameter("Module1date").equals("-")))
		{
		 try{
			Module1date1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("Module1date")));
		 }catch(Exception e)
		 {
			 Module1date1=request.getParameter("Module1date");
		 }
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
	 if(request.getParameter("Module2date")!=null && !(request.getParameter("Module2date").equals("-")))
	 {
		try{
		 Module2date1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("Module2date")));
		}catch(Exception e)
		{
			Module2date1=request.getParameter("Module2date");
		}
	      
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
	 if(request.getParameter("Module3date")!=null && !(request.getParameter("Module3date").equals("-")))
	 {
		 try{
		 Module3date1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("Module3date")));
		 }catch(Exception e)
		 {
			 Module3date1=request.getParameter("Module3date");		 }
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
	 if(request.getParameter("Module4date")!=null && !(request.getParameter("Module4date").equals("-")))
	 {
		 try{
		 Module4date1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("Module4date")));
		 }catch(Exception e)
		 {
			 Module4date1=request.getParameter("Module4date");
		 }
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
		 Module4TrainingCompany1 = "-";
	 }
	 if(request.getParameter("Module4Comments")!=null)
	 {
		 Module4Comments1= (String)request.getParameter("Module4Comments");
	      
	 }
	 else
	 {
		 Module4Comments1 = "-";
	 }
	 //======================================================================================================
		   
	 if(request.getParameter("Module5")!=null)
	 {
		 Module51= (String)request.getParameter("Module5");
	 }
	 else
	 {
		 Module51 = "-";
	 }
	 if(request.getParameter("Module5date")!=null && !(request.getParameter("Module5date").equals("-")))
	 {
		 try{
		 Module5date1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("Module5date")));
		 }catch(Exception e)
		 {
			 Module5date1=request.getParameter("Module5date");
		 }
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
	 //==============================================================================
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
	 if(request.getParameter("FTTrainingdate")!=null && !(request.getParameter("FTTrainingdate").equals("-")))
	 {
		 try{
		 FTTrainingdate1= new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("FTTrainingdate")));
		 }catch(Exception e)
		 {
			 FTTrainingdate1=request.getParameter("FTTrainingdate");
		 }
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
	 if(request.getParameter("LastTrainingDate")!=null && !(request.getParameter("LastTrainingDate").equals("-")))
	 {try{
		 LastTrainingDate1= new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("LastTrainingDate")));
	 }catch(Exception e)
	 {
		 LastTrainingDate1=request.getParameter("LastTrainingDate");
	 }
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
		// System.out.println(LicensePlace1);
	 }
	 else
	 {
		 LicensePlace1 = "-";
	 }
	 if(request.getParameter("LicenseType")!=null)
	 {
		 LicenseType1= (String)request.getParameter("LicenseType");
		 //System.out.println(LicenseType1);
	 }
	 else
	 {
		 LicenseType1 = "-";
	 }
	// System.out.println(vendor1);
	// System.out.println(Transporter1);
	int msg=0;
	Boolean insert=false;
	
try{		
		//	System.out.println("I am in try");
			Class.forName(MM_dbConn_DRIVER);
			conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
			st=conn.createStatement();
			st1=conn.createStatement();
			st2=conn.createStatement();
			st3=conn.createStatement();
			st4=conn.createStatement();
			stmtinsert=conn.createStatement();
			stmtinsert1=conn.createStatement();
			stmtinsert2=conn.createStatement();
			stmtinsert3=conn.createStatement();
			int maxid=0;
			
			java.util.Date dte = new java.util.Date();
			Format formatter = new SimpleDateFormat("yyyy-MM-dd");
			String today=formatter.format(dte);
			String sql21="update t_irtedriver set DriverName='"+drivername1+"', fatherName='"+driverfather1+"',LicenseNo='"+licenceno1+"',DOB='"+DOBB+"',Owner='"+Transporter1+"' where PassportID='"+driverid+"'"; 
           System.out.println("sql21 in update"+sql21);
      	  st1.executeUpdate(sql21);  
      	String abcd=sql21.replace("'","#");	
			abcd=abcd.replace(",","$");								
			stmtinsert.executeUpdate("Insert into t_sqlquery (dbname,query) values ('db_gps','"+abcd+"')");
		//	String OldTransporter="",licenceno1 = "", licnExpiryDate11  = "", MedicalExam1  = "", MediclExpDate11  = "", Place1  = "", Basic1  = "", Module11 = "", Module21  = "",Module31  = "",Module41  = "", remark1  = "", FTTraining1 = "" , LastTraining1 = "", LastTrainingDate11 = "", driverid1 = "";
			sql1="select * FROM t_drivertraining where Dcode = '"+driverid+"' ";
			System.out.println("sql1==>"+sql1);
			ResultSet rst1=st1.executeQuery(sql1);
			if(rst1.next())
			{
				
				//System.out.println("inside if looop==>==>");
				String OldLastTrainingDate="",OldModule2Comments="",OldModule1TrainingCompany="",OldModule1Comments="",OldBasicTrainerName="",OldModule1TrainerName="",OldBasicComments="",OldBasicTrainingCompany="",Oldbasicdate="",OldModule1date="",OldModule2date="",OldFTTrainingdate="";
				String Oldpassport="",OldModule4TrainerName="",OldModule4Comments="",OldModule4TrainingCompany="",OldExpiryDate="",OldModule3Comments="",OldModule2TrainerName="",OldModule3TrainingCompany="",OldModule3TrainerName="",OldModule3date="",OldModule2TrainingCompany="",OldModule4date="",OldMedicalExamdate="";
				String OldModule5TrainerName="",OldModule5Comments="",OldModule5TrainingCompany="",OldModule5date="";
				String OldExpiryDate1="",OldExpiryDate2="";
				
				String OldCapsule1date="",OldCapsule1TrainingCompany="",OldCapsule1Comments="",OldCapsule1TrainerName="";
				String OldCapsule2date="",OldCapsule2TrainingCompany="",OldCapsule2Comments="",OldCapsule2TrainerName="";
				String OldCapsule3date="",OldCapsule3TrainingCompany="",OldCapsule3Comments="",OldCapsule3TrainerName="";

				String OldBTDdate="",OldBTDTrainingCompany="",OldBTDComments="",OldBTDTrainerName="";
				String OldORAdate="",OldORATrainingCompany="",OldORAComments="",OldORATrainerName="",OldORAVehType="";

				
				String OldDecode=rst1.getString("dcode");
				String DriverName=rst1.getString("DriverName");
				String DriverFatherName =rst1.getString("DriverFatherName");
				String Education =rst1.getString("Education");
				String vendor =rst1.getString("vendor");
				String LicenseType =rst1.getString("LicenseType");
				String LicensePlace =rst1.getString("LicensePlace");
				String MedicalExamdate =rst1.getString("MedicalExamdate");
				String educationgrade =rst1.getString("educationgrade");
				String Typeofvehicle =rst1.getString("Typeofvehicle");
				String PostTestper =rst1.getString("PostTestper");
				String PostTest40MM =rst1.getString("PostTest40MM");
				String  PreTestper =rst1.getString("PreTestper");
				String PreTest40MM =rst1.getString("PreTest40MM");
				String FTTrainingdate =rst1.getString("FTTrainingdate");
				String ExpiryDate2=rst1.getString("ExpiryDate2");
				System.out.println("1111111=>");
				try
				{
				 DOB =rst1.getString("DOB").trim();
				}
				catch(Exception e)
				{
					DOB =rst1.getString("DOB");
				}
				
				//System.out.println("222=>");
				String OldTransporter=rst1.getString("Transporter");
				String Oldlicenceno=rst1.getString("licenceno");
				//System.out.println("harshal");
				try
				{
					if(rst1.getString("passport")!=null){
					Oldpassport=rst1.getString("passport").trim();
					}
				}catch(Exception e)
				{
					Oldpassport=rst1.getString("passport");
				}
				
				//System.out.println("333=>");
				
				try
				{
					if(rst1.getString("ExpiryDate")!=null){
					OldExpiryDate=rst1.getString("ExpiryDate").trim();
					}
				
				}catch(Exception e)
				{
					OldExpiryDate=rst1.getString("ExpiryDate");
				}
				//System.out.println("444=>");
				String OldPlace=rst1.getString("Place");
				try
				{
				
					if(rst1.getString("basicdate")!=null){
					Oldbasicdate=rst1.getString("basicdate").trim();
					}
				
				}catch(Exception e)
				{
					Oldbasicdate=rst1.getString("basicdate");
				}
				 
				
				
				//System.out.println("555=>");
				String OldBasic=rst1.getString("Basic");
				
				try
				{
			
					if(rst1.getString("BasicTrainerName")!=null){
					OldBasicTrainerName=rst1.getString("BasicTrainerName").trim();
					}
				
				}catch(Exception e)
				{
					OldBasicTrainerName=rst1.getString("BasicTrainerName");
				}
				
				//System.out.println("666=>");
				try
				{
					if(rst1.getString("BasicTrainingCompany")!=null){
					OldBasicTrainingCompany=rst1.getString("BasicTrainingCompany").trim();
					}
				
				}catch(Exception e)
				{
					OldBasicTrainingCompany=rst1.getString("BasicTrainingCompany");
				}
				//System.out.println("777=>");
				
				try
				{
				
					if(rst1.getString("BasicComments")!=null){
					OldBasicComments=rst1.getString("BasicComments").trim();
					}
				
				}catch(Exception e)
				{
					OldBasicComments=rst1.getString("BasicComments");
				}
				//System.out.println("hiiiiiiii");
				
					//System.out.println("888=>");
				String OldModule1=rst1.getString("Module1");
				try
				{
					if(rst1.getString("Module1date")!=null){
					OldModule1date=rst1.getString("Module1date").trim();
				
					}
				}catch(Exception e)
				{
					OldModule1date=rst1.getString("Module1date");
				}
				
				//System.out.println("999=>");
				
				try
				{
				
					if(rst1.getString("Module1TrainerName")!=null){
					OldModule1TrainerName=rst1.getString("Module1TrainerName").trim();
					}
				
				}catch(Exception e)
				{
					OldModule1TrainerName=rst1.getString("Module1TrainerName");
				}
				
				//System.out.println("10000=>");
				try
				{
				
					if(rst1.getString("Module1TrainingCompany")!=null){	
					OldModule1TrainingCompany=rst1.getString("Module1TrainingCompany").trim();
					}
				
				}catch(Exception e)
				{
					OldModule1TrainingCompany=rst1.getString("Module1TrainingCompany");
				}
				
				//System.out.println("12222=>");
				try
				{
				
					if(rst1.getString("Module1Comments")!=null){	
					OldModule1Comments=rst1.getString("Module1Comments").trim();
					}
				
				}catch(Exception e)
				{
					OldModule1Comments=rst1.getString("Module1Comments");
				}
				String OldModule2=rst1.getString("Module2");
				
				//System.out.println("13333=>");
				try
				{
				
					if(rst1.getString("Module2date")!=null){	
					OldModule2date=rst1.getString("Module2date").trim();
					}
				
				}catch(Exception e)
				{
					 OldModule2date=rst1.getString("Module2date");
				}
				
				//System.out.println("14444=>");
				try
				{
				
					if(rst1.getString("Module2TrainerName")!=null){	
					OldModule2TrainerName=rst1.getString("Module2TrainerName").trim();
				
					}
				}catch(Exception e)
				{
					OldModule2TrainerName=rst1.getString("Module2TrainerName");
				}
				
				//System.out.println("15555=>");
				try
				{
				
					if(rst1.getString("Module2TrainingCompany")!=null){	
					OldModule2TrainingCompany=rst1.getString("Module2TrainingCompany").trim();
				
					}
				
				}catch(Exception e)
				{
					OldModule2TrainingCompany=rst1.getString("Module2TrainingCompany");
				}
				
				//System.out.println("16666=>");
				try
				{
					if(rst1.getString("Module2Comments")!=null){	
					OldModule2Comments=rst1.getString("Module2Comments").trim();
					}
				
				}catch(Exception e)
				{
					OldModule2Comments=rst1.getString("Module2Comments");
				}
				
				//System.out.println("17777=>");
				String OldModule3=rst1.getString("Module3");
				try
				{
				
					if(rst1.getString("Module3date")!=null){	
					OldModule3date=rst1.getString("Module3date").trim();
					}
				
				}catch(Exception e)
				{
					 OldModule3date=rst1.getString("Module3date");
				}
				
				//System.out.println("188=>");
				try
				{
					if(rst1.getString("Module3TrainerName")!=null){
					OldModule3TrainerName=rst1.getString("Module3TrainerName").trim();
					}
				
				}catch(Exception e)
				{
					OldModule3TrainerName=rst1.getString("Module3TrainerName");
				}
				
				//System.out.println("1999>");
				try
				{
				
					if(rst1.getString("Module3TrainingCompany")!=null){
					OldModule3TrainingCompany=rst1.getString("Module3TrainingCompany").trim();
				
					}
				}catch(Exception e)
				{
					OldModule3TrainingCompany=rst1.getString("Module3TrainingCompany");
				}
				//System.out.println("2000>");
				try
				{
				
					if(rst1.getString("Module3Comments")!=null){
					OldModule3Comments=rst1.getString("Module3Comments").trim();
					}
				
				}catch(Exception e)
				{
					OldModule3Comments=rst1.getString("Module3Comments");
				}
				
				//System.out.println("21=>");
				
				String OldModule4=rst1.getString("Module4");
				try
				{
					if(rst1.getString("Module4date")!=null){
					OldModule4date=rst1.getString("Module4date").trim();
					}
				
				}catch(Exception e)
				{
					 OldModule4date=rst1.getString("Module4date");
				}
				
				//System.out.println("22222!!>");
				try
				{
					if(rst1.getString("Module4TrainerName")!=null){
					OldModule4TrainerName=rst1.getString("Module4TrainerName").trim();
					}
				
				}catch(Exception e)
				{
					OldModule4TrainerName=rst1.getString("Module4TrainerName");
				}
				
			//	System.out.println("233333=>");
				try
				{
					if(rst1.getString("Module4TrainingCompany")!=null){
					OldModule4TrainingCompany=rst1.getString("Module4TrainingCompany").trim();
					}
				
				}catch(Exception e)
				{
					OldModule4TrainingCompany=rst1.getString("Module4TrainingCompany");
				}
				//System.out.println("244444=>");
				try
				{
					if(rst1.getString("Module4Comments")!=null){
					OldModule4Comments=rst1.getString("Module4Comments").trim();
					}
				
				}catch(Exception e)
				{
					OldModule4Comments=rst1.getString("Module4Comments");
				}
				
			//System.out.println("hiiiiiiii11111");
				//======================================================================================================================
				
					System.out.println("255555=>");
					String OldModule5=rst1.getString("Module5");
				try
				{
					if(rst1.getString("Module5date")!=null){
					OldModule5date=rst1.getString("Module5date").trim();
					}
				
				}catch(Exception e)
				{
					 OldModule5date=rst1.getString("Module5date");
				}
				
				//System.out.println("26666=>");
				try
				{
					if(rst1.getString("Module5TrainerName")!=null){
					OldModule5TrainerName=rst1.getString("Module5TrainerName").trim();
					}
				
				}catch(Exception e)
				{
					OldModule5TrainerName=rst1.getString("Module5TrainerName");
				}
				
				//System.out.println("27777=>");
				try
				{
				
					if(rst1.getString("Module5TrainingCompany")!=null){
					OldModule5TrainingCompany=rst1.getString("Module5TrainingCompany").trim();
					}
				
				}catch(Exception e)
				{
					OldModule5TrainingCompany=rst1.getString("Module5TrainingCompany");
				}
				
				//System.out.println("288=>");
				try
				{
					if(rst1.getString("Module5Comments")!=null){

					OldModule5Comments=rst1.getString("Module5Comments").trim();
				
					}
				}catch(Exception e)
				{
					OldModule5Comments=rst1.getString("Module5Comments");
				}
				
				
				
		//============================================================================================================================		
				
				
				
				String OldCapsule1=rst1.getString("Capsule1");
				try
				{
					if(rst1.getString("Capsule1date")!=null){
					OldCapsule1date=rst1.getString("Capsule1date").trim();
					}
				
				}catch(Exception e)
				{
					OldCapsule1date=rst1.getString("Capsule1date");
				}
				
				//System.out.println("26666=>");
				try
				{
					if(rst1.getString("Capsule1TrainerName")!=null){
					OldCapsule1TrainerName=rst1.getString("Capsule1TrainerName").trim();
					}
				
				}catch(Exception e)
				{
					OldCapsule1TrainerName=rst1.getString("Capsule1TrainerName");
				}
				
				//System.out.println("27777=>");
				try
				{
				
					if(rst1.getString("Capsule1TrainingCompany")!=null){
					OldCapsule1TrainingCompany=rst1.getString("Capsule1TrainingCompany").trim();
					}
				
				}catch(Exception e)
				{
					OldCapsule1TrainingCompany=rst1.getString("Capsule1TrainingCompany");
				}
				
				//System.out.println("288=>");
				try
				{
					if(rst1.getString("Capsule1Comments")!=null){

					OldCapsule1Comments=rst1.getString("Capsule1Comments").trim();
				
					}
				}catch(Exception e)
				{
					OldCapsule1Comments=rst1.getString("Capsule1Comments");
				}
				
				
				
				
				
				
				
				
				
				
				
		//===================================================================================================================
			
			
			
			
			String OldCapsule2=rst1.getString("Capsule2");
				try
				{
					if(rst1.getString("Capsule2date")!=null){
					OldCapsule2date=rst1.getString("Capsule2date").trim();
					}
				
				}catch(Exception e)
				{
					OldCapsule2date=rst1.getString("Capsule2date");
				}
				
				//System.out.println("26666=>");
				try
				{
					if(rst1.getString("Capsule2TrainerName")!=null){
					OldCapsule2TrainerName=rst1.getString("Capsule2TrainerName").trim();
					}
				
				}catch(Exception e)
				{
					OldCapsule2TrainerName=rst1.getString("Capsule2TrainerName");
				}
				
				//System.out.println("27777=>");
				try
				{
				
					if(rst1.getString("Capsule2TrainingCompany")!=null){
					OldCapsule2TrainingCompany=rst1.getString("Capsule2TrainingCompany").trim();
					}
				
				}catch(Exception e)
				{
					OldCapsule2TrainingCompany=rst1.getString("Capsule2TrainingCompany");
				}
				
				//System.out.println("288=>");
				try
				{
					if(rst1.getString("Capsule2Comments")!=null){

					OldCapsule2Comments=rst1.getString("Capsule2Comments").trim();
				
					}
				}catch(Exception e)
				{
					OldCapsule2Comments=rst1.getString("Capsule2Comments");
				}
				
				
				
				
		
			
			
			
			
		//======================================================================================================================
			
			
			
			String OldCapsule3=rst1.getString("Capsule3");
				try
				{
					if(rst1.getString("Capsule3date")!=null){
						OldCapsule3date=rst1.getString("Capsule3date").trim();
					}
				
				}catch(Exception e)
				{
					OldCapsule3date=rst1.getString("Capsule3date");
				}
				
				//System.out.println("26666=>");
				try
				{
					if(rst1.getString("Capsule3TrainerName")!=null){
					OldCapsule3TrainerName=rst1.getString("Capsule3TrainerName").trim();
					}
				
				}catch(Exception e)
				{
					OldCapsule3TrainerName=rst1.getString("Capsule3TrainerName");
				}
				
				//System.out.println("27777=>");
				try
				{
				
					if(rst1.getString("Capsule3TrainingCompany")!=null){
					OldCapsule3TrainingCompany=rst1.getString("Capsule3TrainingCompany").trim();
					}
				
				}catch(Exception e)
				{
					OldCapsule3TrainingCompany=rst1.getString("Capsule3TrainingCompany");
				}
				
				//System.out.println("288=>");
				try
				{
					if(rst1.getString("Capsule3Comments")!=null){

					OldCapsule3Comments=rst1.getString("Capsule3Comments").trim();
				
					}
				}catch(Exception e)
				{
					OldCapsule3Comments=rst1.getString("Capsule3Comments");
				}
				
				
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			//======================================================================================================================
				
				
				
				
				String OldBTD=rst1.getString("BTD");
				try
				{
					if(rst1.getString("BTDdate")!=null){
					OldBTDdate=rst1.getString("BTDdate").trim();
					}
				
				}catch(Exception e)
				{
					OldBTDdate=rst1.getString("BTDdate");
				}
				
				//System.out.println("26666=>");
				try
				{
					if(rst1.getString("BTDTrainerName")!=null){
					OldBTDTrainerName=rst1.getString("BTDTrainerName").trim();
					}
				
				}catch(Exception e)
				{
					OldBTDTrainerName=rst1.getString("BTDTrainerName");
				}
				
				//System.out.println("27777=>");
				try
				{
				
					if(rst1.getString("BTDTrainingCompany")!=null){
					OldBTDTrainingCompany=rst1.getString("BTDTrainingCompany").trim();
					}
				
				}catch(Exception e)
				{
					OldBTDTrainingCompany=rst1.getString("BTDTrainingCompany");
				}
				
				//System.out.println("288=>");
				try
				{
					if(rst1.getString("BTDComments")!=null){

					OldBTDComments=rst1.getString("BTDComments").trim();
				
					}
				}catch(Exception e)
				{
					OldBTDComments=rst1.getString("BTDComments");
				}
				
				
				
		
				
				
				
				
				
				
				
				
				
				
				
	//================================================================================================================================
		
		
		String OldORA=rst1.getString("ORA");
				try
				{
					if(rst1.getString("ORAdate")!=null){
					OldORAdate=rst1.getString("ORAdate").trim();
					}
				
				}catch(Exception e)
				{
					OldORAdate=rst1.getString("ORAdate");
				}
				
				//System.out.println("26666=>");
				try
				{
					if(rst1.getString("ORATrainerName")!=null){
					OldORATrainerName=rst1.getString("ORATrainerName").trim();
					}
				
				}catch(Exception e)
				{
					OldORATrainerName=rst1.getString("ORATrainerName");
				}
				
				//System.out.println("27777=>");
				try
				{
				
					if(rst1.getString("ORATrainingCompany")!=null){
					OldORATrainingCompany=rst1.getString("ORATrainingCompany").trim();
					}
				
				}catch(Exception e)
				{
					OldORATrainingCompany=rst1.getString("ORATrainingCompany");
				}
				
				//System.out.println("288=>");
				try
				{
					if(rst1.getString("ORAComments")!=null){

					OldORAComments=rst1.getString("ORAComments").trim();
				
					}
				}catch(Exception e)
				{
					OldORAComments=rst1.getString("ORAComments");
				}
				
				
				try
				{
					if(rst1.getString("ORAVehType")!=null){

						OldORAVehType=rst1.getString("ORAVehType").trim();
				
					}
				}catch(Exception e)
				{
					OldORAVehType=rst1.getString("ORAVehType");
				}
				
				
				
		
						
	
		
		
		//=============================================================================================================================
				
				//System.out.println("299=>");
				//======================================================================================================================
				String Oldremark=rst1.getString("remark");
				try
				{
					if(rst1.getString("MedicalExamdate")!=null){
					OldMedicalExamdate=rst1.getString("MedicalExamdate").trim();
					}
				
				}catch(Exception e)
				{
					 OldMedicalExamdate=rst1.getString("MedicalExamdate");
				}
				//System.out.println("3000=>");
				
				String OldMedicalExam=rst1.getString("MedicalExam");
				try
				{
					if(rst1.getString("FTTrainingdate")!=null){
					OldFTTrainingdate=rst1.getString("FTTrainingdate").trim();
				
					}
				}catch(Exception e)
				{
					 OldFTTrainingdate=rst1.getString("FTTrainingdate");
				}
				
				//System.out.println("311=>");
				
				String OldFTTraining=rst1.getString("FTTraining");
				try
				{
					if(rst1.getString("ExpiryDate1")!=null){
					OldExpiryDate1=rst1.getString("ExpiryDate1").trim();
					}
				
				}catch(Exception e)
				{
					 OldExpiryDate1=rst1.getString("ExpiryDate1");
				}
				//System.out.println("32222%%%%%%%%%=>");
			System.out.println("hiiiiiiii22222222"+rst1.getString("ExpiryDate2"));
				 try
					{
					 
					 if(rst1.getString("ExpiryDate2")!=null)
					 {
					  OldExpiryDate2=rst1.getString("ExpiryDate2").trim();
					 }
					 }catch(Exception e)
					{
						 OldExpiryDate2=rst1.getString("ExpiryDate2").trim();
					}
				
					//System.out.println("33333=>");
					
				//System.out.println("hiiiiiiii333333333");
				
				try
				{
				
					if(rst1.getString("LastTrainingDate")!=null){
					OldLastTrainingDate=rst1.getString("LastTrainingDate").trim();
					}
				
				}
				catch(Exception e){
					OldLastTrainingDate=rst1.getString("LastTrainingDate");

				}
				//System.out.println("34444=>");
				String OldLastTraining=rst1.getString("LastTraining");
				//sql="update t_drivertraining set DriverName='"+drivername+"',Transporter='"+Transporter+"', licenceno='"+licenceno+"', ExpiryDate='"+licnExpiryDate+"' , Place ='"+Place+"' , Basic ='"+Basic+"', Module1 = '"+Module1+"' , Module2 = '"+Module2+"', Module3 = '"+Module3+"', Module4 = '"+Module4+"',remark = '"+remark+"', MedicalExam ='"+MedicalExam+"', FTTraining = '"+FTTraining+"', ExpiryDate2='"+MediclExpDate+"',LastTraining='"+LastTraining+"', LastTrainingDate ='"+LastTrainingDate+"', InsrtDt='"+today+"' where Dcode = '"+driverid+"' ";//TripClass_debrief  GPSPercent_debrief
				//System.out.println(DriverName);
				//System.out.println(driverfather1);
				//System.out.println(DOB);
				String stmtupdatetraining="update t_drivertraining set DriverName=?,DriverFatherName=?,DOB=?,Transporter=?,Education=?,vendor=?,PreTest40MM=?,PreTestper=?,PostTest40MM=?,PostTestper=?,Typeofvehicle=?,educationgrade=?, licenceno=?,ExpiryDate=?,LicenseType=?,LicensePlace=?,basicdate=?, Basic =?,BasicTrainerName=?,BasicTrainingCompany=?,BasicComments=?, Module1 =?,Module1date=?,Module1TrainerName=?,Module1TrainingCompany=?,Module1Comments=?, Module2 =?,Module2date=?,Module2TrainerName=?,Module2TrainingCompany=?,Module2Comments=?, Module3 =?,Module3date=?,Module3TrainerName=?,Module3TrainingCompany=?,Module3Comments=?, Module4 =?,Module4date=?,Module4TrainerName=?,Module4TrainingCompany=?,Module4Comments=?,Module5 =?,Module5date=?,Module5TrainerName=?,Module5TrainingCompany=?,Module5Comments=?,remark =?, MedicalExam =?,MedicalExamdate=?, FTTraining =?,FTTrainingdate=?, ExpiryDate2=?,LastTrainingDate =?,LastTraining=?,status=?,user=?, InsrtDt=?,Capsule1=?,Capsule1date=?,Capsule1TrainerName=?,Capsule1TrainingCompany=?,Capsule1Comments=?,Capsule2=?,Capsule2date=?,Capsule2TrainerName=?,Capsule2TrainingCompany=?,Capsule2Comments=?,Capsule3=?,Capsule3date=?,Capsule3TrainerName=?,Capsule3TrainingCompany=?,Capsule3Comments=?,BTD=?,BTDdate=?,BTDTrainerName=?,BTDTrainingCompany=?,BTDComments=?,ORA=?,ORAdate=?,ORATrainerName=?,ORATrainingCompany=?,ORAComments=?,ORAVehType=? where Dcode =? ";
					
				//System.out.println("updatetraining==>"+stmtupdatetraining);
				PreparedStatement updatetraining = conn.prepareStatement(stmtupdatetraining);
					//updatetraining.setInt(1, maxid);
					//System.out.println("updatetraining==>>>>>>>>"+stmtupdatetraining);
					//System.out.println("if started");
					//System.out.println(Transporter1);
					//updatetraining.setString(2, driverid);
					updatetraining.setString(1, drivername1);
					updatetraining.setString(2, driverfather1);
					updatetraining.setString(3, DOBB);
					updatetraining.setString(4, Transporter1);
					updatetraining.setString(5, Education1);
					updatetraining.setString(6, vendor1);
					updatetraining.setString(7, PreTest40MM1);
					updatetraining.setString(8, PreTestper1);
					updatetraining.setString(9, PostTest40MM1);
					updatetraining.setString(10, PostTestper1);
					updatetraining.setString(11, Typeofvehicle1);
					updatetraining.setString(12, Drivingschooleducationgrade1);
					updatetraining.setString(13, licenceno1);
					updatetraining.setString(14, licnExpiryDate1);
					updatetraining.setString(15, LicenseType1);
					updatetraining.setString(16, LicensePlace1);
					updatetraining.setString(17, basicdate1);
					updatetraining.setString(18, Basic1);
					updatetraining.setString(19, BasicTrainerName1);
					updatetraining.setString(20, BasicTrainingCompany1);
					updatetraining.setString(21, BasicComments1);
					updatetraining.setString(22, Module11);
					updatetraining.setString(23, Module1date1);
					updatetraining.setString(24, Module1TrainerName1);
					updatetraining.setString(25, Module1TrainingCompany1);
					updatetraining.setString(26, Module1Comments1);
					updatetraining.setString(27, Module21);
					updatetraining.setString(28, Module2date1);
					updatetraining.setString(29, Module2TrainerName1);
					updatetraining.setString(30, Module2TrainingCompany1);
					updatetraining.setString(31, Module2Comments1);
					updatetraining.setString(32, Module31);
					updatetraining.setString(33, Module3date1);
					updatetraining.setString(34, Module3TrainerName1);
					updatetraining.setString(35, Module3TrainingCompany1);
					updatetraining.setString(36, Module3Comments1);
					updatetraining.setString(37, Module41);
					updatetraining.setString(38, Module4date1);
					updatetraining.setString(39, Module4TrainerName1);
					updatetraining.setString(40, Module4TrainingCompany1);
					updatetraining.setString(41, Module4Comments1);
					updatetraining.setString(42, Module51);
					updatetraining.setString(43, Module5date1);
					updatetraining.setString(44, Module5TrainerName1);
					updatetraining.setString(45, Module5TrainingCompany1);
					updatetraining.setString(46, Module5Comments1);
					updatetraining.setString(47, remark1);
					updatetraining.setString(48, MedicalExam1);
					updatetraining.setString(49, MedicalExamdate1);
					updatetraining.setString(50, FTTraining1);
					updatetraining.setString(51, FTTrainingdate1);
					updatetraining.setString(52, MediclExpDate1);
					updatetraining.setString(53, LastTrainingDate1);
					updatetraining.setString(54, LastTraining1);
					updatetraining.setString(55, status);
					updatetraining.setObject(56, user);
					updatetraining.setString(57, today);
					
					
					updatetraining.setString(58, Capsule1);
					updatetraining.setString(59, Capsule1date);
					updatetraining.setString(60, Capsule1TrainerName);
					updatetraining.setString(61, Capsule1TrainingCompany);
					updatetraining.setString(62, Capsule1Comments);

					
					
					updatetraining.setString(63, Capsule2);
					updatetraining.setString(64, Capsule2date);
					updatetraining.setString(65, Capsule2TrainerName);
					updatetraining.setString(66, Capsule2TrainingCompany);
					updatetraining.setString(67, Capsule2Comments);


					updatetraining.setString(68, Capsule3);
					updatetraining.setString(69, Capsule3date);
					updatetraining.setString(70, Capsule3TrainerName);
					updatetraining.setString(71, Capsule3TrainingCompany);
					updatetraining.setString(72, Capsule3Comments);

					
					updatetraining.setString(73, BTD);
					updatetraining.setString(74, BTDdate);
					updatetraining.setString(75, BTDTrainerName);
					updatetraining.setString(76,BTDTrainingCompany);
					updatetraining.setString(77, BTDComments);

					
					
					updatetraining.setString(78, ORA);
					updatetraining.setString(79, ORAdate);
					updatetraining.setString(80, ORATrainerName);
					updatetraining.setString(81,ORATrainingCompany);
					updatetraining.setString(82, ORAComments);

					updatetraining.setString(83, ORAVehType);

					
					updatetraining.setString(84, driverid);
					
					
					
			
					
					
					
				msg=updatetraining.executeUpdate();
				String abcd1=stmtupdatetraining.replace("'","#");	
				abcd1=abcd1.replace(",","$");								
				stmtinsert1.executeUpdate("Insert into t_sqlquery (dbname,query) values ('db_gps','"+abcd1+"')");
				if(msg!=0)
				insert=true;

				//System.out.println("updatetraining"+updatetraining);
					
					//System.out.println("if completed");
					
			      //  st.executeUpdate(sql);
				
			//	sql2="insert into `t_drivertrainingHistory`(dcode,DriverName,DriverFatherName,DOB,OldTransporter,licenceno,Oldpassport,OldExpiryDate,OldPlace,Oldbasicdate,OldBasic,OldModule1date,OldModule1,OldModule2date,OldModule2,OldModule3date,OldModule3,OldModule4date,OldModule4,Oldremark,OldMedicalExamdate,OldMedicalExam,OldFTTrainingdate,OldFTTraining,OldExpiryDate1,OldExpiryDate2,OldLastTrainingDate,OldLastTraining,NewTransporter,Newlicenceno,NewExpiryDate,NewPlace,NewBasic,NewModule1,NewModule2,NewModule3,NewModule4,Newremark,NewMedicalExam,NewFTTraining,NewExpiryDate2,NewLastTrainingDate,NewLastTraining,Updated)values('"+OldDecode+"','"+DriverName+"','"+DriverFatherName+"','"+DOB+"','"+OldTransporter+"','"+Oldlicenceno+"','"+Oldpassport+"','"+OldExpiryDate+"','"+OldPlace+"','"+Oldbasicdate+"','"+OldBasic+"','"+OldModule1date+"','"+OldModule1+"','"+OldModule2date+"','"+OldModule2+"','"+OldModule3date+"','"+OldModule3+"','"+OldModule4date+"','"+OldModule4+"','"+Oldremark+"','"+OldMedicalExamdate+"','"+OldMedicalExam+"','"+OldFTTrainingdate+"','"+OldFTTraining+"','"+OldExpiryDate1+"','"+OldExpiryDate2+"','"+OldLastTrainingDate+"','"+OldLastTraining+"','"+Transporter+"','"+licenceno+"','"+licnExpiryDate+"','"+Place+"','"+Basic+"','"+Module1+"','"+Module2+"','"+Module3+"','"+Module4+"','"+remark+"','"+MedicalExam+"','"+FTTraining+"','"+MediclExpDate+"','"+LastTrainingDate+"','"+LastTraining+"','"+today+"')";
			String stmtdrivertrainingHistory="INSERT INTO t_drivertrainingHistory (dcode,DriverName,DriverFatherName,DOB,OldTransporter,Education,vendor,PreTest40MM,PreTestper,PostTest40MM,PostTestper,Typeofvehicle,educationgrade,licenceno,Oldpassport,OldExpiryDate,LicenseType,LicensePlace,Oldbasicdate,OldBasic,OldBasicTrainerName,OldBasicTrainingCompany,OldBasicComments,OldModule1date,OldModule1,OldModule1TrainerName,OldModule1TrainingCompany,OldModule1Comments,OldModule2date,OldModule2,OldModule2TrainerName,OldModule2TrainingCompany,OldModule2Comments,OldModule3date,OldModule3,OldModule3TrainerName,OldModule3TrainingCompany,OldModule3Comments,OldModule4date,OldModule4,OldModule4TrainerName,OldModule4TrainingCompany,OldModule4Comments,OldModule5date,OldModule5,OldModule5TrainerName,OldModule5TrainingCompany,OldModule5Comments,Oldremark,OldMedicalExamdate,OldMedicalExam,OldFTTrainingdate,OldFTTraining,OldExpiryDate1,OldExpiryDate2,OldLastTrainingDate,OldLastTraining,NewTransporter,Newlicenceno,Newbasicdate,NewBasic,NewBasicTrainerName,NewBasicTrainingCompany,NewBasicComments,NewModule1date, NewModule1,NewModule1TrainerName,NewModule1TrainingCompany,NewModule1Comments,NewModule2date,NewModule2,NewModule2TrainerName,NewModule2TrainingCompany,NewModule2Comments,NewModule3date,NewModule3,NewModule3TrainerName,NewModule3TrainingCompany,NewModule3Comments,NewModule4date, NewModule4,NewModule4TrainerName,NewModule4TrainingCompany,NewModule4Comments,NewModule5date, NewModule5,NewModule5TrainerName,NewModule5TrainingCompany,NewModule5Comments,Newremark,NewMedicalExamdate,NewMedicalExam,NewFTTrainingdate,NewFTTraining,NewExpiryDate2,NewLastTrainingDate,NewLastTraining,Updated,user,status,OldCapsule1,OldCapsule1date,OldCapsule1TrainerName,OldCapsule1TrainingCompany,OldCapsule1Comments,OldCapsule2,OldCapsule2date,OldCapsule2TrainerName,OldCapsule2TrainingCompany,OldCapsule2Comments,OldCapsule3,OldCapsule3date,OldCapsule3TrainerName,OldCapsule3TrainingCompany,OldCapsule3Comments,OldBTD,OldBTDdate,OldBTDTrainerName,OldBTDTrainingCompany,OldBTDComments,OldORA,OldORAdate,OldORATrainerName,OldORATrainingCompany,OldORAComments,NewCapsule1,NewCapsule1date,NewCapsule1TrainerName,NewCapsule1TrainingCompany,NewCapsule1Comments,NewCapsule2,NewCapsule2date,NewCapsule2TrainerName,NewCapsule2TrainingCompany,NewCapsule2Comments,NewCapsule3,NewCapsule3date,NewCapsule3TrainerName,NewCapsule3TrainingCompany,NewCapsule3Comments,NewBTD,NewBTDdate,NewBTDTrainerName,NewBTDTrainingCompany,NewBTDComments,NewORA,NewORAdate,NewORATrainerName,NewORATrainingCompany,NewORAComments,OldORAVehType,NewORAVehType)VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			PreparedStatement drivertrainingHistory = conn.prepareStatement(stmtdrivertrainingHistory);
			System.out.println("drivertrainingHistory Table Details==>"+stmtdrivertrainingHistory);
				drivertrainingHistory.setString(1, OldDecode);
				drivertrainingHistory.setString(2, DriverName);
				drivertrainingHistory.setString(3, DriverFatherName);
				drivertrainingHistory.setString(4, DOB);
				drivertrainingHistory.setString(5, OldTransporter);
				drivertrainingHistory.setString(6, Education);
				drivertrainingHistory.setString(7, vendor);
				drivertrainingHistory.setString(8, PreTest40MM);
				drivertrainingHistory.setString(9, PreTestper);
				drivertrainingHistory.setString(10, PostTest40MM);
				drivertrainingHistory.setString(11, PostTestper);
				drivertrainingHistory.setString(12, Typeofvehicle);
				drivertrainingHistory.setString(13, Drivingschooleducationgrade1);
				drivertrainingHistory.setString(14, Oldlicenceno);
				drivertrainingHistory.setString(15, Oldpassport);
				drivertrainingHistory.setString(16, OldExpiryDate);
				drivertrainingHistory.setString(17, LicenseType);
				drivertrainingHistory.setString(18, LicensePlace);
				drivertrainingHistory.setString(19, Oldbasicdate);
				drivertrainingHistory.setString(20, OldBasic);
				drivertrainingHistory.setString(21, OldBasicTrainerName);
				drivertrainingHistory.setString(22, OldBasicTrainingCompany);
				drivertrainingHistory.setString(23, OldBasicComments);
				drivertrainingHistory.setString(24, OldModule1date);
				drivertrainingHistory.setString(25, OldModule1);
				drivertrainingHistory.setString(26, OldModule1TrainerName);
				drivertrainingHistory.setString(27, OldModule1TrainingCompany);
				drivertrainingHistory.setString(28, OldModule1Comments);
				drivertrainingHistory.setString(29, OldModule2date);
				drivertrainingHistory.setString(30, OldModule2);
				drivertrainingHistory.setString(31, OldModule2TrainerName);
				drivertrainingHistory.setString(32, OldModule2TrainingCompany);
				drivertrainingHistory.setString(33, OldModule2Comments);
				drivertrainingHistory.setString(34, OldModule3date);
				drivertrainingHistory.setString(35, OldModule3);
				drivertrainingHistory.setString(36, OldModule3TrainerName);
				drivertrainingHistory.setString(37, OldModule3TrainingCompany);
				drivertrainingHistory.setString(38, OldModule3Comments);
				drivertrainingHistory.setString(39, OldModule4date);
				drivertrainingHistory.setString(40, OldModule4);
				drivertrainingHistory.setString(41, OldModule4TrainerName);
				drivertrainingHistory.setString(42, OldModule4TrainingCompany);
				drivertrainingHistory.setString(43, OldModule4Comments);
				drivertrainingHistory.setString(44, OldModule5date);
				drivertrainingHistory.setString(45, OldModule5);
				drivertrainingHistory.setString(46, OldModule5TrainerName);
				drivertrainingHistory.setString(47, OldModule5TrainingCompany);
				drivertrainingHistory.setString(48, OldModule5Comments);
				drivertrainingHistory.setString(49, Oldremark);
				drivertrainingHistory.setString(50, OldMedicalExamdate);
				drivertrainingHistory.setString(51, OldMedicalExam);
				drivertrainingHistory.setString(52, OldFTTrainingdate);
				drivertrainingHistory.setString(53, OldFTTraining);
				drivertrainingHistory.setString(54, OldExpiryDate1);
				drivertrainingHistory.setString(55, OldExpiryDate2);
				drivertrainingHistory.setString(56, OldLastTrainingDate);
				drivertrainingHistory.setString(57, OldLastTraining);
				drivertrainingHistory.setString(58, Transporter1);
				drivertrainingHistory.setString(59, licenceno1);
				drivertrainingHistory.setString(60, basicdate1);
				drivertrainingHistory.setString(61, Basic1);
				drivertrainingHistory.setString(62, BasicTrainerName1);
				drivertrainingHistory.setString(63, BasicTrainingCompany1);
				drivertrainingHistory.setString(64, BasicComments1);
				drivertrainingHistory.setString(65, Module1date1);
				drivertrainingHistory.setString(66, Module11);
				drivertrainingHistory.setString(67, Module1TrainerName1);
				drivertrainingHistory.setString(68, Module1TrainingCompany1);
				drivertrainingHistory.setString(69, Module1Comments1);
				drivertrainingHistory.setString(70, Module2date1);
				drivertrainingHistory.setString(71, Module21);
				drivertrainingHistory.setString(72, Module2TrainerName1);
				drivertrainingHistory.setString(73, Module2TrainingCompany1);
				drivertrainingHistory.setString(74, Module2Comments1);
				drivertrainingHistory.setString(75, Module3date1);
				drivertrainingHistory.setString(76, Module31);
				drivertrainingHistory.setString(77, Module3TrainerName1);
				drivertrainingHistory.setString(78, Module3TrainingCompany1);
				drivertrainingHistory.setString(79, Module3Comments1);
				drivertrainingHistory.setString(80, Module4date1);
				drivertrainingHistory.setString(81, Module41);
				drivertrainingHistory.setString(82, Module4TrainerName1);
				drivertrainingHistory.setString(83, Module4TrainingCompany1);
				drivertrainingHistory.setString(84, Module4Comments1);
				drivertrainingHistory.setString(85, Module5date1);
				drivertrainingHistory.setString(86, Module51);
				drivertrainingHistory.setString(87, Module5TrainerName1);
				drivertrainingHistory.setString(88, Module5TrainingCompany1);
				drivertrainingHistory.setString(89, Module5Comments1);
				drivertrainingHistory.setString(90, remark1);
				drivertrainingHistory.setString(91, MedicalExamdate1);
				drivertrainingHistory.setString(92, MedicalExam1);
				drivertrainingHistory.setString(93, FTTrainingdate1);
				drivertrainingHistory.setString(94, FTTraining1);
				drivertrainingHistory.setString(95, ExpiryDate2);
				drivertrainingHistory.setString(96, LastTrainingDate1);
				drivertrainingHistory.setString(97, LastTraining1);
				drivertrainingHistory.setString(98, today);
				
				/////change the index from 100 to 99 & 100
				drivertrainingHistory.setObject(99, user);
			
				drivertrainingHistory.setString(100, status);
				
				drivertrainingHistory.setString(101, OldCapsule1);
				drivertrainingHistory.setString(102, OldCapsule1date);
				drivertrainingHistory.setString(103, OldCapsule1TrainerName);
				drivertrainingHistory.setString(104, OldCapsule1TrainingCompany);
				drivertrainingHistory.setString(105, OldCapsule1Comments);

				
				drivertrainingHistory.setString(106, OldCapsule2);
				drivertrainingHistory.setString(107, OldCapsule2date);
				drivertrainingHistory.setString(108, OldCapsule2TrainerName);
				drivertrainingHistory.setString(109, OldCapsule2TrainingCompany);
				drivertrainingHistory.setString(110, OldCapsule2Comments);

				
				drivertrainingHistory.setString(111, OldCapsule3);
				drivertrainingHistory.setString(112, OldCapsule3date);
				drivertrainingHistory.setString(113, OldCapsule3TrainerName);
				drivertrainingHistory.setString(114, OldCapsule3TrainingCompany);
				drivertrainingHistory.setString(115, OldCapsule3Comments);

				
				
				

				drivertrainingHistory.setString(116, OldBTD);
				drivertrainingHistory.setString(117, OldBTDdate);
				drivertrainingHistory.setString(118, OldBTDTrainerName);
				drivertrainingHistory.setString(119, OldBTDTrainingCompany);
				drivertrainingHistory.setString(120, OldBTDComments);

				drivertrainingHistory.setString(121, OldORA);
				drivertrainingHistory.setString(122, OldORAdate);
				drivertrainingHistory.setString(123, OldORATrainerName);
				drivertrainingHistory.setString(124, OldORATrainingCompany);
				drivertrainingHistory.setString(125, OldORAComments);

				
				
				drivertrainingHistory.setString(126, Capsule1);
				drivertrainingHistory.setString(127, Capsule1date);
				drivertrainingHistory.setString(128, Capsule1TrainerName);
				drivertrainingHistory.setString(129, Capsule1TrainingCompany);
				drivertrainingHistory.setString(130, Capsule1Comments);

				
				drivertrainingHistory.setString(131, Capsule2);
				drivertrainingHistory.setString(132, Capsule2date);
				drivertrainingHistory.setString(133, Capsule2TrainerName);
				drivertrainingHistory.setString(134, Capsule2TrainingCompany);
				drivertrainingHistory.setString(135, Capsule2Comments);

				
				drivertrainingHistory.setString(136, Capsule3);
				drivertrainingHistory.setString(137, Capsule3date);
				drivertrainingHistory.setString(138, Capsule3TrainerName);
				drivertrainingHistory.setString(139, Capsule3TrainingCompany);
				drivertrainingHistory.setString(140, Capsule3Comments);

				
				
				

				drivertrainingHistory.setString(141, BTD);
				drivertrainingHistory.setString(142, BTDdate);
				drivertrainingHistory.setString(143, BTDTrainerName);
				drivertrainingHistory.setString(144, BTDTrainingCompany);
				drivertrainingHistory.setString(145, BTDComments);

				drivertrainingHistory.setString(146, ORA);
				drivertrainingHistory.setString(147, ORAdate);
				drivertrainingHistory.setString(148, ORATrainerName);
				drivertrainingHistory.setString(149, ORATrainingCompany);
				drivertrainingHistory.setString(150, ORAComments);

				
				drivertrainingHistory.setString(149, OldORAVehType);
				drivertrainingHistory.setString(150, ORAVehType);

				
				
				
				
				
				
			drivertrainingHistory.executeUpdate();
			String abcd2=stmtdrivertrainingHistory.replace("'","#");	
			abcd2=abcd2.replace(",","$");								
			stmtinsert2.executeUpdate("Insert into t_sqlquery (dbname,query) values ('db_gps','"+abcd2+"')");
			// System.out.println("executr"+sql2);
			//	st2.executeUpdate(sql2);
				//out.print(sql2);
			
			//System.out.println("eld of loop====>==>");
			}
			
			else
			{
				//System.out.println("inside else looop==>==>");
				sql4="select max( Sr ) AS srnum from t_drivertraining";
				ResultSet rst4=st4.executeQuery(sql4);
				if(rst4.next())
				{
					maxid=rst4.getInt("srnum");
				}
				maxid=maxid+1;
			//	sql3="INSERT INTO t_drivertraining(Sr ,dcode ,DriverName ,DriverFatherName ,DOB ,Transporter ,licenceno ,ExpiryDate ,Place ,Basic ,Module1 ,Module2 ,Module3 ,Module4 ,remark ,MedicalExam ,FTTraining ,ExpiryDate2 ,LastTrainingDate, LastTraining,InsrtDt) VALUES ('"+maxid+"','"+driverid+"','"+drivername+"','"+driverfather+"','"+DOBB+"','"+Transporter+"','"+licenceno+"','"+licnExpiryDate+"','"+Place+"','"+Basic+"','"+Module1+"','"+Module2+"','"+Module3+"','"+Module4+"','"+remark+"','"+MedicalExam+"','"+FTTraining+"','"+MediclExpDate+"','"+LastTrainingDate+"','"+LastTraining+"','"+today+"')"
			//	,dcode ,DriverName ,DriverFatherName ,DOB ,Transporter ,licenceno ,ExpiryDate ,Place ,Basic ,Module1 ,Module2 ,Module3 ,Module4 ,remark ,MedicalExam ,FTTraining ,ExpiryDate2 ,LastTrainingDate, LastTraining,InsrtDt	
			//	'"+driverid+"','"+drivername+"','"+driverfather+"','"+DOBB+"','"+Transporter+"','"+licenceno+"','"+licnExpiryDate+"'
			//	,'"+Place+"','"+Basic+"','"+Module1+"','"+Module2+"','"+Module3+"','"+Module4+"','"+remark+"','"+MedicalExam+"','"+FTTraining+"','"+MediclExpDate+"','"+LastTrainingDate+"','"+LastTraining+"','"+today+"'
			String stmtinserttraining="INSERT INTO t_drivertraining(Sr,DriverName,DriverFatherName,DOB,Transporter,Education,vendor,PreTest40MM,PreTestper,PostTest40MM,PostTestper,Typeofvehicle,educationgrade, licenceno, ExpiryDate,LicenseType,LicensePlace,basicdate, Basic,BasicTrainerName,BasicTrainingCompany,BasicComments, Module1,Module1date,Module1TrainerName,Module1TrainingCompany,Module1Comments, Module2,Module2date,Module2TrainerName,Module2TrainingCompany,Module2Comments, Module3,Module3date,Module3TrainerName,Module3TrainingCompany,Module3Comments,Module4,Module4date,Module4TrainerName,Module4TrainingCompany,Module4Comments,Module5,Module5date,Module5TrainerName,Module5TrainingCompany,Module5Comments,remark, MedicalExam,MedicalExamdate, FTTraining,FTTrainingdate,ExpiryDate2, LastTrainingDate,LastTraining,status,user, InsrtDt,Dcode,Capsule1,Capsule1date,Capsule1TrainerName,Capsule1TrainingCompany,Capsule1Comments,Capsule2,Capsule2date,Capsule2TrainerName,Capsule2TrainingCompany,Capsule2Comments,Capsule3,Capsule3date,Capsule3TrainerName,Capsule3TrainingCompany,Capsule3Comments,BTD,BTDdate,BTDTrainerName,BTDTrainingCompany,BTDComments,ORA,ORAdate,ORATrainerName,ORATrainingCompany,ORAComments,ORAVehType) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			PreparedStatement inserttraining = conn.prepareStatement(stmtinserttraining);
				//	System.out.println("inserttraining"+inserttraining);
				System.out.println("stmtinserttraining==>"+stmtinserttraining);
					inserttraining.setInt(1, maxid);
					inserttraining.setString(2, drivername1);
					inserttraining.setString(3, driverfather1);
					inserttraining.setString(4, DOBB);
					inserttraining.setString(5, Transporter1);
					inserttraining.setString(6, Education1);
					inserttraining.setString(7, vendor1);
					inserttraining.setString(8, PreTest40MM1);
					inserttraining.setString(9, PreTestper1);
					inserttraining.setString(10, PostTest40MM1);
					inserttraining.setString(11, PostTestper1);
					inserttraining.setString(12, Typeofvehicle1);
					inserttraining.setString(13, Drivingschooleducationgrade1);
					inserttraining.setString(14, licenceno1);
					inserttraining.setString(15, licnExpiryDate1);
					inserttraining.setString(16, LicenseType1);
					inserttraining.setString(17, LicensePlace1);
					inserttraining.setString(18, basicdate1);
					inserttraining.setString(19, Basic1);
					inserttraining.setString(20, BasicTrainerName1);
					inserttraining.setString(21, BasicTrainingCompany1);
					inserttraining.setString(22, BasicComments1);
					inserttraining.setString(23, Module11);
					inserttraining.setString(24, Module1date1);
					inserttraining.setString(25, Module1TrainerName1);
					inserttraining.setString(26, Module1TrainingCompany1);
					inserttraining.setString(27, Module1Comments1);
					inserttraining.setString(28, Module21);
					inserttraining.setString(29, Module2date1);
					inserttraining.setString(30, Module2TrainerName1);
					inserttraining.setString(31, Module2TrainingCompany1);
					inserttraining.setString(32, Module2Comments1);
					inserttraining.setString(33, Module31);
					inserttraining.setString(34, Module3date1);
					inserttraining.setString(35, Module3TrainerName1);
					inserttraining.setString(36, Module3TrainingCompany1);
					inserttraining.setString(37, Module3Comments1);
					inserttraining.setString(38, Module41);
					inserttraining.setString(39, Module4date1);
					inserttraining.setString(40, Module4TrainerName1);
					inserttraining.setString(41, Module4TrainingCompany1);
					inserttraining.setString(42, Module4Comments1);
					inserttraining.setString(43, Module51);
					inserttraining.setString(44, Module5date1);
					inserttraining.setString(45, Module5TrainerName1);
					inserttraining.setString(46, Module5TrainingCompany1);
					inserttraining.setString(47, Module5Comments1);
					inserttraining.setString(48, remark1);
					inserttraining.setString(49, MedicalExam1);
					inserttraining.setString(50, MedicalExamdate1);
					inserttraining.setString(51, FTTraining1);
					inserttraining.setString(52, FTTrainingdate1);
					inserttraining.setString(53, MediclExpDate1);
					inserttraining.setString(54, LastTrainingDate1);
					inserttraining.setString(55, LastTraining1);
					inserttraining.setString(56, status);
					inserttraining.setObject(57, user);
					inserttraining.setString(58, today);
					
					
					
					inserttraining.setString(59, driverid);
					
					
					
					inserttraining.setString(60, Capsule1);
					inserttraining.setString(61, Capsule1date);
					inserttraining.setString(62, Capsule1TrainerName);
					inserttraining.setString(63, Capsule1TrainingCompany);
					inserttraining.setString(64, Capsule1Comments);

					
					inserttraining.setString(65, Capsule2);
					inserttraining.setString(66, Capsule2date);
					inserttraining.setString(67, Capsule2TrainerName);
					inserttraining.setString(68, Capsule2TrainingCompany);
					inserttraining.setString(69, Capsule2Comments);

					
					inserttraining.setString(70, Capsule3);
					inserttraining.setString(71, Capsule3date);
					inserttraining.setString(72, Capsule3TrainerName);
					inserttraining.setString(73, Capsule3TrainingCompany);
					inserttraining.setString(74, Capsule3Comments);

					
					
					

					inserttraining.setString(75, BTD);
					inserttraining.setString(76, BTDdate);
					inserttraining.setString(77, BTDTrainerName);
					inserttraining.setString(78, BTDTrainingCompany);
					inserttraining.setString(79, BTDComments);

					inserttraining.setString(80, ORA);
					inserttraining.setString(81, ORAdate);
					inserttraining.setString(82, ORATrainerName);
					inserttraining.setString(83, ORATrainingCompany);
					inserttraining.setString(84, ORAComments);

					inserttraining.setString(85, ORAVehType);

					
				
					
					
					
					
				msg=inserttraining.executeUpdate();
				String abcd3=stmtinserttraining.replace("'","#");	
				abcd3=abcd3.replace(",","$");								
				stmtinsert3.executeUpdate("Insert into t_sqlquery (dbname,query) values ('db_gps','"+abcd3+"')");
				if(msg!=0)
				insert=true;

			}
			
		
                            System.out.println("Data saved successfully.");

}catch(Exception e)
{
	System.out.print("Exception--->"+e);
    //    out.print("Data Not Saved Please Fill The form Properly.");
}
finally
{
conn.close();

}
response.sendRedirect("trininginfo1.jsp?insert="+insert+"&driverid="+driverid+"&passportid="+driverid+"&driverFatherName="+driverfather1+"&DOB="+DOB+"&LicenseNo="+licenceno1+"&driverName="+drivername1+"&transporter="+Transporter1);
%>

</form>
<!-- <table border="0" width="100%" align="center" style="padding-bottom: 16px;height:20px " > -->
<div class="footer" style="width: 100%;float:left;margin-top:40px;background-color:#0B2161;">


<font color: white;"><center>Copyright &copy; 2008 by Transworld Compressor Technologies Ltd. All Rights Reserved.</center></font>


</div>

<!-- <tr><td  bgcolor="#0B2161" > -->
<!-- <ui><li><center><font color="white" >Copyright &copy; 2008 by Transworld Compressor Technologies Ltd. All Rights Reserved.</font></center></li></ui> -->
<!-- </td></tr> -->
</body>
