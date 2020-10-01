<%@ page language="java" import="java.util.*"
    isErrorPage="true" %>

<H1 align="Center">Exceptions</H1>

<br><%= exception.toString() %>

<%! Enumeration parmNames; %>

<%! Enumeration attrNames; %>

<br>Parameters:

<%    parmNames = request.getParameterNames();

    while (parmNames.hasMoreElements()) {

%>

    <br><%= parmNames.nextElement().toString() %>

<%

    }

%>

<br>Attributes:

<%    attrNames = request.getAttributeNames();

    while (attrNames.hasMoreElements()) {

%>

        <br><%= attrNames.nextElement().toString() %>

<%

    }

%>
