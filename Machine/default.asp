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
                            <h4>บันทึกข้อมูล Machine</h4>
                            <hr />
                            <div class="card"> 
                                <div class="card-body">
                                    <form id="insert_data">
                                            <div class="mb-2">
                                                <label class="form-label">ชื่อเครื่องจักร</label>
                                            <input type="text" class="form-control" name="M_Name" id="M_Name" required autocomplete="off" placeholder="Machine">
                                            </div>
                                            <!-- <div class="mb-3">
                                              <label class="form-label">ตึก/โรง</label>
                                             <select class="form-control " id="M_Building" name="M_Building" required>
                                                <option value="">--- ตึก ---</option> 
                                                        <option value="1">ตึก 1</option>
                                                        <option value="2">ตึก 2</option>  
                                                </select>
                                            </div>  -->
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
                                        <th>ชื่อเครื่องจักร</th>
                                        <!-- <th class="text-center">ตึก/โรง</th> -->
                                        <th class="text-center">จัดการ</th> 
                                    </tr>
                                </thead>
                                <tbody>

                                    <%
                                    i = 1 
                                    sql = "SELECT * FROM [TankDB].[dbo].[Machine] Where M_Status = 1"
                                      SET rs = db.Execute(sql)
                                     While Not rs.EOF 
                                    %>
                                    <tr>
                                        <td><%=i%></td>
                                        <td><%=rs("M_Name")%></td>
                                        <!-- <td class="text-center"><%=rs("M_Building")%></td> -->
                                        <td class="text-center">
                                            <a href="#"class="btn btn-warning btn-sm edit" data-toggle="modal" data-target="#exampleModalCenter"
                                              data-id= "<%=rs("M_ID")%>" 
                                              data-m_name= "<%=rs("M_Name")%>"
                                              >
                                             <i class="fa-solid fa-pen"></i>
                                            </a> 
                                            <a href="#" class="btn btn-danger btn-sm del" data-id= "<%=rs("M_ID")%>"> <i class="fa-solid fa-trash"></i></a> 
                                        </td> 
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
                        <div>

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
 