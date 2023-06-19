<!--#include file = "../backend/connection/db.asp"-->
<%

T_ID = Request.Form("T_ID")
Data = Request.Form("insert")

IF Data = "insert" Then 

sql = "Select Count(*) as DuplicateCount From [TankDB].[dbo].[QrCode] Where T_ID = '"&T_ID&"'"
   SET rs = db.Execute(sql)
        If Not rs.EOF Then
        Dim duplicateCount
        duplicateCount = rs("DuplicateCount")
        
            If duplicateCount <= 0 Then 
 
               sql = "INSERT INTO [TankDB].[dbo].[QrCode](T_ID)VALUES('"&T_ID&"')"

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
          
        End IF
 

       End IF
  
End IF

cleanup = Request.Form("cleanup")

IF cleanup = "cleanup" Then 

      sql = "Delete From [TankDB].[dbo].[QrCode]"

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

End If 

%>