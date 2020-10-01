<%@ include file="Connections/conn.jsp" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
   <%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
   <%@ page import="org.apache.commons.fileupload.*"%>
   <%@ page import="java.util.List" %>
   <%@page import="java.util.Date" %>
   <%@ page import="java.util.Iterator" %>
   <%@ page import="java.io.File" %>
   <%@ page import="java.io.*" %>
   <%@ page import = "java.io.FileNotFoundException"%>
  	<%@ page import = "java.io.FileOutputStream"%>
  	<%@ page import = " java.io.IOException"%>
  	<%@ page import="javax.activation.*" %>
<%@ page buffer="16kb" %>
<%!
Connection conn;
Statement st,st1,st2;
String sql,sql1,username="",mainuser="";
%>
<%! String drivername1="";String fathername1=""; String permanentadd1="";  String currentaddr1=""; String mobno1=""; String licno="";%>
<%-- <%
drivername1=request.getParameter("drivername");
Cookie c=new Cookie("dname1",drivername1);
response.addCookie(c);
fathername1=request.getParameter("fathername");
Cookie c1=new Cookie("fname1",fathername1);
response.addCookie(c1);
permanentadd1=request.getParameter("address1");
Cookie c2=new Cookie("padd1",permanentadd1);
response.addCookie(c2);
currentaddr1=request.getParameter("address2");
Cookie c3=new Cookie("cadd2",currentaddr1);
response.addCookie(c3);
mobno1=request.getParameter("mobno");
Cookie c4=new Cookie("mobno12",mobno1);
response.addCookie(c4);
licno=request.getParameter("licensceno");
Cookie c5=new Cookie("licno12",licno);
response.addCookie(c5);

%> --%>



<%
System.out.println("in insert new Driver page.....");

	username=(String)session.getAttribute("usertypevalue");
	mainuser=(String)session.getAttribute("mainuser");
  
	String InsertDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
    
	//System.out.println("InsertDateTime.."+InsertDateTime);
      String flag="true";
	try
	{
		
		 Class.forName(MM_dbConn_DRIVER); 
		conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD); 
		st=conn.createStatement();
		st1=conn.createStatement();
		st2=conn.createStatement();
		Statement stquery=conn.createStatement();
		String GPName="",drivename="",driverid="",transporter="",fathername="",address1="",address2="",gender="",maridstatus="",dob="",induction="",mobno="",licno="",licenseexpdate="",licexp="",trans=""; 
		int saveflag=0,filecount = 0,count1 = 0;
		String fname="",fname1="",fname2="";
		String savefilestring="",itemName="";
		File savedFile;
		String[] filepath =new String[3];
		String[] filename =new String[3];
	  	int age=0,finalage=0;

		

	
	
	
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		
		if (!isMultipart)
		{
			System.out.println("\n\nin multipart..");
		} 
		else
		{
			System.out.println("\n\n in else with  multipart how are you..");
			FileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			List items = null;
			try 
			{
				items = upload.parseRequest(request);
			}
			catch (FileUploadException e)
			{
				e.printStackTrace();
			}
		
			Iterator itr = items.iterator();

			while (itr.hasNext()) 
			{
				FileItem item = (FileItem) itr.next();
				if(item.isFormField()) 
				{
					String name = item.getFieldName();
					//System.out.print("\n name==>"+name);
					String value = item.getString();
					
								
					if(name.equals("GPName")) 
					{
						GPName = value;
						System.out.println("\n GPName==>"+GPName);
						count1 = 1;
					}
				

					if(name.equals("drivername")) 
					{
						drivename = value;
						
						System.out.print("\n drivername==>"+drivename);
						count1 = 1;
					}
				
					if(name.equals("driverid")) 
					{
						driverid = value;
					

						System.out.print("\n driverid==>"+driverid);
						count1 = 1;
					}
				

					if(name.equals("fathername")) 
					{
						fathername = value;

						System.out.print("\n fathername==>"+fathername);
						count1 = 1;
					}
				
				
	
					if(name.equals("address1")) 
					{
						address1 = value;
						System.out.print("\n address1==>"+address1);
						count1 = 1;
					}
				
				
					if(name.equals("transporter")) 
					{
						transporter = value;
						System.out.print("\n transporter==>"+transporter);
						count1 = 1;
					}

					if(name.equals("address2")) 
					{
						address2 = value;
						System.out.print("\n address2==>"+address2);
						count1 = 1;
					}
	
					if(name.equals("gender")) 
					{
						gender = value;
					System.out.print("\n gender==>"+gender);
					count1 = 1;
				}
					

				if(name.equals("maridstatus")) 
				{
					maridstatus = value;
					System.out.print("\n maridstatus==>"+maridstatus);
					count1 = 1;
				}
				
				
	
				if(name.equals("dob")) 
				{
					dob = value;
					System.out.print("\n dob==>"+dob);
					count1 = 1;
				}
				

				if(name.equals("mobno")) 
				{
					mobno = value;
					System.out.print("\n mobno==>"+mobno);
					count1 = 1;
				}
				
				if(name.equals("induction"))
				{
					induction = value;
					System.out.print("\n induction==>"+induction);

					count1 =1;
				}
				if(name.equals("licenseexpiry"))
					
				{   
					licenseexpdate = value;
					String s=licenseexpdate;
					String dd=s.substring(0, 2);
					String mm=s.substring(3,6);
					String mm1;
					String yy=s.substring(7,11);
					if(mm=="Jan")
					{
						mm1="01";
					}
					 if(mm=="Feb")
					{//alert("in feb");
					mm1="02";
					} if(mm=="Mar")
					{
						mm1="03";
					}
					 if(mm=="Apr")
					{
						mm1="04";
					}

					 if(mm=="May")
					{
						mm1="05";
					}
					 if(mm=="Jun")
					{
						mm1="06";
					}
					 if(mm=="Jul")
					{
						mm1="07";
					}
					 if(mm=="Aug")
					{
						mm1="08";
					}
					 if(mm=="Sep")
					{
						mm1="09";
					}
					if(mm=="Oct")
					{
						mm1="10";
					} if(mm=="Nov")
					{
						mm1="11";
					}
					else
					{
						mm1="12";
					}
					 licexp=yy+"-"+mm1+"-"+dd;
					System.out.println("licenseeexpiry====>"+licenseexpdate);
					System.out.println("changed licexpdate===>"+licexp);
				  
				   
				   

					
					
					 
					//System.out.print("\n licenseexp==>"+convertedDate);

					count1 =1;
				}
				
				if(name.equals("licensceno"))
				{
					licno = value;
					System.out.print("\n licenseno==>"+licno);

					count1 =1;
				}
				
				
				if(name.equals("f6"))
				{
					fname = value;
					System.out.print("\n fname==>"+fname);

					count1 =1;
				}
				if(name.equals("f7"))
				{
					fname1 = value;
					System.out.print("\n fname1==>"+fname1);

					count1 =1;
				}
				if(name.equals("f8"))
				{
					fname2 = value;
					System.out.print("\n fname2==>"+fname2);

					count1 =1;
				}

				
				
				
				
				
		}
		
		else 
		{	
				
			try 
			{

					itemName = item.getName();
					System.out.print("\n\nitemName22<<<<<<<<==>"+itemName);
					if(itemName.equalsIgnoreCase(""))
					{
					}
					else
					{
						try
						{
					
							System.out.println("HHHHHH  ");
							//savedFile = new File("/home/s_dhole/test/"+InsertDateTime+"_"+itemName);

							savedFile = new File("/usr/share/tomcat6/webapps/images1/savedimages/"+InsertDateTime+"_"+itemName);
							 
							System.out.print("\n\nsavedFile==>"+savedFile);
							item.write(savedFile);
							filepath[filecount]=""+savedFile;
								
							filename[filecount]=itemName;
							filecount++;
							if(saveflag==1)
							{
								 savefilestring=""+savedFile;
								 saveflag++;
							}
							else
								savefilestring=savefilestring+","+savedFile;
								 //out.print("successfully saved the file");
								//File file = new File(savedFile);
								String screenshot=savedFile.getAbsolutePath();
							System.out.println("\n\nscreenshot--->>>"+screenshot);
								
						
					}
					catch(Exception e)
					{
						e.printStackTrace();
					}
				}
						
					}
							
				 catch (Exception e) {
	  					e.printStackTrace();
	  				}
					}
			
		}
			
			
			
	}	
	if(fname=="" || fname.equals(""))
	{
		fname=fname;

	}
	else{
		fname= InsertDateTime+"_"+fname;

	}
	if(fname1=="" || fname1.equals(""))
	{
		fname1=fname1;

	}
	else{
		fname1= InsertDateTime+"_"+fname1;

	}
	if(fname2=="" || fname2.equals(""))
	{
		fname2=fname2;

	}
	else{
		fname2= InsertDateTime+"_"+fname2;

	}
	
	try
	{
		//String username=(String)session.getAttribute("usertypevalue");
  String sqlck="select * from db_gps.t_drivers where Owner='"+username+"' and DriverID='"+driverid+"'";
  String sqlck1="select * from db_gps.t_drivers where licenseno ='"+licno+"' and ACTIVESTATUS='Active'";

	System.out.println("***    "+sqlck);
	ResultSet rsck = st.executeQuery(sqlck);
	if(rsck.next())
	{
		out.println("<script>");
        out.println("alert('Details not saved because Driver Id already exits...!');");
        out.println("location='driverentrynew.jsp';");
        out.println("</script>");	
	} 
	
	
	
 /* 
	  ResultSet rsck1 = st2.executeQuery(sqlck1);
	
	 
		 
		 if(rsck1.next())
	{
		//drivername1=rsck1.getString("DriverName");
		//owner=rsck1.getString("Owner");
		
		out.println("<script>");
        //out.println("alert('Details not saved because Licence number already exits with driver'"+drivername1+" and owner "+owner+");");
        out.println("alert('Details not saved because License number already exits....!');");
        out.println("location='driverentrynew.jsp';");
        out.println("</script>");
		//response.sendRedirect("alertGoTo.jsp?msg=Details not saved because Licence number already exits...!&goto=driverentrynew.jsp");
		
	}  */
	 
 
	else{ System.out.println(licexp);
	    
		
	ResultSet rsck1 = st2.executeQuery(sqlck1);
	
	 
	 
	 if(rsck1.next())
{
	//drivername1=rsck1.getString("DriverName");
	//owner=rsck1.getString("Owner");
	
	out.println("<script>");
   //out.println("alert('Details not saved because Licence number already exits with driver'"+drivername1+" and owner "+owner+");");
   out.println("alert('Details not saved because License number already exits....!');");
   out.println("location='driverentrynew.jsp';");
   out.println("</script>");
	//response.sendRedirect("alertGoTo.jsp?msg=Details not saved because Licence number already exits...!&goto=driverentrynew.jsp");
	
} 
	
	
	
	
	 else{
	
	
		sql="insert into db_gps.t_drivers(DriverID,DriverName,FatherNm,Address1,Address2,Gender,Marital,DOB,MobileNo,Owner,GPNAME,ACTIVESTATUS,EntryBy,DOBFile,AddressFile,DateOfInduction,licenseexpdate,licenseno,licensefile)values('"+driverid.replaceAll("'"," ")+"','"+drivename.replaceAll("'"," ")+"' ,'"+fathername.replaceAll("'"," ")+"','"+address1.replaceAll("'"," ")+"','"+address2.replaceAll("'"," ")+"','"+gender+"','"+maridstatus+"','"+dob+"','"+mobno.replaceAll("'"," ")+"','"+transporter+"','"+GPName+"','Active','"+mainuser+"','"+fname+"','"+fname1+"','"+induction+"','"+licexp+"','"+licno.replace("'"," ")+"','"+fname2+"') ";
    	System.out.println("insert to Driver " +sql);

	   System.out.println(licexp);
		st1.executeUpdate(sql);
	
    	System.out.println("insert"+sql);

		sql1="insert into db_gps.t_driverhistory(DriverID,DriverName,FatherNm,Address1,Address2,Gender,Marital,DOB,MobileNo,Owner,GPNAME,ACTIVESTATUS,EntryBy,Action,DOBFile,AddressFile,DateOfInduction)values('"+driverid.replaceAll("'"," ")+"','"+drivename.replaceAll("'"," ")+"' ,	'"+fathername.replaceAll("'"," ")+"','"+address1.replaceAll("'"," ")+"','"+address2.replaceAll("'"," ")+"','"+gender+"','"+maridstatus+"','"+dob+"','"+mobno.replaceAll("'"," ")+"','"+transporter+"','"+GPName+"','Active','"+mainuser+"','Added','"+fname+"','"+fname1+"','"+induction+"')";
    	System.out.println("insert2"+sql1);

	
		st1.executeUpdate(sql1);
    	System.out.println("insert2"+sql1);
    
    	
    	
    	
    	
		 response.sendRedirect("Reportfordriver.jsp?save1=true");
	 }
 	
	}
  }
   catch(Exception e)
   {
	  e.printStackTrace();
   }

}
   catch(Exception e)
  {
		e.printStackTrace();
  }
  finally
  {
		try
		{
			System.out.println("success");
		 conn.close();
		}
		catch(Exception e){}
  }
	
	%>