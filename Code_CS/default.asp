<% username=Request.Cookies("LOGON_USER") 'esponse.write (username)
If username ="" Then
    Response.Write("<script>") 
    Response.Write("window.location.href = ' http://192.168.35.5/login.asp?href=http://192.168.35.5/Tank/default.asp'; ")
    Response.Write(" </script>")
  End If
 
  %>
    <!--#include file = "../backend/connection/db.asp"-->
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>TANK</title>
        <meta charset="UTF-8">
        <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv="Expires" content="0">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="../css/bootstrap.min.css">     
        <link rel="stylesheet" href="../css/tempusdominus-bootstrap-4.min.css"/>
        <link rel="stylesheet" href="../css/Awesome_all.min.css">
        <link rel="stylesheet" href="../css/select2.min.css">
        <link rel="stylesheet" href="../css/dataTables.bootstrap4.min.css">
        <link rel="stylesheet" href="../css/adminlte.min.css"> 
        <!-- <link rel="stylesheet" href="../font/stylesheet.css">  -->
    </head>
    <body>
     <!--#include file="../memu/menu.asp"-->  

      <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-md-5">
                            <h4>บันทึกข้อมูล CS Code</h4>
                            <hr />
                            <div class="card"> 
                                <div class="card-body">
                                    <form id="insert_data"> 
                                            <div class="mb-2">
                                                <label class="form-label">CS_Code</label>
                                                <input type="text" class="form-control" name="CS_Code" id="CS_Code" required autocomplete="off" placeholder="CS Code">
                                            </div>
                                         
                                            <div class="modal-footer">
                                            <button type="submit" class="btn btn-success">บันทึก</button>
                                            </div>
                                    </form>
                                </div>
                            </div>
                        </div> 

                        <div class="col-md-8"><hr/>
                         <div class="card">
                            <div class="card-body">
                            <table id="example" class="table table-striped table-bordered table-sm" style="width:100%">
                                <thead>
                                    <tr>
                                        <th>#</th> 
                                        <th class="text-center">CS_Code</th>
                                        <th class="text-center">จัดการ</th> 
                                    </tr>
                                </thead>
                                <tbody> 
                                    <%
                                    i = 1 
                                    sql = " SELECT * FROM [TankDB].[dbo].[CsCode] Where CS_Status = 1" 
                                      SET rs = db.Execute(sql)
                                     While Not rs.EOF 
                                    %>
                                    <tr>
                                        <td><%=i%></td>
                                        <td><%=rs("CS_Code")%></td> 
                                        <td class="text-center">
                                             <a href="#"class="btn btn-warning btn-sm edit" data-toggle="modal" data-target="#exampleModalCenter"
                                              data-id= "<%=rs("CS_ID")%>" 
                                              data-cs_code= "<%=rs("CS_Code")%>"
                                              >
                                             <i class="fa-solid fa-pen"></i>
                                            </a> 
                                            <a href="#" class="btn btn-danger btn-sm del" data-id= "<%=rs("CS_ID")%>"> <i class="fa-solid fa-trash"></i></a> 
                                        </td> 
                                    </tr> 
                                    <% 
                                    i = i + 1
                                      rs.MoveNext
                                    Wend
                                    %>
                                </tbody> 
                            </table>    
                        <div>
                            </div>
                            </div>
                        </div>
                    <div>
            </body>
        </html>
 
 <!--#include file="./modals.asp"-->  
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

  