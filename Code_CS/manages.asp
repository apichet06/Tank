<!--#include file = "../backend/connection/db.asp"-->
  
<%
username = Request.Cookies("LOGON_USER") 
  
 
CS_Code = Request.Form("CS_Code") 
insert = Request.Form("insert")  


if insert = "insert" Then 

        sql = "SELECT COUNT(*) AS DuplicateCount FROM [TankDB].[dbo].[CsCode] WHERE CS_Code = '" & CS_Code & "' and CS_Status = '1' "
 
        Set rs = db.Execute(sql)

        If Not rs.EOF Then
       
        duplicateCount = rs("DuplicateCount")
        
        If duplicateCount > 0 Then
                show = "11" 

        Else
         
 
                        sql = "INSERT INTO [TankDB].[dbo].[CsCode](CS_Code,Username,CS_Status)VALUES('"&CS_Code&"' ,'"&username&"','1')"

                        on error resume next

                        db.Execute(sql)
     
                        if err<>0 Then
                
                                Response.Write (Err.Description)    
                                response.write("0")
                                show = "0" 
                                
                                Else
                                
                                show = "1" 

                        End if
 
        End If

        Json =""
        Json = Json & "{" 
        Json = Json & """data"": "& show &"  "& vbcrlf  
        Json = Json & "}"
        
        Response.Write Json 

   
        End If
End If

DEL = Request.Form("DEL")
CS_ID = Request.Form("CS_ID")

IF DEL = "delete" Then 
 
           sql = "SELECT COUNT(*) AS DuplicateCount FROM [TankDB].[dbo].[Tank] WHERE CS_ID = '"&CS_ID&"' and T_Status = '1'  "
        
        Set rs = db.Execute(sql)

        If Not rs.EOF Then 
        duplicateCount = rs("DuplicateCount")
        
                If duplicateCount > 0 Then
                        show = "11" 

                Else

                        sql = "UPDATE [TankDB].[dbo].[CsCode] SET CS_Status = '0' WHERE CS_ID = '"&CS_ID&"'"

                                on error resume next

                                db.Execute(sql)
        
                                if err<>0 Then
                        
                                        Response.Write (Err.Description)    
                                        response.write("0")
                                        show = "0" 
                                        
                                        Else
                                        
                                        show = "1" 

                                End if
                End if
        
                Json =""
                Json = Json & "{" 
                Json = Json & """data"": "& show &"  "& vbcrlf  
                Json = Json & "}"
                
                Response.Write Json 
        End if
End IF


update = Request.Form("update")  

if update = "update" Then 

        sql = "SELECT COUNT(*) AS DuplicateCount FROM [TankDB].[dbo].[CsCode] WHERE CS_Code = '" & CS_Code & "' and CS_Status = '1' and CS_ID <> '"& CS_ID &"' "

        
        Set rs = db.Execute(sql)

        If Not rs.EOF Then 
        duplicateCount = rs("DuplicateCount")
        
        If duplicateCount > 0 Then
                show = "11" 

        Else
          
                        
                        sql = "Update [TankDB].[dbo].[CsCode] SET CS_Code = '"& CS_Code &"' Where CS_ID = '"& CS_ID &"'"   
                        on error resume next

                        db.Execute(sql)
     
                        if err<>0 Then
                
                                Response.Write (Err.Description)    
                                response.write("0")
                                show = "0" 
                                
                                Else
                                
                                show = "1" 

                        End if
 
        End If

        Json =""
        Json = Json & "{" 
        Json = Json & """data"": "& show &"  "& vbcrlf  
        Json = Json & "}"
        
        Response.Write Json 

   
        End If
End If


%>


