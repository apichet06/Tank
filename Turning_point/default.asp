<%@Language="VBScript"%>
<% 
Response.CodePage = 65001    
Response.CharSet = "utf-8"

username=Request.Cookies("LOGON_USER") 'esponse.write (username)
 

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
      <div class="container-fluid">
                    <div class="row justify-content-center">
                        <div class="col-md-6">
                            <h4>บันทึกข้อมูลจุดที่ต้องเปลี่ยน</h4>
                            <hr />
                            <div class="card"> 
                                <div class="card-body">
                                    <form id="insert_data">
                                        <div class="form-row"> 
                                            <div class="form-group col-md-12 ">
                                              <label class="form-label">เครื่องจักร</label>
                                                <select class="form-control select2" id="M_ID" name="M_ID" required>
                                                    <option value="">--- เครื่องจักร ---</option> 
                                                            <% 
                                                            sql = " SELECT * FROM [TankDB].[dbo].[Machine] Where M_Status = 1 "
                                                            SET rs = db.Execute(sql)
                                                            While Not rs.EOF
                                                            %>
                                                                <option value="<%=rs("M_ID")%>"><%=rs("M_Name")%></option>  
                                                            <% 
                                                            i = i + 1
                                                            rs.MoveNext
                                                            Wend
                                                            %>
                                                    </select>
                                            </div> 
                                            <div class="form-group col-md-12 ">
                                                <label class="form-label">จุดที่ต้องเปลี่ยน</label>
                                                <input type="text" class="form-control" name="T_Name" id="T_Name" required autocomplete="off" placeholder="จุดที่ต้องเปลี่ยน">
                                            
                                            </div>
                                            <div class="form-group col-md-12 ">
                                                <label class="form-label">Code CS</label>
                                               <select class="form-control select2" id="CS_ID" name="CS_ID" required>
                                                    <option value="">--- CsCode ---</option> 
                                                            <% 
                                                            sql = " SELECT * FROM [TankDB].[dbo].[CsCode] Where CS_Status = 1 "
                                                            SET rs = db.Execute(sql)
                                                            While Not rs.EOF
                                                            %>
                                                                <option value="<%=rs("CS_ID")%>"><%=rs("CS_Code")%></option>  
                                                            <% 
                                                            i = i + 1
                                                            rs.MoveNext
                                                            Wend
                                                            %>
                                                    </select>
                                            
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label class="form-label">จำนวนที่เปลี่ยนต่อครั้ง(EA)</label>
                                                <select class="form-control select2" id="T_QTY" name="T_QTY" required>
                                                        <option value="">จำนวนที่เปลี่ยนต่อครั้ง(EA)</option>  
                                                        <%   For i = 1 To 2000 %> 
                                                         <option value="<%=i%>"><%=i%></option>  
                                                        <%  Next %>
                                                </select> 
                                            </div>
                                            <div class="form-group col-md-3">
                                                <label class="form-label">ความถี่ในการเปลี่ยน</label>
                                                <select class="form-control select2" id="T_Change" name="T_Change" required>
                                                       <option value="">--- ความถี่ ---</option>  
                                                        <%   For i = 1 To 1000 %> 
                                                         <option value="<%=i%>"><%=i%></option>  
                                                        <%  Next %>
                                                </select>         
                                            </div> 
                                            <div class="form-group col-md-4">
                                                <label class="form-label">วัน/เดือน/ปี</label>
                                                 <select class="form-control select2" id="T_Period" name="T_Period" required>
                                                    <option value="">--- วัน/สัปดาห์/เดือน/ปี ---</option>
                                                    <option value="hour">ชั่วโมง</option>  
                                                    <option value="day">วัน</option>   
                                                    <option value="weeks">สัปดาห์</option>  
                                                    <option value="month">เดือน</option>  
                                                    <option value="year">ปี</option>  
                                                </select>
                                            </div>
                                            <div class="form-group col-md-1">
                                                 <label class="form-label text-light">-</label>
                                                  <input type="text" class="form-control" disabled value="ครั้ง">
                                            </div>
                                        </div>
                                           
                                            <div class="modal-footer">
                                            <button type="submit" class="btn btn-success">บันทึก</button>
                                            </div>
                                    </form>
                                </div>
                            </div>
                        </div> 

                                <div class="col-md-10 p-3"><hr/>
                                    <div class="card">
                                        <div class="card-body">
                                          <table class="table table-sm table-striped table-hover table-bordered" id="example">
                                            <thead>
                                                <tr>
                                                    <th>#</th>
                                                    <th>ชื่อเครื่องจักร</th>
                                                    <th class="text-center">ชื่อของจุดที่ต้องเปลี่ยน</th>
                                                    <!-- <th class="text-center">ตึก</th>
                                                   <th class="text-center">Tank</th> -->
                                                    <th class="text-center">Code CS</th>
                                                    <th class="text-center">จำนวนที่เปลี่ยนต่อครั้ง (EA)</th>
                                                    <th class="text-center">ความถี่ในการเปลี่ยน/ครั้ง</th>
                                                    <th class="text-center">จัดการ</th> 
                                                </tr>
                                            </thead>
                                            <tbody> 
                                                <%
                                                i = 1 
                                                sql = " SELECT * FROM [TankDB].[dbo].[Tank] a " &_
                                                " left join [TankDB].[dbo].[Machine] b " &_
                                                " On a.M_ID = b.M_ID " &_
                                                " left join [TankDB].[dbo].[CsCode] c " &_
                                                " On a.CS_ID = c.CS_ID " &_
                                                " Where T_Status = 1 and M_Status = 1 " 
                                                'on error resume next
                                                SET rs = db.Execute(sql)
                                                While Not rs.EOF 
                                                %>
                                                <tr>
                                                    <td><%=i%></td>
                                                    <td><%=rs("M_Name")%></td>
                                                    <td><%=rs("T_Name")%></td>
                                                    <!-- <td><% IF rs("M_Building") =1 Then Response.Write("B-1") Else Response.Write("B-2") End IF %></td>  -->
                                                    <!-- <td><%=rs("T_Name")%></td> -->
                                                    <td><%=rs("CS_Code")%></td>
                                                    <td class="text-center"><%=rs("T_QTY")%> EA</td>
                                                    <td><%=rs("T_Change") & " " &  UCase(rs("T_Period"))%></td> 
                                                    <td class="text-center">
                                                        <a href="#" class="btn btn-warning btn-sm edit" data-toggle="modal" data-target="#staticBackdrop"
                                                        data-id="<%=rs("T_ID")%>"
                                                        data-m_id="<%=rs("M_ID")%>"
                                                        data-t_name="<%=rs("T_Name")%>"
                                                        data-cs_id="<%=rs("CS_ID")%>"
                                                        data-t_qty="<%=rs("T_QTY")%>"
                                                        data-t_change="<%=rs("T_Change")%>"
                                                        data-t_period="<%=rs("T_Period")%>"
                                                        ><i class="fa-solid fa-pen"></i></a>
                                                        <a href="#" class="btn btn-danger btn-sm del" data-id= "<%=rs("T_ID")%>"> <i class="fa-solid fa-trash"></i></a>  
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


    