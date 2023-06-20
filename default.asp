<%@ Language="VBScript" %>
<%
Response.CodePage = 65001
Response.Charset = "UTF-8"
Session.CodePage = 65001
Session.LCID = 1054
%>
<% username=Request.Cookies("LOGON_USER") 'esponse.write (username)
If username ="" Then
    Response.Write("<script>") 
    Response.Write("window.location.href = ' http://192.168.35.5/login.asp?href=http://192.168.35.5/Tank/default.asp'; ")
    Response.Write(" </script>")
  End If
 
  %>
    <!--#include file = "./backend/connection/db.asp"-->


<!DOCTYPE html>
<html lang="th">
    <head>
        <title>TANK</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1">  
        <link rel="stylesheet" href="./css/bootstrap.min.css">
        <link rel="stylesheet" href="./css/tempusdominus-bootstrap-4.min.css"/>
        <link rel="stylesheet" href="./css/Awesome_all.min.css">
        <link rel="stylesheet" href="./css/select2.min.css"> 
        <link rel="stylesheet" href="./css/adminlte.min.css">
        <link rel="stylesheet" href="./font01/stylesheet.css">
    </head>
 <style>
  body{
    /* font-family: 'kanit_mediumregular', sans-serif;  */
    }
 </style>

    <body >
     <!--#include file="./memu/menu.asp"-->  
     <!--#include file="./lib/utility.asp"-->  
     <div class="container-fluid">
         <div class="row justify-content-center"> 
            <div class="col-md-12 text-center">
                  <h3 class="text-info">(Machine)เครื่องจักรทั้งหมด</h3> <hr>
            </div>
            <hr/>
                        <div class="col-md-12">  
                                    <div class="row  ">
  
                                                <% 
                                                i=1
                                                sql =   " SELECT  MAX(a.M_Name) as M_Name,MAX(b.T_Name) as T_Name,MAX(b.T_Change) as T_Change,MAX(b.T_Period) as T_Period,MAX(T_QTY) as T_QTY,MAX(CONVERT(varchar(19), d.TK_Date, 120)) as TK_Date,MAX(CS_Code)as CS_Code  " &_
                                                        " FROM [TankDB].[dbo].[Machine] a " &_ 
                                                        " INNER JOIN [TankDB].[dbo].[Tank] b ON b.M_ID = a.M_ID " &_
                                                        " LEFT JOIN [TankDB].[dbo].[CsCode] c ON c.CS_ID = b.CS_ID " &_
                                                        " LEFT JOIN [TankDB].[dbo].[Tank_Dates] d ON d.T_ID = b.T_ID " &_
                                                        " WHERE b.T_Status = 1 and a.M_Status = 1" &_
                                                        " GROUP BY b.T_ID " &_
                                                        " ORDER BY MAX(d.TK_Id) DESC "
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
                                                                                   
                                                                                <table class="table table-sm">
                                                                                    <thead>
                                                                                        <tr> 
                                                                                        <th class="text-right ">#<%=i %> :</th>
                                                                                        <th class=" text-secondary"><%=M_Name %></th> 
                                                                                        </tr>
                                                                                    </thead>
                                                                                    <tbody>
                                                                                        <tr>
                                                                                          <th class="text-right">จุดที่เปลี่ยน  :</th> 
                                                                                           <th class="text-secondary"><%=T_Name  %></th> 
                                                                                        </tr>
                                                                                        <tr>
                                                                                          <th class="text-right">Code CS :</th>
                                                                                          <th class="text-secondary"><%=CS_Code  %></th>  
                                                                                        </tr>
                                                                                        <tr> 
                                                                                        <th class="text-right">ความถี่ในการเปลี่ยน :</th>
                                                                                         <th class="text-secondary"><%=T_Change &" "& UCase(T_Period) %></th> 
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <th class="text-right">จำนวนที่ต้องเปลี่่ยน :</th>
                                                                                            <th  class="text-secondary"><%=T_QTY %>  EA</th> 
                                                                                        </tr>
                                                                                        <tr> 
                                                                                        <th class="text-right">วันที่เปลี่ยน ล่าสุด :</th>
                                                                                         <th class="text-secondary"><% IF IsNull(TK_Date)  Then response.write("N/A") Else response.write DateNow(rs("TK_Date")) End IF %></th> 
                                                                                      
                                                                                        </tr>
                                                                                        <tr> 
                                                                                        <th class="text-right">เปลี่ยนครั้งถัดไป :</th>
                                                                                         <th class="text-secondary"><% IF IsNull(TK_Date)  Then response.write("N/A") Else response.write DataDate(TK_Date, T_Change, T_Period) End IF %></th> 
                                                                                        </tr>
                                                                                    </tbody>
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
  
     <script src="./js/jquery.min.js"></script>
      <script src="./js/bootstrap.bundle.min.js"></script>      
      <script src="./js/select2.full.js"></script>
      <script src="./js/sweetalert2@11.js"></script>
      <script src="./js/moment.min.js"></script>  
      <script src="./js/tempusdominus-bootstrap-4.min.js"></script>
      <script src="./js/all.min.js"></script> 
     