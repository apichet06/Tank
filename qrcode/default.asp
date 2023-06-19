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
                  <h3>Qrcode</h3> 
            </div>
            <hr/>
                        <div class="col-md-12"> 
                            <hr />
                            <div class="card"> 
                                <div class="card-body">
                                <h4> คลิกเลือกรายการที่ต้องการ Print</h4> <hr/>
                                    <div class="row">
                                    <%
                                    sql = "SELECT MAX(a.M_Name) AS M_Name, MAX(c.T_Name) AS T_Name, MAX(c.T_Change) AS T_Change, MAX(c.T_Period) AS T_Period, MAX(T_QTY) AS T_QTY, c.T_ID" &_
                                        " FROM [TankDB].[dbo].[Machine] a" &_ 
                                        " INNER JOIN [TankDB].[dbo].[Tank] c ON a.M_ID = c.M_ID" &_ 
                                        " LEFT JOIN [TankDB].[dbo].[QrCode] d ON c.T_ID = d.T_ID" &_
                                        " WHERE c.T_Status = 1 AND   a.M_Status = 1 AND c.T_ID NOT IN (SELECT T_ID FROM [TankDB].[dbo].[QrCode])" &_ 
                                        " GROUP BY c.T_ID" 
                                    Set rs = db.Execute(sql)
                                    While Not rs.EOF
                                        M_Name = rs("M_Name")
                                        T_Name = rs("T_Name")
                                        T_ID = rs("T_ID")
                                        T_Change = rs("T_Change")
                                        T_Period = rs("T_Period")
                                    %>      
                                        <div class="col-md-2"> 
                                            <div class="card">
                                                <div class="card-body">
                                                    <a href="#" class="insert_data" data-t_id="<%=T_ID%>">
                                                    <%=M_Name %><br> 
                                                    จุดที่เปลี่ยน : <%=T_Name %><br>
                                                    รอบเช็ค : <%=T_Change &" "& UCase(T_Period) %><br> </a>
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
                        <div class="col-md-12"> 
                            <hr />
                            <div class="card"> 
                                <div class="card-body">
                                <h4> รายการที่จะ Print</h4> <hr/>
                                 <table id="example" class="table table-striped table-bordered" style="width:100%">
                                                <thead>
                                                    <tr>
                                                        <th>#</th>
                                                        <th>เครื่องจักร</th>
                                                        <th>จุดที่เปลี่ยน</th>
                                                        <th>Code CS</th> 
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <% i=1
                                                sql =   " SELECT MAX(a.M_Name) as M_Name,MAX(b.T_Name) as T_Name,MAX(c.CS_CODE) as CS_CODE " &_
                                                        " FROM [TankDB].[dbo].[Machine] a " &_ 
                                                        " INNER JOIN [TankDB].[dbo].[Tank] b ON b.M_ID = a.M_ID " &_ 
                                                        " INNER JOIN [TankDB].[dbo].[CsCode] c ON c.CS_ID = b.CS_ID " &_
                                                        " INNER JOIN [TankDB].[dbo].[QrCode] e ON e.T_ID = b.T_ID " &_
                                                        " WHERE b.T_Status = 1 " &_ 
                                                        " GROUP BY b.T_ID "  
                                                        'on error resume next
                                                       set  rs = db.Execute(sql)
                                                            While Not rs.EOF
                                                            M_Name   = rs("M_Name")
                                                            T_Name = rs("T_Name")
                                                            CS_CODE   = rs("CS_CODE")
                                                           
                                                             
                                                %>  
                                                    <tr>
                                                        <td><%=i%></td>
                                                        <td><%=M_Name%></td>
                                                         <td><%=T_Name%></td>
                                                        <td><%=CS_CODE %></td> 
                                                    </tr> 
                                                      <%
                                                            i = i + 1
                                                            rs.MoveNext
                                                    Wend
                                                %> 
                                                </tbody> 
                                            </table>
                                            <div class="text-right">
                                                <hr>
                                            <a href="#" class="btn btn-danger" id="cleanup">ลบ</a> 
                                            <a href="print.asp" target="_black" class="btn btn-info" >Print</a>
                                            </div> 
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
      <script src="../js/jquery.dataTables.min.js"></script> 
      <script src="../js/dataTables.bootstrap4.min.js"></script> 
      <script src="../js/all.min.js"></script>
      <script src="./script.js"></script>