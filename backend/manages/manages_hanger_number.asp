<!--#include file = "../../lib/aspJSON1.19.asp"-->
<!--#include file = "../../backend/connection/db.asp"-->
<% 
    username = Request.Cookies("LOGON_USER") 
    Form_Number     = Request.Form("Form_Number")

For i = 1 To Form_Number
 
 sql = "SELECT  H_Number  FROM H_Hanger Order by H_Number desc"
  
    set  number = db.execute(sql)
   
     number = number("H_Number")+1
  
   sql_ = "INSERT INTO H_Hanger (H_Number)Values('"& number &"')"

   on error resume next
  db.Execute(sql_)
 
Next

        Dim show

        if err<>0 Then
         
        Response.Write (Err.Description)    
       
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