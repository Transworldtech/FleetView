<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@ include file="Connections/conndriver.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%! 
Connection con1, con2;
%>

<%
try
{//1 gps 
	Class.forName(MM_dbConn_DRIVER);
	con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	con2 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	//con2 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	
	Statement stmt=con2.createStatement(),stmt1=con2.createStatement(), stmt2=con2.createStatement();
	Statement stmt3=con2.createStatement(),stmtveh=con2.createStatement(),stmtveh1=con2.createStatement(),stmtinsert=con2.createStatement();
Statement stmt4 = con2.createStatement();
Statement stmt5 = con2.createStatement();
Statement stmtrs1 = con2.createStatement();
Statement stmtrs2 = con2.createStatement();

	ResultSet rs1=null, rs2=null, rs3=null, rsveh=null,rs = null,rsrsm=null,rsrsm1=null;
	String sql="", sql1="", sql2="", sql3="", sqlveh="",sqlupdt="",sqlupdt1="",sqlrsm="",srrsm="",sqlrsm1="",sqlrsmupdt="";
	String tm="",vcode=null;
	int maxid=0;
	String Msg = "";
	java.util.Date td =new java.util.Date();
	Format fmt = new SimpleDateFormat("yyyy-MM-dd");
	String sdt = fmt.format(td);
	String flag = "2";
	//out.print(sdt);//OwnerName,vehcles,empname,empcode,allocationDate,email
	 String OwnerName=request.getParameter("owner");
	 String vehcles=request.getParameter("vehcles");
	 
	 String empname=request.getParameter("empname");
	 System.out.println("Empname is :- "+empname);
	 
	 //String toBeCapped = "i want this sentence capitalized";
	empname = empname.replace("  "," ");
	//empname=empname.replaceFirst(" ", "");
	System.out.println("empname :- "+empname);
	 
	 String[] tokens = empname.split(" ");
	 //empname = "";

	
	 for(int i=0 ;i<tokens.length; i++)
	 {
		 System.out.println("token :- "+tokens[i]);
	 
	 }
	 
	 try
	 {
	 for(int i = 0; i < tokens.length; i++)
	 {
	     char capLetter = Character.toUpperCase(tokens[i].charAt(0));
	     empname +=  " " + capLetter + tokens[i].substring(1, tokens[i].length());
	     System.out.println("empname*************:-"+empname);
	 }

 
	 System.out.println("Empname after toupper is :- "+empname);
	 
	 }catch(Exception e){
		 e.printStackTrace();
		 System.out.println("exception :-"+e);
	 }
	 
	 //empname = Character.toUpperCase(empname.charAt(0)) + empname.substring(1);
	 
	 
	 
	 //empname = WordUtils.capitalize(empname);
	 String newempid=request.getParameter("newempid");
	 System.out.println("newempid is :- "+newempid);
	 String empcode=request.getParameter("empcode");
	 System.out.println("empcode is :- "+empcode);
	 
	 String allocationDate=request.getParameter("allocationDate");
	 System.out.println("allocationDate is :- "+allocationDate);
	 String oldempname=request.getParameter("oldempname");
	 System.out.println("oldempname is :- "+oldempname);
	 String oldusername=request.getParameter("oldusername");
	 System.out.println("oldusername is :- "+oldusername);
	 String oldmanagername=request.getParameter("oldmanagername");
	 System.out.println("oldmanagername is :- "+oldmanagername);
	 String rsmname=request.getParameter("rsmname");
	 System.out.println("rsmname is :- "+rsmname);
	 String rep=session.getValue("mainuser").toString();
	 System.out.println("1234");
	 String empid=request.getParameter("empid");
	 System.out.println("empid is :- "+empid);
	 String hod = request.getParameter("hod");
	 String email = request.getParameter("email");
	 String location =request.getParameter("location");
	 String designation = request.getParameter("designation");
	 String phno = request.getParameter("phno");
	 String checkstatus = request.getParameter("checkstatus");
	 
	 String TypeValue="",hodid = "-";
	 
	  if(oldusername.equals("-")){
	
		  empid=empname;
	 }else if(checkstatus == "Yes" || checkstatus.equalsIgnoreCase("Yes"))
	  {
		 //empid=empid;
		 //hod=hod;
	 }
	 else
	 { 
		 empid=oldusername;
		
		 hod=oldmanagername;
	 }
	 
	 System.out.println("NEW EMPID IS ====>"+empid);
	 System.out.println("NEW HODID IS ====>"+hod);
	 String transporterlist = "Castrol East,Castrol West,Castrol North,Castrol South,Castrol ILS";
	 String token[] = transporterlist.split(",");
	 int cnt = 0;
	 int vehcode=0;
	System.out.println("***** in inseremp name and data is"+OwnerName+vehcles+empname+empcode+allocationDate+email+location+checkstatus);
	 java.util.Date d = new java.util.Date();
		Format formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String s=formatter.format(d);
	 	
	 
		sqlveh="SELECT VehicleCode FROM db_gps.t_vehicledetails where VehicleRegNumber='"+vehcles+"'";
		rsveh=stmtveh.executeQuery(sqlveh);
		System.out.println("sqlveh>>>"+sqlveh);	
		 if(rsveh.next())
		 	{
			 vehcode=rsveh.getInt("VehicleCode");	
		 	}
		 
		 System.out.println("vehcode>>>"+vehcode);	
		 
		 sql = "select srno from db_gps.t_userdetails where username = '"+hod+"'";
		 
		 System.out.println("vehcode>>>  sql :-  "+sql);
		 rs = stmt.executeQuery(sql);
		 if(rs.next())
		 {
			 hodid = rs.getString("srno");
		 }
		 
		 /////////////////////////////rsm tagging code/////////////////////////
        sqlrsm = "select srno from db_gps.t_userdetails where username = '"+rsmname+"'";
		 
		 System.out.println("vehcode>>>  sqlrsm :-  "+sqlrsm);
		 rsrsm = stmtrs1.executeQuery(sqlrsm);
		 if(rsrsm.next())
		 {
			 srrsm = rsrsm.getString("srno");
		 }/* else{
			 sqlrsm1 = "select srno from db_gps.t_userdetails where FirstName = 'Rajeev' and LastName='Govil' ";
			 
			 System.out.println("vehcode>>>  sqlrsm1 :-  "+sqlrsm1);
			 rsrsm1 = stmtrs2.executeQuery(sqlrsm1);
			 if(rsrsm1.next())
			 {
				 srrsm = rsrsm1.getString("srno");
			 } 
			 
		 } */
		
		 try{
			 sqlrsmupdt="update db_gps.t_userdetails  set hodid ='"+srrsm+"' where UserName ='"+hod+"' ";
			 stmtrs2.executeUpdate(sqlrsmupdt);
			 System.out.println("sqlrsmupdt   "+sqlrsmupdt);
			 
             }catch(Exception e1)
			 {
				// out.println("Exception in update else part query>>"+e1);
				 e1.printStackTrace();
				 
			 }
		 ////////////////////////////////////////////////////////////////////////////////
		 
		 System.out.println("checkstatus  "+checkstatus);
		
		
		
		if(checkstatus == "Yes" || checkstatus.equalsIgnoreCase("Yes"))
		{
			
			
			sql = "select * from db_gps.t_security where username = '"+empid+"'  and ActiveStatus <> 'No' ";
			System.out.println("sql>>>"+sql);
			rs = stmt.executeQuery(sql);
			if(rs.next())
			{
				Msg = "1";
			}
			else
			{
				 String firstname = "",lastname = "";
				 if(empname.contains(" "))
				 {
						System.out.println("IN the if contains  ");
					 	
					 	firstname = empname.substring(0,(empname.lastIndexOf(" "))+(1));
						
					 	System.out.println("IN the if contains firstname:-  "+firstname);
						
					 	lastname = empname.substring(empname.lastIndexOf(" ")+1,empname.length());
					 	
					 	System.out.println("IN the if contains lastname:-  "+lastname);
				 }
				 else
				 {
					 System.out.println("IN the if contains lastname:-  ");
					 firstname = empname;
					 System.out.println("IN the if contains firstname:-  "+firstname);
					 lastname = "";
				 
				 }
				 
				 String sqluser = "select * from db_gps.t_userdetails where concat(firstname,' ',lastname) = '"+empname+"' ";
				 ResultSet rsuser = stmt2.executeQuery(sqluser);
				 if(rsuser.next())
				 {
					 Msg = "4";
				 }
				 else
				 {			 
				 sql1="select max(UserId) as maxid from db_gps.t_security";
				 rs1=stmt3.executeQuery(sql1);
				 if(rs1.next())
				 {
				 	maxid=rs1.getInt("maxid");
				 }
				 
				 maxid = maxid+1;
				 
				 try
				 {
				 	sqlupdt="update  db_gps.t_userdetails  set vehid ='-' where vehid ='"+vehcode+"' ";
				 	stmt5.executeUpdate(sqlupdt);
				 	System.out.println("sqlupdt   "+sqlupdt);
				 
				 }catch(Exception e1)
				 {
					 //out.println("Exception in update query>>"+e1);
					 e1.printStackTrace();
					 
				 }
				 
				 sql1="insert into db_gps.t_security (UserId,UserName,FullName,Password,TypeofUser,TypeValue,CreationDate,ExpiryDate) values ('"+maxid+"','"+empid+"', '"+empname+"', 'transworld', 'GROUP', '"+empname+"', '"+s+"','2012-12-31') ";
				 stmt1.executeUpdate(sql1);
				 
				 String abcd444=sql1.replace("'","#");	
		 		 abcd444=abcd444.replace(",","$");								
		 		 stmtveh1.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd444+"')");
		 			
				
				 
				 sql1 = "insert into db_gps.t_userdetails (UserName,Transporter,Usertype,FirstName,LastName,MobNo,Email,Designation,Location,HODID,vehid) values ('"+
						 	 empid+"','"+OwnerName+"','GROUP','"+firstname+"','"+lastname+"','"+phno+"','"+email+"','"+designation+"','"+location+"','"+hodid+"','"+vehcode+"')";
				 System.out.println("sql1********"+sql1);
				 stmt1.executeUpdate(sql1);
				abcd444=sql1.replace("'","#");	
		 		 abcd444=abcd444.replace(",","$");								
		 		 stmtveh1.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd444+"')");
		 		 
		 		sql1 = "Update t_vehicledetails set Empname ='"+empname+"' ,EmpCode = '"+empcode+"',EmpAllocationDate='"+allocationDate+"' where VehicleRegNumber = '"+vehcles+"' ";
		 		stmt1.executeUpdate(sql1);
				abcd444=sql1.replace("'","#");	
		 		 abcd444=abcd444.replace(",","$");								
		 		 stmtveh1.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd444+"')");
		 		 
		 		 String sqlgroup="select VehRegno,transporter from db_gps.t_group where VehCode='"+vehcode+"' and GPName = '"+oldempname+"'";
				 System.out.println(sqlgroup);	
				 ResultSet rsgroup=stmtinsert.executeQuery(sqlgroup);
			 		
			 		while(rsgroup.next()){
			 			String groupVehNo=rsgroup.getString("VehRegno");
			 			System.out.println(groupVehNo);
			 			String grouptransporter=rsgroup.getString("transporter");
			 			String sqlold="update t_group set VehRegno='"+groupVehNo+" del',transporter='"+grouptransporter+" del',SepReport='No',Active='No' where VehCode='"+vehcode+"' and GPName like '%"+oldempname+"%'";
			 			System.out.println(sqlold);
			 			stmtveh1.executeUpdate(sqlold);
			 			 abcd444=sqlold.replace("'","#");	
			 			abcd444=abcd444.replace(",","$");								
			 			stmtveh1.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd444+"')");
				 		String sqlgrp="insert into db_gps.t_grouphistory (GPName,VehRegno,transporter,VehCode,Status,EntBy,UpdatedDate,InsertedFrom) values ('"+oldempname+"','"+grouptransporter+"','"+groupVehNo+"','"+vehcode+"','Deleted','"+rep+"','"+sdt+"','AddEditEMPName')";
				 		System.out.println(sqlgrp);
				 		stmtveh1.executeUpdate(sqlgrp);
				 		String abcd4444=sqlgrp.replace("'","#");	
				 		abcd4444=abcd4444.replace(",","$");								
				 		stmtveh1.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd4444+"')");
			 		}
			 		
			 		sql3="insert into db_gps.t_group (GPName,VehRegno,transporter,VehCode,EntryBy)values('"+empname+"','"+OwnerName+"','"+vehcles+"','"+vehcode+"','"+rep+"')";
				 	//Query for t_sqlquery
				 	stmt1.executeUpdate(sql3);
			   			String abcd3=sql3.replace("'","#");	
			   			abcd3=abcd3.replace(",","$");								
			   			stmtinsert.executeUpdate("Insert into t_sqlquery (dbname,query) values ('db_gps','"+abcd3+"')");
		 		 
			   			for(int i = 0;i<token.length;i++)
			   			{
			   				if(OwnerName == token[i] || OwnerName.equalsIgnoreCase(token[i]) || OwnerName.contains(token[i]))
			   				{
			   					cnt++;
			   				}
			   			}
			   		 System.out.println(cnt);
			   		 if(cnt>0)
						{
							String sql4 = "select * from db_gps.t_targetpage where typevalue = '"+empname+"'";
							ResultSet rs4 = stmt4.executeQuery(sql4);
							if(rs4.next())
							{
								
							}
							else
							{
								String sql5 = "insert into db_gps.t_targetpage (typevalue,targetpage) values ('"+empname+"','castrolempmain.jsp')";
								stmt1.executeUpdate(sql5);
								String abcd44=sql5.replace("'","#");	
								abcd44=abcd44.replace(",","$");								
								stmtinsert.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd44+"')");
								
							}
						}
			   		 
			   		String sqlemphistory="insert into db_gps.t_empAllocationHistory (VehNo,VehicleCode,EmpName,EmpCode,AllocationDate,managername,RSMname,entby)values ('"+vehcles+"','"+vehcode+"','"+empname+"','"+empcode+"','"+allocationDate+"','"+oldmanagername+"','"+rsmname+"','"+rep+"')";
				 	 stmt1.executeUpdate(sqlemphistory);
				 	String abcd44=sqlemphistory.replace("'","#");	
					abcd44=abcd44.replace(",","$");								
					stmtinsert.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd44+"')");
					
					Msg = "2";
			}
		  }
			
		}
		else
		{
			
			
			System.out.println("in else of the insrtempname jsp");
			
			sql = "select * from db_gps.t_security where username = '"+empid+"'   and ActiveStatus <> 'No' ";
			rs = stmt.executeQuery(sql);
			
			System.out.println("**** HK1111  sql  "+sql);
			
			if(rs.next())
			{

				System.out.println("****");
				
				try{
					 sqlupdt="update  db_gps.t_userdetails  set vehid ='-' where vehid ='"+vehcode+"' ";
					 stmt5.executeUpdate(sqlupdt);
					 System.out.println("sqlupdt   "+sqlupdt);
					 
					 }catch(Exception e1)
					 {
						// out.println("Exception in update else part query>>"+e1);
						 e1.printStackTrace();
						 
					 }
				
				sql1=  "Update db_gps.t_userdetails set hodid = '"+hodid+"',vehid = '"+vehcode+"' where username = '"+empid+"' ";
				System.out.println("****    "+sql1);
				stmt1.executeUpdate(sql1);
				String abcd3=sql1.replace("'","#");	
	   			abcd3=abcd3.replace(",","$");								
	   			stmtinsert.executeUpdate("Insert into t_sqlquery (dbname,query) values ('db_gps','"+abcd3+"')");
				System.out.println("vehcles   "+vehcles);
	   			sql2="Update t_vehicledetails set Empname ='"+empname+"' ,EmpCode = '"+empcode+"',EmpAllocationDate='"+allocationDate+"' where VehicleRegNumber = '"+vehcles+"' ";
	   			//Query for t_sqlquery
	   			stmt1.executeUpdate(sql2);
	   			System.out.println("****    "+sql1);
	   				String abcd=sql2.replace("'","#");	
	   				abcd=abcd.replace(",","$");								
	   				stmtinsert.executeUpdate("Insert into t_sqlquery (dbname,query) values ('db_gps','"+abcd+"')");
	
	   		 String sqlgroup="select VehRegno,transporter from db_gps.t_group where VehCode='"+vehcode+"' and GPName = '"+oldempname+"'";
			 System.out.println(" 8888  "+sqlgroup);	
			 ResultSet rsgroup=stmtinsert.executeQuery(sqlgroup);
		 		
		 		while(rsgroup.next()){
		 			String groupVehNo=rsgroup.getString("VehRegno");
		 			System.out.println(groupVehNo);
		 			String grouptransporter=rsgroup.getString("transporter");
		 			String sqlold="update t_group set VehRegno='"+groupVehNo+" del',transporter='"+grouptransporter+" del',SepReport='No',Active='No' where VehCode='"+vehcode+"' and GPName like '%"+oldempname+"%'";
		 			System.out.println(sqlold);
		 			stmtveh1.executeUpdate(sqlold);
		 			String abcd444=sqlold.replace("'","#");	
		 			abcd444=abcd444.replace(",","$");								
		 			stmtveh1.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd444+"')");
			 		String sqlgrp="insert into db_gps.t_grouphistory (GPName,VehRegno,transporter,VehCode,Status,EntBy,UpdatedDate,InsertedFrom) values ('"+oldempname+"','"+grouptransporter+"','"+groupVehNo+"','"+vehcode+"','Deleted','"+rep+"','"+sdt+"','AddEditEMPName')";
			 		System.out.println(sqlgrp);
			 		stmtveh1.executeUpdate(sqlgrp);
			 		String abcd4444=sqlgrp.replace("'","#");	
			 		abcd4444=abcd4444.replace(",","$");								
			 		stmtveh1.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd4444+"')");
		 		}
	   			
	   			
			 		TypeValue=rs.getString("TypeValue");
			 		
			 		 sql3="insert into t_group (GPName,VehRegno,transporter,VehCode,EntryBy)values('"+TypeValue+"','"+OwnerName+"','"+vehcles+"','"+vehcode+"','"+rep+"')";
				 		//Query for t_sqlquery
				   		stmtinsert.executeUpdate(sql3);	
				   		System.out.println("sql3  "+sql3);
				 		String abcd1=sql3.replace("'","#");	
				   		abcd1=abcd1.replace(",","$");								
				   		stmtinsert.executeUpdate("Insert into t_sqlquery (dbname,query) values ('db_gps','"+abcd1+"')");
						
						 System.out.println("OwnerName"+OwnerName);
						 System.out.println("transporterlist"+transporterlist);
						 
						 
						 for(int i = 0;i<token.length;i++)
				   			{
							 System.out.println("***  "+OwnerName+"  token   "+token[i]);
				   				if(OwnerName == token[i] || OwnerName.equalsIgnoreCase(token[i]) || OwnerName.contains(token[i]))
				   				{
				   					
				   					cnt++;
				   				}
				   			}
						 System.out.println(cnt);
						 
						 if(cnt>0)
						{
							String sql4 = "select * from db_gps.t_targetpage where typevalue = '"+TypeValue+"'";
							ResultSet rs4 = stmt4.executeQuery(sql4);
							System.out.println("sql4  "+sql4);
							if(rs4.next())
							{
								
							}
							else
							{
								String sql5 = "insert into db_gps.t_targetpage (typevalue,targetpage) values ('"+TypeValue+"','castrolempmain.jsp')";
								stmt1.executeUpdate(sql5);
								System.out.println("sql5  "+sql5);
							}
						}
				 		
						 String sqlemphistory="insert into db_gps.t_empAllocationHistory (VehNo,VehicleCode,EmpName,EmpCode,AllocationDate,managername,RSMname,entby)values ('"+vehcles+"','"+vehcode+"','"+empname+"','"+empcode+"','"+allocationDate+"','"+oldmanagername+"','"+rsmname+"','"+rep+"')";
					 	 stmt1.executeUpdate(sqlemphistory);
					 	String abcd44=sqlemphistory.replace("'","#");	
						abcd44=abcd44.replace(",","$");								
						stmtinsert.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd44+"')");
						
						Msg = "2";
			}
			else
			{
				sql1 = "select * from db_gps.t_security where username = '"+empid+"'  and ActiveStatus = 'NO' ";
			    
				System.out.println("^^^^^^^^   Sql1 ^^^^^^ "+sql1);
				
				ResultSet rs4 = stmt1.executeQuery(sql1);
			    
				if(rs4.next())
			    {
			    		Msg = "5";
			    }
			    else
			    {
			    	Msg = "3";
			    }
			    
			}
		}
		
		
			response.sendRedirect("EditEmpName.jsp?updated="+Msg+"&id="+empid+"&empname="+empname);
			
		 	return;
}
catch(Exception e)
{
	out.print("Exception --->"+e);e.printStackTrace();
}
finally
{
	con1.close();
	con2.close();
	
}
%>

</body>
</html>