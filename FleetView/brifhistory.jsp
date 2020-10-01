<%@ include file="headernew.jsp" %>
<%!
Connection con1, con2;
String driveridjsp="";

%>
<form name="driverbriefingform" method="get" action="brifhistory.jsp" onSubmit="return validate();" >
<% 
try {

 Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt1=con1.createStatement();
Statement stmt2=con1.createStatement();
ResultSet rs2=null;
String sql2="";
String msg = (String)request.getParameter("msg");
String briefid = (String)request.getParameter("briefId");

%>

	<table border="0"  width="100%" class="stats">
	   <tr>
		<td>
		    <table border="0" width="100%">
			<tr>
				<td> <div align="center"> <font size="2"> <B> Driver History </B> </font> </div> </td>
			</tr>
		    </table>	

<%
	String inserted=request.getParameter("inserted");
	if(inserted==null)
	{
	}	
	else
	{ %>
		<table border="0" width="100%" class="stats">
			<tr>
				<td align="center"> <font color="maroon"> Successfully Saved</font> 
                                <font color="maroon"> And the brief Id is : <%= briefid %> </font> </td>
			</tr>
 		</table>
<%	}
%>	
		    <table class="stats">
			
			<tr>
				<td> <div align="left"> <B> Search </B> &nbsp;&nbsp;&nbsp; <input type="text" name="srchbx" id="srchbx" value="" valclass="formElement"  /> &nbsp;&nbsp;&nbsp;
                                <input type="submit" value="Submit" name="btnSearch"  " class="formElement" />
		Please enter Driver Name or Driver Id. Matching values would come below in the table automatically .
			</div>
                        </td>
			</tr>
		    </table>
		
		    <table class="stats">
                       
		       <tr>
				 <td> 
				
			<%
			System.out.println("\n\n before submit button");
			%>
                            
                        </tr>
		    </table>
		</td>
	     </tr>
	  </table>	

<%
if(request.getQueryString()!=null)
{
System.out.println("\n\n in submit button");
try {
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
 stmt1=con1.createStatement();
// 
ResultSet rs1=null;
String sql1="";
sql2 ="";
String srchval=request.getParameter("srchbx");
System.out.println("\n\n driver"+srchval);
srchval = srchval.replace(" ", "");
int i=1;
String drivname="", driverid="", trans="";
String briefId = "";

//sql1="select * from t_drivers where Owner in(select distinct(VehRegNo) from t_group where GPName='Castrol') and (DriverName like '"+srchval+"%' or DriverID like '"+srchval+"%' )  order by  DriverName asc";
//sql1="select * from t_drivers where Owner in(select distinct(VehRegNo) from t_group where GPName='Castrol') and (DriverName like 'ram pra%' or DriverID like '"+srchval+"%' )  order by  DriverName asc";
//sql1="select *  from t_drivers where Owner in(select distinct(VehRegNo) from t_group where GPName='Castrol') and (replace(driverName,' ','' ) like '%"+srchval+"%' or DriverID like '%"+srchval+"%') order by  DriverName asc";
if(session.getValue("usertypevaluemain").toString().equals("Castrol"))
{
//sql1="select *  from t_drivers where Owner in(select distinct(VehRegNo) from t_group where GPName='Castrol') and (replace(driverName,' ','' ) like '%"+srchval+"%' or DriverID like '%"+srchval+"%') and GPNAME<>'BS' order by  DriverName asc";
sql1="select a.* from db_gps.t_drivers a inner JOIN (select distinct(VehRegNo) ownername from db_gps.t_group where GPName='Castrol') b  ON a.Owner = b.ownername and (replace(a.driverName,' ','') like '%"+srchval+"%' or a.DriverID like '%"+srchval+"%') and a.GPNAME<>'BS'  order by a.DriverName";
}
else
	if(session.getValue("usertypevaluemain").toString().equals("BS"))
	{
	sql1="select *  from t_drivers where GPName='BS' and (replace(driverName,' ','' ) like '%"+srchval+"%' or DriverID like '%"+srchval+"%') order by  DriverName asc";
	}	
	else
		if(session.getValue("usertypevaluemain").toString().equals("ALL"))
		{
		sql1="select *  from t_drivers where Owner in(select distinct(VehRegNo) from t_group where GPName='BS' or GPName='Castrol') and (replace(driverName,' ','' ) like '%"+srchval+"%' or DriverID like '%"+srchval+"%') and (GPNAME='BS' or GPName='Castrol') order by  DriverName asc";
		}
		else
		{
		sql1="select *  from t_drivers where Owner='"+session.getValue("usertypevaluemain").toString()+"' and (replace(driverName,' ','' ) like '%"+srchval+"%' or DriverID like '%"+srchval+"%') order by  DriverName asc";
		}


System.out.println(sql1);
rs1=stmt1.executeQuery(sql1);
if( !(  rs1.next() ) ){
    %>
   <center> <table border='0' width='50%' class="stats"><tr> <th> Driver does not exist. </th> </tr>
<!--   //  out.print("<center> <table border='1' width='50%'><tr> <th> <a href='addDriver.jsp' >    Please Click here to add the driver.  </a> </th> </tr>");
--> 
<%
}else{
	%>
 <center> <table border='1' width='50%' class="sortable"><tr> <th> Sr.No.</th> <th> Driver Name</th> <th> Driver Id </th> <th> Transporter </th> </tr>
<%
System.out.println("in else");
ResultSet rs3 = stmt1.executeQuery(sql1);
while(rs3.next())
{
    System.out.println("in while");
	drivname=rs3.getString("DriverName");
	driverid=rs3.getString("DriverID");
	//trans=rs3.getString("Owner");
	trans="-";
	sql2="select * from t_startedjourney where DriverCode='"+driverid+"' order by StartDate Desc limit 1";
	 rs2=stmt2.executeQuery(sql2);
	if(rs2.next())
	{
		trans=rs2.getString("OwnerName");
	}
//System.out.println(driverid+"in while"+drivname);
%>
<input type="hidden" name="drivid"<%=i %> id="drivid"<%=i %> value=<%=driverid%>></input>
<input type="hidden" name="drvrname"<%=i %> id="drvrname"<%=i %> value=<%=drivname%>></input>
		
	<tr> <td  style="text-align:right"> 
  <%      
	
      /*  sql2 = "select * from t_driverbriefingquest where DriverId ="+driverid+"  ";
        ResultSet rs2=stmt2.executeQuery(sql2);
        if(rs2.next()){
            briefId = rs2.getString("SrNo");
        
        }
        */
        //checkc this ok..
        //out.print(i+"</td> <td> <a href='driverbriefhistory.jsp?briefId="+briefId+"&driverid="+driverid+"&drivername="+drivname+"&trans="+trans+"'> "+drivname+"</a> </td> <td>"+driverid+"</td> <td>"+trans+"</td> </tr>");
       %>
       <%=i %></td> <td  style="text-align:left"> <a href="driverbriefhistory.jsp?driverid=<%=driverid%>&drivername=<%=drivname%>&trans=<%=trans%>"> <%=drivname%></a> </td> <td  style="text-align:right"><%=driverid%></td> <td  style="text-align:left"><%=trans%></td> </tr>
	<%
	i++;
}
System.out.println("\n\n\n out of if else loop");
}
%>
</table></div> </td>
<%
} catch(Exception e) { }
finally
{
  con1.close();
}

}	
} catch(Exception e) { }
finally
{
con1.close();
}
%>
</form>
<%@ include file="footernew.jsp" %>
