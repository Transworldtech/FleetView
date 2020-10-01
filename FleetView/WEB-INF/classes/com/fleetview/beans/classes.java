package com.fleetview.beans;
import java.sql.*;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
public class classes {
	Connection connmain=null;
	Connection connmain1=null;
	Connection connmain2=null;
	Statement stmain=null;
	Statement stmain1=null;
	Statement stmain2=null;
	NumberFormat numberformat = new DecimalFormat("#0.00");
	public String getDate(String dt,String userFormat, String returnFormat) throws Exception {
		String thedate="";
		String UserDate=dt;
		String UserFormat=userFormat;
		String ReturnFormat=returnFormat;
		thedate=new SimpleDateFormat(ReturnFormat).format(new SimpleDateFormat(UserFormat).parse(UserDate));
		return thedate;

	}
	public double  KM_TO_MILES(int kmvalue) {
		int km= kmvalue;
		double miles=0;
		try{
			miles=Double.parseDouble(numberformat.format(km/1.609344));
		}catch (Exception e) {
		}
		return miles;
	}
	public int Liter_To_Gallan(int liters)
	{
		int litr=liters;
		//System.out.print(litr/3.78541178);
		int gal=0;
		try{
			gal= (int) (litr/3.78541178);
		}catch (Exception e) {

		}
		return gal;
	}
	public double  KM_TO_MILES1(double kmvalue) {
		double km= kmvalue;
		double miles=0;
		try{
			miles=Double.parseDouble(numberformat.format(km/1.609344));
		}catch (Exception e) {
		}
		return miles;
	}
	public String ChangeLocation(String Location)
	{
		String location,loc2;
		double mils;
		try{
			location=Location;
			loc2=location.substring(9);
			mils= KM_TO_MILES1(Double.parseDouble(location.substring(0,4)));
			location=mils+" Miles "+loc2;
		}catch (Exception e) {
			return Location;
		}
		return location;
	}
	public String getFuelLevel(String vehcode, int rid)
	{
		String fuelvalue="NA",sql,sql1;
		long a=0, b=12, c=24, d=36, e=48, f=60, g=72, h=84, i=96, j=108, k=120, l=132, m=144, n=156, o=168, p=180, q=192, r=204, s=216, t=228, u=240;
		int fcap=1;
		double mfact=1;
		try{ 
			String vehregno=getVehRegNo(vehcode);
			sql1="select * from t_fuelleveldata where vehregno='"+vehregno+"' limit 1";
			ResultSet rstx=stmain.executeQuery(sql1);
			if(rstx.next())
			{
				fcap=rstx.getInt("FuelCapacity");
				mfact=fcap/20;
				a=0;
				b=Math.round(1*mfact);
				c=Math.round(2*mfact);
				d=Math.round(3*mfact);
				e=Math.round(4*mfact);
				f=Math.round(5*mfact);
				g=Math.round(6*mfact);
				h=Math.round(7*mfact);
				i=Math.round(8*mfact);
				j=Math.round(9*mfact);
				k=Math.round(10*mfact);
				l=Math.round(11*mfact);
				m=Math.round(12*mfact);
				n=Math.round(13*mfact);
				o=Math.round(14*mfact);
				p=Math.round(15*mfact);
				q=Math.round(16*mfact);
				r=Math.round(17*mfact);
				s=Math.round(18*mfact);
				t=Math.round(19*mfact);
				u=fcap;
				//}	
			sql="select FuelLevel from t_veh"+vehcode+"  where concat(TheFieldDataDate,' ',TheFieldDataTime)<= (select concat(TheDate,' ',TheTime) from t_onlinedata where vehiclecode='"+vehcode+"') and TheFiledTextFileName='SI' and FuelLevel>0 order by concat(TheFieldDataDate,TheFieldDataTime) desc limit 1";
			ResultSet rst=stmain.executeQuery(sql);
			if(rst.next())
			{
				//double val=(rst.getDouble("FuelLevel")*153)/1000;
				fuelvalue=rst.getString("FuelLevel");
			}
			if(!((fuelvalue.equals("NA")) ||(fuelvalue.equals("0"))))
			{
				String str="<div id=\"showbar"+rid+"\" style=\"font-size:6pt;padding:1px;border:solid black 1px;visibility:hidden\"> <span id=\"progressA"+rid+"\">&nbsp;</span><span id=\"progressB"+rid+"\">&nbsp;</span><span id=\"progressC"+rid+"\">&nbsp;</span><span id=\"progressD"+rid+"\">&nbsp;</span><span id=\"progressE"+rid+"\">&nbsp;</span><span id=\"progressF"+rid+"\">&nbsp;</span><span id=\"progressG"+rid+"\">&nbsp;</span><span id=\"progressH"+rid+"\">&nbsp;</span><span id=\"progressI"+rid+"\">&nbsp;</span><span id=\"progressJ"+rid+"\">&nbsp;</span><span id=\"progressK"+rid+"\">&nbsp;</span><span id=\"progressL"+rid+"\">&nbsp;</span><span id=\"progressM"+rid+"\">&nbsp;</span><span id=\"progressN"+rid+"\">&nbsp;</span><span id=\"progressO"+rid+"\">&nbsp;</span><span id=\"progressP"+rid+"\">&nbsp;</span><span id=\"progressQ"+rid+"\">&nbsp;</span><span id=\"progressR"+rid+"\">&nbsp;</span><span id=\"progressS"+rid+"\">&nbsp;</span><span id=\"progressT"+rid+"\">&nbsp;</span></div>";
				String str1="";

				if(Integer.parseInt(fuelvalue) > a && Integer.parseInt(fuelvalue)<=b)
				{
					str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+rid+"').style.visibility = 'visible';document.getElementById('progressA"+rid+"').style.backgroundColor = progressColor;</script>";
				}

				if(Integer.parseInt(fuelvalue) >b && Integer.parseInt(fuelvalue)<=c)
				{
					str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+rid+"').style.visibility = 'visible';document.getElementById('progressA"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressB"+rid+"').style.backgroundColor = progressColor;</script>";
				}

				if(Integer.parseInt(fuelvalue) >c && Integer.parseInt(fuelvalue)<=d)
				{
					str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+rid+"').style.visibility = 'visible';document.getElementById('progressA"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressB"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressC"+rid+"').style.backgroundColor = progressColor;</script>";
				}

				if(Integer.parseInt(fuelvalue) >d && Integer.parseInt(fuelvalue)<=e)
				{
					str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+rid+"').style.visibility = 'visible';document.getElementById('progressA"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressB"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressC"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressD"+rid+"').style.backgroundColor = progressColor;</script>";
				}

				if(Integer.parseInt(fuelvalue) >e && Integer.parseInt(fuelvalue)<=f)
				{
					str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+rid+"').style.visibility = 'visible';document.getElementById('progressA"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressB"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressC"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressD"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressE"+rid+"').style.backgroundColor = progressColor;</script>";
				}

				if(Integer.parseInt(fuelvalue) >f && Integer.parseInt(fuelvalue)<=g)
				{
					str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+rid+"').style.visibility = 'visible';document.getElementById('progressA"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressB"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressC"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressD"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressE"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressF"+rid+"').style.backgroundColor = progressColor;</script>";
				}

				if(Integer.parseInt(fuelvalue) >g && Integer.parseInt(fuelvalue)<=h)
				{
					str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+rid+"').style.visibility = 'visible';document.getElementById('progressA"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressB"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressC"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressD"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressE"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressF"+rid+"').style.backgroundColor = progressColor; document.getElementById('progressG"+rid+"').style.backgroundColor = progressColor;</script>";
				}

				if(Integer.parseInt(fuelvalue) >h && Integer.parseInt(fuelvalue)<=i)
				{
					str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+rid+"').style.visibility = 'visible';document.getElementById('progressA"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressB"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressC"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressD"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressE"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressF"+rid+"').style.backgroundColor = progressColor; document.getElementById('progressG"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressH"+rid+"').style.backgroundColor = progressColor;</script>";
				}

				if(Integer.parseInt(fuelvalue) >i && Integer.parseInt(fuelvalue)<=j)
				{
					str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+rid+"').style.visibility = 'visible';document.getElementById('progressA"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressB"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressC"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressD"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressE"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressF"+rid+"').style.backgroundColor = progressColor; document.getElementById('progressG"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressH"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressI"+rid+"').style.backgroundColor = progressColor;</script>";
				}

				if(Integer.parseInt(fuelvalue) >j && Integer.parseInt(fuelvalue)<=k)
				{
					str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+rid+"').style.visibility = 'visible';document.getElementById('progressA"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressB"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressC"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressD"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressE"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressF"+rid+"').style.backgroundColor = progressColor; document.getElementById('progressG"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressH"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressI"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressJ"+rid+"').style.backgroundColor = progressColor;</script>";
				}

				if(Integer.parseInt(fuelvalue) >k && Integer.parseInt(fuelvalue)<=l)
				{
					str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+rid+"').style.visibility = 'visible';document.getElementById('progressA"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressB"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressC"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressD"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressE"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressF"+rid+"').style.backgroundColor = progressColor; document.getElementById('progressG"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressH"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressI"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressJ"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressK"+rid+"').style.backgroundColor = progressColor;</script>";
				}

				if(Integer.parseInt(fuelvalue) >l && Integer.parseInt(fuelvalue)<=m)
				{
					str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+rid+"').style.visibility = 'visible';document.getElementById('progressA"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressB"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressC"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressD"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressE"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressF"+rid+"').style.backgroundColor = progressColor; document.getElementById('progressG"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressH"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressI"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressJ"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressK"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressL"+rid+"').style.backgroundColor = progressColor;</script>";
				}


				if(Integer.parseInt(fuelvalue) >m && Integer.parseInt(fuelvalue)<=n)
				{
					str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+rid+"').style.visibility = 'visible';document.getElementById('progressA"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressB"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressC"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressD"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressE"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressF"+rid+"').style.backgroundColor = progressColor; document.getElementById('progressG"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressH"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressI"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressJ"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressK"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressL"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressM"+rid+"').style.backgroundColor = progressColor;</script>";
				}

				if(Integer.parseInt(fuelvalue) >n && Integer.parseInt(fuelvalue)<=o)
				{
					str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+rid+"').style.visibility = 'visible';document.getElementById('progressA"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressB"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressC"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressD"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressE"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressF"+rid+"').style.backgroundColor = progressColor; document.getElementById('progressG"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressH"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressI"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressJ"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressK"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressL"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressM"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressN"+rid+"').style.backgroundColor = progressColor;</script>";
				}

				if(Integer.parseInt(fuelvalue) >o && Integer.parseInt(fuelvalue)<=p)
				{
					str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+rid+"').style.visibility = 'visible';document.getElementById('progressA"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressB"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressC"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressD"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressE"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressF"+rid+"').style.backgroundColor = progressColor; document.getElementById('progressG"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressH"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressI"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressJ"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressK"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressL"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressM"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressN"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressO"+rid+"').style.backgroundColor = progressColor;</script>";
				}

				if(Integer.parseInt(fuelvalue) >p && Integer.parseInt(fuelvalue)<=q)
				{
					str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+rid+"').style.visibility = 'visible';document.getElementById('progressA"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressB"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressC"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressD"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressE"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressF"+rid+"').style.backgroundColor = progressColor; document.getElementById('progressG"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressH"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressI"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressJ"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressK"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressL"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressM"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressN"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressO"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressP"+rid+"').style.backgroundColor = progressColor;</script>";
				}

				if(Integer.parseInt(fuelvalue) >q && Integer.parseInt(fuelvalue)<=r)
				{
					str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+rid+"').style.visibility = 'visible';document.getElementById('progressA"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressB"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressC"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressD"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressE"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressF"+rid+"').style.backgroundColor = progressColor; document.getElementById('progressG"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressH"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressI"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressJ"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressK"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressL"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressM"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressN"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressO"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressP"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressQ"+rid+"').style.backgroundColor = progressColor;</script>";
				}

				if(Integer.parseInt(fuelvalue) >r && Integer.parseInt(fuelvalue)<=s)
				{
					str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+rid+"').style.visibility = 'visible';document.getElementById('progressA"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressB"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressC"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressD"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressE"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressF"+rid+"').style.backgroundColor = progressColor; document.getElementById('progressG"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressH"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressI"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressJ"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressK"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressL"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressM"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressN"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressO"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressP"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressQ"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressR"+rid+"').style.backgroundColor = progressColor;</script>";
				}

				if(Integer.parseInt(fuelvalue) >s && Integer.parseInt(fuelvalue)<=t)
				{
					str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+rid+"').style.visibility = 'visible';document.getElementById('progressA"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressB"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressC"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressD"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressE"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressF"+rid+"').style.backgroundColor = progressColor; document.getElementById('progressG"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressH"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressI"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressJ"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressK"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressL"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressM"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressN"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressO"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressP"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressQ"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressR"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressS"+rid+"').style.backgroundColor = progressColor;</script>";
				}

				if(Integer.parseInt(fuelvalue) > t && Integer.parseInt(fuelvalue)<= u)
				{
					str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+rid+"').style.visibility = 'visible';document.getElementById('progressA"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressB"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressC"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressD"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressE"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressF"+rid+"').style.backgroundColor = progressColor; document.getElementById('progressG"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressH"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressI"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressJ"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressK"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressL"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressM"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressN"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressO"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressP"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressQ"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressR"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressS"+rid+"').style.backgroundColor = progressColor;document.getElementById('progressT"+rid+"').style.backgroundColor = progressColor;</script>";
				}
				fuelvalue=fuelvalue +" ltr"+str +str1;
			}
			}
			else
			{
				fuelvalue="Not Calibrated";
			}

		}catch (Exception ee) {
			//System.out.println("Exception-->"+e);
			return fuelvalue;
		}
		return fuelvalue;
	}
	public void getConnection(String MM_dbConn_DRIVER,String MM_dbConn_STRING,String MM_dbConn_USERNAME, String MM_dbConn_PASSWORD) {
		try{
			Class.forName(MM_dbConn_DRIVER); 
			connmain = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
			stmain=connmain.createStatement();
		}catch (Exception e) {
			System.out.print("Connection Error");
		}
	}
	public void getConnection1(String MM_dbConn_DRIVER,String MM_dbConn_STRING,String MM_dbConn_USERNAME, String MM_dbConn_PASSWORD) {
		try{
			Class.forName(MM_dbConn_DRIVER); 
			connmain1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
			stmain1=connmain1.createStatement();
			stmain2=connmain1.createStatement();
		}catch (Exception e) {
			System.out.print("Connection Error");
		}
	}

	public void getConnection2(String MM_dbConn_DRIVER,String MM_dbConn_STRING,String MM_dbConn_USERNAME, String MM_dbConn_PASSWORD) {
		try{
			Class.forName(MM_dbConn_DRIVER); 
			connmain2 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
			stmain2=connmain2.createStatement();
		}catch (Exception e) {
			System.out.print("Connection Error");
		}

	}
	public void closeConnection()
	{
		try{
			stmain.close();
			connmain.close();

		}catch (Exception e) {

		}
	}
	public void closeConnection1()
	{
		try{
			stmain1.close();
			connmain1.close();

		}catch (Exception e) {


		}
	}

	public String getWareHouseList(String UserName)
	{
		String WareHouse="<option value='Select'>Select</option>";

		try{
			String sql="select * from t_waypoints where OwnerName='"+UserName+"' order by Name";
			ResultSet rst=stmain.executeQuery(sql);
			while(rst.next())
			{
				WareHouse=WareHouse+"<option value='"+rst.getString("Lat")+','+rst.getString("Lon")+','+rst.getString("Name")+"'>"+rst.getString("Name")+"</option>";
			}
		}catch (Exception e) {
			System.out.print("Exception"+e);
		}
		return WareHouse;
	}

	public double PointToPointDistance(double lat1, double lon1, double lat2, double lon2)
	{
		double theta = lon1 - lon2;
		double dist = Math.sin(lat1* Math.PI / 180.0) * Math.sin(lat2* Math.PI / 180.0) + Math.cos(lat1* Math.PI / 180.0) * Math.cos(lat2* Math.PI / 180.0) * Math.cos(theta* Math.PI / 180.0);
		dist = Math.acos(dist);
		dist = (dist* 180 / Math.PI);
		dist = dist * 60 * 1.1515;
		double dist2 = dist * 1.609344;
		return Double.parseDouble(numberformat.format(dist2));
	}

	public String PrintDate()
	{
		return "Date : "+new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date());
	}
	public Connection ReturnConnection() 
	{	
		return connmain;
	}
	public Connection ReturnConnection1() 
	{	
		return connmain1;
	}
	public Connection ReturnConnection2() 
	{	
		return connmain2;
	}
	public String showNewMap(String lat, String lon, String discription)
	{
		String lat1=lat;
		String lon1=lon;
		String disc=discription;
		String str="<a href=\"shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"\" onclick=\"popWin=open('shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"', 'myWin','width=500, height=500'); popWin.focus(); return false\">"+disc+"</a>";
		return str;
	}

	public String getVehicleCodes(String UserType, String UserTypeValue)
	{
		String sql="";
		String Svehlist="(0";
		try{
			if (UserType.equals("Transporter"))
			{
				sql="Select vehiclecode as vehcode1 from t_vehicledetails where OwnerName='"+ UserTypeValue +"' order by vehiclecode";
			}
			if (UserType.equals("GROUP"))
			{
				sql="Select vehcode as vehcode1 from t_group where GPName='"+ UserTypeValue  +"' and Active='Yes' order by vehregno";
			}
			ResultSet rst=stmain.executeQuery(sql);
			while(rst.next())
			{
				Svehlist=Svehlist+","+rst.getString("vehcode1");
			}
			Svehlist=Svehlist+")";
			Svehlist = Svehlist.replace("(0,", "(");
			//System.out.println(Svehlist);
		}catch (Exception e) {
			System.out.print("Exception--->"+e);
		}
		return Svehlist;
	}
	public String getOwnerNames(String vehlist)
	{
		String OwnerName="(";
		try{
			String sql="select Distinct(OwnerName) from t_vehicledetails where vehiclecode in "+vehlist+" order by OwnerName";
			ResultSet rst=stmain.executeQuery(sql);
			while(rst.next())
			{
				OwnerName=OwnerName+"'"+rst.getString("OwnerName")+"',";
			}
			OwnerName=OwnerName.substring(0,OwnerName.length()-1);
			OwnerName=OwnerName+")";
		}catch (Exception e) {
			System.out.print("Exception--->"+e);
		}
		return OwnerName;
	}

	public String getFuelAlertToday(String VehicleCode)
	{
		String str="";
		String today=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		String today1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
		int alert=0;
		try{
			String sql="select count(*) as cnt from t_veh"+VehicleCode+" where TheFieldDataDate='"+today+"' and TheFiledTextFileName='FT'";
			ResultSet rst=stmain.executeQuery(sql);
			if(rst.next())
			{
				alert=rst.getInt("cnt");

				if(alert >0){
					str="<div style=\"width:100%; height:30px; background-image:url(images/oil.png); background-repeat:no-repeat\" align=\"center\"><span class=\"super\"> <a href=\"showfuelalert.jsp?vehcode="+VehicleCode+"&data="+today1+"&data1="+today1+"\"><font color='red'>"+alert+"</font></a></span></div>";
				}
				else
				{
					str="<a href=\"showfuelalert.jsp?vehcode="+VehicleCode+"&data="+today1+"&data1="+today1+"\">"+alert+"</a> ";
				}
			}
		}catch (Exception e) {
			System.out.print("Exception--->"+e);
		}
		return str;
	}
	public String getFueladd(String VehicleCode)
	{
		String str="";
		String yesdate="";
		String today=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		try{
			String sql3="select DATE_ADD('"+today+"',INTERVAL -1 DAY) as newdate";
			ResultSet rs3= stmain.executeQuery(sql3);
			if(rs3.next())
			{  
				yesdate=rs3.getString("newdate");
			}
		}catch (Exception e) {
			System.out.print("Exception--->"+e);
		}
		String today1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
		int alert=0;
		try{
			String sql="select count(*) as cnt from t_veh"+VehicleCode+" where TheFieldDataDate='"+yesdate+"' and TheFiledTextFileName='FA'";
			ResultSet rst=stmain.executeQuery(sql);
			if(rst.next())
			{
				alert=rst.getInt("cnt");
				str="<a href=\"showfueladd.jsp?vehcode="+VehicleCode+"&data="+today1+"&data1="+today1+"\">"+alert+"</a> ";
			}
		}catch (Exception e) {
			System.out.print("Exception--->"+e);
		}
		return str;
	}
	public String getUnitDescription(String VehicleCode)
	{
		String desc="";
		try{
			String sql="select Description as descrip from t_vehicledetails where VehicleCode='"+VehicleCode+"'";
			ResultSet rst=stmain.executeQuery(sql);
			if(rst.next())
			{
				desc=rst.getString("descrip");


			}
		}catch (Exception e) {
			System.out.print("Exception--->"+e);
		}
		return desc;
	}

	public String  getVehRegNo(String VehCode)
	{
		String VehRegNo="";
		try{
			String sql="select * from t_vehicledetails where VehicleCode='"+VehCode+"'";
			ResultSet rst=stmain.executeQuery(sql);
			if(rst.next())
			{
				VehRegNo=rst.getString("VehicleRegNumber");
			}
		}catch (Exception e) {
			System.out.print("Exception--->"+e);
		}
		return VehRegNo;
	}
	public String getPrevFuelLevel(String VehCode, String TheDate, String TheTime)
	{
		String FuelLevel="0";
		try
		{
			String sql="select FuelLevel from t_veh"+VehCode+" where concat(TheFieldDataDate,' ',TheFieldDataTime) <'"+TheDate+' '+TheTime+"' and DataValid='Yes' and FuelLevel >0 order by concat(TheFieldDataDate,TheFieldDataTime) desc limit 1";
			ResultSet rst=stmain.executeQuery(sql);
			if(rst.next())
			{
				FuelLevel=rst.getString("FuelLevel");
			}			
		}catch (Exception e) {
			System.out.print("Exception-->"+e);
		}
		return FuelLevel;
	}

	public String checkUserBlocked(String UsetTypeValue)
	{
		String blocked="No";
		try{
			String sql="select * from t_usermessage where UserTypeValue='"+UsetTypeValue+"' and MessageId='4'";
			ResultSet rstnew=stmain.executeQuery(sql);
			if(rstnew.next())
			{
				blocked="Yes";
			}
		}catch (Exception e) {
			return blocked;
		}
		return blocked;
	}

	public ResultSet isInTrip(String vehcode, String TypeValue)
	{
		ResultSet rst=null;
		String sql="";
		try{
			/*if(TypeValue.equals("Transporter"))
			{
			 sql="select * from t_startedjourney where Vehid='"+vehcode+"' and JStatus='Running' order by StartDate desc limit 1";
			}
			else if(TypeValue.equals("zone"))
			{
				sql="select * from t_startedjourney where Vehid='"+vehcode+"' and JStatus='Running' order by StartDate desc limit 1";				
			}
			else 
			{
				sql="select * from t_startedjourney where Vehid='"+vehcode+"' and JStatus='Running' and OwnerName <> GPname order by StartDate desc limit 1";				
			}*/
			sql="select * from t_startedjourney where Vehid='"+vehcode+"' and JStatus='Running' order by StartDate desc limit 1";
			rst=stmain.executeQuery(sql);
		}catch (Exception e) {
			return rst;	
		}
		return rst;
	}

	public String isUnitRemoved(String VehCode)
	{
		String ANS="No";
		try{ 
			String sql="select Status from t_vehicledetails where VehicleCode='"+VehCode+"' and Status='Removed'";
			ResultSet rst=stmain.executeQuery(sql);
			if(rst.next())
			{
				ANS="Yes";
			}
		}catch (Exception e) {
			return ANS;
		}

		return ANS;
	}
	public ResultSet getTempValue(String VehCode)
	{
		ResultSet rst=null;
		try{
			String sql="select * from t_veh"+VehCode+" where TheFiledTextFileName = 'SI' order by concat(TheFieldDataDate,TheFieldDataTime) desc limit 1";
			rst=stmain.executeQuery(sql);
		}catch (Exception e) {
			return rst;
		}
		return rst;
	}

	public ResultSet retunOverSpeed(String VehCode, String FromDate, String ToDate)
	{
		ResultSet rst=null;
		try{
			String sql="select * from t_veh"+VehCode+"_overspeed where FromDate >='"+FromDate+"' and FromDate <='"+ToDate+"' order by Concat(FromDate,FromTime)";
			rst=stmain1.executeQuery(sql);
		}catch (Exception e) {
			System.out.print("Exception--->"+e);
		}
		return rst;
	}
	public ResultSet retunRA(String VehCode, String FromDate, String ToDate)
	{
		ResultSet rst=null;
		try{
			String sql="select * from t_veh"+VehCode+"_ra where TheDate >='"+FromDate+"' and TheDate <='"+ToDate+"' order by Concat(TheDate,TheTime) desc";
			rst=stmain1.executeQuery(sql);
		}catch (Exception e) {
			System.out.print("Exception--->"+e);
		}
		return rst;
	}
	public ResultSet retunRD(String VehCode, String FromDate, String ToDate)
	{
		ResultSet rst=null;
		try{
			String sql="select * from t_veh"+VehCode+"_rd where TheDate >='"+FromDate+"' and TheDate <='"+ToDate+"' order by Concat(TheDate,TheTime)";
			rst=stmain1.executeQuery(sql);
		}catch (Exception e) {
			System.out.print("Exception--->"+e);
		}
		return rst;
	}
	public ResultSet retunStop(String VehCode, String FromDate, String ToDate)
	{
		ResultSet rst=null;
		try{
			String sql="select * from t_veh"+VehCode+"_stsp where FromDate >='"+FromDate+"' and FromDate <='"+ToDate+"' order by Concat(FromDate,FromTime)";
			rst=stmain1.executeQuery(sql);
		}catch (Exception e) {
			System.out.print("Exception--->"+e);
		}
		return rst;
	}
	public ResultSet retunND(String VehCode, String FromDate, String ToDate)
	{
		ResultSet rst=null;
		try{
			String sql="select * from t_veh"+VehCode+"_nd where FromDate >='"+FromDate+"' and FromDate <='"+ToDate+"' order by Concat(FromDate,FromTime)";
			rst=stmain1.executeQuery(sql);
		}catch (Exception e) {
			System.out.print("Exception--->"+e);
		}
		return rst;
	}

	public ResultSet retunCD(String VehCode, String FromDate, String ToDate)
	{
		ResultSet rst=null;
		try{
			String sql="select * from t_veh"+VehCode+"_cr where FromDate >='"+FromDate+"' and FromDate <='"+ToDate+"' order by Concat(FromDate,FromTime)";
			rst=stmain1.executeQuery(sql);
		}catch (Exception e) {
			System.out.print("Exception--->"+e);
		}
		return rst;
	}
	public String getLocationByDateTime(String VehicleCode, String TheDate, String TheTime)
	{
		String str="-";
		try{
			String sql="select * from t_veh"+VehicleCode+" where TheFieldDataDate='"+TheDate+"' and TheFieldDataTime='"+TheTime+"'";
			ResultSet rst=stmain.executeQuery(sql);
			if(rst.next())
			{
				String lat1=rst.getString("LatinDec");
				String lon1=rst.getString("LonginDec");
				String disc=rst.getString("TheFieldSubject");
				str="<a href=\"shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"\" onclick=\"popWin=open('shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"', 'myWin','width=500, height=500'); popWin.focus(); return false\">"+disc+"</a>";

			}
		}catch (Exception e) {
			return "-";
		}
		return str;
	}

	public String getLocationByDateTimeOnly(String VehicleCode, String TheDate, String TheTime)
	{
		String str="-";
		try{
			String sql="select * from t_veh"+VehicleCode+" where TheFieldDataDate='"+TheDate+"' and TheFieldDataTime='"+TheTime+"'";
			ResultSet rst=stmain.executeQuery(sql);
			if(rst.next())
			{

				str=rst.getString("TheFieldSubject");

			}
		}catch (Exception e) {
			return "-";
		}
		return str;
	}

	public String getPlolyline(String vehcode,String fromdate,String fromtime,String todate,String totime)
	{
		String polyline="[",sql="";

		try{
			sql="select * from t_veh"+vehcode+" where concat(TheFieldDataDate,TheFieldDataTime)>='"+fromdate+fromtime+"' and concat(TheFieldDataDate,TheFieldDataTime)<='"+todate+totime+"' and TheFiledTextFileName='SI' and Speed >0 order by concat(TheFieldDataDate,TheFieldDataTime) ";
			ResultSet rst=stmain.executeQuery(sql);
			while(rst.next())
			{
				//var polyline = new GPolyline([new GPoint(74.8954,17.5981),new GPoint(74.8918,17.5982)],"#ff0ff0", 5, 10);
				polyline=polyline+"new GPoint("+rst.getString("Longindec")+","+rst.getString("Latindec")+"),";
			}
			polyline =polyline.substring(0,polyline.length()-1);
			polyline=polyline+"]";
		}catch (Exception e) {
			return ""+e;
		}
		return polyline;
	}
	public int KmTodayVehicle(String vehcode)
	{
		String today=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		int km=0;
		try{
			String sql="select min(Distance) as dist1, max(Distance) as dist2 from t_veh"+vehcode+" where TheFieldDataDate='"+today+"' and TheFiledTextFileName='SI' and Distance >0";
			ResultSet rst=stmain.executeQuery(sql);
			if(rst.next())
			{
				km=rst.getInt("dist2")-rst.getInt("dist1");
			}
		}catch (Exception e) {
			//System.out.println("Exception-->"+e);
			return km;
		}
		return km;
	}

	public int KmThisMonthVehicle(String vehcode)
	{

		String today=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		String firstday=today.substring(0,8)+"01";
		int km=0;
		String sql="";
		try{

			sql="select sum(Distance) as dist from t_veh"+vehcode+"_ds where TheDate >='"+firstday+"' and TheDate < '"+today+"'";
			ResultSet rst=stmain1.executeQuery(sql);
			if(rst.next())
			{
				km=rst.getInt("dist")+KmTodayVehicle(vehcode);
			}
		}catch (Exception e) {
			//System.out.println("Exception-->"+e);
			return km;
		}
		return km;
	}

	public String OSToday(String vehcode)
	{
		String today=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		String rval="0";
		try{
			String sql="select count(*) as cnt from t_veh"+vehcode+" where TheFieldDataDate='"+today+"' and TheFiledTextFileName='OS' and Speed < 80";
			ResultSet rst=stmain.executeQuery(sql);
			if(rst.next())
			{
				if(rst.getInt("cnt") >0)
				{
					rval="<a href='newos.jsp?vehcode="+vehcode+"&fromdate="+today+"&todate="+today+"'>"+rst.getInt("cnt")+"</a>";
				}
			}
		}catch (Exception e) {
			//System.out.println("Exception-->"+e);
			return rval;
		}
		return rval;
	}

	public String IgnitionONOFF(String vehcode)
	{
		String today=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		String ison="OFF";
		try{
			String sql="select FuelLevel from t_veh"+vehcode+" where TheFieldDataDate='"+today+"' and TheFiledTextFileName='SI' order by concat(TheFieldDataDate,TheFieldDataTime) desc limit 1";
			ResultSet rst=stmain.executeQuery(sql);
			if(rst.next())
			{
				if(rst.getInt("FuelLevel") >0)
				{
					ison="On";
				}
				else
				{
					ison="OFF";
				}
			}
		}catch (Exception e) {
			//System.out.println("Exception-->"+e);
			return ison;
		}
		return ison;
	}

	public ResultSet getACforDateRange(String startdate, String enddate,String vehcode)
	{
		ResultSet rst=null;
		try{
			if(startdate.length()>12)
			{
				String sql="SELECT "+
				" ra.Thedate, ra.TheTime, ra.FromSpeed, ra.ToSpeed , " +
				"	       veh.TheFieldSubject ,veh.LatinDec, veh.LonginDec, veh.ZoneColor,veh.TheFieldDataDate,veh.TheFieldDataTime,veh.Distance " +
				" FROM "+
				"(SELECT Thedate, TheTime, FromSpeed, ToSpeed"+
				"		  FROM db_gpsExceptions.t_veh"+vehcode+"_ra" +
				"			 WHERE"+
				"		  concat(TheDate,' ',TheTime)  >= '"+startdate+"'" +
				"			 AND" +
				"		  concat(TheDate,' ',TheTime)<= '"+enddate+"') ra"+
				" LEFT OUTER JOIN " +
				"   (SELECT LatinDec, LonginDec,Distance, TheFieldSubject,TheFieldDataDate,TheFieldDataTime,ZoneDesc AS ZoneColor " +
				" FROM db_gps.t_veh"+vehcode+"" +
				"	WHERE" +
				"   	TheFieldDataDateTime >= '"+startdate+"' " +
				"	AND" +
				"		 TheFieldDataDateTime<= '"+enddate+"')veh "+
				" ON(veh.TheFieldDataDate = ra.TheDate AND veh.TheFieldDataTime = ra.TheTime) " +
				" GROUP BY " +
				"	CONCAT( ra.Thedate , ra.TheTime )" +
				"ORDER BY CONCAT( ra.Thedate , ra.TheTime )";
					
					//"SELECT * FROM t_veh"+vehcode+"  where concat(TheFieldDataDate,' ',TheFieldDataTime) >='"+startdate+"' and concat(TheFieldDataDate,' ',TheFieldDataTime) <='"+enddate+"' and TheFiledTextFileName ='AC' and Distance >5 order by concat(TheFieldDataDate,' ',TheFieldDataTime) desc";
				rst=stmain.executeQuery(sql);
			}
			else
			{
				String sql="SELECT "+
				" ra.Thedate, ra.TheTime, ra.FromSpeed, ra.ToSpeed , " +
				"	       veh.TheFieldSubject ,veh.LatinDec, veh.LonginDec, veh.ZoneColor,veh.TheFieldDataDate,veh.TheFieldDataTime,veh.Distance " +
				" FROM "+
				"(SELECT Thedate, TheTime, FromSpeed, ToSpeed"+
				"		  FROM db_gpsExceptions.t_veh"+vehcode+"_ra" +
				"			 WHERE"+
				"		  concat(TheDate,' ',TheTime)  >= '"+startdate+"'" +
				"			 AND" +
				"		  concat(TheDate,' ',TheTime)<= '"+enddate+"') ra"+
				" LEFT OUTER JOIN " +
				"   (SELECT LatinDec, LonginDec,Distance, TheFieldSubject,TheFieldDataDate,TheFieldDataTime,ZoneDesc AS ZoneColor " +
				" FROM db_gps.t_veh"+vehcode+"" +
				"	WHERE" +
				"   	TheFieldDataDateTime >= '"+startdate+"' " +
				"	AND" +
				"		 TheFieldDataDateTime<= '"+enddate+"')veh "+
				" ON(veh.TheFieldDataDate = ra.TheDate AND veh.TheFieldDataTime = ra.TheTime) " +
				" GROUP BY " +
				"	CONCAT( ra.Thedate , ra.TheTime )" +
				"ORDER BY CONCAT( ra.Thedate , ra.TheTime )";
					
					//"SELECT * FROM t_veh"+vehcode+"  where TheFieldDataDate >='"+startdate+"' and concat(TheFieldDataDate,' ',TheFieldDataTime) <='"+enddate+"' and TheFiledTextFileName ='AC' and Distance >5 order by concat(TheFieldDataDate,' ',TheFieldDataTime) desc";
				rst=stmain.executeQuery(sql);
			}
		}catch (Exception e) {
			//System.out.println("Exception-->"+e);
			return rst;

		}
		return rst;
	}

	public ResultSet getDCforDateRange(String startdate, String enddate,String vehcode)
	{
		ResultSet rst=null;
		try{
			if(startdate.length()>12)
			{
				String sql="SELECT "+
				" rd.Thedate, rd.TheTime, rd.FromSpeed, rd.ToSpeed , " +
				"	       veh.TheFieldSubject , veh.LatinDec, veh.LonginDec, veh.ZoneColor,veh.TheFieldDataDate,veh.TheFieldDataTime,veh.Distance " +
				" FROM "+
				"(SELECT Thedate, TheTime, FromSpeed, ToSpeed"+
				"		  FROM db_gpsExceptions.t_veh"+vehcode+"_rd " +
				"			 WHERE"+
				"		  concat(TheDate,' ',TheTime)  >= '"+startdate+"'" +
				"			 AND" +
				"		  concat(TheDate,' ',TheTime)<= '"+enddate+"') rd "+
				" LEFT OUTER JOIN " +
				"   (SELECT LatinDec, LonginDec,Distance, TheFieldSubject, TheFieldDataDate, TheFieldDataTime, ZoneDesc AS ZoneColor " +
				" FROM db_gps.t_veh"+vehcode+"" +
				"	WHERE " +
				"   	TheFieldDataDateTime >= '"+startdate+"' " +
				"	AND " +
				"		 TheFieldDataDateTime<= '"+enddate+"')veh "+
				" ON(veh.TheFieldDataDate = rd.TheDate AND veh.TheFieldDataTime = rd.TheTime) " +
				" GROUP BY " +
				"	CONCAT( rd.Thedate , rd.TheTime )" +
				"ORDER BY CONCAT( rd.Thedate , rd.TheTime )";
					
					//"SELECT * FROM t_veh"+vehcode+"  where concat(TheFieldDataDate,' ',TheFieldDataTime) >='"+startdate+"' and concat(TheFieldDataDate,' ',TheFieldDataTime) <='"+enddate+"' and TheFiledTextFileName ='DC' and Distance <120 order by concat(TheFieldDataDate,' ',TheFieldDataTime) desc";
				rst=stmain.executeQuery(sql);
			}
			else
			{
				String sql=
					"SELECT "+
					" rd.Thedate, rd.TheTime, rd.FromSpeed, rd.ToSpeed , " +
					"	       veh.TheFieldSubject , veh.LatinDec, veh.LonginDec, veh.ZoneColor,veh.TheFieldDataDate,veh.TheFieldDataTime,veh.Distance " +
					" FROM "+
					"(SELECT Thedate, TheTime, FromSpeed, ToSpeed"+
					"		  FROM db_gpsExceptions.t_veh"+vehcode+"_rd " +
					"			 WHERE"+
					"		  concat(TheDate,' ',TheTime)  >= '"+startdate+"'" +
					"			 AND" +
					"		  concat(TheDate,' ',TheTime)<= '"+enddate+"') rd "+
					" LEFT OUTER JOIN " +
					"   (SELECT LatinDec, LonginDec,Distance, TheFieldSubject, TheFieldDataDate, TheFieldDataTime, ZoneDesc AS ZoneColor " +
					" FROM db_gps.t_veh"+vehcode+"" +
					"	WHERE " +
					"   	TheFieldDataDateTime >= '"+startdate+"' " +
					"	AND " +
					"		 TheFieldDataDateTime <= '"+enddate+"')veh "+
					" ON(veh.TheFieldDataDate = rd.TheDate AND veh.TheFieldDataTime = rd.TheTime) " +
					" GROUP BY " +
					"	CONCAT( rd.Thedate , rd.TheTime )" +
					"ORDER BY CONCAT( rd.Thedate , rd.TheTime )";
					//"SELECT * FROM t_veh"+vehcode+"  where TheFieldDataDate >='"+startdate+"' and concat(TheFieldDataDate,' ',TheFieldDataTime) <='"+enddate+"' and TheFiledTextFileName ='DC' and Distance <120 order by concat(TheFieldDataDate,' ',TheFieldDataTime) desc";
				rst=stmain.executeQuery(sql);
			}
		}catch (Exception e) {
			//System.out.println("Exception-->"+e);
			return rst;
		}
		return rst;
	}

	public ResultSet getOSforDateRange(String startdate, String enddate,String vehcode)
	{
		ResultSet rst=null;
		try{
			if(startdate.length()>12)
			{
				String sql="SELECT os.Duration, os.FromDate, os.FromTime, os.ToDate, os.ToTime," +
				"       veh.LatinDec, veh.LonginDec, veh.TheFieldSubject, veh.Distance, os.Speed, veh.ZoneColor" +
				"  FROM db_gpsExceptions.t_veh"+vehcode+"_overspeed os " +
				" LEFT OUTER JOIN (" +
				"    SELECT TheFieldDataDate, TheFieldDataTime,Distance," +
				"           MAX(LonginDec) AS LonginDec, MAX(LatinDec) AS LatinDec," +
				"           MAX(TheFieldSubject) AS TheFieldSubject, ZoneDesc AS ZoneColor" +
				"     FROM  db_gps.t_veh"+vehcode +
				"     WHERE  TheFiledTextFileName= 'OS'" +
				"     GROUP BY TheFieldDataDate, TheFieldDataTime" +
				") veh ON (veh.TheFieldDataDate = os.FromDate" +
				"   AND veh.TheFieldDataTime = os.FromTime)" +
				"WHERE 1=1 " +
				" AND concat(os.fromdate,' ',os.fromtime)>='"+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(startdate))+ "'" +
				" AND concat(os.ToDate,' ',os.ToTime)<='"+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(enddate))+ "'" +
				"ORDER BY concat(os.FromDate,os.FromTime)";
					
					//"SELECT * FROM t_veh"+vehcode+"  where concat(TheFieldDataDate,' ',TheFieldDataTime) >='"+startdate+"' and concat(TheFieldDataDate,' ',TheFieldDataTime) <='"+enddate+"' and TheFiledTextFileName ='OS' order by concat(TheFieldDataDate,' ',TheFieldDataTime) desc";
				rst=stmain.executeQuery(sql);
			}
			else
			{
				String sql="SELECT os.Duration, os.FromDate, os.FromTime, os.ToDate, os.ToTime," +
				"       veh.LatinDec, veh.LonginDec, veh.TheFieldSubject,veh.Distance, os.Speed, veh.ZoneColor" +
				"  FROM db_gpsExceptions.t_veh"+vehcode+"_overspeed os " +
				" LEFT OUTER JOIN (" +
				"    SELECT TheFieldDataDate, TheFieldDataTime,Distance," +
				"           MAX(LonginDec) AS LonginDec, MAX(LatinDec) AS LatinDec," +
				"           MAX(TheFieldSubject) AS TheFieldSubject, ZoneDesc AS ZoneColor" +
				"     FROM  db_gps.t_veh"+vehcode +
				"     WHERE  TheFiledTextFileName= 'OS'" +
				"     GROUP BY TheFieldDataDate, TheFieldDataTime" +
				") veh ON (veh.TheFieldDataDate = os.FromDate" +
				"   AND veh.TheFieldDataTime = os.FromTime)" +
				"WHERE 1=1 " +
				" AND os.fromdate>='"+new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(startdate))+ "'" +
				" AND concat(os.ToDate,' ',os.ToTime)<='"+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(enddate))+ "'" +
				"ORDER BY concat(os.FromDate,os.FromTime)";
					
					//"SELECT * FROM t_veh"+vehcode+"  where TheFieldDataDate >='"+startdate+"' and concat(TheFieldDataDate,' ',TheFieldDataTime) <='"+enddate+"' and TheFiledTextFileName ='OS' order by concat(TheFieldDataDate,' ',TheFieldDataTime) desc";
				rst=stmain.executeQuery(sql);
			}

		}catch (Exception e) {
			//System.out.println("Exception-->"+e);
			return rst;
		}
		return rst;
	}

	public String ShowOnMapOnlyByLocation(String Location, String vehcode, String Thedate)
	{
		String Loc=Location;
		try{
			String sql="select * from t_veh"+vehcode+" where TheFieldDataDate='"+Thedate+"' and TheFieldSubject='"+Loc+"'";
			ResultSet rst=stmain.executeQuery(sql);
			if(rst.next())
			{
				String lat1=rst.getString("LatinDec");
				String lon1=rst.getString("LonginDec");
				String disc=Location;
				Loc ="<a href=\"shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"\" onclick=\"popWin=open('shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"', 'myWin','width=500, height=500'); popWin.focus(); return false\">"+disc+"</a>";
			}
		}catch (Exception e) {
			//System.out.println("Exception-->"+e);
			return Loc;
		}
		return Loc;
	}
	public ResultSet GetOS_RA_RD_CR_DT_ST_DURATION_CountFromExceptionDBForDateRange(String vehcode,String FromDate, String ToDate)
	{
		ResultSet rst=null;
		try
		{
			String sql="select SUM(OSCount),SUM(RACount),SUM(RDCount),SUM(CRCount),SUM(Distance),SUM(StopCount), SUM(RDuration), SUM(FACount),SUM(FTCount),SUM(RDinSec),SUM(RDurationinHrs)  from t_veh"+vehcode+"_ds where  TheDate >='"+FromDate+"' AND TheDate <='"+ToDate+"'";
			rst=stmain1.executeQuery(sql);

		}catch (Exception e) {
			//System.out.println("Exception-->"+e);
			return rst ;
		}
		return rst;
	}
	public String isNightDrivingFormExceptionsForDateRange(String vehcode,String FromDate, String ToDate)
	{
		String ND="No";
		try
		{
			String sql="select count(*) as cnt from t_veh"+vehcode+"_ds where TheDate>='"+FromDate+"' and TheDate <='"+ToDate+"' and ND='Yes'";
			ResultSet rst=stmain1.executeQuery(sql);
			if(rst.next())
			{
				if(rst.getInt("cnt")>0)
				{
					ND="Yes";
				}
			}
		}catch (Exception e) {
			//System.out.println("Exception-->"+e);
			return ND;
		}
		return ND;
	}
	public int NightDrivingFormExceptionsForDateRange(String vehcode,String FromDate, String ToDate)
	{
		int count=0;
		try
		{
			String sql="select count(*) as cnt from t_veh"+vehcode+"_nd where FromDate>='"+FromDate+"' and FromDate <='"+ToDate+"' order by fromdate asc";
			ResultSet rst=stmain1.executeQuery(sql);
			if(rst.next())
			{
				if(rst.getInt("cnt")>0)
				{
					count=rst.getInt("cnt");
				}
			}
		}catch (Exception e) {
			//System.out.println("Exception-->"+e);
			return count;
		}
		return count;
	}
	//....for ND km
	public int NightDrivingFormExceptionsForDateRange1(String vehcode,String FromDate, String ToDate)
	{
		int count=0;
		try
		{
			String sql="select Distance cnt from t_veh"+vehcode+"_nd where FromDate>='"+FromDate+"' and FromDate <='"+ToDate+"' order by fromdate asc";
			ResultSet rst=stmain1.executeQuery(sql);
			while(rst.next())
			{
				
					count=count+rst.getInt("cnt");
				
			}
		}catch (Exception e) {
			//System.out.println("Exception-->"+e);
			return count;
		}
		return count;
	}
	
	
	
	//....
	
	
	
	
	public String ShowOnMapOnlyByDateTime(String vehcode, String Thedate,String TheTime)
	{
		String Loc="";
		try{
			String sql="select * from t_veh"+vehcode+" where TheFieldDataDate='"+Thedate+"' and TheFieldDataTime='"+TheTime+"'";
			ResultSet rst=stmain.executeQuery(sql);
			if(rst.next())
			{
				String lat1=rst.getString("LatinDec");
				String lon1=rst.getString("LonginDec");
				String disc=rst.getString("TheFieldSubject");
				Loc ="<a href=\"shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"\" onclick=\"popWin=open('shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"', 'myWin','width=500, height=500'); popWin.focus(); return false\">"+disc+"</a>";

			}
		}catch (Exception e) {
			//System.out.println("Exception-->"+e);
			return Loc;
		}
		return Loc;
	}

	public String ShowLocationOnlyByDateTime(String vehcode, String Thedate,String TheTime)
	{
		String Loc="";
		try{
			String sql="select * from t_veh"+vehcode+" where TheFieldDataDate='"+Thedate+"' and TheFieldDataTime='"+TheTime+"'";
			ResultSet rst=stmain.executeQuery(sql);
			if(rst.next())
			{
				Loc=rst.getString("TheFieldSubject");

			}
		}catch (Exception e) {
			//System.out.println("Exception-->"+e);
			return Loc;
		}
		return Loc;
	}

	public int getFuelConsumptionForDateRange(String vehcode,String FromDate, String ToDate)
	{
		int FC=0;
		try{
			String sql="select sum(FC) as FC from t_veh"+vehcode+"_ds where TheDate>='"+FromDate+"' and TheDate <='"+ToDate+"'";
			ResultSet rst=stmain2.executeQuery(sql);
			if(rst.next())
			{
				FC=rst.getInt("FC");
			}

		}catch (Exception e) {
			//System.out.println("Exception 1-->"+e);
			return FC;
		}
		return FC;
	}

	public Double getFuelAVGForDateRange(String vehcode,String FromDate, String ToDate)
	{
		Double FAVG=0.00;
		try{
			String sql="select AVG(FAVG) as FAVG from t_veh"+vehcode+"_ds where TheDate>='"+FromDate+"' and TheDate <='"+ToDate+"'";
			ResultSet rst=stmain2.executeQuery(sql);
			if(rst.next())
			{
				if(rst.getDouble("FAVG") >0)
				{
					FAVG=rst.getDouble("FAVG");
				}
				else
				{
					FAVG=0.00;
				}
			}

		}catch (Exception e) {
			//System.out.println("Exception 2-->"+e);
			return FAVG;
		}
		return FAVG;
	}
	public int getOSDurationforDateRange(String vehcode,String startdate, String enddate)
	{
		ResultSet rst=null;
		int osduration=0;
		try{
			if(startdate.length()>12)
			{
				String sql="SELECT * FROM t_veh"+vehcode+"_overspeed  where concat(FromDate,' ',FromTime) >='"+startdate+"' and concat(ToDate,' ',ToTime) <='"+enddate+"'  order by concat(FromDate,' ',FromTime) desc";
				rst=stmain1.executeQuery(sql);
			}	
			else
			{
				String sql="SELECT * FROM t_veh"+vehcode+"_overspeed  where FromDate >='"+startdate+"' and ToDate <='"+enddate+"' order by concat(FromDate,' ',FromTime) desc";
				rst=stmain1.executeQuery(sql);
			}
			if(rst.next())
			{
				if(rst.getInt("duration")>0)
				{
					osduration=rst.getInt("duration");
				}
				else{

					osduration=0;
				}
			}

		}catch (Exception e) {
			//System.out.println("Exception-->"+e);
			return osduration;
		}
		return osduration;
	}



}



