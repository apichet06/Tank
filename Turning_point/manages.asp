<!--#include file = "../backend/connection/db.asp"-->
  
<%
username = Request.Cookies("LOGON_USER") 
  

 
M_ID = Request.Form("M_ID")
T_Name = Request.Form("T_Name") 
CS_ID = Request.Form("CS_ID")  
T_QTY = Request.Form("T_QTY") 
T_Change = Request.Form("T_Change") 
T_Period = Request.Form("T_Period")  
insert = Request.Form("insert")  

 

if insert = "insert" Then 

        sql = "SELECT COUNT(*) AS DuplicateCount FROM [TankDB].[dbo].[Tank] WHERE  T_Name = '"& T_Name &"' and T_Status = '1' "

        Dim rs
        Set rs = db.Execute(sql)

        If Not rs.EOF Then
        Dim duplicateCount
        duplicateCount = rs("DuplicateCount")
        
        If duplicateCount > 0 Then
                
                show = "11" 

        Else
          
                        sql = "INSERT INTO [TankDB].[dbo].[Tank]([M_ID],[T_Name],[CS_ID],[T_QTY],[T_Change],[T_Period],[T_Status],[Username])VALUES('"&M_ID&"','"&T_Name&"','"&CS_ID&"','"&T_QTY&"','"&T_Change&"','"&T_Period&"','1','"&username&"')"

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
T_ID = Request.Form("T_ID")

IF DEL = "delete" Then 
  
                sql = "UPDATE [TankDB].[dbo].[Tank] SET T_Status = '0' WHERE T_ID = '"&T_ID&"'"

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
%>


