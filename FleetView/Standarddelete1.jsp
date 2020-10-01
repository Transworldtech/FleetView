<%@ include file="headernew.jsp" %>
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
String lat="",lon="",category="",subcategory="",wtype="",options="",enter="",update="";
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




System.out.println("-- category --"+tokencat[0]);
System.out.println("-- subcategory --"+subcategory);
System.out.println("-- options --"+options);
System.out.println("-- enter --"+enter);
System.out.println("-- update --"+update);
for(int a=0;a<tokencat.length;a++)
{
	String sql="Delete from db_gps.t_JourneyGoals where  Categoery='"+tokencat[a]+"' and Categoery1='"+tokensubcat[a]+"' and Options='"+options+"' and EntryBy='"+enter+"' and UpdatedDateTime='"+update+"'";




}



				
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
