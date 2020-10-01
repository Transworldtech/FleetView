<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
   <%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
   <%@ page import="org.apache.commons.fileupload.*"%>
   <%@ page import="java.util.List" %>
   <%@ page import="java.util.Iterator" %>
   <%@ page import="java.io.File" %>
   <%@ page import="java.io.*" %>
   <%@ page import = "java.io.FileNotFoundException"%>
  	<%@ page import = "java.io.FileOutputStream"%>
  	<%@ page import = " java.io.IOException"%>
  	<%@ page import="javax.activation.*" %>
<%@ include file="Connections/conn.jsp" %>
<%!
Connection con1;
%>
<%
String msgSend="";
Statement st=null;
try
{
	Class.forName(MM_dbConn_DRIVER);
	con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=con1.createStatement();	
}
catch(Exception e)
{
	System.out.println("Exception DB Connection---->>"+e);
}
%>
        
   <%
   System.out.println("##############################contestIncidentMaster.jsp##############################");
   	 DateFormat df1=new SimpleDateFormat("HHmmss");
   	 String d1=df1.format(new java.util.Date());
     String f123="",incidentid="",username="",vehregno="";
   	 String itemName="",docPath="";
     int fileCount=0;
     String resendMsg="";
 %>
 <%
 boolean isMultipart = ServletFileUpload.isMultipartContent(request);
 System.out.println(isMultipart);
 if (!isMultipart) 
 {
	 System.out.println(request.getParameter("MyFile"));
	 System.out.println("^^^^^^^^^^^^^^NOT Multipart^^^^^^^^^^^^^^^");
 } 
 else
 {
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
   Iterator itr=null;
   try
   {
   		itr= items.iterator();
   }
   catch (Exception e) 
   {
   		out.println("Iterator-------->"+e);
   }

   String a="";
   while (itr.hasNext()) 
   {
   		   FileItem item = (FileItem) itr.next();
   		   if (item.isFormField())
           {
              String name = item.getFieldName();
                  String value = item.getString();
                  if(name.equals("MyFile"))
                  {
               	   f123=value.trim();
                  }
                  if(name.equals("incidentid"))
                  {
                	  incidentid=value.trim();
                  }
                   if(name.equals("username"))
                   {
                	   username=value.trim();
                   }
                   if(name.equals("element_1"))					
                   {
                	   vehregno=value.trim();
                   }
                  
                   System.out.println(f123+"========="+incidentid+"==========="+username+"============"+vehregno);
                   
          } 
    	  else
		  {    
    		  System.out.println("((((((((((ELSE))))))))))");
						try 
						{
							String FileUploadPath =getServletContext().getInitParameter("configuredUploadDir1");
							System.out.println("======================"+FileUploadPath+"=========================");
							
						   itemName = item.getName();
						   File savedFile = new File(config.getServletContext().getRealPath("/")+itemName);
						// File savedFile = new File(FileUploadPath+"/"+itemName);
						   System.out.println("path==========>>"+(config.getServletContext().getRealPath("/")).toString());
						   
						   docPath=(config.getServletContext().getRealPath("/")).toString();
						   item.write(savedFile);
					   } 
			    	   catch (Exception e) 
			    	   {
					   		e.printStackTrace();
					   		System.out.println("&&&&&&&&&&&>>>"+e);
					   }
		}
	}
   
   try
   {
	   //-----Rename Video File------------------------------
	   String vdoFile=itemName.substring( (itemName.lastIndexOf(".")),itemName.length() );
	   vdoFile=incidentid+vdoFile;
	   //----------------------------------------------------
	   String sqlInsert="insert into db_gps.t_contestIncidentMaster (OriginalIncidentFile,NewIncidentFile,Transporter,vehicle,EnteredBy) values ('"+itemName+"','"+vdoFile+"','"+username+"','"+vehregno+"','"+session.getAttribute("mainuser")+"')";
	   st.executeUpdate(sqlInsert);
	   msgSend="Record Inserted Successfully!";
   }
   catch(Exception e)
   {
	   System.out.println("Insert To DB-------->>"+e);
	   msgSend="Unable To Insert!!";
   }
   
   }//close of else(multipart)
		   
		   con1.close();
   			String sendIt="msg="+msgSend+"&goto=contestIncidentMaster.jsp";
		   response.sendRedirect("redirectPage.jsp?"+sendIt);
		   %>
