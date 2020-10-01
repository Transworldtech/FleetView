package com.fleetview.beans;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.text.Format;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.OfficeXmlFileException;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import com.fleetview.beans.InvalidData;
import com.fleetview.beans.ValidData;

public class POIExcelReader {

	Connection conn=null,con=null; 
	PreparedStatement ps=null;
	Statement stmt=null,stmt1=null,stmt2=null,stn3=null,stmt3=null,stmt4=null,stmt10=null;
	ResultSet rs=null;

	/** Creates a new instance of POIExcelReader */
	public POIExcelReader ()
	{}

	/**
	 * This method is used to display the Excel content to command line.
	 *
	 * @param xlsPath
	 */
	@SuppressWarnings ({ "unchecked", "deprecation" })

	/*private void getConnection() throws ClassNotFoundException, SQLException{
		String MM_dbConn_DRIVER="org.gjt.mm.mysql.Driver";
		String MM_dbConn_USERNAME="fleetview";
		String MM_dbConn_PASSWORD="1@flv";
		String MM_dbConn_STRING="jdbc:mysql://localhost/db_gps";
		Class.forName(MM_dbConn_DRIVER);
		conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

	}*/

	private void getnewConnection() throws ClassNotFoundException, SQLException{
		String MM_dbConn_DRIVER="org.gjt.mm.mysql.Driver";
		String MM_dbConn_USERNAME="fleetview";
		String MM_dbConn_PASSWORD="1@flv";
		String MM_dbConn_STRING="jdbc:mysql://localhost/db_gps";
		Class.forName(MM_dbConn_DRIVER);
		con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		stmt=con.createStatement();
		stmt1=con.createStatement();
		stmt2=con.createStatement();
		stn3=con.createStatement();
		stmt3=con.createStatement();
		stmt4=con.createStatement();
		stmt10=con.createStatement();
	}

	public ArrayList<DisplayData> displayFromExcel (String xlsPath,String user,String usertypevalue) throws ClassNotFoundException, SQLException, ParseException,OfficeXmlFileException
	{


		InputStream inputStream = null;

		try
		{
			inputStream = new FileInputStream (xlsPath);
		}
		catch (FileNotFoundException e)
		{
			System.out.println ("File not found in the specified path.");
			e.printStackTrace ();
		}



		POIFSFileSystem fileSystem = null;
		//bean for insertion
		ValidData valid = null;
		InvalidData invaliddata =null;
		DisplayData dispdata=null;

		String username=user;

		ArrayList<ValidData> validList= new ArrayList<ValidData>();
		ArrayList<InvalidData> invalidList= new ArrayList<InvalidData>();
		ArrayList<DisplayData> dispList= new ArrayList<DisplayData>();

		try
		{
			fileSystem = new POIFSFileSystem (inputStream);

			HSSFWorkbook      workBook = new HSSFWorkbook (fileSystem);
			HSSFSheet         sheet    = workBook.getSheetAt (0);
			Iterator rows     = sheet.rowIterator ();
			System.out.println(sheet.getLastRowNum()+"<<last row no   >>  "+sheet.getDefaultColumnWidth());
			while (rows.hasNext ())	{
				System.out.println("row:"+rows);
				boolean insertFlag = false;
				//valid and invalid bean
				valid = new ValidData();
				invaliddata = new InvalidData();
				dispdata=new DisplayData();
				// 
				HSSFRow row = (HSSFRow)rows.next ();
				// display row number in the console.
				System.out.println ("Row No.: " + row.getRowNum ());
				int rowno=row.getRowNum ();
				if(rowno!=0){
					// once get a row its time to iterate through cells.
					Iterator cells = row.cellIterator ();

					while (cells.hasNext ()) {

						HSSFCell cell = (HSSFCell)cells.next ();

						System.out.println ("Cell No.: " + cell.getColumnIndex());

						/*
						 * Now we will get the cell type and display the values
						 * accordingly.
						 */

						switch(cell.getColumnIndex())
						{

						case 0:
						{

							try
							{
								int srno = (int) cell.getNumericCellValue();

								dispdata.setSrNo(srno+"");
								if(srno>0)
								{

									valid.setSrNo(srno);	
								}
								else
								{
									invaliddata.setSrNo(srno);	
									dispdata.setSrNo("Error "+srno);
									insertFlag = true;
								}
							}
							catch(Exception e)
							{
								dispdata.setSrNo("Error: Sr.No should be in number format");
								insertFlag = true;
							}
							break;
						}

						case 1:
						{
							try
							{

								HSSFRichTextString tripid = cell.getRichStringCellValue ();
								String var= tripid.toString();

								dispdata.setTripID(var);
								boolean FlagOK=false;
								System.out.println("TripID====>"+var);
								if(var.length()>0)
								{
									for(int i=0;i<var.length();i++)
									{
										FlagOK=false;
										//if(var.charAt(i)>=65 && var.charAt(i)<=90 || var.charAt(i)>=97 && var.charAt(i)<=122 || var.charAt(i)>=48 && var.charAt(i)<=57)
										//if (Character.isLetterOrDigit(var.charAt(i)))
										//if(var.matches("[a-zA-Z0-9]*"))
										//{
											FlagOK=true;
										//}
										//else
										//	break;
									}
								}
								if(FlagOK==true)
								{

									valid.setTripID(var);


									//System.out.println("valid "+var);
								}

								else
								{
									invaliddata.setTripID("Error "+var);
									dispdata.setTripID(var+" [Error: Trip Id cannot contain value other than digits and alphabets]");
									insertFlag = true;
								}
							}catch(Exception e)
							{
								int tripid=(int) cell.getNumericCellValue();
								String var=Integer.toString(tripid);
								dispdata.setTripID(var);
								String regex ="^.*[0-9].*$";
								String msg=validate(regex,var.trim());
								if(msg=="true")
								{
									valid.setTripID(var);
								}
								else
								{
									invaliddata.setTripID("Error "+var);
									dispdata.setTripID(var+" [Error:'int'Trip Id cannot contain value other than digits and alphabets]");
									insertFlag = true;
								}	
								//dispdata.setTripID("Error: Trip Id cannot contain value other than digits and alphabets");
								//insertFlag = true;
							}

							/*
							String regex ="^.*[0-9].*$";                    //"/[^0-9]/";               //"[A-Za-z0-9]";               //"[0-9a-zA-Z]";           //"/[^0-9]/";
							String msg=validate(regex,var.trim());
							if(msg=="true")
							{
								valid.setTripID(var);
							}
							else
							{

								invaliddata.setTripID(var);
								System.out.println("invalid "+var);
								insertFlag = true;
							}*/

							break;
						}

						case 2:
						{
							try{
								HSSFRichTextString  datetime = cell.getRichStringCellValue ();
								String var= datetime.toString();
String startDate=null;
								//Date startDate=null;
								Boolean Flag=false;
								//	^((31(?! (FEB|APR|JUN|SEP|NOV)))|((30|29)(?! FEB))|(29(?= FEB (((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)))))|(0?[1-9])|1\d|2[0-8]) (JAN|FEB|MAR|MAY|APR|JUL|JUN|AUG|OCT|SEP|NOV|DEC) ((1[6-9]|[2-9]\d)\d{2})$

								/*String StartDt=null,StartTime=null;


							 StringTokenizer st = new StringTokenizer(var);
						     while (st.hasMoreTokens()) {
						         StartDt=st.nextToken();
						         StartTime=st.nextToken();
						     }

						     valid.setDate(StartDt);
								valid.setTime(StartTime);
								System.out.println("valid "+StartDt+StartTime);*/
								System.out.println("var date ************************************>"+var);
							
								startDate=new SimpleDateFormat("dd-MMM-yy HH:mm:ss").format(new SimpleDateFormat("dd/MM/yy HH:mm").parse(var));
								//	startDate=new SimpleDateFormat("") ;
									System.out.println("startDate************************************>"+startDate);
									Flag=true;
								


								String StartDt=null,StartTime=null;
								StringTokenizer st = new StringTokenizer(startDate);
								System.out.println("st----->"+st);
								while (st.hasMoreTokens()) {
									StartDt=st.nextToken();
									System.out.println("String tocknizer date---->"+StartDt);
									StartTime=st.nextToken();
									System.out.println("String tocknizer StartTime---->"+StartTime);
								}
								dispdata.setDate(var);


								System.out.println("Flag-------->"+Flag);
								if(Flag==true)	
								{

									valid.setDate(StartDt);
									System.out.println("StartDt-------->"+StartDt);
									valid.setTime(StartTime);
									System.out.println("StartTime-------->"+StartTime);

									//System.out.println("valid "+StartDt+StartTime);
								}
								else
								{
									invaliddata.setDate("Error "+StartDt);
									invaliddata.setTime("Error" +StartTime);
									dispdata.setDate(var+" [Error:Date & Time Should be in proper format(dd/MM/yy HH:mm) (E.g 12/10/10 12:00)]");

									insertFlag = true;

								}
							}catch(Exception e)
							{
								dispdata.setDate(" Error:Date & Time Should be in proper format(dd/MM/yy HH:mm) (E.g 12/10/10 12:00)]");
								insertFlag = true;
							}


							/* if(StartDt.equals(new SimpleDateFormat("dd-MMM-yy")))
						     {
						    	 if(StartTime.equals(new SimpleDateFormat("HH:MM:SS")))
						    	 {
						    	 Flag=true;
						    	 }
						     }*/
							/*if(Flag=true)
						{
							valid.setDate(StartDt);
							valid.setTime(StartTime);
							System.out.println("valid "+StartDt+StartTime);
						}
						else
							{invaliddata.setDate(StartDt);
						invaliddata.setTime(StartTime);}*/

							/*String regex = "\\d{1,2}/\\d{1,2}/\\d{2,4}";
							String msg=validate(regex,var.trim());
							if(msg=="true")
							{
								valid.setDateTime(var);
							}
							else
							{
								invaliddata.setDateTime(var);
								insertFlag = true;
							}*/
							break;
						}
						case 3:
						{
							try{
								HSSFRichTextString vehNo = cell.getRichStringCellValue ();
								String var= vehNo.toString();
								dispdata.setVehNo(var);
								String msg=null;

								if(var.length()>0)
								{

									msg=validateString(var.trim());

								}
								if(msg=="true")
								{

									valid.setVehNo(var);

									//	System.out.println("valid "+var);
								}

								else
								{
									invaliddata.setVehNo("Error "+var);
									dispdata.setVehNo(var+"[Error: Veh.No cannot contain value other than alphabets and digits]");
									insertFlag = true;
								}
							}catch(Exception e)
							{


								int vehno=(int) cell.getNumericCellValue();
								String var=Integer.toString(vehno);
								dispdata.setVehNo(var);
								String regex ="^.*[0-9].*$";
								String msg=validate(regex,var.trim());
								if(msg=="true")
								{
									valid.setVehNo(var);
								}
								else
								{
									invaliddata.setVehNo("Error "+var);
									dispdata.setVehNo("Error: Veh.No should contain value in alphabets and digits only");
									insertFlag = true;
								}



							}
							/*

							String regex = "[0-9a-zA-Z' ']";     //alphanumeric and space
							String msg=validate(regex,var.trim());
							if(msg=="true")
							{
								valid.setVehNo(var);
							}
							else
							{
								invaliddata.setVehNo(var);
								insertFlag = true;
							}*/

							break;
						}
						
						
						
						case 4:
						{
							try
							{
								HSSFRichTextString transport = cell.getRichStringCellValue ();
								String var= transport.toString();
								dispdata.setTransport(var);
								String msg=null;

								if(var.length()>0)
								{

									msg=validateString(var.trim());

								}
								if(msg=="true")
								{
									valid.setTransport(var);

									//	System.out.println("valid "+var);
								}
								
								else
								{
									invaliddata.setTransport("Error "+var);
									dispdata.setTransport(var+"[Error: Transport cannot contain value other than alphabets and digits]");
									insertFlag = true;
								}
							}catch(Exception e)
							{
								dispdata.setTransport("Error:Transport should contain value in alphabets and digits only");
								insertFlag = true;
							}

							
						/*	String regex="[0-9a-zA-Z' ']";                          //"^[a-zA-Z ]+$";            //alphanumeric and space
							String msg=validate(regex,var.trim());
							if(msg=="true")
							{
								valid.setTransport(var);
							}
							else
							{
								invaliddata.setTransport(var);
								insertFlag = true;
							}*/
							 
							break;
						} 
						
						case 5:
						{
							try{
								//dispdata.setTransport(usertypevalue);
								//valid.setTransport(usertypevalue);
								HSSFRichTextString tripfrom = cell.getRichStringCellValue ();
								String var= tripfrom.toString();
								dispdata.setTripFrom(var);
								String msg=null;

								if(var.length()>0)
								{

									msg=validateString(var.trim());

								}
								if(msg=="true")
								{

									valid.setTripFrom(var);

									//	System.out.println("valid "+var);
								}

								else
								{
									invaliddata.setTripFrom(var+"[Error]");
									dispdata.setTripFrom(var+"[Error:TripFrom cannot contain value other than alphabets and digits]");
									insertFlag = true;
								}
							}catch(Exception e){
								dispdata.setTripFrom("Error: TripFrom should contain value in alphabets and digits only ");
								insertFlag = true;
							}

							/*

							String regex="[0-9a-zA-Z' ']";    
							String msg=validate(regex,var.trim());
							if(msg=="true")
							{
								valid.setTripFrom(var);
							}
							else
							{
								invaliddata.setTripFrom(var);
								insertFlag = true;
							}*/

							break;
						}
						case 6:
						{
							try{
								HSSFRichTextString tripto = cell.getRichStringCellValue ();
								String var= tripto.toString();

								dispdata.setTripTo(var);
								String msg=null;

								if(var.length()>0)
								{

									msg=validateString(var.trim());

								}
								if(msg=="true")
								{

									valid.setTripTo(var);

									//	System.out.println("valid "+var);
								}

								else
								{
									invaliddata.setTripTo("Error "+var);
									dispdata.setTripTo(var+"[Error:TripTo cannot contain value other than alphabets and digits]");
									insertFlag = true;
								}
							}catch(Exception e)
							{
								dispdata.setTripTo("Error:TripTo should contain value in alphabets and digits only  ");
								insertFlag = true;
							}
							/*
							String regex="[0-9a-zA-Z' ']";    
							String msg=validate(regex,var.trim());
							if(msg=="true")
							{
								valid.setTripTo(var);
							}
							else
							{
								invaliddata.setTripTo(var);
								insertFlag = true;
							}*/
							break;
						}
						case 7:
						{
							try
							{
								HSSFRichTextString Driverid1 = cell.getRichStringCellValue ();
								String var= Driverid1.toString();

								dispdata.setDriverID1(var);
								String msg=null;

								if(var.length()>0)
								{

									msg=validateString(var.trim());

								}
								if(msg=="true")
								{

									valid.setDriverID1(var);

									//	System.out.println("valid "+var);
								}

								else
								{
									invaliddata.setDriverID1("Error "+var);
									dispdata.setDriverID1(var+"[Error:DriverCode cannot contain value other than alphabets and digits] ");
									insertFlag = true;
								}
							}catch(Exception e)
							{

								int driverid=(int) cell.getNumericCellValue();
								String var=Integer.toString(driverid);
								dispdata.setDriverID1(var);
								String regex ="^.*[0-9].*$";
								String msg=validate(regex,var.trim());
								if(msg=="true")
								{
									valid.setDriverID1(var);
								}
								else
								{
									invaliddata.setDriverID1("Error "+var);
									dispdata.setDriverID1("Error: DriverCode should contain value in alphabets and digits only ");
									insertFlag = true;
								}	




							}
							/*
							String regex="/[^a-zA-Z0-9]/";
							String msg=validate(regex,var.trim());
							if(msg=="true")
							{
								valid.setDriverID1(var);
							}
							else
							{
								invaliddata.setDriverID1(var);
								insertFlag = true;
							}*/

							break;
						}
						case 8:
						{
							try{
								HSSFRichTextString Drivername = cell.getRichStringCellValue ();
								String var= Drivername.toString();

								dispdata.setDriverName1(var);
								String msg=null;

								if(var.length()>0)
								{

									msg=validateName(var.trim());

								}
								if(msg=="true")
								{

									valid.setDriverName1(var);

									//	System.out.println("valid "+var);
								}

								else
								{
									invaliddata.setDriverName1("Error "+var);
									dispdata.setDriverName1(var+"[Error:DriverName cannot contain value other than alphabets] ");
									insertFlag = true;
								}
							}catch(Exception e)
							{
								dispdata.setDriverName1("Error:DriverName should contain value in alphabets and digits only");
								insertFlag = true;
							}
							/*
							String regex="/^([a-zA-Z' ']+)*$/";
							String msg=validate(regex,var.trim());
							if(msg=="true")
							{
								valid.setDriverName1(var);
							}
							else
							{
								invaliddata.setDriverName1(var);
								insertFlag = true;
							}*/

							break;
						}
						case 9:
						{
							try
							{
								HSSFRichTextString Driverid2 = cell.getRichStringCellValue ();
								String var= Driverid2.toString();

								dispdata.setDriverID2(var);
								String msg=null;

								if(var.length()>0)
								{

									msg=validateString(var.trim());

								}
								if(msg=="true")
								{
									valid.setDriverID2(var);

									//	System.out.println("valid "+var);
								}

								else
								{
									invaliddata.setDriverID2("Error "+var);
									dispdata.setDriverID2(var+"[Error:DriverCode cannot contain value other than alphabets and digits] ");
									insertFlag = true;
								}
							}catch(Exception e)
							{

								int driverid=(int) cell.getNumericCellValue();
								String var=Integer.toString(driverid);
								dispdata.setDriverID2(var);
								String regex ="^.*[0-9].*$";
								String msg=validate(regex,var.trim());
								if(msg=="true")
								{
									valid.setDriverID2(var);
								}
								else
								{
									invaliddata.setDriverID2("Error "+var);
									dispdata.setDriverID2("Error:DriverCode should contain value in alphabets and digits only ");
									insertFlag = true;
								}	




							}

							/*
							String regex="/^([a-zA-Z0-9]+)*$/";
							String msg=validate(regex,var.trim());
							if(msg=="true")
							{
								valid.setDriverID2(var);
							}
							else
							{
								invaliddata.setDriverID2(var);
								insertFlag = true;
							}*/

							break;
						}
						case 10:
						{
							try
							{
								HSSFRichTextString Drivername2 = cell.getRichStringCellValue ();
								String var= Drivername2.toString();
								dispdata.setDriverName2(var);
								String msg=null;

								if(var.length()>0)
								{

									msg=validateName(var.trim());

								}
								if(msg=="true")
								{

									valid.setDriverName2(var);

									//	System.out.println("valid "+var);
								}

								else
								{
									invaliddata.setDriverName2("Error "+var);
									dispdata.setDriverName2(var+"[Error:DriverName cannot contain value other than alphabets]");
									insertFlag = true;
								}
							}catch(Exception e)
							{
								dispdata.setDriverName2("Error:DriverName should contain value in alphabets and digits only");
								insertFlag = true;
							}
							/*
							String regex="/^([a-zA-Z' ']+)*$/";
							String msg=validate(regex,var.trim());
							if(msg=="true")
							{
								valid.setDriverName2(var);
							}
							else
							{
								invaliddata.setDriverName2(var);
								insertFlag = true;
							}*/

							break;
						}
						case 11:
						{
							try{

								HSSFRichTextString  ETA = cell.getRichStringCellValue ();
								String var= ETA.toString();

								Date ETADate=null;
								Boolean Flag=false;

								System.out.println("var"+var);
								try{
									ETADate=new SimpleDateFormat("dd-MMM-yy HH:mm:ss").parse(new SimpleDateFormat("dd-MMM-yy HH:mm:ss").format(new SimpleDateFormat("dd/MM/yy HH:mm").parse(var))) ;
									System.out.println("ETADate"+ETADate);
									Flag=true;

								}catch(Exception e)
								{
									// System.out.println("Date Exception"+e);
									Flag=false;

								}

								String etadate=null;
								etadate=new SimpleDateFormat("dd-MMM-yy HH:mm:ss").format(ETADate);

								dispdata.setETA(etadate);



								if(Flag==true)
								{

									valid.setETA(etadate);


									//	System.out.println("valid "+var);
								}
								else
								{
									invaliddata.setETA("Error "+var);

									dispdata.setETA(var+" [Error:ETA Date & Time Should be in proper format(dd/MM/yy HH:mm) (E.g 12/10/10 12:00)]");

									insertFlag = true;

								}
							}catch(Exception e)
							{
								dispdata.setETA(" Error:ETA Date & Time Should be in proper format(dd/MM/yy HH:mm) (E.g 12/10/10 12:00)]");
								insertFlag = true;
							}



							break;
						}
						case 12:
						{

							try
							{
								double weight = (double) cell.getNumericCellValue();
								dispdata.setWeight(weight+"");
								//	dispdata.setWeight(weight);
								if(weight<0)
								{
									invaliddata.setWeight(weight);	
									dispdata.setSrNo("Error "+weight);
									insertFlag = true;						

								}
								else
								{
									valid.setWeight(weight);	
								}
							}
							catch(Exception e)
							{
								dispdata.setWeight("Error: Weight should be in number format");
								insertFlag = true;
							}
							break;
						}

						case 13:
						{

							try
							{
								HSSFRichTextString vendorname = cell.getRichStringCellValue ();
								//String var="-";
								String  var= vendorname.toString();
								dispdata.setVendor(var);
								String msg="-";
								System.out.println("Vendor>>>>>>>"+vendorname);
								
								if(var.length()>0)
								{

									msg=validateName(var.trim());

								}
								//if(var.equals("-")||var.equals(null))
							//	{
							//		valid.setVendor(var);
							//	}
									if(msg=="true")
								{

									valid.setVendor(var);

									//	System.out.println("valid "+var);
								}

								else
								{
									invaliddata.setVendor("Error "+var);
									dispdata.setVendor(var+"[Error:Vendor cannot contain value other than alphabets]");
									insertFlag = true;
								}
							}catch(Exception e)
							{
								dispdata.setVendor("Error:Vendor should contain value in alphabets only");
								insertFlag = true;
							}


							break;



						}

						case 14:
						{

							try
							{
								HSSFRichTextString triptype = cell.getRichStringCellValue ();
								String var="-";
								var= triptype.toString();
								dispdata.setTriptype(var);
								String msg=null;
								System.out.println("In Trip type"+triptype);
								if(var.length()>0)
								{

									msg=validateName(var.trim());

								}
								//if(var.equals("-")||var.equals(null))
								//{
								//	valid.setTriptype(var);
								//}
								if(msg=="true")
								{

									valid.setTriptype(var);

									//	System.out.println("valid "+var);
								}

								else
								{
									invaliddata.setTriptype("Error "+var);
									dispdata.setTriptype(var+"[Error:Trip Type cannot contain value other than alphabets]");
									insertFlag = true;
								}
							}catch(Exception e)
							{
								dispdata.setTriptype("Error:Trip type should contain value in alphabets only");
								insertFlag = true;
							}


							break;



						}

						case 15:
						{

							try
							{
								int advance = (int) cell.getNumericCellValue();
								System.out.println("In advance"+advance);
								dispdata.setAdvance(advance+"");
								if(advance>=0)
								{

									valid.setAdvance(advance);	
								}
								else
								{
									invaliddata.setAdvance(advance);	
									dispdata.setAdvance("Error "+advance);
									insertFlag = true;
								}
							}
							catch(Exception e)
							{
								dispdata.setAdvance("Error: Advance should be in number format");
								insertFlag = true;
							}
							break;
						}

						case 16:
						{

							try
							{
								int frieght = (int) cell.getNumericCellValue();
								System.out.println("In frieght"+frieght);
								dispdata.setFreight(frieght+"");
								if(frieght>=0)
								{

									valid.setFrieght(frieght);	
								}
								else
								{
									invaliddata.setFrieght(frieght);	
									dispdata.setFreight("Error "+frieght);
									insertFlag = true;
								}
							}
							catch(Exception e)
							{
								dispdata.setSrNo("Error: Frieght should be in number format");
								insertFlag = true;
							}
							break;
						}

						case 17:
						{

							try
							{
								int fxkm = (int) cell.getNumericCellValue();

								dispdata.setFxkm(fxkm+"");
								if(fxkm>=0)
								{

									valid.setFxkm(fxkm);	
								}
								else
								{
									invaliddata.setFxkm(fxkm);	
									dispdata.setFxkm("Error "+fxkm);
									insertFlag = true;
								}
								System.out.println("In fxkm"+fxkm);
							}
							catch(Exception e)
							{
								dispdata.setFxkm("Error: Fixeh Km should be in number format");
								insertFlag = true;
							}

							break;
						}



						case 18:
						{

							try{
								HSSFRichTextString fxtime = cell.getRichStringCellValue ();
								String var= fxtime.toString();
								dispdata.setFxtime(var);
								String msg=null;

								if(var.length()>0)
								{

									msg=validateString(var.trim());

								}
								if(msg=="true")
								{

									valid.setFxtime(var);

									//	System.out.println("valid "+var);
								}

								else
								{
									invaliddata.setFxtime("Error "+var);
									dispdata.setFxtime(var+"[Error: Fixed time cannot contain value other than alphabets and digits]");
									insertFlag = true;
								}
							}catch(Exception e)
							{


								int fxtime=(int) cell.getNumericCellValue();
								String var=Integer.toString(fxtime);
								dispdata.setFxtime(var);
								String regex ="^.*[0-9].*$";
								String msg=validate(regex,var.trim());
								if(msg=="true")
								{
									valid.setFxtime(var);
								}
								else
								{
									invaliddata.setFxtime("Error "+var);
									dispdata.setFxtime("Error: Fixed time should contain value in  digits only");
									insertFlag = true;
								}



							}
							break;
						}
						/*
							String regex="/^([a-zA-Z' ']+)*$/";
							String msg=validate(regex,var.trim());
							if(msg=="true")
							{
								valid.setDriverName2(var);
							}
							else
							{
								invaliddata.setDriverName2(var);
								insertFlag = true;
							}*/

						//	break;
						//	}
						case 19:
						{
							try{
								HSSFRichTextString  rptdatetime = cell.getRichStringCellValue ();
								String var= rptdatetime.toString();

								Date reportDate=null;
								Boolean Flag=false;
								
								try{
									reportDate=new SimpleDateFormat("dd-MMM-yy HH:mm:ss").parse(new SimpleDateFormat("dd-MMM-yy HH:mm:ss").format(new SimpleDateFormat("dd/MM/yy HH:mm").parse(var))) ;
									Flag=true;
								}catch(Exception e)
								{
									// System.out.println("Date Exception"+e);
									Flag=false;

								}


								//String StartDt=null,StartTime=null;
								//StringTokenizer st = new StringTokenizer(var);
								//while (st.hasMoreTokens()) {
								//	StartDt=st.nextToken();
								//	StartTime=st.nextToken();
								//}
							String RptDateTime=null;
								RptDateTime=new SimpleDateFormat("dd-MMM-yy HH:mm:ss").format(reportDate);
								
								dispdata.setReportDateTime(RptDateTime);



								if(Flag==true)
								{

									valid.setReportDateTime(RptDateTime);
									//valid.setTime(StartTime);

								
								}
								else
								{
									invaliddata.setReportDateTime("Error "+RptDateTime);
									//invaliddata.setTime("Error" +StartTime);
									dispdata.setReportDateTime(var+" [Error:Date & Time Should be in proper format(dd/MM/yy HH:mm) (E.g 12/10/10 12:00)]");

									insertFlag = true;

								}
							}catch(Exception e)
							{
								dispdata.setDate(" Error:Date & Time Should be in proper format(dd/MM/yy HH:mm) (E.g 12/10/10 12:00)]");
								insertFlag = true;
							}

							break;
						}
						case 20 :
						{

							try
							{
								HSSFRichTextString delayrsn = cell.getRichStringCellValue ();
								String var= delayrsn.toString();
								dispdata.setLoadDelayReason(var);
								System.out.println("Delay reason"+delayrsn);
								if(var.length()>0)
								{
									valid.setLoadDelayReason(var);
									//	System.out.println("valid "+var);
								}
								else
								{
									invaliddata.setLoadDelayReason("Error "+var);
									dispdata.setLoadDelayReason(var+"[Error:this field cannot contain value other than alphabets]");
									insertFlag = true;
								}
							}catch(Exception e)
							{
								dispdata.setLoadDelayReason("Error: delay reason field should contain value in alphabets only");
								insertFlag = true;
							}


							break;
						}
						case 21:
						{

							try
							{
								HSSFRichTextString cmt = cell.getRichStringCellValue ();
								String var= cmt.toString();
								dispdata.setComment(var);
								System.out.println("setComment"+cmt);
								if(var.length()>0)
								{
									valid.setComment(var);
								}
								else
								{
									invaliddata.setComment("Error "+var);
									dispdata.setComment(var+"[Error:Comment cannot contain value other than alphabets]");
									insertFlag = true;
								}
							}catch(Exception e)
							{
								dispdata.setComment("Error:Comment should contain value in alphabets only");
								insertFlag = true;
							}
							break;
						}

						default :
						{
							try{
								System.out.println ("Wrong value not numeric: " + cell.getNumericCellValue ());
							}catch(Exception e)
							{
								//insertFlag = true;
							}
							//insertFlag = true;
							break;
						}
						}//switch end




					}//cell end

					if (insertFlag!=true){

						try{
						String Tripid="",ReportDateTime=null,LoadDelayReason="",Comment="",ETA=null,Date=null,StTime=null,VehNo=null,Transport="",TripFrom="",TripTo="",Vendor=null,DriverID1=null,Drivername1=null,DriverID2=null,Drivername2=null;
						double Weight=0.0;
						String triptype="",fxtime="";
						int advanace=0,frieght=0,fxkm=0;
						validList.add(valid); 
						java.util.Date d12=new java.util.Date();  	
						Format frt2=new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
						String now= frt2.format(d12);
						getnewConnection();


						//ArrayList<ValidData> validList= new ArrayList<ValidData>();
						Iterator<ValidData> itr = validList.iterator();
						while (itr.hasNext()) {
							ValidData element = itr.next();

							/*System.out.print("valid Data");
						 System.out.print(element.getSrNo());
						 System.out.print(element.getTripID());
						 System.out.print(element.getDate());
						 System.out.print(element.getVehNo());
						 System.out.print(element.getTransport());
						 System.out.print(element.getTripFrom());
						 System.out.print(element.getTripTo());
						 System.out.print(element.getDriverID1());
						 System.out.print(element.getDriverName1());
						 System.out.print(element.getDriverID2());
						 System.out.print(element.getDriverName2());*/


							Tripid=element.getTripID();
							VehNo=element.getVehNo();
							Transport=element.getTransport();
							TripFrom=element.getTripFrom();
							TripTo=element.getTripTo();
							DriverID1=element.getDriverID1();
							Drivername1=element.getDriverName1();
							DriverID2=element.getDriverID2();
							Drivername2=element.getDriverName2();
							Date=element.getDate();
							StTime=element.getTime();
							ETA=element.getETA();
							ReportDateTime=element.getReportDateTime();
							LoadDelayReason=element.getLoadDelayReason();
							Comment=element.getComment();
							Vendor=element.getVendor();
							Weight=element.getWeight();

							triptype=element.getTriptype();
							advanace=element.getAdvance();
							frieght=element.getFrieght();
							fxkm=element.getFxkm();
							fxtime=element.getFxtime();

							System.out.println("Vendor"+Vendor);
						}
						System.out.println("trip type------>"+triptype);
						System.out.println("Advance "+advanace);
						System.out.println("fr"+frieght);
						System.out.println("Fxkm "+fxkm);
						System.out.println("Fxtime"+fxtime);
						System.out.println("fr"+frieght);
						System.out.println("ReportDateTime "+ReportDateTime);
						System.out.println("LoadDelayReason"+LoadDelayReason);
						System.out.println("Comment"+Comment);
						//------------------------------------------------
						String transporter=null;
						if(Transport.contains("(") ||Transport.contains(")"))
						{
							transporter=Transport;
						}
						else
						{
							transporter=Transport;
						}
						System.out.println("transporter"+transporter);
						//-------------------------------------
						//-------------------------------Vendor-----------------
						String ven=null;
						if(null== Vendor ||  "".equalsIgnoreCase(Vendor)||"null".equalsIgnoreCase(Vendor)||"-".equalsIgnoreCase(Vendor))
						{
							ven="-";
						}
						else
						{
							ven=Vendor;
						}
						System.out.println("ven"+ven);											
						//------------------------------------TripType-------------------------------------
								
						String category=null;
						if(null== triptype ||  "".equalsIgnoreCase(triptype)||"null".equalsIgnoreCase(triptype)||"-".equalsIgnoreCase(triptype))
						{
							category="-";
						}
						else
						{
							category=triptype;
						}
						System.out.println("category"+category);
						//-------------------------------Advance------------------------------------------------------
						
						String adv="0"+ advanace;
						System.out.println(adv);
						//if(advanace<0)
						//{
						//	adv=0;
						//}
						//else
					//	{
					//		adv=advanace;
						//}
						//-----------------------------------------------------------------------------------------
						
						//-----------------------------------LoadDelayreason------------------------------------------------
						
						String delayrsn=null;
						if(null== delayrsn ||  "".equalsIgnoreCase(delayrsn)||"null".equalsIgnoreCase(delayrsn)|| "-".equalsIgnoreCase(delayrsn))
						{
							delayrsn="-";
						}
						else
						{
							delayrsn=LoadDelayReason;
						}
						System.out.println("delayrsn"+delayrsn);			
						//----------------------------------------------------------------------------------------------------
						
						
						//-------------------------------------------Comments--------------------------------------
						String cmmt=null;
						if(null== cmmt ||  "".equalsIgnoreCase(cmmt)||"null".equalsIgnoreCase(cmmt)|| "-".equalsIgnoreCase(cmmt))
						{
							cmmt="-";
						}
						else
						{
							cmmt=Comment;
						}
						System.out.println("cmmt"+cmmt);
						//-------------------------------------------------------------------------------------------------------
						
						//----------------- Concat Driver ID and Driver Name-----------------------
						String DriverID=null,DriverName=null;
						if(null== DriverID2 || "".equalsIgnoreCase(DriverID2)||"null".equalsIgnoreCase(DriverID2))
						{
							DriverID=DriverID1;
						}
						else if(null== DriverID2 ||  "".equalsIgnoreCase(DriverID2)||"null".equalsIgnoreCase(DriverID2))			
						{
							DriverID=DriverID2;
						}
						else
						{
							DriverID=DriverID1+"-"+DriverID2;
						}
						System.out.println("DriverID"+DriverID);
						//------------------------- DriverName---------------

						if("".equalsIgnoreCase(Drivername2) || null==Drivername2||"null".equalsIgnoreCase(Drivername2))
						{
							DriverName=Drivername1;
						}
						else if("".equalsIgnoreCase(Drivername1) || null==Drivername1||"null".equalsIgnoreCase(Drivername1))
							DriverName=Drivername2;
						else
							DriverName=Drivername1+"-"+Drivername2;



						//-------------------------------------------------------------------------------- 

						//---------------------------- Trip Date and Time--------------------------
						String startDate =null,Time=null;
						if(Date!=null)
						{

							startDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yy").parse(Date));
						}
						if(StTime!=null)
						{					   
							Time=new SimpleDateFormat("HH:mm:ss").format(new SimpleDateFormat("HH:mm:ss").parse(StTime));
						}
						//------------------------------------------------------------------------------
						
						
						//---------------------------Report Date time----------------------------------
						String reportdttime="0000-00-00 00:00:00";
						if(ReportDateTime!=null)
						{

							reportdttime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("dd-MMM-yy HH:mm:ss").parse(ReportDateTime));
						}
						
						//--------------------------------------------------------------------------------------------------
												
						//------------------- ETA------------------------------

						String ETADate="0000-00-00 00:00:00";
						if(ETA!=null)
						{		     

							ETADate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("dd-MMM-yy HH:mm:ss").parse(ETA));

						}

						System.out.println("ETADate"+ETADate);
						//--------------------------------------------------------------------------------------

						// String str="insert into t_startedjourney(TripID,VehRegNo,StartPlace,EndPlace,StartDate,StartTime,DriverCode,DriverName,OwnerName) values(?,?,?,?,?,?,?,?,?)";


						//-------------------------------- Get Vehicle code  -----------------------

						//=con.createStatement();
						String s="Select TripID from t_startedjourney where TripID='"+Tripid+"'";
						System.out.println("Str"+s);
						rs=stmt2.executeQuery(s);
						if(rs.next())
						{
							dispdata.setTripID(Tripid+" [Error: Duplicate Entry for Trip ID , Please Enter TripID in this format yymmddvrgnostateno(E.g 1012240358AP)]");
							insertFlag=true;
						}
						else{
							int vehcode=0;

						//	stmt1=con.createStatement();
							String str="Select VehicleCode,Status from t_vehicledetails where VehicleRegNumber='"+VehNo+"' and status='-'";
							System.out.println("Str"+str);
							rs=stmt1.executeQuery(str);

							if(rs.next())
							{

								vehcode=rs.getInt(1);


								//----------------- if vehreg no matches with veh code insert the record into database-----------------------

								try{
									
									String str1="insert into t_startedjourney(TripID,Vehid,VehRegNo,StartPlace,EndPlace,StartDate,StartTime,ETA,DriverCode,DriverName,OwnerName,EndedBy,Weight,Vendor,TripCategory,Advance,Frieght,FIxedKM,	FIxedTime,ReportDateTime,Loadreason,Loadcomments,StartCode,EndCode,GPName) values('"+Tripid+"',"+vehcode+",'"+VehNo+"','"+TripFrom+"','"+TripTo+"','"+startDate+"','"+Time+"','"+ETADate+"','"+DriverID+"','"+DriverName+"','"+transporter+"','"+username+"','"+Weight+"','"+ven+"','"+category+"','"+advanace+"','"+frieght+"','"+fxkm+"','"+fxtime+"','"+reportdttime+"','"+delayrsn+"','"+cmmt+"','"+TripFrom+"','"+TripTo+"','"+transporter+"')";
									System.out.println(str1);
									stmt.executeUpdate(str1);
									String abc1=str1.replace("'", "#");
									abc1=abc1.replace(",", "$");
									String str3="insert into t_sqlquery(dbname,query)values('db_gps','"+abc1+"')";	
									System.out.println("t_sqlquery >>>>>>>"+str3);
									stn3.executeUpdate(str3);
									/* Add new code as per new requirement 2010-12-27*/
									///added check to update the previously open trips status to tobeclosed
									String upst="select TripID from t_startedjourney where VehRegNo='"+VehNo+"' and Jstatus='Running' " +
											"and concat(startdate,' ',starttime)<'"+startDate+" "+Time+"' order by " +
													"startdate,starttime desc";
									System.out.println("upst...status"+upst);
									ResultSet uprs=stn3.executeQuery(upst);
									while(uprs.next())
									{
										String tpid=uprs.getString("TripID");
										System.out.println("TripID"+tpid);
										
										String update="update t_startedjourney set JStatus='tobeclosed' where VehRegNo='"+VehNo+"' and TripId='"+tpid+"'";
										stmt3.executeUpdate(update);
										System.out.println("upst...status update"+update);
										String abc3u=update.replace("'", "#");
										abc3u=abc3u.replace(",", "$");
										String str5u="insert into t_sqlquery(dbname,query)values('db_gps','"+abc3u+"')";	
										
										stmt2.executeUpdate(str5u);

									}

									
									
									if(DriverID1.length()>1)
									{
										String oenerdriv="";
										String driv="select * from t_drivers where DriverID='"+DriverID1+"'";
										System.out.println("upst...driver"+driv);


										ResultSet rsdriv=stmt10.executeQuery(driv);

										if(rsdriv.next())
										{
											oenerdriv=rsdriv.getString("Owner");

											if(!oenerdriv.equalsIgnoreCase(transporter))
											{
												String dpdiv="update t_drivers Set Owner='"+transporter+"' where DriverID='"+DriverID1+"',EntryBy='JD',UpdatedDtTime ='"+now+"'";
												System.out.println("upst...driver update"+dpdiv);
												stmt2.executeUpdate(dpdiv); 



												String abc3u1=dpdiv.replace("'", "#");
												abc3u1=abc3u1.replace(",", "$");

												String str5u1="insert into t_sqlquery(dbname,query)values('db_gps','"+abc3u1+"')";	
												stmt3.executeUpdate(str5u1);

											}
											System.out.println("out of driver update tans!owner");
										}
										else
										{

											String insdiv="insert into t_drivers(DriverID,DriverName,Owner,Entryby)values('"+DriverID1+"','"+Drivername1+"','"+transporter+"','Bulk Trip UPload')";
											System.out.println("insert...driver"+insdiv);
											stmt4.executeUpdate(insdiv);


											String abc3u1=insdiv.replace("'", "#");
											abc3u1=abc3u1.replace(",", "$");

											String str5u1="insert into t_sqlquery(dbname,query)values('db_gps','"+abc3u1+"')";	
											stmt3.executeUpdate(str5u1);

										}


									}
									else if(DriverID2.length()==0)
									{
									
									}
									else if(DriverID2.length()>1)
									{
										String oenerdriv="";
										String driv="select * from t_drivers where DriverID='"+DriverID2+"'";
										System.out.println("upst...driver"+driv);


										ResultSet rsdriv=stmt1.executeQuery(driv);

										if(rsdriv.next())
										{
											System.out.println("*************************** inside b4 ownername ");

											oenerdriv=rsdriv.getString("Owner");
System.out.println("*************************** inside "+oenerdriv);
											if(!oenerdriv.equalsIgnoreCase(transporter))
											{
												System.out.println("*************************** inside owner != trans"+oenerdriv);

												String dpdiv="update t_drivers Set Owner='"+transporter+"' where DriverID='"+DriverID2+"'";
												System.out.println("upst...driver update"+dpdiv);
												stmt2.executeUpdate(dpdiv); 

												String abc3u1=dpdiv.replace("'", "#");
												abc3u1=abc3u1.replace(",", "$");

												String str5u1="insert into t_sqlquery(dbname,query)values('db_gps','"+abc3u1+"')";	
												stmt3.executeUpdate(str5u1);

											}

										}
										else
										{

											String insdiv="insert into t_drivers(DriverID,DriverName,Owner,EntryBy)values('"+DriverID2+"','"+Drivername2+"','"+transporter+"','Bulk Trip UPload')";
											System.out.println("insert...driver"+insdiv);
											stmt4.executeUpdate(insdiv);


											String abc3u1=insdiv.replace("'", "#");
											abc3u1=abc3u1.replace(",", "$");

											String str5u1="insert into t_sqlquery(dbname,query)values('db_gps','"+abc3u1+"')";	
											stmt3.executeUpdate(str5u1);

										}


									}



								}
								catch(com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e)
								{
									dispdata.setTripID("Error: Duplicate entry for Trip ID- "+Tripid);
									insertFlag=true;
								}



							}
							else
							{
								dispdata.setVehNo(VehNo+" [Error: Veh No is not register]");
								insertFlag=true;
							}

						}


					}catch(Exception e){
						
					}
						//----------------------------------------------------------------------------------
					}
					if(insertFlag==true)
					{
System.out.println("in insert flag == true**********************************************************");

						String Tripid=null,Date=null,StTime=null,VehNo=null,Transport=null,TripFrom=null,TripTo=null,DriverID1=null,Drivername1=null,DriverID2=null,Drivername2=null,weight=null,vendor=null,ReportDateTime=null,LoadDelayReason=null,Comment=null;
						int advanace=0,frieght=0,fxkm=0;
						invalidList.add(invaliddata);
						dispList.add(dispdata);
						validList.add(valid);
						//getConnection();

						Iterator<InvalidData> itrr1 = invalidList.iterator();

						Iterator<ValidData> itr = validList.iterator();

						Iterator<DisplayData> ditr = dispList.iterator();

						System.out.println("B4 While*************************************************************");

						while (ditr.hasNext()) {
							DisplayData element = ditr.next();
							System.out.println("************************************************inside while ");

							/*System.out.print("Display Data");
						 System.out.print(element.getSrNo());
						 System.out.print(element.getTripID());
						 System.out.print(element.getDate());
						 System.out.print(element.getVehNo());
						 System.out.print(element.getTransport());
						 System.out.print(element.getTripFrom());
						 System.out.print(element.getTripTo());
						 System.out.print(element.getDriverID1());
						 System.out.print(element.getDriverName1());
						 System.out.print(element.getDriverID2());
						 System.out.print(element.getDriverName2());*/
						}
						//System.out.print("Invalid Data"+element + " ");

						/*while (itrr1.hasNext()) {
						 InvalidData element = itrr1.next();


						 System.out.print(element.getSrNo());
						 System.out.print(element.getTripID());
						 System.out.print(element.getDate());
						 System.out.print(element.getVehNo());
						 System.out.print(element.getTransport());
						 System.out.print(element.getTripFrom());
						 System.out.print(element.getTripTo());
						 System.out.print(element.getDriverID1());
						 System.out.print(element.getDriverName1());
						 System.out.print(element.getDriverID2());
						 System.out.print(element.getDriverName2());
					      //System.out.print("Invalid Data"+element + " ");

						 Tripid=element.getTripID();

						 VehNo=element.getVehNo();
						 Transport=element.getTransport();
						 TripFrom=element.getTripFrom();
						 TripTo=element.getTripTo();
						 DriverID1=element.getDriverID1();
						 Drivername1=element.getDriverName1();
						 DriverID2=element.getDriverID2();
						 Drivername2=element.getDriverName2();
						 Date=element.getDate();
						 StTime=element.getTime();
					}*/

						/*while (itr.hasNext()) {
						 ValidData element1 = itr.next(); 

					if(Tripid!=null)
					{
						dispdata.setTripID(Tripid);
					} 
					else
					{
						Tripid=element1.getTripID();
						dispdata.setTripID(Tripid);
					}
					 }*/

						//---------------Code for insertion of record in database----------------------- 

						//String DriverID=DriverID1+" And "+DriverID2;
						// String DriverName=Drivername1+" And "+Drivername2;

						/*String StartDt=null,StartTime=null;

						 StringTokenizer st = new StringTokenizer(Date);
					     while (st.hasMoreTokens()) {
					         StartDt=st.nextToken();
					         StartTime=st.nextToken();
					     }*/

						/* String startDate =null,Time=null;
						 if(Date!=null && StTime!=null)
						 {
							 try
							 {
					     startDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yy").parse(Date));

					     Time=new SimpleDateFormat("HH:MM:SS").format(new SimpleDateFormat("HH:MM:SS").parse(StTime));

						 }catch(Exception e)
						 {

						 }
						 }
					    // String str="insert into t_startedjourney(TripID,VehRegNo,StartPlace,EndPlace,StartDate,StartTime,DriverCode,DriverName,OwnerName) values(?,?,?,?,?,?,?,?,?)";
						/* 
					     stmt=conn.createStatement();
					    String str1="insert into t_startedjourney(TripID,VehRegNo,StartPlace,EndPlace,StartDate,StartTime,DriverCode,DriverName,OwnerName) values('"+Tripid+"','"+VehNo+"','"+TripFrom+"','"+TripTo+"','"+startDate+"','"+Time+"','"+DriverID+"','"+DriverName+"','"+Transport+"')";

					     stmt.executeUpdate(str1);

					    /* 	 ps=conn.prepareStatement(str);
							 ps.setString(0, Tripid);
							 ps.setString(1,VehNo);
							 ps.setString(2,TripFrom);
							 ps.setString(3,TripTo);
							 ps.setString(4,startDate);
							 ps.setString(5, Time);
							 ps.setString(6, DriverID);
							 ps.setString(7,DriverName);
							 ps.setString(8, Transport);*/

						// System.out.println("Query Executed");
						//ps.executeUpdate();
						System.out.println("***************************************outside while");

					}
				}// End of if row 0 end
			}//End of while -row end
		}
		catch (IOException e)
		{
			e.printStackTrace ();
		}
		catch(OfficeXmlFileException e)
		{
			e.printStackTrace();

		}
	
		if(!(validList.isEmpty()))
		{
			/*ManageCustomers cust = new ManageCustomers(); 
			flag = cust.insertCorpEmp(corp,validList);
			if(flag.equalsIgnoreCase("true"))
				return flag;*/

		}

		return dispList;
	}


	private String validateString(String var) {
		String FlagOK="false";
		String str=var;
		for(int i=0;i<str.length();i++)
		{
			FlagOK="false";
			//if(var.charAt(i)>=65 && var.charAt(i)<=90 || var.charAt(i)>=97 && var.charAt(i)<=122 || var.charAt(i)>=48 && var.charAt(i)<=57)
			if (Character.isLetterOrDigit(var.charAt(i)) || Character.isWhitespace(var.charAt(i)))
			{
				FlagOK="true";

			}
			else
				break;

		}

		return FlagOK;
	}

	private String validateName(String var) {
		String FlagOK="false";
		String str=var;
		for(int i=0;i<str.length();i++)
		{
			FlagOK="false";
			//if(var.charAt(i)>=65 && var.charAt(i)<=90 || var.charAt(i)>=97 && var.charAt(i)<=122 || var.charAt(i)>=48 && var.charAt(i)<=57)
			if (Character.isLetter(var.charAt(i)) || Character.isWhitespace(var.charAt(i)))
			{
				FlagOK="true";
			}
			
		}
		return FlagOK;
	}

	public String validate(String regex,String var)
	{  String msg="false";
	Pattern p=Pattern.compile(regex);
	Matcher m=p.matcher(var);
	boolean b=m.matches();
	if(b==true)
	{
		msg="true";
	}
	else
	{
		msg="false";
	}


	return msg;
	}
	/*switch (cell.getCellType ()){

			case HSSFCell.CELL_TYPE_NUMERIC :
			{
				//checking data types of cells


				/*if(cell.getColumnIndex() == 0 || cell.getColumnIndex() == 1 || cell.getColumnIndex() == 2
						|| cell.getColumnIndex() == 2 ||  cell.getColumnIndex() == 3 || cell.getColumnIndex() == 3
						|| cell.getColumnIndex() == 2 ||  cell.getColumnIndex() == 3 || cell.getColumnIndex() == 3
						|| cell.getColumnIndex() == 2 ||  cell.getColumnIndex() == 3 || cell.getColumnIndex() == 3){
					System.out.println ("Wrong value not numeric: " + cell.getNumericCellValue ());
					insertFlag = true;
				}else{
					if(cell.getColumnIndex()==4){
						double d = cell.getNumericCellValue();
						if(HSSFDateUtil.isValidExcelDate(d)){
							System.out.println(HSSFDateUtil.getJavaDate(d));
							String datef=new SimpleDateFormat("yyyy-MM-dd").format(HSSFDateUtil.getJavaDate(d));
							System.out.println(datef);
							}
					}else{
						System.out.println ("Numeric value: " + cell.getNumericCellValue ());
					}
				}
				break;
			}
			case HSSFCell.CELL_TYPE_STRING :
			{
				if(cell.getColumnIndex() == 3){
					System.out.println ("Wrong value not string: " + cell.getRichStringCellValue ());
					insertFlag = true;
				}else{

					// cell type string.
					HSSFRichTextString richTextString = cell.getRichStringCellValue ();

					System.out.println ("String value: " + richTextString.getString ());
				}
				break;
			}

			default :
			{

				// types other than String and Numeric.
				System.out.println ("Type not supported.");

				break;
			}
			} */



}		

