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
                            <h4>บันทึกข้อมูลการเปลี่ยน CS Part</h4>
                            <hr />
                            <div class="card"> 
                                <div class="card-body">
                                    <form id="insert_data"> 
                                            <div class="mb-3">
                                              <label class="form-label">จุดที่เปลี่ยน</label>
                                             <select class="form-control select2" id="T_ID" name="T_ID" required>
                                                <option value="">--- จุดที่เปลี่ยน ---</option> 
                                                <%
                                                        sql = "SELECT * FROM [TankDB].[dbo].[Tank] a " &_ 
                                                        " inner join [TankDB].[dbo].[Machine] c " &_ 
                                                        " On a.M_ID = c.M_ID " &_
                                                        " Where T_Status = 1 and M_Status = 1"
                                                        SET rs = db.Execute(sql)
                                                        While Not rs.EOF
                                                        %>
                                                           <option value="<%=rs("T_ID")%>"><%=rs("M_Name") %> | <%=rs("T_Name")%>  </option>  
                                                        <%
                                                        i = i + 1
                                                        rs.MoveNext
                                                        Wend
                                                        %>
                                                </select>
                                            </div>
                                             
                                            <div class="mb-2">
                                            <label class="form-label">วันที่เปลี่ยน</label>
                                            <input type="text" class="form-control datetimepicker-input" name="TK_Date" id="TK_Date"  data-toggle="datetimepicker" data-target="#TK_Date" required autocomplete="off">
                                            </div>
                                            <div class="mb-2 text-danger" id="Data"></div>
                                            <div class="modal-footer">
                                            <button type="submit" class="btn btn-success">บันทึก</button>
                                            </div>
                                    </form>
                                </div>
                            </div>
                        </div>  
                        </div>
                    <div>
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