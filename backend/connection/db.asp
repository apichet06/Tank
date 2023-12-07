<!--#include file = "./db-96.asp"-->
<!--#include file = "./db-95.asp"-->
<!--#include file = "./db-50.asp"-->
<!--#include file = "./db-71.asp"-->
<!--#include file = "./db-thtprod.asp"-->

<%

  session.codepage=65001
  
  If Request.ServerVariables("SERVER_NAME") = "localhost" Then
    SET db = db50
  Else
     SET db = db71
    'SET db = dbFOI
  End If

%>