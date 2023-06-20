<% username=Request.Cookies("LOGON_USER") 'esponse.write (username)
If username ="" Then
    Response.Write("<script>") 
    Response.Write("window.location.href = ' http://192.168.35.5/login.asp?href=http://192.168.35.5/Hanger_repair/default.asp'; ")
    Response.Write(" </script>")
  End If
 
  %>
  <!--#include file = "../backend/connection/db.asp"-->
  <!DOCTYPE html>
  <html lang="en"> 
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> 
    <title>HANGER REPAIR</title>
    <link rel="stylesheet" href="../css/bootstrap.min.css"> 
    <link rel="stylesheet" href="../css/tempusdominus-bootstrap-4.min.css"/>
   <!-- <link rel="stylesheet" type="text/css" href="../font/stylesheet.css"> -->
     <script src="../js/qrcode.min.js"></script>
  </head>
  <body> 
 <!--  onload=" window.print(); window.close()" -->
   <!--#include file="../lib/utility.asp"--> 
    <style> 
       .qrcode {
          display: flex;
          flex-direction: column;
          justify-content: center;
          align-items: center;
        }
    </style>
     
              <div class="container "> 
                          <div class="row justify-content-center">     

                          <%
                              sql =   " SELECT MAX(a.M_Name) as M_Name,MAX(b.T_Name) as T_Name,MAX(c.CS_CODE) as CS_CODE,MAX(b.T_ID) as T_ID " &_
                                                        " FROM [TankDB].[dbo].[Machine] a " &_ 
                                                        " INNER JOIN [TankDB].[dbo].[Tank] b ON b.M_ID = a.M_ID " &_ 
                                                        " INNER JOIN [TankDB].[dbo].[CsCode] c ON c.CS_ID = b.CS_ID " &_
                                                        " INNER JOIN [TankDB].[dbo].[QrCode] e ON e.T_ID = b.T_ID " &_
                                                        " WHERE b.T_Status = 1 " &_ 
                                                        " GROUP BY b.T_ID " 
                          set row = db.execute(sql)
                              do while not row.eof                            
                          %>
                          <div class="col-md-3 p-1">
                            <div class="card">
                                <div class="card-body text-center">
                                  <div class="qrcode" id="qrcode<%=row(("T_ID"))%>"><%=GenerateQRCode(row(("T_ID")))%></div> 
                                  <hr>
                                  <h5><%=row("M_Name")&" | "&row("T_Name")%></h5>
                                </div>
                              </div> 
                          </div> 
  
           <%
                  row.moveNext 
            loop 
            %> 
            </div>  
          </div>
        </div>
      </div>
    </div>
     <script src="../js/jquery.min.js"></script> 
     
<script>
    $(document).ready(function() {
      // Print the page
      window.print();

      // Close the window after a short delay (adjust the delay as needed)
      setTimeout(function() {
        window.close();
      }, 500); // 1000 milliseconds = 1 second
    });
  </script>
</body>
 
</html>