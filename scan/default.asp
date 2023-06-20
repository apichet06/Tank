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
                  <h4>บันทึกข้อมูลการเปลี่ยน CS Part</h4>  <hr/>
            </div>
           

                       <div class="col-md-3">
                                    <form id="insert_data"> 
                                            <div class="mb-3"> 
                                                <%
                                                        sql = "SELECT * FROM [TankDB].[dbo].[Tank] a " &_  
                                                        " inner join [TankDB].[dbo].[Machine] c " &_ 
                                                        " On a.M_ID = c.M_ID " &_  
                                                        " Where T_Status = 1 and M_Status = 1 and a.T_ID = '"&T_ID&"'"
                                                        SET rs = db.Execute(sql)
                                                        IF Not rs.EOF Then
                                                        %>
                                                        <input class="form-control select2" id="T_ID" name="T_ID" value="<%=rs("T_ID")%>" hidden> 
                                                        <input class="form-control select2"value="<%=rs("M_Name")&" | "&rs("T_Name")%>" disabled>  
                                                        <%
                                                     End IF
                                                        %>
                                                </select>
                                            </div>
                                            <hr /> 
                            <div class="card"> 
                                <div class="card-body">
                                
                                                <%
                                        

                                                sql =   " SELECT  MAX(a.M_Name) as M_Name,MAX(b.T_Name) as T_Name,MAX(b.T_Change) as T_Change,MAX(b.T_Period) as T_Period,MAX(T_QTY) as T_QTY,MAX(CONVERT(varchar(19), d.TK_Date, 120)) as TK_Date,MAX(CS_Code)as CS_Code  " &_
                                                        " FROM [TankDB].[dbo].[Machine] a " &_ 
                                                        " INNER JOIN [TankDB].[dbo].[Tank] b ON b.M_ID = a.M_ID " &_
                                                        " LEFT JOIN [TankDB].[dbo].[CsCode] c ON c.CS_ID = b.CS_ID " &_
                                                        " LEFT JOIN [TankDB].[dbo].[Tank_Dates] d ON d.T_ID = b.T_ID " &_
                                                        " WHERE b.T_Status = 1 and b.T_ID = '"&T_ID&"' " &_
                                                        " GROUP BY b.T_Name " &_
                                                        " ORDER BY MAX(d.TK_Id) DESC "

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
                                                                                   <%=M_Name  %><br>
                                                                                   จุดที่เปลี่ยน  : <%=T_Name  %><br>
                                                                                   Code CS : <%=CS_Code  %><br>
                                                                                   ความถี่ในการเปลี่ยน : <%=T_Change &" "& UCase(T_Period) %><br>
                                                                                   จำนวนที่ต้องเปลี่่ยน : <%=T_QTY %>  EA<br>
                                                                                   วันที่เปลี่ยน ล่าสุด  : <% IF IsNull(TK_Date) Then response.write("N/A") Else response.write DateNow(rs("TK_Date")) End IF  %><br>
                                                                                   เปลี่ยนครั้งถัดไป : <% IF IsNull(TK_Date) Then response.write("N/A") Else response.write DataDate(TK_Date, T_Change, T_Period) %>
                                                                  
                                                                        <%
                                                            i = i + 1
                                                            rs.MoveNext
                                                    Wend
                                                %>     
                              
                                </div>
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
<div class="row justify-content-center">

            <div class="col-md-4"> 
                            
                           

                               <%
                                 SQL  = "SELECT COUNT(*) as COUNT_DATA From [TankDB].[dbo].[Tank_Dates] Where T_ID = '"&T_ID&"'"
                                            
                                 SET rs = db.execute(SQL)

                                IF Not rs.EOF Then                
                                     IF rs("COUNT_DATA") > 0 Then 
                                %>
                                <hr/>
                                 <a href="./report.asp?T_ID=<%=T_ID%>" class="btn btn-primary btn-block">ข้อมูลทั้งหมด</a> <hr>
                                <%
                           End IF
                    End IF
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
      <script src="./script.js"></script> 
     