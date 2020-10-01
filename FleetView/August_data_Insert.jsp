<%@ include file="header1.jsp" %>
<%!
	Connection con,con1,con2;
	Statement stmt,stmt1,stmt2,stmt3,stmt4,stmt5,stmt6,stmt7,stmt8,stmt9,stmt10,stmt11,stmt12,stquery;
	String sql1,sql2,sql3,sql4,sql5,sql6,sql7,sql8,sql9,sql10,sql11;
	String vehiclecode="",vehregnumber="",owner="",gpname="";
	String instdate="",calender="",calender1="",fnddate="",newdate="";
	String data;
	String data1,data2,data3,data4,data5,data6,data7,data8,data9,data10,data11,data12,data13,data14,data15,
data16,data17,data18,data19,data20,data21,data22,data23,data24,data25,data26,data27,data28,data29,
data30,data31;
%>
<%
	try
	{
		Class.forName("org.gjt.mm.mysql.Driver");
		con = DriverManager.getConnection("jdbc:mysql://localhost/db_gps","fleetview","1@flv");
		con1= DriverManager.getConnection("jdbc:mysql://localhost/db_CustomerComplaints","fleetview","1@flv");
		con2= DriverManager.getConnection("jdbc:mysql://localhost/db_gpsbills","fleetview","1@flv");
		stmt1=con.createStatement();
   		stmt2=con.createStatement();
		stmt3=con.createStatement();
		stmt4=con.createStatement();
		stmt5=con.createStatement();
		stmt6=con.createStatement();
		stmt7=con.createStatement();
		stmt8=con.createStatement();
		stmt9=con2.createStatement();
		stmt10=con.createStatement();
		stmt11=con1.createStatement();
		stmt12=con2.createStatement();
		sql1="select * from t_vehicledetails where  status='-' and installeddate <= '2009-10-31'";
		//int counttotaldays=0,diff=31;
			ResultSet rs1=stmt1.executeQuery(sql1);
			while(rs1.next())
			{
				String[] monthdates=new String[35];	
				int countyes=0,countyesstar=0,totalyes=0,totalyesstar=0,totalno=0,countno=0,counttotaldays=0,diff=31;
				calender="2009-10-01";
				calender1="2009-10-31";
				vehiclecode=rs1.getString("vehiclecode");
				vehregnumber=rs1.getString("vehicleregnumber");
				owner=rs1.getString("OwnerName");
				instdate=rs1.getString("InstalledDate");
				out.print("Installtion date"+instdate);
				sql2="select * from t_group where transporter='"+vehregnumber+"' and GPName in ('Castrol','BS')";
				ResultSet rs2=stmt2.executeQuery(sql2);
				if(rs2.next())
				{
					gpname=rs2.getString("GPName");
				}
				else
				{
					gpname="-";	
				}
		String sql9=" select To_days('"+instdate+"') - To_days('"+calender+"') as diff2";
		//out.print(sql9+"<br>");
		ResultSet rs9= stmt4.executeQuery(sql9);
		if(rs9.next())
		{ 
			// out.print("in rs9");
			int diff2=rs9.getInt("diff2");
			//  out.print("diff2 is "+diff2+"<br>");
			if(diff2<=0)
			{ 
				counttotaldays=diff;
				out.print("totaldays"+counttotaldays);
			}
			else
			{   
				String sql10=" select To_days('"+calender1+"') - To_days('"+instdate+"') as diff3";
				ResultSet rs10= stmt10.executeQuery(sql10);
				if(rs10.next())
				{  
					int diff3=rs10.getInt("diff3");  
					counttotaldays=diff3+1;
					out.print("totaldays"+counttotaldays);
					//counttotaldays=counttotaldays+diff3+1;
					// out.print("diff3 is greater than 0 ="+diff3);
					// out.print(totaldays+"<br>");
				}//if
			}//else
		}//if rs9	
		for(int j=0;j<=30;j++)
		{
   			sql3="select DATE_ADD('"+calender+"',INTERVAL '"+j+"' DAY) as newdate";
			//out.print(sql8);
   			ResultSet rs3= stmt3.executeQuery(sql3);
			if(rs3.next())
	        {  
				newdate=rs3.getString("newdate"); 
	    	    sql4="select * from t_veh"+vehiclecode+" where Thefielddatadate='"+newdate+"' and TheFieldSubject not like 'In Transworld Pune(MH)' limit 1";
			    ResultSet rs4= stmt4.executeQuery(sql4);
	    	    if(rs4.next())
				{ 
 				  		countyes++;
            	 		totalyes=totalyes;
						monthdates[j+1]="Yes";
				}
				else 
     			{	
					sql5="select * from t_specialreports where vehregno='"+vehregnumber+"' and founddate>='"+newdate+"' and founddate<='2009-10-31' order by founddate asc limit 1";
					ResultSet rs5= stmt11.executeQuery(sql5);
					if(rs5.next())
					{
						monthdates[j+1]="Yes*";
						countyesstar++;
						totalyesstar=totalyesstar;
					}//rs5
					else
					{
						monthdates[j+1]="No";
						countno++;
						totalno=countno;
					}	
				}//else
		    }//while rs4
		    out.print(monthdates[j]+",");
		} //for
		sql11="select * from t_billdetails_2009_10 where VehRegNo='"+vehregnumber+"'";
		ResultSet rs12=stmt12.executeQuery(sql11);
		if(rs12.next())
		{
		}
		else
		{
				sql9="insert into t_billdetails_2009_10(Transporter,GPName,VehRegNo,InstDate,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,D12,D13,D14,D15,D16,D17,D18,D19,D20,D21,D22,D23,D24,D25,D26,D27,D28,D29,D30,D31,TotalYes,TotalNo,TotalYesStar,TotalDays) values('"+owner+"','"+gpname+"','"+vehregnumber+"','"+instdate+"','"+monthdates[1]+"','"+monthdates[2]+"','"+monthdates[3]+"','"+monthdates[4]+"','"+monthdates[5]+"','"+monthdates[6]+"','"+monthdates[7]+"','"+monthdates[8]+"','"+monthdates[9]+"','"+monthdates[10]+"','"+monthdates[11]+"','"+monthdates[12]+"','"+monthdates[13]+"','"+monthdates[14]+"','"+monthdates[15]+"','"+monthdates[16]+"','"+monthdates[17]+"','"+monthdates[18]+"','"+monthdates[19]+"','"+monthdates[20]+"','"+monthdates[21]+"','"+monthdates[22]+"','"+monthdates[23]+"','"+monthdates[24]+"','"+monthdates[25]+"','"+monthdates[26]+"','"+monthdates[27]+"','"+monthdates[28]+"','"+monthdates[29]+"','"+monthdates[30]+"','"+monthdates[31]+"','"+countyes+"','"+countno+"','"+countyesstar+"','"+counttotaldays+"')";
				stmt9.executeUpdate(sql9);	
		}
		/*out.print("vehicle no "+vehregnumber);
		out.print("total yes"+countyes);
		out.print("total no"+countno);
		out.print("total yes *"+countyesstar);
		out.print("totaldays"+counttotaldays);
		out.print("inserted successfully");*/
	} //while
}//try
catch(Exception e)
{
	out.println(e.toString());
}
finally
{
	con.close();
	con1.close();
	con2.close();
}
%>		
