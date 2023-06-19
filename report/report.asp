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
        <link rel="stylesheet" href="../css/dataTables.bootstrap4.min.css">
        <!-- <link rel="stylesheet" type="text/css" href="../font/stylesheet.css"> -->
    </head>
 <style>

 </style>

    <body >
     <!--#include file="../memu/menu.asp"-->  
     <!--#include file="../lib/utility.asp"-->  
     <div class="container-fluid">
         <div class="row justify-content-center"> 
            <div class="col-md-12 text-center">
                  <h3>ประวัติการเปลี่ยน CS Part</h3> 
            </div>
            <hr/>
                        <div class="col-md-12"> 
                            <hr />
                            <div class="card"> 
                                <div class="card-body">
                               
                                        <table id="example" class="table table-striped table-bordered" style="width:100%">
                                                <thead>
                                                    <tr>
                                                        <th>#</th>
                                                        <th>เครื่องจักร</th>
                                                        <th>บ่อ</th>
                                                        <th>Code CS</th>
                                                        <th>รอบเช็ค</th>
                                                        <th>วันที่เปลี่ยน</th>
                                                         
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <% i=1
                                                sql =   " SELECT MAX(a.M_Name) as M_Name, MAX(b.T_Name) as T_Name, MAX(b.T_Change) as T_Change, MAX(b.T_Period) as T_Period, MAX(T_QTY) as T_QTY,MAX(CONVERT(varchar(19), d.TK_Date, 120)) as TK_Date, MAX(CS_Code) as CS_Code " &_
                                                        " FROM [TankDB].[dbo].[Machine] a " &_ 
                                                        " INNER JOIN [TankDB].[dbo].[Tank] b ON a.M_ID = b.M_ID " &_
                                                         " INNER JOIN [TankDB].[dbo].[CsCode] c ON b.CS_ID = c.CS_ID " &_
                                                        " INNER JOIN [TankDB].[dbo].[Tank_Dates] d ON b.T_ID = d.T_ID " &_
                                                        " WHERE b.T_Status = 1 " &_ 
                                                        " GROUP BY d.TK_Id  " &_
                                                        " ORDER BY MAX(d.TK_Id) DESC " 
                                                        ' on error resume next
                                                        SET rs = db.Execute(sql)
                                                            While Not rs.EOF
                                                            M_Name   = rs("M_Name") 
                                                            T_Name   = rs("T_Name")
                                                            CS_Code  = rs("CS_Code")
                                                            T_QTY    = rs("T_QTY")
                                                            T_Change = rs("T_Change")
                                                            T_Period = rs("T_Period")
                                                            TK_Date  = rs("TK_Date") 
                                                %>  
                                                    <tr>
                                                        <td><%=i%></td>
                                                        <td><%=M_Name%></td>
                                                         <td><%=T_Name%></td>
                                                        <td><%=CS_Code  %></td>
                                                        <td> <%=T_Change &" "& UCase(T_Period) %></td>
                                                        <td><% IF TK_Date = "" Then response.write("N/A") Else response.write DateNow(rs("TK_Date")) End IF %></td>
                                                       
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
  
      <script src="../js/jquery.min.js"></script>
      <script src="../js/bootstrap.bundle.min.js"></script>      
      <script src="../js/select2.full.js"></script>
      <script src="../js/sweetalert2@11.js"></script>
      <script src="../js/moment.min.js"></script>
      <script src="../js/tempusdominus-bootstrap-4.min.js"></script>
      <script src="../js/all.min.js"></script>
      <script src="../js/jquery.dataTables.min.js"></script> 
      <script src="../js/dataTables.bootstrap4.min.js"></script>  
     <script>
        $(document).ready(function () {
            $('#example').DataTable();
        });
     </script>