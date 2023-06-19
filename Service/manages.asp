<!--#include file = "../backend/connection/db.asp"-->
  
<%
username = Request.Cookies("LOGON_USER") 
  


T_ID = Request.Form("T_ID")
TK_Date = Request.Form("TK_Date")
insert = Request.Form("insert")  
 

if insert = "insert" Then  
 
                        sql = "INSERT INTO [TankDB].[dbo].[Tank_Dates](T_ID,TK_Date,TK_Username,TK_Status)VALUES('"&T_ID&"','"&TK_Date&"','"&username&"','1')"

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
 

' DEL = Request.Form("DEL")
' M_ID = Request.Form("M_ID")
' IF DEL = "delete" Then 
' 
'  sql = "SELECT COUNT(*) AS DuplicateCount FROM [TankDB].[dbo].[Turning_point] WHERE M_Name = '" & M_Name & "' and M_Status = '1' "
'
'        
'         Set rs = db.Execute(sql)
'
'         If Not rs.EOF Then
'
'         duplicateCount = rs("DuplicateCount")
'
'         If duplicateCount > 0 Then
'                 show = "11" 
'
'         Else
'                 sql = "Update [TankDB].[dbo].[Machine] Set  [M_Status]  = '0'  Where M_ID = '"&M_ID&"'"
'
'                         on error resume next
'
'                         db.Execute(sql)
'
'                         if err<>0 Then
'
'                                 Response.Write (Err.Description)    
'                                 response.write("0")
'                                 show = "0" 
'                                 
'                                 Else
'                                 
'                                 show = "1" 
'
'                         End if
'         End if
'
'                 Json =""
'                 Json = Json & "{" 
'                 Json = Json & """data"": "& show &"  "& vbcrlf  
'                 Json = Json & "}"
'                 
'                 Response.Write Json 
'       End if
' End IF


T_ID  = Request.Form("T_ID")  
Data = Request.Form("Data")
IF Data = "Data" Then

        sql = " SELECT * FROM [TankDB].[dbo].[Machine] a " &_   
        " Inner join [TankDB].[dbo].[Tank] b " &_
        " On a.M_ID = b.M_ID" &_
        " Left join [TankDB].[dbo].[Tank_Dates] c " &_
        " On b.T_ID = c.T_ID " &_
        " Left join [TankDB].[dbo].[CsCode] d " &_
        " On b.CS_ID = d.CS_ID " &_
        " Where b.T_ID = '"&T_ID&"' and b.T_Status = 1 " &_ 
        " order by c.TK_Id desc "
        SET rs = db.Execute(sql)

        If Not rs.EOF Then
        M_Name   = rs("M_Name")
        T_Name   = rs("T_Name")
        CS_Code   = rs("CS_Code")
        T_QTY    = rs("T_QTY")
        T_Change = rs("T_Change")
        T_Period = rs("T_Period")
        TK_Date  = rs("TK_Date") 

                ' ตรวจสอบว่าข้อมูลที่อ้างอิงถูกต้องและมีอยู่ในฐานข้อมูล
                If Not IsNull(show) And Not IsNull(T_Name) And Not IsNull(T_QTY) And Not IsNull(T_Change) And Not IsNull(T_Period) Then
                        Json = ""
                        Json = Json & "{"
                        Json = Json & """M_Name"": """ & M_Name & """ , " & vbCrLf  
                        Json = Json & """T_Name"": """ & T_Name & """ , " & vbCrLf
                        Json = Json & """CS_Code"": """ & CS_Code & """ , " & vbCrLf
                        Json = Json & """T_QTY"": """ & T_QTY & """ , " & vbCrLf
                        Json = Json & """T_Change"": """ & T_Change & """ , " & vbCrLf
                        Json = Json & """T_Period"": """ & T_Period & """ , " & vbCrLf
                        Json = Json & """TK_Date"": """ & TK_Date & """  " & vbCrLf
                        Json = Json & "}"
                        
                        Response.Write Json
                End If
        End IF
End IF




%>


