<%@ include file="headernew.jsp" %>
<%@page import="java.util.Date"%>
	<link rel="stylesheet" type="text/css" href="css/form.css" media="all">

<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">

<html>
<head>
<script>

function gotoExcel (elemId, frmFldId)  
{  try
{
	//alert("*********** ");
///	alert(elemId);
	///alert(frmFldId);

         var obj = document.getElementById(elemId);  
      //   alert(obj);
         var oFld = document.getElementById(frmFldId); 
     //    alert(oFld);
          oFld.value = obj.innerHTML;  

          document.Standardinput.action ="excel.jsp";     // CHANGE FORM NAME HERE

          document.forms["Standardinput"].submit();       // CHANGE FORM NAME HERE
}
catch(e)
{
	alert(e);
}
} 	




function toggleDetails(id,show)
{
	var popup = document.getElementById("popup"+id);
if (show) {
//	alert("in if  "+popup.Value);
popup.style.visibility = "visible";
popup.setfocus();

} else {
popup.style.visibility = "hidden";

 }
}
function toggleDetails2(id,show)
{
	//alert("in togel");
	var temp="popup_"+id;
	//alert(temp);
var popup = document.getElementById(temp);
if (show) {
	//alert("in if  "+popup.Value);
popup.style.visibility = "visible";

popup.setfocus();

} else {
popup.style.visibility = "hidden";

 }
}
function deleteselected()
{
	//alert(">>>val>>>>");
	 var cat1="ak",subcat="ak",inp="ak",entr="ak",updat="ak";
	var cntr=document.Standardinput.cntr.value;
    var subcat1;
    var inp1;
   // alert(cntr);
	var lt=document.getElementsByName("cb").length;
	//alert(lt);
	
	///    var maincbx=document.getElementsByName("maincb").length;
	//	alert(maincbx);
	//	var subcb=document.getElementsByName("cb"+i).length;
		//alert(subcb);
	
/*	if(document.getElementById("cb"+i).checked==true)
	{
			var subcb=document.getElementsByName("cb"+i).length;
			alert(subcb);
	}
	if(maincbx=1 || subcb==0)
	{
		alert("please select data to delete");
		return false;
	}*/
	
	/*if(maincbx='maincb'|| maincbx!=""||maincbx!=null)
	{
		 alert("please select data to delete");
		 return false;
	}*/
	//if(document.Standardinput.maincb.checked==false || document.getElementById("cb"+i).checked==false)
	//{
	//	     alert(">>>val>>>>");
	//	      alert("please select data to delete");
	//	      return false; 
			
	//}
	
//	else if(document.Standardinput.maincb.checked==true || document.getElementById("cb"+i).checked==true)
	//{

	
	cntr=cntr-1;
    var catf,catf1;
	if(document.Standardinput.maincb.checked==true)
	{
      //    alert(">>>>>>");

		for(var i=0;i<=lt;i++)
		{	
            
        // alert("111")
       
           try{
			if(document.getElementById("cb"+i).checked==true)
			{
			
				//alert("5555555>>>>"+i);
           //  alert(">>lt>>>>>>>>>>>>>>>>>>.>>"+subcat==0);
                
          //  if(subcat==0){
                   
 //  alert("if loop");
            //	cat1= document.getElementById("cat"+i).innerHTML;
              //  catf=cat1.substring(110,cat1.indexOf("</font>"));


          //  	alert(cat1);
   		//	 subcat= document.getElementById("subcat"+i).innerHTML;
   			  //alert("subcat lt>>"+subcat.length);

   		//		inp=document.getElementById("inp"+i).innerHTML;
   		//	 entr=document.getElementById("entr"+i).innerHTML;
   		//	 updat=document.getElementById("updat"+i).innerHTML;

            	

        //    }
       // else{
 

         //   alert("else ");
          //  	cat1= document.getElementById("cat"+i).innerHTML;
            	// catf1=cat1.substring(110,cat1.indexOf("</font>")); 
            	

      //      cat1= cat1+","+cat1; 
         //   alert("catf  in else>>>"+catf)
   		//	 subcat= subcat+","+document.getElementById("subcat"+i).innerHTML;
   		//	  alert("subcat >>>>>"+subcat);

   		//		inp=inp+","+document.getElementById("inp"+i).innerHTML;
   		//	 entr=entr+","+document.getElementById("entr"+i).innerHTML;
   			// updat=updat+","+document.getElementById("updat"+i).innerHTML;

   			if(cat1.length==2 )
        	{
        		
        		//alert("if loop11111")
      

   	        	cat1=document.getElementById("cat"+i).innerHTML;

        		
        	}else{
        		//alert("else CHHHHHHHH loop11111")

       	cat1=cat1+","+ document.getElementById("cat"+i).innerHTML;

        	}
    if(subcat.length==2 )
	{
		
		//alert("if loop11111")
		

		subcat=document.getElementById("subcat"+i).innerHTML;

		
	}else{
	//	alert("else CHHHHHHHH loop11111")

		subcat=subcat+","+document.getElementById("subcat"+i).innerHTML;

	}

    if(inp.length==2 )
	{
		
		//alert("if loop11111")
		

		inp=document.getElementById("inp"+i).innerHTML;

		
	}else{
	//	alert("else CHHHHHHHH loop11111")

		inp=inp+","+document.getElementById("inp"+i).innerHTML;

	}
	
    if(entr.length==2 )
	{
		
		//alert("if loop11111")
		

		entr=document.getElementById("entr"+i).innerHTML;

		
	}else{
		//alert("else CHHHHHHHH loop11111")

		 entr=entr+","+document.getElementById("entr"+i).innerHTML;

	}
    if(updat.length==2 )
	{
		
		//alert("if loop11111")
		

		updat=document.getElementById("updat"+i).innerHTML;

		
	}else{
		//alert("else CHHHHHHHH loop11111")

		 updat=updat+","+document.getElementById("updat"+i).innerHTML;

	}
         
        //    }
  			 
			

        //    alert("catf out in else>>>"+catf)
			 
			}			

            }catch(e){//alert(e)}
		}
			}

		}

	else
	{
        //alert("inside");
		for(var i=0;i<=lt;i++)
		{	
            
          //alert("111")
           try{
			if(document.getElementById("cb"+i).checked==true)
			{
			
			//	alert("5555555>>>>"+i);
             //alert(">>lt>>>>>>>>>>>>>>>>>>.>>"+subcat==0);
                
           // if(subcat==0){
                   
   //alert("if loop");
            	//cat1= document.getElementById("cat"+i).innerHTML;
              //  catf=cat1.substring(127,cat1.indexOf("</font>"));
              // cat1= cat1+","+cat1; 
        	

            //	alert("if  " +cat1);
   			// subcat= document.getElementById("subcat"+i).innerHTML;
   			//  alert("subcat lt>>"+subcat);

            //   subcat1=subcat.substring(17,subcat.indexof("<div>"));
            //  alert("subcat lt>4444444>"+subcat1);
   			  
   				//inp=document.getElementById("inp"+i).innerHTML;
   				//inp1=inp.substring(15,23)
   				//alert("subcat lt>55555>"+inp);
   			 //entr=document.getElementById("entr"+i).innerHTML;
   		//	alert("subcat lt>55555>"+entr);
   			 //updat=document.getElementById("updat"+i).innerHTML;
   		//	alert("subcat lt>55555>"+updat);

            	

           // }else{
 

        //    alert("else ");
    //    alert("cat1 in @@@##############ltttttt####3@@@@@@@@@@@@@@@22>>>"+cat1.length)
    //    alert("cat1 in @@@##################3@@@@@@@@@@@@@@@22>>>"+cat1==0)
            	
            	if(cat1.length==2 )
            	{
            		
            	//	alert("if loop11111")
            		

            		cat1=document.getElementById("cat"+i).innerHTML;

            		
            	}else{
            		//alert("else CHHHHHHHH loop11111")

            		cat1=cat1+","+ document.getElementById("cat"+i).innerHTML;

            	}
        if(subcat.length==2 )
    	{
    		
    	//	alert("if loop11111")
    		

    		subcat=document.getElementById("subcat"+i).innerHTML;

    		
    	}else{
    	//	alert("else CHHHHHHHH loop11111")

    		subcat=subcat+","+document.getElementById("subcat"+i).innerHTML;

    	}

        if(inp.length==2 )
    	{
    		
    		//alert("if loop11111")
    		

    		inp=document.getElementById("inp"+i).innerHTML;

    		
    	}else{
    	//	alert("else CHHHHHHHH loop11111")

    		inp=inp+","+document.getElementById("inp"+i).innerHTML;

    	}
    	
        if(entr.length==2 )
    	{
    		
    	//	alert("if loop11111")
    		

    		entr=document.getElementById("entr"+i).innerHTML;

    		
    	}else{
    		//alert("else CHHHHHHHH loop11111")

    		 entr=entr+","+document.getElementById("entr"+i).innerHTML;

    	}
        if(updat.length==2 )
    	{
    		
    	//	alert("if loop11111")
    		

    		updat=document.getElementById("updat"+i).innerHTML;

    		
    	}else{
    	//	alert("else CHHHHHHHH loop11111")

    		 updat=updat+","+document.getElementById("updat"+i).innerHTML;

    	}

    	
                 //	 catf1=cat1.substring(110,cat1.indexOf("</font>")); 
            	//alert("cat1 length in else>>>"+cat1.length)

            	
            	
            	//alert("cat1 in @@@@@@@@@@@@@@@@@@22>>>"+cat1)
            	
            ///cat1= cat1+","+cat1; 
          //  alert("cat1 in else>>>"+cat1)
   			// subcat= subcat+","+document.getElementById("subcat"+i).innerHTML;
   			 // alert("subcat lt>>"+subcat.length);

   			//	inp=inp+","+document.getElementById("inp"+i).innerHTML;
   			// entr=entr+","+document.getElementById("entr"+i).innerHTML;
   			// updat=updat+","+document.getElementById("updat"+i).innerHTML;
                 
           // }
  			 
			


			 
			}			

            }catch(e){//alert(e)}
		}
			}



		//alert("catf  in final>>>"+catf)
		//alert("cat>>>final"+cat);
		//alert(">>>sbst  final>>>."+subcat);
		//alert("inp final>>>"+inp);
	//	alert(entr);
		//alert(updat);
		}
	// } 	

			//	alert("cat1  in final>>>"+cat1)
			//	alert("catf  in subcat1>>>"+subcat)
		 window.location="Standarddelete.jsp?category="+cat1+"&sub="+subcat+" &input="+inp+" &enter="+entr+" &update="+updat+"";
			
					//alert("catf>>>"+catf)

}

function selectAll()
{

    //alert(">>>>>");

	var cntr=document.Standardinput.cntr.value;

	//alert(">>>val>>>>"+cntr)
	cntr=cntr-1;

	
	if(document.Standardinput.maincb.checked==true)
	{

      //  alert("inside")
		for(var i=0;i<=cntr;i++)
		{	

           //alert("111")
           try{
			document.getElementById("cb"+i).checked=true;
			

            }catch(e){//alert(e)}
		}
			}
	}
	else
	{
		
		for(var i=0;i<=cntr;i++)
		{	

          try{
			document.getElementById("cb"+i).checked=false;
          }catch(e){//alert(e)}
		}

			}
	}
}
function addcategory()
{
  var cat=document.getElementById("cat").Value;
  var cat=document.getElementById("subcat").Value;
  var cat=document.getElementById("inp").Value;
  var cat=document.getElementById("entr").Value;
}

function FillSubCategory2()
{
	//alert("Hiiiii");
	}

function FillSubCategory()
			{
				try{
					var b=0;
				//	alert("Hiiiii");
					var category=document.getElementById("category").value;
					
					var ajaxRequest;  // The variable that makes Ajax possible!
					try{// Opera 8.0+, Firefox, Safari
						ajaxRequest = new XMLHttpRequest();	}  
					catch (e)
					{// Internet Explorer Browsers
						try{ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");} 
						catch (e)
						{try{ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");} 
							catch (e)
							{// Something went wrong
								alert("Your browser broke!");return false;}}}
					
					ajaxRequest.onreadystatechange = function()
					{	if(ajaxRequest.readyState == 4)
						{try{	
							var reslt=ajaxRequest.responseText;
							//alert(reslt);
							reslt=reslt.replace(/^\s+|\s+$/g,'');
							var respo=reslt.split("~");
							//alert(respo);
							if(respo[0]=="Not"){
															
								
								}else 
								{	
									//alert(respo[0]);
								//	alert(respo[1]);
								//	alert(respo[2]);
									var anOption = document.createElement("category1");
									//alert(anOption);
								//	var select = document.getElementById("category1");
								//	for (i = 0; i < select.options.length; i++) {
  								//	select.options[i] = null;
								//	}
							//		
							var select = document.getElementById("category1");
								select.options.length = 0;
							
							var select = document.getElementById("category1");
							for(index in respo) {
								
	    						select.options[select.options.length] = new Option(respo[index], respo[index]);
								}

							
								}
							
							}catch(e)
							{alert(e);}}};
						
					var queryString = "?&category="+category+"";
					
					ajaxRequest.open("POST", "StandardInputAjax.jsp" + queryString, true);
					ajaxRequest.send(null); 
					}
					
				    catch(e)
					{
						alert(e);
					}
			}

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

<%
Date dte=new java.util.Date();
String data1=new SimpleDateFormat("dd-MMM-yyyy hh:MM:ss").format(dte);
System.out.println("date new" +data1);
%>


<%!
Connection conn;
Statement st,st1,st2,st3,st4 ;
String sqln=null,sqln1=null;;
String date1, date2,datenew1,datenew2, vehcode, vehregno,tbname,sql,owner,km,rating,from,to,ndcount;
int os,ra,rd,cd,nd,osdur;
String oscount,racount,rdcount,cdcount,category="",Subcategory="",Input="",UpdatedDate="",EntryBy="",Selected="",category1="",usertypevalue="";
%>
<%
String trname=request.getParameter("trNm");
String brfDate = "";
String trainername = "";
String brStatus = "";
String tripid=request.getParameter("tripid");
String pagefrom="";
pagefrom=request.getParameter("rdpassport");
String del=request.getParameter("Parameter");
System.out.println("del   "+del);
String updat=request.getParameter("Param");
System.out.println("updat   "+updat);
String updat1=request.getParameter("Parameter1");
if(updat1!=null)
{%>
	<script language="javascript" type="text/javascript">
alert("Please select data to delete");
window.location="Standardinput.jsp";
	
	</script>
	
<% }
 if(del!=null)
{%>
	<script language="javascript" type="text/javascript">
alert("Record deleted successfully");
window.location="Standardinput.jsp";
	
	</script>
	
<% }

//if(updat!=null)
//{%>
	<script language="javascript" type="text/javascript">
//alert("Record updated successfully");	
	
	
	</script>
	
<%/// }
	
	usertypevalue=session.getAttribute("usertypevalue").toString();
System.out.println("usertypevalue  "+usertypevalue);



NumberFormat nf1 = DecimalFormat.getNumberInstance();
nf1.setMaximumFractionDigits(2);
nf1.setMinimumFractionDigits(2);	
nf1.setGroupingUsed(false);
try{
category=request.getParameter("category");
if(category.equalsIgnoreCase("null"))
{category="All";}

}catch(Exception e)
{category="All";
	}
try{
category1=request.getParameter("category1");
if(category1.equalsIgnoreCase("null"))
{category1="All";}

}catch(Exception e)
{category1="All";
	}
System.out.println("category  "+category);
System.out.println("category1  "+category1);
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
<body>
<form name="Standardinput" method="post" onsubmit="return validate();" >
<div align="right">

			<table align="right"><tr>	
				<td align="right">
								<font size="1">&nbsp;&nbsp;&nbsp;<%=data1%></font>
				<a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('purchase','tableHTML');">

	     <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img>
	
					<a href="#" onclick="window.print();return false;" title="Print"><img src="images/print.jpg" width="15px" height="15px"></img></a>
			 
				</td>
		</tr></table>
	</div>
	
<table width="100%" align="center" class="" border="0">
<tr>
<td width="100%" align="center">
	<font face="Arial" size="2" color="blue"><b>&nbsp;&nbsp;&nbsp; Standard Inputs for Driver Briefing </b></font>
</td>
</tr>
</table>

	<table border="0" width="100%" align="center" class=""><br></br>
	
		<tr>
			<td id="Cat">
			<font face="Arial" size="2" color="">Category :</font> &nbsp;&nbsp;
					<select name="category" id="category" class="element select medium" style="width: 250px" onchange="javascript:FillSubCategory()">
					<option value="ALL">All</option>			
					<%
					     String sql210="select distinct(Categoery) from db_gps.t_JourneyGoals";
					                int pn=0;
										ResultSet rs210=st.executeQuery(sql210);
										while(rs210.next())
										{
									
					%>	
					     	      	<option value="<%=rs210.getString("Categoery") %>"> <%=rs210.getString("Categoery") %></option>
									<%
									pn++;
										}				
					%>
					</select>
			</td>
			<td id="subcategory1">
			<font face="Arial" size="2" color="">Sub Category :</font> &nbsp;&nbsp;
			<select name="category1" id="category1" class="element select medium" style="width: 120px" >
					<option value="All">All</option>
					<%
				//	String sql211="select distinct(Categoery1) from db_gps.t_JourneyGoals";
	            //   int pn1=0;
				//		ResultSet rs211=st.executeQuery(sql211);
					//	while(rs211.next())
					//	{
					
	%>	
<!--	     	      	<option value="< %=rs211.getString("Categoery1") %>"> < %=rs211.getString("Categoery1") %></option>-->
					<%
				//	pn1++;
				//		}		
					%>	
					</select>
						
						
			</td>
			
			
			


			
			
			<td>
			
					<input type="submit" name="submit" id="submit" style="border-style: outset; border-color: black" value="submit" >
			</td>					
		</tr>	
	</table> 
	<table> 
<td>
<!--<a href=" Standardadd.jsp?category=< %=category %>&subcategory=< %=Subcategory %>&options=< %=Input %> " id="tdx" >ADD</a>-->
<a href="#" onClick="window.open ('Standardadddemo.jsp?category=<%=category%>&subcategory=<%=Subcategory%>&options=<%=Input %>&limit=10','win1','width=800,height=200,location=0,menubar=0,scrollbars=1,status=0,toolbar=0,resizable=0,minimizable=no,Dialog=yes')"><font  size="2"><b>ADD</b></font></a> &nbsp;&nbsp;
&nbsp;&nbsp;
<!--<a href=" Standardedit.jsp"  id="tdy">EDIT</a>-->
&nbsp;&nbsp;
<a href="#" onclick="deleteselected()"><font  size="2"><b>Delete</b></font></a> &nbsp;&nbsp;
&nbsp;&nbsp;
</div>
</td>

</table>


<%
String exportFileName="Standard_input.xls";   // GIVE YOUR REPORT NAME
%>
<input type="hidden" id="tableHTML" name="tableHTML" value="" />   

	<input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 


	<div id='purchase'>
	<table style="width: 100%;" align="center" class="sortable entry">
<tr>
               <th><div align="center"> <input type="checkbox" name="maincb"  id="maincb"  value="maincb" onClick="selectAll();"/></div> </th>
				<th class="hed" align="center">Sr no</th>
				<th class="hed" align="center" id="cat">Category</th>
				<th class="hed" align="center" id="subcat">Sub Category</th>
				<th class="hed" align="center" id="inp">Input</th>
				<th class="hed" align="center" id="entr">EntryBy</th>		
				<th class="hed" align="center" >UpdatedDate</th>
				</tr>
				<%
				try
				{
					int i=1;
					int j=1;
					if(category.equalsIgnoreCase("null") || category1.equalsIgnoreCase("null"))
					{
					}else{

			     	if(category.equalsIgnoreCase("All") && category1.equalsIgnoreCase("All"))
						{
					     sqln="select * from db_gps.t_JourneyGoals";
					 	System.out.println("querry  " +sqln);
						}
			     	else if(category.equalsIgnoreCase(category) && category1.equalsIgnoreCase("All")) 
			     	{
			     		//sqln="select * from db_gps.t_JourneyGoals where Categoery1 in (select distinct(Categoery1) From db_gps.t_JourneyGoals where Categoery='"+category+"') and Categoery='"+category+"' ";
			     		sqln="select * from db_gps.t_JourneyGoals where  Categoery='"+category+"' ";
			     		System.out.println("querry 111  " +sqln);
			     	}
			     	else
			     	{
			     		sqln="select * from db_gps.t_JourneyGoals where Categoery1='"+category1+"'  and Categoery='"+category+"' ";
			     		System.out.println("querry 222  " +sqln);
			     	}
			     	
				
			
				ResultSet rsn=st.executeQuery(sqln);
			//	System.out.println("querry  " +sqln);
				while(rsn.next())
				{
					
					category=rsn.getString("Categoery");
					Subcategory=rsn.getString("Categoery1");
					Input=rsn.getString("Options");
					EntryBy=rsn.getString("EntryBy");
					UpdatedDate=rsn.getString("UpdatedDateTime");
					UpdatedDate=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(UpdatedDate));
					
					
					
					%>
					<tr>
					<td> 
					<div align="center"> <input type="checkbox" name="cb" id="cb<%=i%>"  value="cb<%=i%>" > </input> </div> 
				</td>
					<td><div align="right"><%=i %></div></td>
<!--					<td id="cat" ><div align="left"><input type="radio" value="Cate" id="Cate" class="" name="Cate" onclick="addcategory()">< %=category %></div></td>-->
<!--					<td id="cat"><div align="left">< %= category%></div></td>-->
<!--<td  align="left"><div id="cat< %=i%>" align="left">< %= category%></div></td>					-->
<td  align="left"><div  align="left">
<font size="2">

<a href="javascript:toggleDetails(<%=i%>,true);" title="Click To See the Reports" id="cat<%=i%>" ><%=category%></a> </font><br/>

<div class="popup" id="popup<%=i%>">
<table border="1" bgcolor="white" style="margin-right; ">
<!---->
<tr>
<td><a href="javascript:toggleDetails(<%=i%>,false);" onclick="window.open ('Standardedit.jsp?category=<%=category%>&subcategory=<%=Subcategory%>&options=<%=Input %>&limit=10','win1','width=700,height=300,location=0,menubar=0,scrollbars=1,status=0,toolbar=0,resizable=0,minimizable=no,Dialog=yes')"><font size="2"></font>&nbsp;&nbsp;Edit</a>
</td></tr>
<tr><td><a href="javascript:toggleDetails(<%=i%>,false);">Close</a></td></tr>
</table></div></div> 
</td>
					
					<td  align="left"><div id="subcat<%=i%>" align="left"><%= Subcategory%></div></td>
					<td align="left"><div  id="inp<%=i%>" align="left"><%=Input%></div></td>
					<td  align="left"><div id="entr<%=i%>" align="left"> <%=EntryBy%> </div>   </td>
					<td  align="right"><div id="updat<%=i%>" align="right"> <%=UpdatedDate%></div>  </td>
					
					
					<%
					i++;
				}
					}
				%>
				<input type="hidden" name="cntr" id="cntr"  value="<%=i%>" />	
				<%
				}
				catch(Exception e)
				{
					e.printStackTrace();
				}
				%>
					
				</tr>
			
				</table>
				</div>
				
	
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
