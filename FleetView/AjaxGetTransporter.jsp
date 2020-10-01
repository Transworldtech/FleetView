
<%@page import="org.apache.poi.hssf.record.formula.functions.Replace"%><%@ include file="Connections/conn.jsp" %>

<%!
Connection con1;
Statement st;
%>
<% 
try {

Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=con1.createStatement();
ResultSet rst=null;
String sql="";
boolean flag=false;
int element=99;
String transporter=request.getParameter("transporter");
transporter=transporter.replace(".","");
transporter=transporter.replace(" ","");
transporter=transporter.replace("-","");
transporter=transporter.replace("_","");
System.out.println("^^^^^^^^ "+transporter);
int cnt=0;
String A=request.getParameter("limitcount");
System.out.println(">>>>>>>>>>>>>>>>     "+A);
int limitcnt=0;
limitcnt=Integer.parseInt(A);
//String user=request.getParameter("user");

if(session.getValue("usertypevaluemain").toString().equals("Castrol"))
{ 
	sql="select distinct(VehRegNo) as grp from t_group where SepReport='Yes' and GPName='Castrol' and Replace(Replace( Replace( Replace( VehRegNo ,'.', '') ,' ','') ,'-','') ,'_','')  like '%"+transporter+"%' order by VehRegNo asc limit 0,"+limitcnt+"";		
}
else if(session.getValue("usertypevaluemain").toString().equals("DSC"))
{
	sql="select distinct(VehRegNo) as grp from t_group where GPName='DSC' and Replace(Replace( Replace( Replace( VehRegNo ,'.', '') ,' ','') ,'-','') ,'_','') like '%"+transporter+"%' order by VehRegNo asc limit 0,"+limitcnt+"";
}
else if(session.getValue("usertypevaluemain").toString().equals("Castrol EMP VEH"))
{ 
sql="select distinct(VehRegNo) as grp from t_group where SepReport='Yes' and GPName='Castrol EMP VEH' and Replace(Replace( Replace( Replace( VehRegNo ,'.', '') ,' ','') ,'-','') ,'_','')  like '%"+transporter+"%' Union select distinct(GPName) as grp from t_group where SepReport='Yes' and VehRegno IN ('Castrol East','Castrol West','Castrol North','Castrol South') and Replace(Replace( Replace( Replace( GPName ,'.', '') ,' ','') ,'-','') ,'_','')  like '"+transporter+"%' limit 0,"+limitcnt+"";		
}
else if(session.getValue("usertypevaluemain").toString().equalsIgnoreCase("DelEx All"))
{
	sql="select distinct(GPName) as grp from t_group where SepReport='Yes' and VehRegno IN ('DelEx Cargo India pvt. Ltd.') and GPName not like '%DelEx All%' and Replace(Replace( Replace( Replace( GPName ,'.', '') ,' ','') ,'-','') ,'_','') like '%"+transporter+"%' limit 0,"+limitcnt+"";
}
else if(session.getValue("usertypevaluemain").toString().equalsIgnoreCase("Nawany All"))
{
	sql="select distinct(GPName) as grp from t_group where SepReport='Yes' and VehRegno IN ('Nawany Corp (I) Ltd') and GPName not like '%Nawany All%' and Replace(Replace( Replace( Replace( GPName ,'.', '') ,' ','') ,'-','') ,'_','')  like '%"+transporter+"%' limit 0,"+limitcnt+"";
}
else if(session.getValue("usertypevaluemain").toString().equalsIgnoreCase("ACC"))
{
	sql="select distinct(GPName) as grp from t_group where SepReport='Yes' and GPName in('ACC_BCCI','ACC_PUNE','ACC _Coimbatore','ACC_BLR') and Replace(Replace( Replace( Replace( GPName ,'.', '') ,' ','') ,'-','') ,'_','')  like '%"+transporter+"%' order by GPName asc limit 0,"+limitcnt+"";
}
else if(session.getValue("usertypevaluemain").toString().equalsIgnoreCase("Praxair India Pvt.Ltd"))
{
	sql="select distinct(GPName) as grp from t_group where SepReport='Yes' and GPName in('Praxair Hospet','Praxair Paharpur','Praxair Alibaug','Praxair Asansol','Praxair Jamshedpur') and Replace(Replace( Replace( Replace( GPName ,'.', '') ,' ','') ,'-','') ,'_','')  like '%"+transporter+"%' order by GPName asc limit 0,"+limitcnt+"";
}



else if(session.getValue("usertypevaluemain").toString().equalsIgnoreCase("Crest Premedia Rakshak"))
{
	sql="select distinct(vehregno) as grp from t_group where SepReport='Yes' and GPName in('Crest Premedia Rakshak','Crest Premedia Rakshak','Crest Premedia Rakshak','Crest Premedia Rakshak','Crest Premedia Rakshak') and Replace(Replace( Replace( Replace( GPName ,'.', '') ,' ','') ,'-','') ,'_','')  like '%"+transporter+"%' order by GPName asc limit 0,"+limitcnt+"";
}





else if(session.getValue("usertypevaluemain").toString().equalsIgnoreCase("North_East_Roadways"))
{
//		sql="select distinct(GPName) as grp from t_group where SepReport='Yes' and VehRegno IN ('North East Roadways')and GPName not like '%Nawany All%' and Replace(Replace( Replace( Replace( GPName ,'.', '') ,' ','') ,'-','') ,'_','') like '%"+transporter+"%' ";
	sql="select distinct(GPName) as grp from t_group where SepReport='Yes' and VehRegno IN ('North East Roadways') and Replace(Replace( Replace( Replace( GPName ,'.', '') ,' ','') ,'-','') ,'_','') like '%"+transporter+"%' ";
}
else if(session.getValue("usertypevaluemain").toString().equalsIgnoreCase("NECC ALL"))
{
	sql="select distinct(GPName) as grp from t_group where SepReport='Yes' and VehRegno IN ('NECC Roadways') and GPName not like '%NECC ALL%' and Replace(Replace( Replace( Replace( GPName ,'.', '') ,' ','') ,'-','') ,'_','')  like '%"+transporter+"%' limit 0,"+limitcnt+"";
}
else if(session.getValue("usertypevaluemain").toString().equalsIgnoreCase("Manish Thapar"))
{
	sql="select distinct(GPName) as grp from t_group where GPName IN ('Castrol Emp West Sanchay Singh Team ','Castrol Emp Sanchay Singh Team','Nilesh Malani','Siddesh Vaity','Manish Thapar') and Replace(Replace( Replace( Replace( GPName ,'.', '') ,' ','') ,'-','') ,'_','')  like '%"+transporter+"%' limit 0,"+limitcnt+"";
}
else if(session.getValue("usertypevaluemain").toString().equalsIgnoreCase("EMehtha ALL"))
{
	sql="select distinct(GPName) as grp from t_group where VehRegno in ('EMehtha') and Replace(Replace( Replace( Replace( GPName ,'.', '') ,' ','') ,'-','') ,'_','')  like '%"+transporter+"%' limit 0,"+limitcnt+"";
}
else
	if(session.getValue("usertypevaluemain").toString().equalsIgnoreCase("IAL_INDIA"))
	{
		sql = "select distinct(grp) from (select distinct(VehRegNo) as grp from t_group where SepReport='Yes' and GPName='IAL_INDIA' and Replace(Replace( Replace( Replace( VehRegNo ,'.', '') ,' ','') ,'-','') ,'_','')  like '%"+transporter+"%' Union select distinct(GPName) as grp from t_group where SepReport='Yes' and GPName  IN ('IAL_INDIA') and Replace(Replace( Replace( Replace( GPName ,'.', '') ,' ','') ,'-','') ,'_','')  like '"+transporter+"%' ) a order by grp  limit 0,"+limitcnt+"";
	}
else
{
	
	sql="select distinct(FullName) from (select distinct FullName as FullName from t_security where TypeOfUser <> 'SUBUSER' and Replace(Replace( Replace( Replace( FullName ,'.', '') ,' ','') ,'-','') ,'_','') like '%"+transporter+"%' union select distinct(GPName) as FullName from t_group where SepReport='Yes' and Replace(Replace( Replace( Replace( GPName ,'.', '') ,' ','') ,'-','') ,'_','')  like '%"+transporter+"%' order by FullName  limit 0,"+limitcnt+") a ";		
}

if(limitcnt==0)
{
	if(session.getValue("usertypevaluemain").toString().equals("Castrol"))
	{ 
		sql="select distinct(VehRegNo) as grp from t_group where SepReport='Yes' and GPName='Castrol' and Replace(Replace( Replace( Replace( VehRegNo ,'.', '') ,' ','') ,'-','') ,'_','') like '%"+transporter+"%' order by VehRegNo asc ";		
	}
	else if(session.getValue("usertypevaluemain").toString().equals("DSC"))
	{
		sql="select distinct(VehRegNo) as grp from t_group where GPName='DSC' and Replace(Replace( Replace( Replace( VehRegNo ,'.', '') ,' ','') ,'-','') ,'_','') like '%"+transporter+"%' order by VehRegNo asc ";
	}
	else if(session.getValue("usertypevaluemain").toString().equals("Castrol EMP VEH"))
	{ 
	sql="select distinct(VehRegNo) as grp from t_group where SepReport='Yes' and GPName='Castrol EMP VEH' and Replace(Replace( Replace( Replace( VehRegNo ,'.', '') ,' ','') ,'-','') ,'_','') like '%"+transporter+"%' Union select distinct(GPName) as grp from t_group where SepReport='Yes' and VehRegno IN ('Castrol East','Castrol West','Castrol North','Castrol South') and Replace(Replace( Replace( Replace( GPName ,'.', '') ,' ','') ,'-','') ,'_','')  like '"+transporter+"%' ";		
	}
	else if(session.getValue("usertypevaluemain").toString().equalsIgnoreCase("DelEx All"))
	{
		sql="select distinct(GPName) as grp from t_group where SepReport='Yes' and VehRegno IN ('DelEx Cargo India pvt. Ltd.') and GPName not like '%DelEx All%' and Replace(Replace( Replace( Replace( GPName ,'.', '') ,' ','') ,'-','') ,'_','') like '%"+transporter+"%' ";
	}
	else if(session.getValue("usertypevaluemain").toString().equalsIgnoreCase("North_East_Roadways"))
	{
// 		sql="select distinct(GPName) as grp from t_group where SepReport='Yes' and VehRegno IN ('North East Roadways')and GPName not like '%Nawany All%' and Replace(Replace( Replace( Replace( GPName ,'.', '') ,' ','') ,'-','') ,'_','') like '%"+transporter+"%' ";
		sql="select distinct(GPName) as grp from t_group where SepReport='Yes' and VehRegno IN ('North East Roadways') and Replace(Replace( Replace( Replace( GPName ,'.', '') ,' ','') ,'-','') ,'_','') like '%"+transporter+"%' ";
	}
	
	
	
	else if(session.getValue("usertypevaluemain").toString().equalsIgnoreCase("Crest Premedia Rakshak"))
	{
		sql="select distinct(vehregno) as grp from t_group where SepReport='Yes' and GPName in('Crest Premedia Rakshak','Crest Premedia Rakshak','Crest Premedia Rakshak','Crest Premedia Rakshak','Crest Premedia Rakshak') and Replace(Replace( Replace( Replace( GPName ,'.', '') ,' ','') ,'-','') ,'_','')  like '%"+transporter+"%' order by GPName asc limit 0,"+limitcnt+"";
	}

	else if(session.getValue("usertypevaluemain").toString().equalsIgnoreCase("ACC"))
	{
		sql="select distinct(GPName) as grp from t_group where SepReport='Yes' and GPName in('ACC_BCCI','ACC_PUNE','ACC _Coimbatore','ACC_BLR') and Replace(Replace( Replace( Replace( GPName ,'.', '') ,' ','') ,'-','') ,'_','') like '%"+transporter+"%' order by GPName asc";
	}
	else if(session.getValue("usertypevaluemain").toString().equalsIgnoreCase("Praxair India Pvt.Ltd"))
	{
		sql="select distinct(GPName) as grp from t_group where SepReport='Yes' and GPName in('Praxair Hospet','Praxair Paharpur','Praxair Alibaug','Praxair Asansol','Praxair Jamshedpur') and Replace(Replace( Replace( Replace( GPName ,'.', '') ,' ','') ,'-','') ,'_','') like '%"+transporter+"%' order by GPName asc ";
	}
	else if(session.getValue("usertypevaluemain").toString().equalsIgnoreCase("NECC ALL"))
	{
		sql="select distinct(GPName) as grp from t_group where SepReport='Yes' and VehRegno IN ('NECC Roadways') and GPName not like '%NECC ALL%' and Replace(Replace( Replace( Replace( GPName ,'.', '') ,' ','') ,'-','') ,'_','') like '%"+transporter+"%' ";
	}
	else if(session.getValue("usertypevaluemain").toString().equalsIgnoreCase("Manish Thapar"))
	{
		sql="select distinct(GPName) as grp from t_group where GPName IN ('Castrol Emp West Sanchay Singh Team ','Castrol Emp Sanchay Singh Team','Nilesh Malani','Siddesh Vaity','Manish Thapar') and Replace(Replace( Replace( Replace( GPName ,'.', '') ,' ','') ,'-','') ,'_','') like '%"+transporter+"%' ";
	}
	else if(session.getValue("usertypevaluemain").toString().equalsIgnoreCase("EMehtha ALL"))
	{
		sql="select distinct(GPName) as grp from t_group where VehRegno in ('EMehtha') and Replace(Replace( Replace( Replace( GPName ,'.', '') ,' ','') ,'-','') ,'_','')  like '%"+transporter+"%' ";
	}
	else
		if(session.getValue("usertypevaluemain").toString().equalsIgnoreCase("IAL_INDIA"))
		{
			sql = "select distinct(grp) from (select distinct(VehRegNo) as grp from t_group where SepReport='Yes' and GPName='IAL_INDIA' and Replace(Replace( Replace( Replace( VehRegNo ,'.', '') ,' ','') ,'-','') ,'_','')  like '%"+transporter+"%' Union select distinct(GPName) as grp from t_group where SepReport='Yes' and GPName  IN ('IAL_INDIA') and Replace(Replace( Replace( Replace( GPName ,'.', '') ,' ','') ,'-','') ,'_','')  like '"+transporter+"%' ) a order by grp";
		}
	else
	{
		
		sql="select distinct(FullName) from (select distinct FullName as FullName from t_security where TypeOfUser <> 'SUBUSER' and Replace(Replace( Replace( Replace( FullName ,'.', '') ,' ','') ,'-','') ,'_','')  like '%"+transporter+"%' union select distinct(GPName) as FullName from t_group where SepReport='Yes' and Replace(Replace( Replace( Replace( GPName ,'.', '') ,' ','') ,'-','') ,'_','')  like '%"+transporter+"%' order by FullName ) a ";		
	}

}
System.out.println(session.getValue("usertypevaluemain"));
System.out.println("*****"+sql);
rst=st.executeQuery(sql);
String buffer="<div style='height:110px;width:300px;overflow:auto; align:left;'><table style='display: block';>";
int i=1;
while(rst.next())
{
	
	 if(session.getValue("usertypevaluemain").toString().equals("Castrol")||session.getValue("usertypevaluemain").toString().equals("DSC")|| session.getValue("usertypevaluemain").toString().equals("Castrol EMP VEH")||
             session.getValue("usertypevaluemain").toString().equalsIgnoreCase("DelEx All")|| 
          		session.getValue("usertypevaluemain").toString().equalsIgnoreCase("Nawany All")|| 
          		session.getValue("usertypevaluemain").toString().equalsIgnoreCase("North_East_Roadways")||
          		session.getValue("usertypevaluemain").toString().equalsIgnoreCase("ACC")||
          		session.getValue("usertypevaluemain").toString().equals("Praxair India Pvt.Ltd")|| 
          		session.getValue("usertypevaluemain").toString().equals("NECC ALL")||
          		session.getValue("usertypevaluemain").toString().equals("Manish Thapar") ||
          		session.getValue("usertypevaluemain").toString().equals("EMehtha ALL") ||
          		session.getValue("usertypevaluemain").toString().equalsIgnoreCase("IAL_INDIA")||session.getValue("usertypevaluemain").toString().equalsIgnoreCase("Crest Premedia Rakshak"))
	 {
		 String transporter1=rst.getString("grp");
		 buffer+="<tr><td><div align='left'><a style='color: black;' href='#' onclick='getTransporterDetails(\""+transporter1+"\");'>"+transporter1.replaceAll("(?i)"+transporter,"<font color=blue><u>"+transporter.toUpperCase()+"</u></font>")+"</a></div></tr></td>";
	i++;
	 }
	 else
	 {
		 String transporter1=rst.getString("FullName");
		// System.out.println("TJLCVB    "+transporter1	 );
		 buffer+="<tr><td><div  align='left'><a style='color: black;' href='#' onclick='getTransporterDetails(\""+transporter1+"\");'>"+transporter1.replaceAll("(?i)"+transporter,"<font color=blue><u>"+transporter.toUpperCase()+"</u></font>")+"</a></div></tr></td>";
		 i++;
	 }
	 }

System.out.println("limitcnt    "+limitcnt);
buffer+="<tr><td><input type='hidden'  name='element'  id='element'  value='"+limitcnt+"'/></td></tr>";

if(limitcnt!=0 && i>20)
{ 
	   buffer+="<tr><td align='right'><h3><a href='#' onclick='getTransporter(2);' >more..</a></h3></td></tr>";
      // buffer+="<tr><td><input type='hidden'  name='element'  id='element'  value='"+limitcnt+"'/></td></tr>";

}else{  
	   System.out.println("BUFFER HAS TO GO BLANK>>>>>>>>>>>>> .  ");
	   buffer+="<tr><td></td></tr>";
	      
}

buffer+="</table></div>";
out.println(buffer+"</select>");

buffer=null;

} catch(Exception e) { 
	out.print("<div style='height:110px;width:300px;overflow:auto; align:left;'><table style='display: block';></table></div>");
	}
	finally
	{
		st.close();
		con1.close();
	}

%>