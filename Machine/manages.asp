<!--#include file = "../backend/connection/db.asp"-->
  
<%
username = Request.Cookies("LOGON_USER") 
  
M_ID = Request.Form("M_ID")
M_Name = Request.Form("M_Name")
M_Building = Request.Form("M_Building")
insert = Request.Form("insert")  


if insert = "insert" Then 

        sql = "SELECT COUNT(*) AS DuplicateCount FROM [TankDB].[dbo].[Machine] WHERE M_Name = '" & M_Name & "' and M_Status = '1' "

        Dim rs
        Set rs = db.Execute(sql)

        If Not rs.EOF Then
        Dim duplicateCount
        duplicateCount = rs("DuplicateCount")
        
        If duplicateCount > 0 Then
                show = "11" 

        Else
        

 
                        sql = "INSERT INTO [TankDB].[dbo].[Machine](M_Name,M_Building,Username,M_Status)VALUES('"&M_Name&"','"&M_Building&"','"&username&"','1')"

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

update = Request.Form("update") 

if update = "update" Then 

        sql = "SELECT COUNT(*) AS DuplicateCount FROM [TankDB].[dbo].[Machine] WHERE M_Name = '" & M_Name & "' and M_Status = '1' and M_ID <> '"& M_ID &"' "

       
        Set rs = db.Execute(sql)

        If Not rs.EOF Then
       
        duplicateCount = rs("DuplicateCount")
        
        If duplicateCount > 0 Then
                show = "11" 

        Else 
                         
                        sql = "UPDATE [TankDB].[dbo].[Machine] SET M_Name ='"& M_Name &"' Where M_ID = '"& M_ID &"'"
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

IF DEL = "delete" Then 
 
 sql = "SELECT COUNT(*) AS DuplicateCount FROM [TankDB].[dbo].[Turning_point] WHERE M_ID = '" & M_ID & "' and TP_Status = '1' "

     
        Set rs = db.Execute(sql)

        If Not rs.EOF Then
     
        duplicateCount = rs("DuplicateCount")
        
        If duplicateCount > 0 Then
                show = "11" 

        Else
                sql = "Update [TankDB].[dbo].[Machine] Set  [M_Status]  = '0'  Where M_ID = '"&M_ID&"'"

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
%>


