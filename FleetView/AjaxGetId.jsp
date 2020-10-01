<%@page import="org.apache.poi.hssf.record.formula.functions.Replace"%><%@ include file="Connections/conn.jsp" %>
<%!
Connection con1=null;
%>



<% 
System.out.println("========In Ajax Get Company Infoooo=========");
session.setAttribute("flag","company");
try 
{
	Class.forName(MM_dbConn_DRIVER);
	con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement stmt2 = con1.createStatement();
ResultSet rs1 = null;
String newstring = "";
boolean flag = false;
String originalcompany=request.getParameter("id");
String empid = request.getParameter("id").replaceAll(" ","");



System.out.println("*&&&&&&&&&&&******&&&&&&&&&&&&*  "+empid);
String sql2="";
String A = request.getParameter("limitcount");
int limitcnt = 0,count=0,flg=1;
limitcnt = Integer.parseInt(A);
System.out.println("?????????LimitCount"+limitcnt);

	  int j = 1;
	  String buf = "<div id='companyinfoid' style='height:100%;width:100%;overflow:auto; align:right;'><table align = 'left' >";
	  
	  if(limitcnt==0)
	  {
		   sql2 = "SELECT empid  from db_gps.t_rakshakmaster where empid like '"+empid+"%' order by empid";
		   flg=0;
	  }
	  else
	  {
		   //sql2 = "SELECT CustomerCode,SalesCustomerCode,Replace( Replace( Replace( CompanyName,'.', '') ,' ','') ,'-','') AS com,CompanyName as a from t_prospectivecustmaster where Replace( Replace( Replace( CompanyName, '.', '') , ' ', '') , '-', '') like ('"+company+"%') and IsDataValid='1'  order by CompanyName limit 0,"+limitcnt+"";
		  sql2 = "SELECT empid from db_gps.t_rakshakmaster where  empid like '"+empid+"%' order by empid limit 0,"+limitcnt+"";
		  
	  }
	  
	  
	 // String sql2 = "SELECT CustomerCode,SalesCustomerCode,Replace( Replace( Replace( CompanyName,'.', '') ,' ','') ,'-','') AS com,CompanyName as a from t_prospectivecustmaster where Replace( Replace( Replace( CompanyName, '.', '') , ' ', '') , '-', '') like ('"+company+"%') and IsDataValid='1'  order by CompanyName union SELECT CustomerCode,SalesCustomerCode,Replace( Replace( Replace( CompanyName,'.', '') ,' ','') ,'-','') AS com,CompanyName as a from t_prospectivecustmaster where Replace( Replace( Replace( CompanyName, '.', '') , ' ', '') , '-', '') like ('%"+company+"%') and IsDataValid='1'  order by CompanyName limit 0,300";
	 
	  ResultSet rs = stmt2.executeQuery(sql2);
	  if (rs.last()) {
		  count = rs.getRow();
		  rs.beforeFirst(); // not rs.first() because the rs.next() below will move on, missing the first element
		}
	  System.out.println("The Query ===>"+sql2);
	  System.out.println("cntt===>"+count);
	  
	  if (!rs.next()) {
		    System.out.println("No records found");
		    buf +="<tr><td align='left'><h4><a href='#' >No Records found</a></h4></td></tr>";
		    rs.beforeFirst();
		} else {
			//rs.first();
			System.out.println("limitcnt    "+limitcnt+"row count==>"+count+"flg val"+flg);
			  
			   if( count >= limitcnt && flg==1)
			  { 
			   	   buf +="<tr ><td ></td><td align='left'><a href='#' onclick='getCompanies(2);' >more..</a></td></tr>";
			  }
			   else 
			  {  
			   	 // buf +="<tr><td></td></tr>";
			  }
			  
			   //rs.beforeFirst();
			  do {
		    	
		        // Get data from the current row and use it
		    		
				  
				
				  
				  	
				  	{
				  		//originalcompany=originalcompany.replaceAll("\\s","");
				  		System.out.println("str==>"+originalcompany);
				  		
					  	buf += "<tr><td align = 'left'><a href='#' onclick='getTransporterDetails("+rs.getString("empid")+")';   style='color: black;'>"+rs.getString("empid")+"</a></td></tr>";
				  	}
				  		
					
				 j++; 
		    }while (rs.next());
			  buf+="<tr><td><input type='hidden'  name='element'  id='element'  value='"+limitcnt+"'/></td></tr>";
		}
	/*  while(rs.next())
	  {
		  newstring = rs.getString("com");
		  String b = rs.getString("a");
		  String type = (rs.getString("SalesCustomerCode") == null || rs.getString("SalesCustomerCode").equalsIgnoreCase("") ) ? "-" : rs.getString("SalesCustomerCode");
		  
		  String custcode = "";
		  if(type.equals("0") || type == "0")
		  {
			  type = "Prospect";
			  custcode = rs.getString("CustomerCode");
		  }
		  else	
		  {
			   type = "Customer";
			   custcode = rs.getString("SalesCustomerCode");
		  }
		  
		  
		  	System.out.println("Company Name ===>"+b+ "!!!!!! Customer Type ==>"+type);
		  	if(newstring.toLowerCase().contains(company.toLowerCase()))
		  	{
		  		//originalcompany=originalcompany.replaceAll("\\s","");
		  		System.out.println("str==>"+originalcompany);
		  		
			  	buf += "<tr><td align = 'left'><a href='#' onClick=getCustomerInfo('"+type+"','"+custcode+"');  style='color: black;'>"+rs.getString("a").replaceAll("(?i)"+originalcompany,"<font color=blue><u>"+originalcompany.toUpperCase()+"</u></font>")+".</a></td></tr>";
		  	}
			else if(rs1.getString("ContactPerson").toLowerCase().contains(company.toLowerCase()))
			{
				//company=company.replaceAll("\\s","*");
				System.out.println("str==11>"+company);
			  	buf += "<tr><td align='left'><a href='#' onClick=getCustomerInfo('"+type+"','"+custcode+"');  style='color: black;'>"+rs.getString("ContactPerson").replaceAll("(?i)"+originalcompany,"<font color=blue><u>"+originalcompany.toUpperCase()+"</u></font>")+"-> <u>"+newstring+"</u>.</a></td></tr>";
			}
			else if(rs1.getString("MobileNo").contains(company))
			{
				//company=company.replaceAll("\\s","*");
				System.out.println("str==1122>"+company);
			   	 buf += "<tr><td align='left'><a href='#' onClick=getCustomerInfo('"+type+"','"+custcode+"');  style='color: black;'>"+rs.getString("MobileNo").replaceAll("(?i)"+originalcompany,"<font color=blue><u>"+originalcompany.toUpperCase()+"</u></font>")+"-> <u>"+rs.getString("CompanyName")+".</u></a></td></tr>";
			}
		 j++; 	
			
	  }//end of while
		  */
  //new element
 
  buf += "</table></div>";
  out.println(buf);
  //System.out.println(">>>>>>>>>>>>>>>>>"+buf);
   
  buf = null;
}
catch(Exception e)
{ 
  //out.print("<div style='height:110px;width:300px;overflow:auto; align:left;'><table style='display: block';><tr><td>Exception</td></tr></table></div>");
  out.print("<div style='height:110px;width:300px;overflow:auto; align:left;'><table style='display: block';></table></div>");
}
finally
{
  con1.close();
}
%>