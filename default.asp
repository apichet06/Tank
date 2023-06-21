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
        <!-- <link rel="stylesheet" href="./font01/stylesheet.css"> -->
        <link rel="stylesheet" href="./css/dataTables.bootstrap4.min.css">
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
            <div class="col-md-11">
                <div class="card">
                     <div class="card-body">
                         <table class="table table-sm table-striped table-hover table-bordered" id="example">
                            <thead>
                                <tr>
                                <th scope="col">#</th>
                                <th scope="col">Machine</th>
                                <th scope="col">จุดที่เปลี่ยน</th>
                                <th scope="col">Code CS</th>
                                <th scope="col">จำนวนที่ต้องเปลี่่ยน</th>
                                <th scope="col">ความถี่ในการเปลี่ยน</th> 
                                <th scope="col">วันที่เปลี่ยน ล่าสุด</th>
                                <th scope="col">เปลี่ยนครั้งถัดไป</th>
                                </tr>
                            </thead>
                            <tbody>
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
                                                        <tr>
                                                        <th scope="row"><%=i %></th>
                                                        <td><%=M_Name %></td>
                                                        <td><%=T_Name  %></td>
                                                        <td><%=CS_Code  %></td> 
                                                        <td><%=T_QTY %>  EA</td>
                                                        <td><%=T_Change &" "& UCase(T_Period) %></td>
                                                        <td><% IF IsNull(TK_Date)  Then response.write("N/A") Else response.write DateNow(rs("TK_Date")) End IF %></td>
                                                        <td><% IF IsNull(TK_Date)  Then response.write("N/A") Else response.write DataDate(TK_Date, T_Change, T_Period) End IF %></td>
                                                        </tr> 
                                                        <%
                                                            i = i + 1
                                                            rs.MoveNext
                                                    Wend
                                                %>     
                            </tbody>
                         </table>
                        </div>
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
      <script src="./js/jquery.dataTables.min.js"></script> 
      <script src="./js/dataTables.bootstrap4.min.js"></script> 

      <script>
        $(document).ready(function () {
            $('#example').DataTable();
        });
      </script>
     