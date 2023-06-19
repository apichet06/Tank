<!--#include file = "../../backend/connection/db.asp"-->
 

<%
username = Request.Cookies("LOGON_USER") 
  

T_id = Request.form("T_id")
TK_Date = Request.form("TK_Date")

sql = "INSERT INTO [TankDB].[dbo].[tank_Dates](T_Id,TK_Date,TK_Username)VALUES('"&T_id&"','"&TK_Date&"','"&username&"')"

on error resume next

        db.Execute(sql)
     
        if err<>0 Then
  
        Response.Write (Err.Description)    
        response.write("0")
        show = "0"

        Else
        
        show = "1" 

        End if
    Json =""
        Json = Json & "{" 
        Json = Json & """data"": "& show &"  "& vbcrlf  
        Json = Json & "}"
        
        Response.Write Json 

%>


