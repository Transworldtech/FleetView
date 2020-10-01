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

public class POICSVReader {


	Connection conn=null,con=null; 
	PreparedStatement ps=null;
	Statement stmt=null,stmt1=null,stmt2=null,stn3=null,stmt3=null,stmt4=null,stmt10=null;
	ResultSet rs=null;

	/** Creates a new instance of POIExcelReader */
	public POICSVReader ()
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

	@SuppressWarnings("null")
	public ArrayList<DisplayData> displayFromCSV (String xlsPath,String user,String usertypevalue) throws ClassNotFoundException, SQLException, ParseException,OfficeXmlFileException
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
		ValidData valid = null;
		InvalidData invaliddata =null;
		DisplayData dispdata=null;

		String username=user;

		ArrayList<ValidData> validList= new ArrayList<ValidData>();
		ArrayList<InvalidData> invalidList= new ArrayList<InvalidData>();
		ArrayList<DisplayData> dispList= new ArrayList<DisplayData>();

		String 	flag="false";
		String fileName="/home/sujata/Desktop/test.csv";
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
					valid = new ValidData();
					invaliddata = new InvalidData();
					dispdata=new DisplayData();
					tokenNumber++;
					String  srno=null,ETA=null,Weight=null,Vendor=null,TripType=null,DriverID2=null;
					String TripID=null,Advance=null,Frieght=null,FixedKM=null;
					String TripDateTime=null,FixedTime=null,ReportDateTime=null,LoadDelayReason=null;
					String vehno=null,DriverID1=null,Commnets=null;
					String TripFrom=null,TripTo=null,DriverName1=null,DriverName2=null;
					//String contains double cots.so they are replaced
					srno=st.nextToken().replace("\"", "");
					System.out.println(srno);
					TripID=st.nextToken().replace("\"", "");
					System.out.println(TripID);
					TripDateTime=st.nextToken().replace("\"", "");
					System.out.println(TripDateTime);
					vehno=st.nextToken().replace("\"", "");
					System.out.println(vehno);
					String t=st.nextToken().replace("\"", "");
					System.out.println(t);
					TripFrom=st.nextToken().replace("\"", "");
					System.out.println(TripFrom);
					TripTo=st.nextToken().replace("\"", "");
					System.out.println(TripTo);
					DriverID1=st.nextToken().replace("\"", "");
					System.out.println(DriverID1);
					DriverName1=st.nextToken().replace("\"", "");
					System.out.println(DriverName1);
					DriverID2=st.nextToken().replace("\"", "");
					System.out.println(DriverName1);
					DriverName2=st.nextToken().replace("\"", "");
					System.out.println(DriverName1);
					ETA=st.nextToken().replace("\"", "");
					System.out.println(DriverName1);
					Weight=st.nextToken().replace("\"", "");
					System.out.println(Weight);
					Vendor=st.nextToken().replace("\"", "");
					System.out.println(Vendor);
					TripType=st.nextToken().replace("\"", "");
					System.out.println(TripType);
					Advance=st.nextToken().replace("\"", "");
					System.out.println(Advance);
					Frieght=st.nextToken().replace("\"", "");
					System.out.println(Frieght);
					FixedKM=st.nextToken().replace("\"", "");
					System.out.println(FixedKM);
					FixedTime=st.nextToken().replace("\"", "");
					System.out.println(FixedTime);
					ReportDateTime=st.nextToken().replace("\"", "");
					System.out.println(ReportDateTime);
					if(noOfTokens>20){
					LoadDelayReason=st.nextToken().replace("\"", "");
					
					}else{
						LoadDelayReason="none";
					}
					System.out.println(LoadDelayReason);
					if(noOfTokens>21){
						Commnets=st.nextToken().replace("\"", "");
					}else{
						Commnets="none";
					}
					System.out.println(Commnets);
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
					String startDate1=null;String StartDt=null,StartTime=null;
					try {
						String dt=TripDateTime.replace("\"", "");
						Boolean Flag=false;
						try{
							startDate1=new SimpleDateFormat("dd-MMM-yy HH:mm:ss").format(new SimpleDateFormat("dd/MM/yy HH:mm").parse(dt));
							Flag=true;
						}catch(Exception e){
							Flag=false;
						}
						StringTokenizer stt = new StringTokenizer(startDate1);
						System.out.println("st----->"+stt);
						while (stt.hasMoreTokens()) {
							StartDt=stt.nextToken();
							StartTime=stt.nextToken();
						}
						dispdata.setDate(TripDateTime);
						if(Flag==true)
						{
							valid.setDate(StartDt);
							valid.setTime(StartTime);
						}
						else
						{
							invaliddata.setDate("Error "+StartDt);
							invaliddata.setTime("Error" +StartTime);
							dispdata.setDate(TripDateTime+" [Error:Date & Time Should be in proper format(dd/MM/yy HH:mm) (E.g 12/11/10 12:00)]");
							insertFlag = true;
						}
					} catch (Exception e) {
						dispdata.setDate(" Error:Date & Time Should be in proper format(dd/MM/yy HH:mm) (E.g 12/11/10 12:00:12)");
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
					}
					//------------------------------------------Transporter-----------------------------------------------------------------------
				/*	try{
						dispdata.setTransport(transporter);
						String msg=null;
						if(transporter.length()>0)
						{
							msg=validateName(transporter.trim());
						}
						if(msg=="true")
						{
							valid.setTransport(transporter);
						}

						else
						{
							invaliddata.setTransport("Error "+transporter);
							dispdata.setTransport(transporter+"[Error: Transport cannot contain value other than alphabets and digits]");
							insertFlag = true;
						}
					}catch(Exception e){
						dispdata.setTransport("Error:Transport should contain value in alphabets and digits only");
						insertFlag = true;
					}
					*/
					dispdata.setTransport(usertypevalue);
					valid.setTransport(usertypevalue);
					//-----------------------------------------Trip From---------------------------------------------------------------------------------
					try{
						dispdata.setTripFrom(TripFrom);
						String msg=null;
						if(TripFrom.length()>0)
						{
							msg=validateString(TripFrom.trim());
						}
						if(msg=="true")
						{
							valid.setTripFrom(TripFrom);
						}
						else
						{
							invaliddata.setTripFrom(TripFrom+"[Error]");
							dispdata.setTripFrom(TripFrom+"[Error:TripFrom cannot contain value other than alphabets and digits]");
							insertFlag = true;
						}
					}catch(Exception e){
						dispdata.setTripFrom("Error: TripFrom should contain value in alphabets and digits only ");
						insertFlag = true;
					}
					//----------------------------------------Trip To---------------------------------------------------------------------------
					try{
						dispdata.setTripTo(TripTo);
						String msg=null;
						if(TripTo.length()>0)
						{
							msg=validateString(TripTo.trim());
						}
						if(msg=="true")
						{
							valid.setTripTo(TripTo);
						}
						else
						{
							invaliddata.setTripTo("Error "+TripTo);
							dispdata.setTripTo(TripTo+"[Error:TripTo cannot contain value other than alphabets and digits]");
							insertFlag = true;
						}
					}catch(Exception e){
						dispdata.setTripTo("Error:TripTo should contain value in alphabets and digits only  ");
						insertFlag = true;
					}
					//------------------------------------------------DriverID 1------------------------------------------------------------------------
					try{
						dispdata.setDriverID1(DriverID1);
						String msg=null;
						if(DriverID1.length()>0)
						{
							msg=validateString(DriverID1.trim());
						}
						if(msg=="true")
						{
							valid.setDriverID1(DriverID1);
						}
						else
						{
							invaliddata.setDriverID1("Error "+DriverID1);
							dispdata.setDriverID1(DriverID1+"[Error:DriverCode cannot contain value other than alphabets and digits] ");
							insertFlag = true;
						}
					}catch(Exception e){
						dispdata.setDriverID1(DriverID1);
						String regex ="^.*[0-9].*$";
						String msg=validate(regex,DriverID1.trim());
						if(msg=="true")
						{
							valid.setDriverID1(DriverID1);
						}
						else
						{
							invaliddata.setDriverID1("Error "+DriverID1);
							dispdata.setDriverID1("Error: DriverCode should contain value in alphabets and digits only ");
							insertFlag = true;
						}
					}
					//---------------------------------------DriverName 1----------------------------------------------------------------------------------
					try{
						dispdata.setDriverName1(DriverName1);
						String msg=null;
						if(DriverName1.length()>0)
						{
							msg=validateString(DriverName1.trim());
						}
						if(msg=="true")
						{
							valid.setDriverName1(DriverName1);
						}
						else
						{
							invaliddata.setDriverName1("Error "+DriverName1);
							dispdata.setDriverName1(DriverName1+"[Error:DriverName cannot contain value other than alphabets] ");
							insertFlag = true;
						}
					}catch(Exception e){
						dispdata.setDriverName1("Error:DriverName should contain value in alphabets and digits only");
						insertFlag = true;
					}
					//--------------------------------------Driver ID 2---------------------------------------------------------------------------------
					try{
						dispdata.setDriverID2(DriverID2);
						String msg=null;

						if(DriverID2.length()>0)
						{

							msg=validateString(DriverID2.trim());

						}
						if(msg=="true")
						{
							valid.setDriverID2(DriverID2);

							//	System.out.println("valid "+var);
						}

						else
						{
							invaliddata.setDriverID2("Error "+DriverID2);
							dispdata.setDriverID2(DriverID2+"[Error:DriverCode cannot contain value other than alphabets and digits] ");
							insertFlag = true;
						}
					}catch(Exception e){
						dispdata.setDriverID2(DriverID2);
						String regex ="^.*[0-9].*$";
						String msg=validate(regex,DriverID2.trim());
						if(msg=="true")
						{
							valid.setDriverID2(DriverID2);
						}
						else
						{
							invaliddata.setDriverID2("Error "+DriverID2);
							dispdata.setDriverID2("Error:DriverCode should contain value in alphabets and digits only ");
							insertFlag = true;
						}	

					}
					//-----------------------------------------Driver Name 2-------------------------------------------------------------------------
					try
					{
						dispdata.setDriverName2(DriverName2);
						String msg=null;

						if(DriverName2.length()>0)
						{

							msg=validateString(DriverName2.trim());

						}
						if(msg=="true")
						{

							valid.setDriverName2(DriverName2);

							//	System.out.println("valid "+var);
						}

						else
						{
							invaliddata.setDriverName2("Error "+DriverName2);
							dispdata.setDriverName2(DriverName2+"[Error:DriverName cannot contain value other than alphabets]");
							insertFlag = true;
						}
					}catch(Exception e)
					{
						dispdata.setDriverName2("Error:DriverName should contain value in alphabets and digits only");
						insertFlag = true;
					}
					//--------------------------------------------ETA------------------------------------------------------------------------------
					try{
						Date ETADate=null;
						Boolean Flag=false;
						System.out.println("ETA"+ETA);
						try{
							String dt=ETA.replace("\"", "");
							ETA=new SimpleDateFormat("dd-MMM-yy HH:mm:ss").format(new SimpleDateFormat("dd/MM/yy HH:mm").parse(dt));
							System.out.println("ETADate"+ETA);
							Flag=true;
						}catch(Exception e)
						{
							// System.out.println("Date Exception"+e);
							Flag=false;
						}
						dispdata.setETA(ETA);
						if(Flag==true)
						{
							valid.setETA(ETA);
						}
						else
						{
							invaliddata.setETA("Error "+ETA);
							dispdata.setETA(ETA+" [Error:ETA Date & Time Should be in proper format(dd/MM/yy HH:mm) (E.g. 12/09/10 12:00)]");
							insertFlag = true;
						}
					}catch(Exception e)
					{
						dispdata.setETA(" Error:ETA Date & Time Should be in proper format(dd/MM/yy HH:mm) (E.g. 12/09/10 12:00)");
						insertFlag = true;
					}
					//------------------------------------------------Weight-----------------------------------------------------------------------
					try
					{
						int weight=Integer.parseInt(Weight);
						dispdata.setWeight(Weight);
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
					//------------------------------------------Vendor-------------------------------------------------------------------------------
					try
					{
						dispdata.setVendor(Vendor);
						String msg="-";
						System.out.println("Vendor>>>>>>>"+Vendor);
						if(Vendor.length()>0)
						{
							msg=validateName(Vendor.trim());
						}
						if(msg=="true")
						{
							valid.setVendor(Vendor);
						}
						else
						{
							invaliddata.setVendor("Error "+Vendor);
							dispdata.setVendor(Vendor+"[Error:Vendor cannot contain value other than alphabets]");
							insertFlag = true;
						}
					}catch(Exception e)
					{
						dispdata.setVendor("Error:Vendor should contain value in alphabets only");
						insertFlag = true;
					}
					//----------------------------------Trip Type-----------------------------------------------------------------------------------
					try
					{
						dispdata.setTriptype(TripType);
						String msg=null;
						System.out.println("In Trip type"+TripType);
						if(TripType.length()>0)
						{
							msg=validateString(TripType.trim());
						}
						if(msg=="true")
						{
							valid.setTriptype(TripType);
						}
						else
						{
							invaliddata.setTriptype("Error "+TripType);
							dispdata.setTriptype(TripType+"[Error:Trip Type cannot contain value other than alphabets]");
							insertFlag = true;
						}
					}catch(Exception e)
					{
						dispdata.setTriptype("Error:Trip type should contain value in alphabets only");
						insertFlag = true;
					}
					//------------------------------------Advance------------------------------------------------------------------------------------
					try
					{
						int a=Integer.parseInt(Advance);
						dispdata.setAdvance(a+"");
						if(a>=0)
						{
							valid.setAdvance(a);	
						}
						else
						{
							invaliddata.setAdvance(a);	
							dispdata.setAdvance("Error "+a);
							insertFlag = true;
						}
					}
					catch(Exception e)
					{
						dispdata.setAdvance("Error: Advance should be in number format");
						insertFlag = true;
					}
					//-------------------------------------Frieght---------------------------------------------------------------------------------------
					try
					{
						int frieght=Integer.parseInt(Frieght);
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
						dispdata.setFreight("Error: Frieght should be in number format");
						insertFlag = true;
					}
					//-------------------------------------------------------------------------------------------------------------------------------
					try
					{
						int fxkm =Integer.parseInt(FixedKM);
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
					//-------------------------------------------------------------------------------------------------------------------------------
					try{
						dispdata.setFxtime(FixedTime);
						String msg=null;
						if(FixedTime.length()>0)
						{
							msg=validateString(FixedTime.trim());
						}
						if(msg=="true")
						{
							valid.setFxtime(FixedTime);
						}
						else
						{
							invaliddata.setFxtime("Error "+FixedTime);
							dispdata.setFxtime(FixedTime+"[Error: Fixed time cannot contain value other than alphabets and digits]");
							insertFlag = true;
						}
					}catch(Exception e)
					{
						dispdata.setFxtime(FixedTime);
						String regex ="^.*[0-9].*$";
						String msg=validate(regex,FixedTime.trim());
						if(msg=="true")
						{
							valid.setFxtime(FixedTime);
						}
						else
						{
							invaliddata.setFxtime("Error "+FixedTime);
							dispdata.setFxtime("Error: Fixed time should contain value in  digits only");
							insertFlag = true;
						}



					}
					//-------------------------------------ReportDateTime----------------------------------------------------------------------------
					try{
						Boolean Flag=false;
						try{
							String dt=ReportDateTime.replace("\"", "");
							ReportDateTime=new SimpleDateFormat("dd-MMM-yy HH:mm:ss").format(new SimpleDateFormat("dd/MM/yy HH:mm").parse(dt));
							Flag=true;
						}catch(Exception e)
						{
							Flag=false;
						}
						dispdata.setReportDateTime(ReportDateTime);
						if(Flag==true)
						{
							valid.setReportDateTime(ReportDateTime);
						}
						else
						{
							invaliddata.setReportDateTime("Error "+ReportDateTime);
							dispdata.setReportDateTime(ReportDateTime+" [Error:Date & Time Should be in proper format(dd/MM/yy HH:mm) (E.g 12/09/10 12:00)]");
							insertFlag = true;
						}
					}catch(Exception e)
					{
						dispdata.setReportDateTime(" Error:Date & Time Should be in proper format(dd-MMM-yy HH:MM:SS) (E.g 12-Sep-10 12:00:12)");
						insertFlag = true;
					}
					//-----------------------------------------------Delay Load reason---------------------------------------------------------------
					try
					{
						dispdata.setLoadDelayReason(LoadDelayReason);
						//String msg=null;
						System.out.println("Delay reason"+LoadDelayReason);
						if(LoadDelayReason.length()>0)
						{
							valid.setLoadDelayReason(LoadDelayReason);
						}
						else
						{
							invaliddata.setLoadDelayReason("Error "+LoadDelayReason);
							dispdata.setLoadDelayReason(LoadDelayReason+"[Error:this field cannot contain value other than alphabets]");
							insertFlag = true;
						}
					}catch(Exception e)
					{
						dispdata.setLoadDelayReason("Error: delay reason field should contain value in alphabets only");
						insertFlag = true;
					}
					//-----------------------------------------------Comment-------------------------------------------------------------------------
					try
					{
						dispdata.setComment(Commnets);
						String msg=null;
						System.out.println("setComment"+Commnets);
						if(Commnets.length()>0)
						{
							valid.setComment(Commnets);
						}
						else
						{
							invaliddata.setComment("Error "+Commnets);
							dispdata.setComment(Commnets+"[Error:Comment cannot contain value other than alphabets]");
							insertFlag = true;
						}
					}catch(Exception e)
					{
						dispdata.setComment("Error:Comment should contain value in alphabets only");
						insertFlag = true;
					}
					//-------------------------------------------------------------------------------------------------------------------------------
					System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
					if (insertFlag!=true){
						try{
							System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
							//validList.add(valid); 
							java.util.Date d12=new java.util.Date();  	
							Format frt2=new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
							String now= frt2.format(d12);
							getnewConnection();
							System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
							//------------------------------------------------
							String Trans=null;
							
								Trans=usertypevalue;
							
							System.out.println("transporter"+Trans);
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
							if(null== TripType ||  "".equalsIgnoreCase(TripType)||"null".equalsIgnoreCase(TripType)||"-".equalsIgnoreCase(TripType))
							{
								category="-";
							}
							else
							{
								category=TripType;
							}
							System.out.println("category"+category);
							//-------------------------------Advance------------------------------------------------------

							String adv="0"+ Advance;
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
							if(null==LoadDelayReason ||  "".equalsIgnoreCase(LoadDelayReason)||"null".equalsIgnoreCase(LoadDelayReason)|| "-".equalsIgnoreCase(LoadDelayReason))
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
							if(null== Commnets ||  "".equalsIgnoreCase(Commnets)||"null".equalsIgnoreCase(Commnets)|| "-".equalsIgnoreCase(Commnets))
							{
								cmmt="-";
							}
							else
							{
								cmmt=Commnets;
							}
							System.out.println("cmmt"+cmmt);
							//-------------------------------------------------------------------------------------------------------

							//----------------- Concat Driver ID and Driver Name-----------------------
							String DriverID=null,DriverName=null;
							if(null== DriverID2 || "".equalsIgnoreCase(DriverID2)||"null".equalsIgnoreCase(DriverID2))
							{
								DriverID=DriverID1;
							}
							else if(null== DriverID1 ||  "".equalsIgnoreCase(DriverID1)||"null".equalsIgnoreCase(DriverID1))			
							{
								DriverID=DriverID2;
							}
							else
							{
								DriverID=DriverID1+"-"+DriverID2;
							}
							System.out.println("DriverID"+DriverID);
							//------------------------- DriverName---------------

							if("".equalsIgnoreCase(DriverName2) || null==DriverName2||"null".equalsIgnoreCase(DriverName2))
							{
								DriverName=DriverName1;
							}
							else if("".equalsIgnoreCase(DriverName1) || null==DriverName1||"null".equalsIgnoreCase(DriverName1))
								DriverName=DriverName2;
							else
								DriverName=DriverName1+"-"+DriverName2;


							System.out.println("DriverName===>"+DriverName);
							//-------------------------------------------------------------------------------- 

							//---------------------------- Trip Date and Time--------------------------
							String startDate =null,Time=null;
							if(StartDt!=null)
							{

								startDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yy").parse(StartDt));
							}
							if(StartTime!=null)
							{					   
								Time=new SimpleDateFormat("HH:mm:ss").format(new SimpleDateFormat("HH:mm:ss").parse(StartTime));
							}
							System.out.println("startDate====>"+startDate);
							System.out.println("Time====>"+Time);
							//------------------------------------------------------------------------------


							//---------------------------Report Date time----------------------------------
							String reportdttime="0000-00-00 00:00:00";
							System.out.println("ReportDateTime===>"+ReportDateTime);
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

						//	stmt2=con.createStatement();
							String s="Select TripID from t_startedjourney where TripID='"+TripID+"'";
							System.out.println("Str"+s);
							rs=stmt2.executeQuery(s);
							if(rs.next())
							{
								dispdata.setTripID(TripID+" [Error: Duplicate Entry for Trip ID , Please Enter TripID in this format yymmddvrgnostateno(E.g 1012240358AP)]");
								insertFlag=true;
								System.out.println("[Error: Duplicate Entry for Trip ID , Please Enter TripID in this format yymmddvrgnostateno(E.g 1012240358AP)]"); 
								//insertFlag=true;
							}
							else{
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
										
										String str1="insert into t_startedjourney(TripID,Vehid,VehRegNo,StartPlace,EndPlace,StartDate,StartTime,ETA,DriverCode,DriverName,OwnerName,EndedBy,Weight,Vendor,TripCategory,Advance,Frieght,FIxedKM,	FIxedTime,ReportDateTime,Loadreason,Loadcomments,StartCode,EndCode,GPName) values('"+TripID+"',"+vehcode+",'"+vehno+"','"+TripFrom+"','"+TripTo+"','"+startDate+"','"+Time+"','"+ETADate+"','"+DriverID+"','"+DriverName+"','"+usertypevalue+"','"+username+"','"+Weight+"','"+ven+"','"+category+"','"+Advance+"','"+Frieght+"','"+FixedKM+"','"+FixedTime+"','"+reportdttime+"','"+delayrsn+"','"+cmmt+"','"+TripFrom+"','"+TripTo+"','"+usertypevalue+"')";
										System.out.println(str1);
										stmt.executeUpdate(str1);
										String abc1=str1.replace("'", "#");
										abc1=abc1.replace(",", "$");
										String str3="insert into t_sqlquery(dbname,query)values('db_gps','"+abc1+"')";	
										System.out.println("t_sqlquery >>>>>>>"+str3);
										stn3.executeUpdate(str3);
										/* Add new code as per new requirement 2010-12-27*/
										
										///added check to update the previously open trips status to tobeclosed
										String upst="select TripID from t_startedjourney where VehRegNo='"+vehno+"' and Jstatus='Running' " +
												"and concat(startdate,' ',starttime)<'"+startDate+" "+Time+"' order by " +
														"startdate,starttime desc";
										System.out.println("upst...status"+upst);
										ResultSet uprs=stn3.executeQuery(upst);
										while(uprs.next())
										{
											String tpid=uprs.getString("TripID");
											System.out.println("TripID"+tpid);
											
											String update="update t_startedjourney set JStatus='tobeclosed' where VehRegNo='"+vehno+"' and TripId='"+tpid+"'";
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

												if(!oenerdriv.equalsIgnoreCase(usertypevalue))
												{
													String dpdiv="update t_drivers Set Owner='"+usertypevalue+"' where DriverID='"+DriverID1+"',EntryBy='JD',UpdatedDtTime ='"+now+"'";
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

												String insdiv="insert into t_drivers(DriverID,DriverName,Owner,Entryby)values('"+DriverID1+"','"+DriverName+"','"+usertypevalue+"','Bulk Trip UPload')";
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
												if(!oenerdriv.equalsIgnoreCase(usertypevalue))
												{
													System.out.println("*************************** inside owner != trans"+oenerdriv);

													String dpdiv="update t_drivers Set Owner='"+usertypevalue+"' where DriverID='"+DriverID2+"'";
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

												String insdiv="insert into t_drivers(DriverID,DriverName,Owner,EntryBy)values('"+DriverID2+"','"+DriverName2+"','"+usertypevalue+"','Bulk Trip UPload')";
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
										System.out.println("Error: Duplicate entry for Trip ID- "+TripID);
										//	insertFlag=true;
									}



								}
								else
								{
									System.out.println(vehno+" [Error: Veh No is not register]");
									//insertFlag=true;
								}

							}

							//----------------------------------------------------------------------------------

						}catch(Exception e){

						}
					}else{
						System.out.println("@@@@@@@@@@@@@@@@@insert flag is false---$$$$$$$$$$$$$$$$$");
					}
					if(insertFlag==true){

						System.out.println("in insert flag == true**********************************************************");
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
