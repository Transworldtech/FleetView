<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%
//fixedkm="+fixedkm+"&tripexpence="+tripexpence+"&ratekm="+ratekm+"&ratehr="+ratehr+"&cal="+cal+"&sttime1="+sttime1+"&sttime2="+sttime1+"";
String fixedkm=request.getParameter("fixedkm");
String fixedtm=request.getParameter("fixedtm");
String ratekm=request.getParameter("ratekm");
String ratehr=request.getParameter("ratehr");


System.out.println("fixedtm:-"+fixedtm);
System.out.println("fixedkm:-"+fixedkm);

if(fixedtm.contains(":")){
	System.out.println("in fixedtm222");
	fixedtm=fixedtm.replaceAll(":", ".");
	//fixedtm.replaceAll(".", ":");
	System.out.println("fixedtm2:-"+fixedtm);
}
float fr=Float.parseFloat(fixedkm);
float rk=Float.parseFloat(ratekm);
float frrk=(fr*rk);
float ft=Float.parseFloat(fixedtm);
float rh=Float.parseFloat(ratehr);
float ftrh=(ft*rh);
float tripexp=frrk+ftrh;

System.out.println("tripexp:-"+tripexp);
out.print(tripexp);
%>
    