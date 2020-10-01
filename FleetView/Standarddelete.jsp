<%@ include file="Connections/conn.jsp" %>
	<link rel="stylesheet" type="text/css" href="css/form.css" media="all">

<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%-- 
	Document   : brif_driverbrifsum
	Created on : June 26, 2009, 1:32:17 PM
	Author     : vikram
--%>
<html>
<head>
<script language="javascript" type="text/javascript">








//////////////////////  FOR MULTIPLE DELETE    //////////////////////////////

</script>
<style>
.popup {
background-color: #98AFC7;
position: absolute;
visibility: hidden;

.popupnew {
background-color: #98AFC7;
position: absolute;
visibility: visible;
}
</style>
<style>
#ctrip {visibility:hidden;}
</style>
</head>
<body>
<form action="" method="get" name="Standardinput" onSubmit="return validate('data','data1');">
<%!
Connection conn;
Statement st,st1,st2,st3,st4 ;
String sqln=null,sqln1=null;;
String date1, date2,datenew1,datenew2, vehcode, vehregno,tbname,sql,owner,km,rating,from,to,ndcount;
int os,ra,rd,cd,nd,osdur;
String oscount,racount,rdcount,cdcount,category="",Subcategory="",Input="",UpdatedDate="",EntryBy="",Selected="",category1="",usertypevalue="";
%>
<%

try
{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
	st2=conn.createStatement();
	st3=conn.createStatement();
	st4=conn.createStatement();
	
%>
<% 
String ak="";
String lat="",lon="",category="",subcategory="",wtype="",options="",enter="",update="",updateddatetime="",Categoery="",Categoery1="",Options="",EntryBy="";
category=request.getParameter("category");
subcategory=request.getParameter("sub");
 options=request.getParameter("input");
 enter=request.getParameter("enter");
update=request.getParameter("update");

System.out.println("-- category --"+category);
//System.out.println("-- subcategory --"+subcategory);
//System.out.println("-- options --"+options);
//System.out.println("-- enter --"+enter);
//System.out.println("-- update --"+update);

String tokencat[],tokensubcat[],tokeninput[],tokenentr[],tokenupdat[];
tokencat=category.split(",");
tokensubcat=subcategory.split(",");
tokeninput=options.split(",");
tokenentr=enter.split(",");
tokenupdat=update.split(",");

String del="";


System.out.println("-- category --"+tokencat.length);
System.out.println("-- subcategory --"+subcategory);
System.out.println("-- options --"+options);
System.out.println("-- enter --"+enter);
System.out.println("-- update --"+update);


for(int a=0;a<tokencat.length;a++)
{
	
	String sql2="select * from db_gps.t_JourneyGoals where Categoery='"+tokencat[a].trim()+"'and Options='"+tokeninput[a].trim()+"' and Categoery1='"+tokensubcat[a].trim()+"'and EntryBy='"+tokenentr[a].trim()+"'";
	ResultSet rs4=st4.executeQuery(sql2);
	System.out.println("-- querry select--11111111111111111111"+sql2);
	while(rs4.next())
	{
	//	System.out.println("*****************************************8");

		Categoery=rs4.getString("Categoery");
		Categoery1=rs4.getString("Categoery1");
		Options=rs4.getString("Options");
		EntryBy=rs4.getString("EntryBy");
		updateddatetime=rs4.getString("updateddatetime");
		//System.out.println("-- updateddatetime--"+updateddatetime);
		
		
		
	}
	if(Categoery.equalsIgnoreCase(tokencat[a].trim())&& Categoery1.equalsIgnoreCase(tokensubcat[a].trim())&& Options.equalsIgnoreCase(tokeninput[a].trim()))
	{
		
		String sql3="select * from db_gps.t_JourneyGoals where Categoery='"+tokencat[a].trim()+"'and Options='"+tokeninput[a].trim()+"' and Categoery1='"+tokensubcat[a].trim()+"'and EntryBy='"+tokenentr[a].trim()+"'";
		ResultSet rs5=st4.executeQuery(sql2);
		System.out.println("-- querry select--22222222222222222222222"+sql2);
		while(rs5.next())
		{
		//	System.out.println("*****************************************8");

			Categoery=rs5.getString("Categoery");
			Categoery1=rs5.getString("Categoery1");
			Options=rs5.getString("Options");
			EntryBy=rs5.getString("EntryBy");
			updateddatetime=rs5.getString("updateddatetime");
		//	System.out.println("-- updateddatetime--"+updateddatetime);
			
			
			
		}
		
		
		String sql="Delete from db_gps.t_JourneyGoals where  Categoery='"+tokencat[a].trim()+"' and Categoery1='"+tokensubcat[a].trim()+"' and Options like '%"+tokeninput[a].trim()+"%' and EntryBy='"+tokenentr[a].trim()+"' ";
		// System.out.println("-- Beforequerry --"+sql);
	     st.executeUpdate(sql);
	     System.out.println("-- querry 1111111111111333333333333333333333--"+sql);
	    





	 int b=0;
	String sql1=" select max(srno) from db_gps.t_JourneyGoalshistory";
	ResultSet rs3=st2.executeQuery(sql1);
	// System.out.println("-- insert querry--"+sql1);

	rs3.next();
	b=rs3.getInt(1);
	b++;

	//System.out.println("-- insert querry--");
	String insert="INSERT INTO db_gps.t_JourneyGoalshistory (Srno,Category,subcategory,Input,EntryBy) VALUES ('"+b+"','"+Categoery+"', '"+Categoery1+"', '"+options+"','"+EntryBy+"')";  
	//System.out.println("-- insert querry--"+insert);
	st3.executeUpdate(insert);
	System.out.println("-- insert querry--44444444444444444444444444444"+insert);
		
	}
	else
	{
		del="No";

		System.out.println("-- final--");
		response.sendRedirect("Standardinput.jsp?Parameter1="+del);
	}
	//if(tokencat[a].contains(">"))
			
		//	{
		//tokencat[a]=tokencat[a].replace(">","");
		//	}
	

}

del="yes";

System.out.println("-- final--");
response.sendRedirect("Standardinput.jsp?Parameter="+del);



				
%>	
	</form>  

<% 
  }catch(Exception e){
 	out.print("Exception::"+e);
 }
  finally
  {
	try
	{
	  conn.close();
	}
	catch(Exception e)
	{
		
	}
	
  }
%>

</body>
</html>
</jsp:useBean>

<%@include file="footernew.jsp" %>
