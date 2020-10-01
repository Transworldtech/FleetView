package com.fleetview.beans;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.Format;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.poi.poifs.filesystem.OfficeXmlFileException;

public class CSVTripClosureReader {


	Connection conn=null,con=null; 
	PreparedStatement ps=null;
	Statement stmt=null,stmt1=null,stmt2=null,stn3=null,stmt3=null,stmt4=null,stmt10=null;
	ResultSet rs=null;

	/** Creates a new instance of POIExcelReader */
	public CSVTripClosureReader ()
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
		stmt=con.createStatement();
		stmt1=con.createStatement();
		stn3=con.createStatement();
	}

	/*private void getnewConnection() throws ClassNotFoundException, SQLException{
		String MM_dbConn_DRIVER="org.gjt.mm.mysql.Driver";
		String MM_dbConn_USERNAME="fleetview";
		String MM_dbConn_PASSWORD="1@flv";
		String MM_dbConn_STRING="jdbc:mysql://localhost/db_gps";
		Class.forName(MM_dbConn_DRIVER);
		con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

	}*/

	@SuppressWarnings("null")
	public ArrayList<TripClosureData> displayFromCSV (String xlsPath,String user,String usertypevalue) throws ClassNotFoundException, SQLException, ParseException,OfficeXmlFileException
	{

		System.out.println("xlspath============&>"+xlsPath);
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
		//bean for insertion
		ValidTripClosureData valid = null;
		InvalidTripClosureData invaliddata =null;
		TripClosureData dispdata=null;

		String username=user;

		ArrayList<ValidTripClosureData> validList= new ArrayList<ValidTripClosureData>();
		ArrayList<InvalidTripClosureData> invalidList= new ArrayList<InvalidTripClosureData>();
		ArrayList<TripClosureData> dispList= new ArrayList<TripClosureData>();

		String 	flag="false";
		String fileName="/home/veena/Desktop/test.csv";
		System.out.println("filename---------->"+fileName);
		try
		{

			BufferedReader br = new BufferedReader( new FileReader(xlsPath));
			String strLine = null;
			StringTokenizer st = null;
			int lineNumber = 0, tokenNumber = 0;
			while( (fileName = br.readLine()) != null)
			{
				lineNumber++;
				System.out.println("filename before replacement--->"+fileName);
				//break comma separated line using ","
				fileName=fileName.replace(",," , ",0,");
				System.out.println("filename between--->"+fileName);
				fileName=fileName.replace(",," , ",0,");
				
				System.out.println("filename after replacement-->"+fileName);
				st = new StringTokenizer(fileName, ",");
				int noOfTokens=st.countTokens();
				System.out.println("no of tokens are---->"+noOfTokens);
				while(st.hasMoreTokens())
				{
					boolean insertFlag = false;
					valid = new ValidTripClosureData();
					invaliddata = new InvalidTripClosureData();
					dispdata=new TripClosureData();
					tokenNumber++;
					String  srno=null;
					String TripID=null,TripEndDate=null,UnloadDate=null,UnloadDelayReason=null;
					String vehno=null,Remark=null;
					//String contains double cots.so they are replaced
					srno=st.nextToken().replace("\"", "");
					System.out.println("srno===>"+srno);
					TripID=st.nextToken().replace("\"", "");
					System.out.println("Tripid===>"+TripID);
					vehno=st.nextToken().replace("\"", "");
					System.out.println("vehno===>"+vehno);
					TripEndDate=st.nextToken().replace("\"", "");
					System.out.println("TripEndDate===>"+TripEndDate);
					UnloadDate=st.nextToken().replace("\"", "");
					System.out.println("UnloadDate===>"+UnloadDate);
					if(noOfTokens>5){
					UnloadDelayReason=st.nextToken().replace("\"", "");
					
					}else{
						UnloadDelayReason="none";
					}
					
					System.out.println("UnloadDelayReason===>"+UnloadDelayReason);
					if(noOfTokens>6){
						Remark=st.nextToken().replace("\"", "");
					}else{
						Remark="none";
					}
					System.out.println("Remark===>"+Remark);
					//validation for srno------------------------------------------------------------------------------------------------
					try{
						dispdata.setSrNo(srno);
						if(Integer.parseInt(srno)>0){
							System.out.println("Valid srno");
							valid.setSrNo(Integer.parseInt(srno));	
							System.out.println("Valid srno");
						}else{
							System.out.println("Invalide");
							invaliddata.setSrNo(Integer.parseInt(srno));	
							System.out.println("Invalide");
							dispdata.setSrNo("Error "+srno);
							insertFlag = true;
						}
					}catch(Exception e){
						e.printStackTrace();
						System.out.println("catchblock");
						dispdata.setSrNo("Error: Sr.No should be in number format");
						insertFlag = true;
					}
					//-----------------------------------validation for tripid--------------------------------------------------------------------------		
					try
					{
						dispdata.setTripID(TripID);
						boolean FlagOK=false;
						System.out.println("TripID====>"+TripID);
						if(TripID.length()>0)
						{
							
							String sqlchk="Select * from db_gps.t_startedjourney where Tripid ='"+TripID+"' ";
							ResultSet rstchk=stmt.executeQuery(sqlchk);
							if(rstchk.next()){
								valid.setTripID(TripID);
							}
							else{
								invaliddata.setTripID("Error "+TripID);
								dispdata.setTripID(TripID+" [Error: Not a valid Trip Id(Entry for Trip Load not done for this trip id.) ]");
								insertFlag = true;
							}
						}
						else
						{
							invaliddata.setTripID("Error "+TripID);
							dispdata.setTripID(TripID+" [Error: Not a valid Trip Id(Entry for Trip Load not done for this trip id.) ]");
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
							dispdata.setTripID(TripID+" [Error: Not a valid Trip Id(Entry for Trip Load not done for this trip id.) ]");
							insertFlag = true;
						}	
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
					}

					//---------------------------------------------------------------------------------------------------------------------------------
					String endDate1=null;String endDt=null,endTime=null;
					try {
						Boolean Flag=false;
						try{
							String tripdt=TripEndDate.replace("\"", "");
							System.out.println(tripdt);
						//	Date dt11  = new SimpleDateFormat("dd-MMM-yy HH:mm:ss").parse(tripdt);
						//	System.out.println(dt11);
							TripEndDate=new SimpleDateFormat("dd-MMM-yy HH:mm:ss").format(new SimpleDateFormat("dd/MM/yy HH:mm").parse(tripdt));
							System.out.println("TripEndDate===> "+TripEndDate);
							Flag=true;
						}catch(Exception e)
						{
							e.printStackTrace();
							Flag=false;
						}
						dispdata.setTripEndDate(TripEndDate);
						if(Flag==true)
						{
							valid.setTripEndDate(TripEndDate);
						}
						else
						{
							invaliddata.setTripEndDate("Error "+TripEndDate);
							dispdata.setTripEndDate(TripEndDate+" [Error:Date & Time Should be in proper format(dd/MM/yy HH:mm) (E.g 12/09/10 12:00)]");
							insertFlag = true;
						}
					}catch(Exception e)
					{
						dispdata.setTripEndDate(" Error:Date & Time Should be in proper format(dd-MMM-yy HH:mm) (E.g 12/09/10 12:00)");
						insertFlag = true;
					}
				
				
					//-------------------------------------UnloadDateTime----------------------------------------------------------------------------
					try{
						Boolean Flag=false;
						try{
							String dt=UnloadDate.replace("\"", "");
							UnloadDate=new SimpleDateFormat("dd-MMM-yy HH:mm:ss").format(new SimpleDateFormat("dd/MM/yy HH:mm").parse(dt));
							Flag=true;
						}catch(Exception e)
						{
							Flag=false;
						}
						dispdata.setUnloadDate(UnloadDate);
						if(Flag==true)
						{
							valid.setUnloadDate(UnloadDate);
						}
						else
						{
							invaliddata.setUnloadDate("Error "+UnloadDate);
							dispdata.setUnloadDate(UnloadDate+" [Error:Date & Time Should be in proper format(dd/MM/yy HH:mm) (E.g 12/09/10 12:00)]");
							insertFlag = true;
						}
					}catch(Exception e)
					{
						dispdata.setUnloadDate(" Error:Date & Time Should be in proper format(dd-MMM-yy HH:mm) (E.g 12/09/10 12:00)");
						insertFlag = true;
					}
					//-----------------------------------------------Delay Load reason---------------------------------------------------------------
					try
					{
						dispdata.setUnloadDelayReason(UnloadDelayReason);
						String msg=null;
						System.out.println("Delay reason===>"+UnloadDelayReason);
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
						dispdata.setUnloadDelayReason("Error: delay reason field should contain value in alphabets only");
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
					//-------------------------------------------------------------------------------------------------------------------------------
					System.out.println("Insert Flag==>"+insertFlag);
					if (insertFlag!=true){
						try{
							//validList.add(valid); 
							java.util.Date d12=new java.util.Date();  	
							Format frt2=new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
							String now= frt2.format(d12);
							getnewConnection();
							//------------------------------------------------
							String Trans=null;
							
								Trans=usertypevalue;
							
							System.out.println("transporter===>"+Trans);
							String uploadedby=user;
							//-------------------------------------
							
							//-----------------------------------LoadDelayreason------------------------------------------------

							String delayrsn=null;
							if(null==UnloadDelayReason ||  "".equalsIgnoreCase(UnloadDelayReason)||"null".equalsIgnoreCase(UnloadDelayReason)|| "-".equalsIgnoreCase(UnloadDelayReason))
							{
								delayrsn="-";
							}
							else
							{
								delayrsn=UnloadDelayReason;
							}
							System.out.println("delayrsn"+delayrsn);			
							//----------------------------------------------------------------------------------------------------


							//-------------------------------------------Comments--------------------------------------
							String cmmt=null;
							if(null== Remark ||  "".equalsIgnoreCase(Remark)||"null".equalsIgnoreCase(Remark)|| "-".equalsIgnoreCase(Remark))
							{
								cmmt="-";
							}
							else
							{
								cmmt=Remark;
							}
							System.out.println("cmmt"+cmmt);
							//-------------------------------------------------------------------------------------------------------
							//-------------------------------------UnloadDateTime----------------------------------------------------------------------------
							String unloaddttime="0000-00-00 00:00:00";
							System.out.println("UnloadDate===>"+UnloadDate);
							if(UnloadDate!=null)
							{

								unloaddttime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("dd-MMM-yy HH:mm:ss").parse(UnloadDate));
							}
							
							System.out.println("unloaddttime===>"+unloaddttime);
							//------------------------------------------------------------------------------------------------------------------//
							String tripenddttime="0000-00-00 00:00:00";
							System.out.println("TripEndDate===>"+TripEndDate);
							if(TripEndDate!=null)
							{
								
							//	String tripdt=TripEndDate.replace("\"", "");
							//	System.out.println(tripdt);
							//	TripEndDate=new SimpleDateFormat("dd-MMM-yy HH:mm:ss").format(new SimpleDateFormat("dd/MM/yy HH:mm").parse(tripdt));
								tripenddttime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("dd-MMM-yy HH:mm:ss").parse(TripEndDate));
								System.out.println("TripEndDate===> "+tripenddttime);
							
							}
							System.out.println("tripenddttime===>"+tripenddttime);
							//-------------------------------- Get Vehicle code  -----------------------
							//stmt2=con.createStatement();
							/***		String s="Select TripID from t_TripClosureData where TripID='"+TripID+"'";
							System.out.println("Str"+s);
							rs=stmt2.executeQuery(s);
							if(rs.next())
							{
								dispdata.setTripID(TripID+" [Error: Duplicate Entry for Trip ID ,Entry for this Trip Id has already been Processed]");
								insertFlag=true;
								System.out.println("[Error: Duplicate Entry for Trip ID ,Entry for this Trip Id has already been Processed]"); 
								//insertFlag=true;
							}
							else{**/
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
										
										
										String str1="insert into t_TripClosureData(TripID,Vehid,VehRegNo,Enddatetime,UnloadDatetime,unloadreason,Remark,transporter,uploadedby) values('"+TripID+"',"+vehcode+",'"+vehno+"','"+tripenddttime+"','"+unloaddttime+"','"+delayrsn+"','"+cmmt+"','"+Trans+"','"+uploadedby+"')";
										System.out.println("insert into t_TripClosureData===>"+str1);
										stmt.executeUpdate(str1);
										String abc1=str1.replace("'", "#");
										abc1=abc1.replace(",", "$");
										String str3="insert into t_sqlquery(dbname,query)values('db_gps','"+abc1+"')";	
										System.out.println("t_sqlquery >>>>>>>"+str3);
										stn3.executeUpdate(str3);
										
										
										/* Add new code as per new requirement 2010-12-27*/
									}
									catch(com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e)
									{
										System.out.println("Error: Duplicate entry for Trip ID- "+TripID);
										//	insertFlag=true;
									}



								}
								else
								{
									System.out.println(vehno+" [Error: Veh No is not register]");
									//insertFlag=true;
								}

							
							///}//if of duplicate Tripid chk
							//----------------------------------------------------------------------------------

						}catch(Exception e){

						}
						
					}
					if(insertFlag==true){

						System.out.println("in insert flag == true**********************************************************");
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


					}
				}
				//reset token number

				tokenNumber = 0;
			}
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
	public static String validate(String regex,String var)
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
}