<%@ Language="VBScript" %>
<%
Response.CodePage = 65001
Response.Charset = "UTF-8"
Session.CodePage = 65001
Session.LCID = 1054

T_ID = Request.QueryString("T_ID")

%>
<% username=Request.Cookies("LOGON_USER") 'esponse.write (username)
If username ="" Then
    Response.Write("<script>") 
    Response.Write("window.location.href = ' http://192.168.35.5/login.asp?href=http://192.168.35.5/Tank/scan/default.asp?T_ID=" & T_ID & "'; ")
    Response.Write(" </script>")
  End If
 
  %>
    <!--#include file = "../backend/connection/db.asp"-->


<!DOCTYPE html>
<html lang="th">
    <head>
        <title>TANK</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1">  
        <link rel="stylesheet" href="../css/bootstrap.min.css">
        <link rel="stylesheet" href="../css/tempusdominus-bootstrap-4.min.css"/>
        <link rel="stylesheet" href="../css/Awesome_all.min.css">
        <link rel="stylesheet" href="../css/select2.min.css"> 
        <link rel="stylesheet" href="../css/adminlte.min.css">
        <!-- <link rel="stylesheet" type="text/css" href="../font/stylesheet.css"> -->
    </head>
 <style>

 </style>

    <body >
     <!--#include file="./menu.asp"-->  
     <!--#include file="../lib/utility.asp"-->  
     <div class="container-fluid">
         <div class="row justify-content-center"> 
            <div class="col-md-12 text-center">
                  <h4>ประวัติการเปลี่ยน CS Part</h4> <hr/>
            </div>
             <div class="col-md-12 text-center">
                  <h4> <a href="./default.asp?T_ID=<%=T_ID%>"><i class="fa-solid fa-house-chimney"></i></a></h4> <hr/>
            </div>
            <div class="col-md-12 ">
                                    <div class="row justify-content-center">
                                        
                                                                    <%
                                                            
                                                                    i=1
                                                                    sql =   " SELECT  (a.M_Name) as M_Name,(b.T_Name) as T_Name,(b.T_Change) as T_Change,(b.T_Period) as T_Period,(T_QTY) as T_QTY,(CONVERT(varchar(19), d.TK_Date, 120)) as TK_Date,(CS_Code)as CS_Code  " &_
                                                                            " FROM [TankDB].[dbo].[Machine] a " &_ 
                                                                            " LEFT JOIN [TankDB].[dbo].[Tank] b ON b.M_ID = a.M_ID " &_
                                                                            " LEFT JOIN [TankDB].[dbo].[CsCode] c ON c.CS_ID = b.CS_ID " &_
                                                                            " LEFT JOIN [TankDB].[dbo].[Tank_Dates] d ON d.T_ID = b.T_ID " &_
                                                                            " WHERE b.T_Status = 1 and b.T_ID = '"&T_ID&"' " &_ 
                                                                            " ORDER BY (d.TK_Id) DESC "

                                                                            on error resume next

                                                                            SET rs = db.Execute(sql)
                                                                                While Not rs.EOF
                                                                                M_Name   = rs("M_Name")
                                                                                CS_Code = rs("CS_Code")
                                                                                T_Name   = rs("T_Name")
                                                                                T_QTY    = rs("T_QTY")
                                                                                T_Change = rs("T_Change")
                                                                                T_Period = rs("T_Period")
                                                                                TK_Date  =  rs("TK_Date")   
                                                                    %> 
                                                                    <div class="col-md-4">  
                                                                        <div class="card"> 
                                                                            <div class="card-body">  
                                                                            <div class="text-center">
                                                                                                    *** <%=i%> ***
                                                                                                </div> 
                                                                                                <table class="table table-sm">
                                                                                                <thead>
                                                                                                <tr>
                                                                                                    <th class="text-right">ชื่อเครื่องจักร :</th>
                                                                                                    <th ><%=M_Name  %></th> 
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <th class="text-right">จุดที่เปลี่ยน :</th>
                                                                                                    <th ><%=T_Name  %></th> 
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <th class="text-right">Code CS :</th>
                                                                                                    <th > <%=CS_Code  %></th> 
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <th class="text-right">จำนวนที่ต้องเปลี่่ยน :</th>
                                                                                                    <th ><%=T_QTY %>  EA</th> 
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <th class="text-right">ความถี่ในการเปลี่ยน :</th>
                                                                                                    <th > <%=T_Change &" "& UCase(T_Period) %></th> 
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <th class="text-right text-secondary">วันที่เปลี่ยน ล่าสุด :</th>
                                                                                                    <th class="text-secondary"><% IF IsNull(TK_Date) Then response.write("N/A") Else response.write DateNow(rs("TK_Date")) End IF  %></th> 
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <th class="text-right text-secondary">เปลี่ยนครั้งถัดไป :</th>
                                                                                                    <th class="text-secondary"><% IF IsNull(TK_Date) Then response.write("N/A") Else response.write DataDate(TK_Date, T_Change, T_Period) %> </th> 
                                                                                                </tr>
                                                                                                </thead> 
                                                                                            </table> 
                                                                                              
                                                                                   </div> 
                                                                         </div>
                                                                 </div>     
                                                                        
                                                                 <%
                                                                                i = i + 1
                                                                                rs.MoveNext
                                                                        Wend
                                                                    %>     
                                                 
                                        
                                    </div> 
                      </div>    
                </div>  
         </div>
    </body>
</html>
  
     <script src="../js/jquery.min.js"></script>
      <script src="../js/bootstrap.bundle.min.js"></script>      
      <script src="../js/select2.full.js"></script>
      <script src="../js/sweetalert2@11.js"></script>
      <script src="../js/moment.min.js"></script>  
      <script src="../js/tempusdominus-bootstrap-4.min.js"></script>
      <script src="../js/all.min.js"></script> 
     