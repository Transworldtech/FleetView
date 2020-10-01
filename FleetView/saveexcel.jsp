<%@ include file="headernew.jsp"%>               
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes"	scope="page">

<%@ page import="java.sql.*" %>
<%@page import="java.util.Date.*"%>
<%@ page import="java.util.List" %>
   <%@ page import="java.util.Iterator" %>
   <%@ page import="java.io.File" %>
   <%@ page import="java.io.*" %>
   <%@ page import="java.util.Properties,javax.mail.*,javax.mail.internet.*"%>
   <%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
   <%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
   <%@ page import="org.apache.commons.fileupload.*"%>  
   <%@ page import="org.apache.poi.hssf.usermodel.HSSFWorkbook" %>
   <%@ page import="org.apache.poi.hssf.usermodel.HSSFSheet" %>
   <%@ page import="org.apache.poi.hssf.usermodel.HSSFCell" %> 
   <%@ page import="org.apache.poi.hssf.usermodel.*" %> 
   <%@ page import="org.apache.poi.hssf.usermodel.HSSFRow" %>
   <%@ page import = "java.io.FileNotFoundException"%>
   <%@ page import = "java.io.FileOutputStream"%>
   <%@ page import = "java.io.IOException"%>
   <%@ page import="javax.activation.*" %>  
   <%@ page import="java.io.FileInputStream" %>
   <%@ page import="java.math.BigDecimal" %>
   <%@ page import="java.sql.Connection" %>
   <%@ page import="java.sql.DriverManager" %>
   <%@ page import="java.sql.ResultSet" %>
   <%@ page import="java.sql.Statement" %>
   <%@ page import="java.text.SimpleDateFormat" %>
   <%@ page import="java.util.ArrayList" %>
   <%@ page import="java.util.Iterator" %>
   <%@ page import="java.util.List" %>
   <%@ page import="java.util.StringTokenizer" %>
 
 
  <%@ page import = "java.io.FileInputStream"%>
   <%@ page import = "java.io.FileNotFoundException"%>
   <%@ page import = "java.io.IOException"%>
   <%@ page import="java.util.Date" %>  
   <%@ page import="org.apache.poi.hssf.usermodel.HSSFCell" %>
   <%@ page import="org.apache.poi.hssf.usermodel.HSSFRow" %>
   <%@ page import=" org.apache.poi.hssf.usermodel.HSSFSheet" %>
   <%@ page import="org.apache.poi.hssf.usermodel.HSSFWorkbook" %>
   <%@ page import="java.sql.ResultSet" %>
   <%@ page import="java.sql.Statement" %>
   <%@ page import="java.text.SimpleDateFormat" %>
   <%@ page import="java.util.ArrayList" %>
   <%@ page import="java.util.Iterator" %>
   <%@ page import="java.util.List" %>
   <%@ page import="java.util.StringTokenizer" %>
 
   <%@ page import="org.apache.poi.hssf.usermodel.HSSFSheet" %>
   <%@ page import="org.apache.poi.hssf.usermodel.HSSFWorkbook" %>


	  <%@ page import="java.util.Iterator" %>
  	 <%@ page import="java.util.Vector" %>
  	 <%@ page import="org.apache.poi.poifs.filesystem.POIFSFileSystem" %>
  	
	  <%@ page import="java.lang.Iterable" %>
	    <%@ page import="java.lang.Object" %>
	     <%@ page import="org.apache.poi.ss.usermodel.*" %>
	    
<% 
fleetview.getConnection(MM_dbConn_DRIVER, MM_dbConn_STRING,MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
Connection con1;
Class.forName(MM_dbConn_DRIVER);
con1 = fleetview.ReturnConnection();

Statement st = con1.createStatement();
%>
<%!
public static void SaveException(String exceptionCaught,String driver_id, String diver_name, String computed_incentive, String entitled_incentive, String final_incentive, String amount_paid){
	try{
		BufferedWriter writer = null;
		try{
			writer = new BufferedWriter( new FileWriter( "/root/newupload/Exceptions.txt",true));
			
			writer.write("Exception Caught At Time : "+new java.util.Date());
			writer.newLine();
			writer.write("Exception          : "+exceptionCaught.toString());
			writer.newLine();
			writer.write( "Driver id         : "+driver_id );
			writer.newLine();
			writer.write( "Driver name       : "+diver_name );
			writer.newLine();
			writer.write( "Computed incntive : "+computed_incentive );
			writer.newLine();
			writer.write( "Entitled incntive : "+entitled_incentive );
			writer.newLine();
			writer.write( "Final incntive    : "+final_incentive );
			writer.newLine();
			writer.write( "Amount Paid       : "+amount_paid );
			writer.newLine();
			writer.write("----------------------------------------------------------------------------------------------------------------");
			writer.newLine(); 	writer.newLine();  writer.newLine();
			writer.flush();
			System.out.println("write successful in CATCH block");
		}catch (Exception ee) {
			System.out.println("xx"+ee);
			//ee.printStackTrace();
		}
		finally
		{		try	{
						if ( writer != null)
							writer.close( );
					}
				catch ( IOException e)	{	}
		}
	  }catch (Exception e) { }
	}

%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body style="font-family: Arial">

	<div style="margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em" align="center">

<form name="DriverIncentivePaymentReport" id="DriverIncentivePaymentReport" action="" method="post">
<div id="table1" align="center" style="width: 850px;">
<div style="font-size: 1.4em;" align="center">

<table class="sortable" width="100%" align="center">
<tr>
<th style="width: 10px">Sr No</th>
<th style="width: 50px">Driver PP No</th>
<th style="width: 160px">Driver Name</th>
<th style="width: 25px">Computed Incentive </th>
<th style="width: 25px">Entitled Incentive</th>
<th style="width: 40px">Final Incentive</th>
<th style="width: 60px">Final Paid Amount</th>
<th style="width: 60px">Driver Sign</th>
<th style="width: 40px">CFA Incharge</th>
<th style="width: 40px">PPA Incharge</th>
<th style="width: 50px">Date of payment</th>
<th style="width: 50px">Remark</th>
</tr>	
<%! 	
		int cnt=0, firstrow=0, count=0;
		String row="";
	
		String srno="-", driverid="-",driver_id, computed_incentive="-", entitled_incentive="-", final_incentive="-", paid_amount="-", driver_name="-", paid_date="-", driver_sign="-", cfa_incharge="-", ppa_incharge="-", date_of_payment="-" ;

%>
<%		
%>
<%
String user,usertypevalue,sessionid;
user=session.getAttribute("user").toString();
usertypevalue=session.getAttribute("usertypevalue").toString();
//sessionid=session.getAttribute("sessionid").toString();
String ipaddr= request.getRemoteAddr();

sessionid=session.getId().toString();
//out.println("\nsessionid-->>"+sessionid);
%>
<%

String file1="";
int saveflag=1;
File savedFile;
String[] filepath =new String[10];
String[] filename =new String[10];
int  count2 = 0, filecount = 0;;
int count=1;
String savefilestring="";
String uploadedBy = "";


int count1=0;
boolean isMultipart = ServletFileUpload.isMultipartContent(request);
System.out.println("\n\n ismultipart-->>"+isMultipart);
        if (!isMultipart) {
        System.out.println("\n\nin multipart..");
        } else {
                System.out.println("\n\n in else with  multipart..");
                FileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);
                List items = null;
                try {
                        items = upload.parseRequest(request);
                //      System.out.print("\n\n items==>"+items);
                } catch (FileUploadException e) {
                        e.printStackTrace();
                }
                Iterator itr = items.iterator();
                
                
                while (itr.hasNext()) {
                    FileItem item = (FileItem) itr.next();
                    if(item.isFormField()) 
                    {
	                   		String name1 = item.getFieldName();
	                       System.out.print("\n name==>"+name1);
	                       String value = item.getString();
	                       System.out.print("\n value==>"+value);
	                       if(name1.equals("uploadedby")) 
	                       {
	                       		uploadedBy = value;
	                               System.out.print("\n title==>"+uploadedBy);		                             
	                              
	                       }	
                    } else {
                     try {

                           String itemName = item.getName();
                           System.out.print("\n\nitemName==>"+itemName);
                           	file1=itemName;
                            if(itemName.equalsIgnoreCase(""))
                            {
                            }
                          else
                           {
                           
                       		// savedFile = new File("/home/sumedh/Desktop/Task_List/"+itemName);  
                       		savedFile = new File("/root/newupload/"+itemName);  
                           
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
                      // System.out.println("\n\nscreenshot--->>>"+screenshot);
                               }
                                      
                                      
                      } catch (Exception e) {
                              e.printStackTrace();
                      }
                    }
            }
	
 }
   //=============================excel reading code========================

	
	   
	String fname = "/root/newupload/"+file1;
	System.out.println("The filename is :"+file1);
	System.out.println("The filepath is :"+fname);
   
   
	System.out.println("The filepath is :"+fname);
	List sheetData = new ArrayList();			 
	FileInputStream fis = null;
	try {
	    
	    fis = new FileInputStream(fname);			 
	    HSSFWorkbook workbook = new HSSFWorkbook(fis);			            
	    HSSFSheet sheet = workbook.getSheetAt(0);
	    Iterator rows = sheet.rowIterator();
	    while (rows.hasNext()) {
	        HSSFRow row = (HSSFRow) rows.next();
	        Iterator cells = row.cellIterator();
	
	        List data = new ArrayList();
	        while (cells.hasNext()) {
	            HSSFCell cell = (HSSFCell) cells.next();
	            data.add(cell);
	            
	        }
	
	        sheetData.add(data);
	    }
	} catch (IOException e) {
	    e.printStackTrace();
	} finally {
	    if (fis != null) {
	        fis.close();
	    }
	}

try
{
		int  countFeild=0;;
		// Iterates the data and print it out to the console.	
        for (int i = 2; i < sheetData.size(); i++) 
        {
           List list = (List) sheetData.get(i);
          for (int j = 0; j < list.size(); j++) 
         {
             HSSFCell cell = (HSSFCell) list.get(j);
             
             if(cell.getCellType()==HSSFCell.CELL_TYPE_NUMERIC) 
             {
             	// Date and numeric filed validate	
             	if(HSSFDateUtil.isCellDateFormatted(cell))
             	{  
             		if(row.equals(""))
             		{
             		row=new SimpleDateFormat("yyyy-MM-dd").format(cell.getDateCellValue());
             		}else
             		{	
             			row=row+"$"+new SimpleDateFormat("yyyy-MM-dd").format(cell.getDateCellValue());
             		}
                 }else{
                 
                 	//System.out.print(new BigDecimal(cell.getNumericCellValue()).toString());
                 	if(row.equals(""))
                 	{
                 	row=new BigDecimal(cell.getNumericCellValue()).toString();
                 	}else
                 	{
                 		row=row+"$"+new BigDecimal(cell.getNumericCellValue()).toString();
                 	}
                 }
            	
             }
             
             else{  
         	  	    System.out.print("this is a cell "+cell.toString());
               	   if (cell == null || cell.getCellType() == Cell.CELL_TYPE_BLANK) 
             	    {
             			row=row+"$"+"-"+cell.toString();
             		}
             	   else
             	   {
             		  row=row+"$"+cell.toString();  
             	   }
             	    
              }
                      
        System.out.println(row);
         }// End of for loop
		 
       		//out.println(row );       		       
       		try
       		{
       				
       			StringTokenizer stringTokenizer = new StringTokenizer(row,"$");
       			System.out.println("The total no. of tokens generated :  " + stringTokenizer.countTokens());
       			countFeild  = stringTokenizer.countTokens();

    			if(stringTokenizer.countTokens() == 11)	
       			{
    			
    				
       				srno = stringTokenizer.nextToken();
       				driverid = stringTokenizer.nextToken();
       				driver_name=stringTokenizer.nextToken();
       				computed_incentive= stringTokenizer.nextToken();
       				entitled_incentive=stringTokenizer.nextToken();
       				final_incentive=stringTokenizer.nextToken();
       				paid_amount=stringTokenizer.nextToken(); 	
       				driver_sign=stringTokenizer.nextToken();
       				cfa_incharge=stringTokenizer.nextToken();
       				ppa_incharge=stringTokenizer.nextToken();
       				date_of_payment=stringTokenizer.nextToken();
       				
       			
       				
       				if(srno.equals("-"))
					{
						srno="0";
					}
					if(driverid.equals("-"))
					{
						driverid="0";
					}
					
					if(computed_incentive.equals("-"))
					{
						computed_incentive="0";
					}
					if(entitled_incentive.equals("-"))
					{
						entitled_incentive="0";
					}
					if(final_incentive.equals("-"))
					{
						final_incentive="0";
					}
					if(paid_amount.equals("-"))
					{
						paid_amount="0";
					}
					if(date_of_payment.equals("-"))
					{
						date_of_payment="0000-00-00";
					}
       			}

       		}
       		catch(Exception e)
       		{
       			System.out.println("Exception "+e.getMessage());	
       			
       		}
       		row="";
      			
       		try
       		{       					    	
			    	String sql;
								
sql="insert into  db_gps.t_bulkincentive(srno, driver_id, driver_name, computed_incentive, entitled_incentive, final_incentive,paid_amount,driver_sign,cfa_incharge,ppa_incharge,date_of_payment,session_id, uploaded_by,ip_addr,inserted_Date) values('"+srno+"', '"+driverid+"','"+driver_name+"','"+computed_incentive+"','"+entitled_incentive+"','"+final_incentive+"','"+paid_amount+"','"+driver_sign+"','"+cfa_incharge+"','"+ppa_incharge+"','"+date_of_payment+"','"+sessionid+"','"+user+"','"+ipaddr+"',NOW())";
					st.executeUpdate(sql);
					
  		
%>     
<tr>   
<td style="text-align: right;" align="right"><%= srno %></td>
<td style="text-align: right;" align="right" ><%= driverid %></td>
<td style="text-align: left;" align="left" ><%=  driver_name %></td>
<td style="text-align: right;" align="right"><%= computed_incentive %></td>
<td style="text-align: right;" align="right"><%=entitled_incentive  %></td>
<td style="text-align: right;" align="right"><%=final_incentive  %></td>
<td style="text-align: right;" align="right"><%=paid_amount  %></td>
<td style="text-align: left;" align="left"><%=driver_sign  %></td>
<td style="text-align: left;" align="left"><%=cfa_incharge  %></td>
<td style="text-align: left;" align="left"><%=ppa_incharge  %></td>
<td style="text-align: right;" align="right"><%=date_of_payment  %></td>
<td style="text-align: left;" align="left">
       		
<%     		out.println("Inserted successfully");
			//cnt++; // Dont change position
			count++;
%>
</td>	
</tr>
<%! 

%>
<% 	 
       		}catch(Exception e)
       		{	
       			//cnt++;
       			count++;
       			out.println("Error while inserting record "+" For Sr No "+count+ " For driver id "+  driverid +" "+e.getMessage() + "</br>");
       					
			   String sql1;
			   //sql1="insert into  db_gps.t_bulkincentive_exception(srno, driver_id, driver_name) values('"+srno+"', '"+driverid+"','"+driver_name+"')";
			   //st.executeUpdate(sql1);	   
       			
			   SaveException(e.toString(),driverid,driver_name,computed_incentive, entitled_incentive, final_incentive,paid_amount  ); 			
       		 }
        }   		
        
		
}
	catch(Exception e)
	{
		System.out.println("Exception ->"+e.getMessage());
		
	}
		
	System.out.println("Cont is "+cnt+ "First row count "+ firstrow);
	
	File f = new File("/root/newupload/"+file1);				
	if(f.renameTo(new File("/root/newupload/MovedFiles/"+new java.util.Date()+file1)))
	{							
		System.out.println("File is moved successful!");
	}
	
	%>

	
</table>
</div>
</form>
</div>
</body>
</html>
	
	
	
	<%con1.close(); %>
</jsp:useBean>
<%@ include file="footernew.jsp" %>
