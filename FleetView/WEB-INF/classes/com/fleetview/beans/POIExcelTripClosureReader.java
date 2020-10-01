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

import javax.mail.Session;
import javax.servlet.http.HttpSession;


import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.OfficeXmlFileException;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.util.NumberToTextConverter;



import com.fleetview.beans.InvalidData;
import com.fleetview.beans.ValidData;
import com.mysql.jdbc.exceptions.MySQLIntegrityConstraintViolationException;

public class POIExcelTripClosureReader {

	Connection conn=null,con=null; 
	PreparedStatement ps=null;
	Statement stmt=null,stmt1=null,stmt2=null,stn3=null,stmt3=null,stmt4=null,stmt10=null;
	ResultSet rs=null;

	/** Creates a new instance of POIExcelReader */
	public POIExcelTripClosureReader ()
	{}

	/**
	 * This method is used to display the Excel content to command line.
	 *
	 * @param xlsPath
	 */
	@SuppressWarnings ({ "unchecked", "deprecation" })

	private void getnewConnection() throws ClassNotFoundException, SQLException{
		String MM_dbConn_DRIVER="org.gjt.mm.mysql.Driver";
		String MM_dbConn_USERNAME="fleetview";
		String MM_dbConn_PASSWORD="1@flv";
		String MM_dbConn_STRING="jdbc:mysql://localhost/db_gps";
		Class.forName(MM_dbConn_DRIVER);
		con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		stmt1=con.createStatement();stmt=con.createStatement();stn3=con.createStatement();
	}

/*	private void getnewConnection() throws ClassNotFoundException, SQLException{
		String MM_dbConn_DRIVER="org.gjt.mm.mysql.Driver";
		String MM_dbConn_USERNAME="fleetview";
		String MM_dbConn_PASSWORD="1@flv";
		String MM_dbConn_STRING="jdbc:mysql://localhost/db_gps";
		Class.forName(MM_dbConn_DRIVER);
		con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

	}*/

	public ArrayList<TripClosureData> displayFromExcel (String xlsPath,String user,String usertypevalue) throws ClassNotFoundException, SQLException, ParseException,OfficeXmlFileException
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
		ValidTripClosureData valid = null;
		InvalidTripClosureData invaliddata =null;
		TripClosureData dispdata=null;

		String username=user;
		ArrayList<ValidTripClosureData> validList= new ArrayList<ValidTripClosureData>();
		ArrayList<InvalidTripClosureData> invalidList= new ArrayList<InvalidTripClosureData>();
		ArrayList<TripClosureData> dispList= new ArrayList<TripClosureData>();
		String 	flag="false";
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
				valid = new ValidTripClosureData();
				invaliddata = new InvalidTripClosureData();
				dispdata=new TripClosureData();
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
									String sqlchk="Select * from db_gps.t_startedjourney where Tripid ='"+var+"' ";
									ResultSet rstchk=stmt.executeQuery(sqlchk);
									if(rstchk.next()){
										valid.setTripID(var);
									}
									else{
										invaliddata.setTripID("Error "+var);
										dispdata.setTripID(var+" [Error: Not a valid Trip Id(Entry for Trip Load not done for this trip id.) ]");
										insertFlag = true;
									}
									valid.setTripID(var);


									//System.out.println("valid "+var);
								}

								else
								{
									invaliddata.setTripID("Error "+var);
									dispdata.setTripID(var+" [Error: Not a valid Trip Id(Entry for Trip Load not done for this trip id.) ]");
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
									dispdata.setTripID(var+" [Error: Not a valid Trip Id(Entry for Trip Load not done for this trip id.) ]");
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
							break;
						}

						case 3:
						{
							try{
								HSSFRichTextString  tripenddttime = cell.getRichStringCellValue ();
								String var= tripenddttime.toString();

								Date enddate=null;
								Boolean Flag=false;

								try{
									enddate=new SimpleDateFormat("dd-MMM-yy HH:mm:ss").parse(new SimpleDateFormat("dd-MMM-yy HH:mm:ss").format(new SimpleDateFormat("dd/MM/yy HH:mm").parse(var))) ;
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
								String TripenddtTime=null;
								TripenddtTime=new SimpleDateFormat("dd-MMM-yy HH:mm:ss").format(enddate);

								dispdata.setTripEndDate(TripenddtTime);



								if(Flag==true)
								{

									valid.setTripEndDate(TripenddtTime);
									//valid.setTime(StartTime);


								}
								else
								{
									invaliddata.setTripEndDate("Error "+TripenddtTime);
									//invaliddata.setTime("Error" +StartTime);
									dispdata.setTripEndDate(var+" [Error:Date & Time Should be in proper format(dd/MM/yy HH:mm) (E.g 12/10/10 12:00)]");

									insertFlag = true;

								}
							}catch(Exception e)
							{
								dispdata.setDate(" Error:Date & Time Should be in proper format(dd/MM/yy HH:mm) (E.g 12/10/10 12:00)]");
								insertFlag = true;
							}



							break;
						}
						case 4:
						{  //setUnloadDate
							try{
								HSSFRichTextString  unloaddatetime = cell.getRichStringCellValue ();
								String var= unloaddatetime.toString();

								Date unloadDate=null;
								Boolean Flag=false;

								try{
									unloadDate=new SimpleDateFormat("dd-MMM-yy HH:mm:ss").parse(new SimpleDateFormat("dd-MMM-yy HH:mm:ss").format(new SimpleDateFormat("dd/MM/yy HH:mm").parse(var))) ;
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
								String unloadDateTime=null;
								unloadDateTime=new SimpleDateFormat("dd-MMM-yy HH:mm:ss").format(unloadDate);

								dispdata.setUnloadDate(unloadDateTime);



								if(Flag==true)
								{

									valid.setUnloadDate(unloadDateTime);
									//valid.setTime(StartTime);


								}
								else
								{
									invaliddata.setUnloadDate("Error "+unloadDateTime);
									//invaliddata.setTime("Error" +StartTime);
									dispdata.setUnloadDate(var+" [Error:Date & Time Should be in proper format(dd/MM/yy HH:mm) (E.g 12/10/10 12:00)]");

									insertFlag = true;

								}
							}catch(Exception e)
							{
								dispdata.setDate(" Error:Date & Time Should be in proper format(dd/MM/yy HH:mm) (E.g 12/10/10 12:00)]");
								insertFlag = true;
							}

							break;
						}
						case 5 :
						{

							try
							{
								//setUnloadDelayReason
								HSSFRichTextString delayrsn = cell.getRichStringCellValue ();
								String var= delayrsn.toString();
								dispdata.setUnloadDelayReason(var);
								String msg=null;
								System.out.println("Delay reason"+delayrsn);
								if(var.length()>0)
								{

									msg=validateName(var.trim());

								}
								if(msg=="true")
								{

									valid.setUnloadDelayReason(var);

									//	System.out.println("valid "+var);
								}

								else
								{
									invaliddata.setUnloadDelayReason("Error "+var);
									dispdata.setUnloadDelayReason(var+"[Error:this field cannot contain value other than alphabets]");
									insertFlag = true;
								}
							}catch(Exception e)
							{
								dispdata.setUnloadDelayReason("Error: delay reason field should contain value in alphabets only");
								insertFlag = true;
							}


							break;
						}
						case 6:
						{

							try
							{
								HSSFRichTextString cmt = cell.getRichStringCellValue ();
								String var= cmt.toString();
								dispdata.setRemark(var);
								String msg=null;
								System.out.println("setRemark"+cmt);
								if(var.length()>0)
								{

									msg=validateName(var.trim());

								}
								if(msg=="true")
								{

									valid.setRemark(var);

									//	System.out.println("valid "+var);
								}

								else
								{
									invaliddata.setRemark("Error "+var);
									dispdata.setRemark(var+"[Error:Remark cannot contain value other than alphabets]");
									insertFlag = true;
								}
							}catch(Exception e)
							{
								dispdata.setRemark("Error: Remark should contain value in alphabets only");
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
							String TripID="",UnloadDate=null,UnloadDelayReason="",Remark="",vehno=null,Transporter="",Uploadedby="",TripEndDate="";


							validList.add(valid); 
							java.util.Date d12=new java.util.Date();  	
							Format frt2=new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
							String now= frt2.format(d12);
							getnewConnection();


							//ArrayList<ValidData> validList= new ArrayList<ValidData>();
							Iterator<ValidTripClosureData> itr = validList.iterator();
							while (itr.hasNext()) {
								ValidTripClosureData element = itr.next();

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


								TripID=element.getTripID();
								vehno=element.getVehNo();
								TripEndDate=element.getTripEndDate();
								UnloadDate=element.getUnloadDate();
								UnloadDelayReason=element.getUnloadDelayReason();
								Remark=element.getRemark();
								Transporter=usertypevalue;
								Uploadedby=user;



							}
							System.out.println("TripID------>"+TripID);
							System.out.println("vehno--?> "+vehno);
							System.out.println("TripEndDate==>"+TripEndDate);
							System.out.println("UnloadDate==> "+UnloadDate);
							System.out.println("UnloadDelayReason==>"+UnloadDelayReason);
							System.out.println("Remark==>"+Remark);
							System.out.println("Transporter==> "+Transporter);
							System.out.println("Uploadedby==>"+Uploadedby);

							//-----------------------------------validation for tripid--------------------------------------------------------------------------		
						/*	try
							{
								dispdata.setTripID(TripID);
								boolean FlagOK=false;
								System.out.println("TripID====>"+TripID);
								if(TripID.length()>0)
								{
									valid.setTripID(TripID);
								}
								else
								{
									invaliddata.setTripID("Error "+TripID);
									dispdata.setTripID(TripID+" [Error: Trip Id cannot contain value other than digits and alphabets]");
									insertFlag = true;
								}
							}catch(Exception e)
							{
								dispdata.setTripID(TripID);
								String regex ="^.*[0-9].*$";
								String msg=validate(regex,TripID.trim());
								if(msg=="true")
								{
									valid.setTripID(TripID);
								}
								else
								{
									invaliddata.setTripID("Error "+TripID);
									dispdata.setTripID(TripID+" [Error:'int'Trip Id cannot contain value other than digits and alphabets]");
									insertFlag = true;
								}	
							}

							//---------------------------------------------------------------------------------------------------------------------------------
							String endDate1=null;String endDt=null,endTime=null;
							try {
								String dt=TripEndDate.replace("\"", "");
								Boolean Flag=false;
								try{
									endDate1=new SimpleDateFormat("dd-MMM-yy HH:mm:ss").format(new SimpleDateFormat("dd/MM/yy HH:mm").parse(dt));
									Flag=true;
								}catch(Exception e){
									Flag=false;
								}
								StringTokenizer stt = new StringTokenizer(endDate1);
								System.out.println("st----->"+stt);
								while (stt.hasMoreTokens()) {
									endDt=stt.nextToken();
									endTime=stt.nextToken();
								}
								dispdata.setTripEndDate(endDate1);
								if(Flag==true)
								{
									valid.setDate(endDt);
									valid.setTime(endTime);
								}
								else
								{
									invaliddata.setTripEndDate("Error "+endDate1);
									dispdata.setTripEndDate(endDate1+" [Error:Date & Time Should be in proper format(dd/MM/yy HH:mm) (E.g 12/11/10 12:00)]");
									insertFlag = true;
								}
							} catch (Exception e) {
								dispdata.setTripEndDate(" Error:Date & Time Should be in proper format(dd/MM/yy HH:mm) (E.g 12/11/10 12:00)");
								insertFlag = true;
							}
							//=----------------------------------vahicleno-----------------------------------------------------------------------------------------------		
							try{
								dispdata.setVehNo(vehno);
								String msg=null;
								if(vehno.length()>0)
								{
									msg=validateString(vehno.trim());
								}
								if(msg=="true")
								{
									valid.setVehNo(vehno);
									System.out.println("valid "+vehno);
								}
								else
								{
									invaliddata.setVehNo("Error "+vehno);
									dispdata.setVehNo(vehno+"[Error: Veh.No cannot contain value other than alphabets and digits]");
									insertFlag = true;
								}
							}catch(Exception e){
								dispdata.setVehNo(vehno);
								String regex ="^.*[0-9].*$";
								String msg=validate(regex,vehno.trim());
								if(msg=="true")
								{
									//	valid.setVehNo(vehno);
								}
								else
								{
									//	invaliddata.setVehNo("Error "+vehno);
									dispdata.setVehNo("Error: Veh.No should contain value in alphabets and digits only");
									insertFlag = true;
								}
							}*/

							//-------------------------------------UnloadDateTime----------------------------------------------------------------------------
							String unloaddttime="0000-00-00 00:00:00";
							System.out.println("UnloadDate===>"+UnloadDate);
							if(UnloadDate!=null)
							{

								unloaddttime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("dd-MMM-yy HH:mm:ss").parse(UnloadDate));
							}
							
							
							//------------------------------------------------------------------------------------------------------------------//
							String tripenddttime="0000-00-00 00:00:00";
							System.out.println("TripEndDate===>"+TripEndDate);
							if(TripEndDate!=null)
							{

								tripenddttime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("dd-MMM-yy HH:mm:ss").parse(TripEndDate));
							}
		
							
							//-----------------------------------------------Delay Load reason---------------------------------------------------------------
							try
							{
								dispdata.setUnloadDelayReason(UnloadDelayReason);
								String msg=null;
								System.out.println("Delay reason"+UnloadDelayReason);
								if(UnloadDelayReason.length()>0)
								{
									msg=validateString(UnloadDelayReason.trim());
								}
								if(msg=="true")
								{
									valid.setUnloadDelayReason(UnloadDelayReason);
								}
								else
								{
									invaliddata.setUnloadDelayReason("Error "+UnloadDelayReason);
									dispdata.setUnloadDelayReason(UnloadDelayReason+"[Error:this field cannot contain value other than alphabets]");
									insertFlag = true;
								}
							}catch(Exception e)
							{
								dispdata.setUnloadDelayReason("Error: unload reason field should contain value in alphabets only");
								insertFlag = true;
							}
							//-----------------------------------------------Comment-------------------------------------------------------------------------
							try
							{
								dispdata.setRemark(Remark);
								String msg=null;
								System.out.println("Remark"+Remark);
								if(Remark.length()>0)
								{
									msg=validateString(Remark.trim());
								}
								if(msg=="true")
								{
									valid.setRemark(Remark);
								}
								else
								{
									invaliddata.setRemark("Error "+Remark);
									dispdata.setRemark(Remark+"[Error: Remark cannot contain value other than alphabets]");
									insertFlag = true;
								}
							}catch(Exception e)
							{
								dispdata.setRemark("Error:Remark should contain value in alphabets only");
								insertFlag = true;
							}

			
							/*******************Transporter***************************************/
							Transporter=usertypevalue;
							Uploadedby=user;
							//-------------------------------- Get Vehicle code  -----------------------

							//stmt1=con.createStatement();stmt=con.createStatement();stn3=con.createStatement();
							
							////Commented the
							/*String s="Select TripID from t_TripClosureData where TripID='"+TripID+"'";
							System.out.println("Str"+s);
							rs=stmt2.executeQuery(s);
							if(rs.next())
							{
								dispdata.setTripID(TripID+" [Error: Duplicate Entry for Trip ID ,Entry for this Trip Id has already been Processed]");
								insertFlag=true;
							}
							else{*/
								int vehcode=0;

								//stmt1=con.createStatement();
								String str="Select VehicleCode,Status from t_vehicledetails where VehicleRegNumber='"+vehno+"' and status='-'";
								System.out.println("Str"+str);
								rs=stmt1.executeQuery(str);

								if(rs.next())
								{

									vehcode=rs.getInt(1);


									//----------------- if vehreg no matches with veh code insert the record into database-----------------------

									try{
									
										String str1="insert into t_TripClosureData(TripID,Vehid,VehRegNo,Enddatetime,UnloadDatetime,unloadreason,Remark,transporter,uploadedby) values('"+TripID+"',"+vehcode+",'"+vehno+"','"+tripenddttime+"','"+unloaddttime+"','"+UnloadDelayReason+"','"+Remark+"','"+Transporter+"','"+Uploadedby+"')";
										System.out.println(str1);
										stmt.executeUpdate(str1);
										String abc1=str1.replace("'", "#");
										abc1=abc1.replace(",", "$");
										String str3="insert into t_sqlquery(dbname,query)values('db_gps','"+abc1+"')";	
										System.out.println("t_sqlquery >>>>>>>"+str3);
										stn3.executeUpdate(str3);
									}

									catch(com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e)
									{
										dispdata.setTripID("Error: Duplicate entry for Trip ID- "+TripID);
										insertFlag=true;
									}

								}
								else
								{
									dispdata.setVehNo(vehno+" [Error: Veh No is not register]");
									insertFlag=true;
								}

							//}


						}catch(Exception e){

						}
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

						Iterator<InvalidTripClosureData> itrr1 = invalidList.iterator();

						Iterator<ValidTripClosureData> itr = validList.iterator();

						Iterator<TripClosureData> ditr = dispList.iterator();

						System.out.println("B4 While*************************************************************");

						while (ditr.hasNext()) {
							TripClosureData element = ditr.next();
							System.out.println("************************************************inside while ");
						}
						System.out.println("***************************************outside while");
					}//if insertFlag==true
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
		finally{
			stmt.close();
			stmt1.close();
		//	stmt10.close();
		//	stmt2.close();
		//	stmt3.close();
			stn3.close();
			
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
}