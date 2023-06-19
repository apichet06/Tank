<%   
   sql = "SELECT [EI_Title],[EI_FirstName],[EI_LastName],[EI_DepartmentShort] FROM MA_EffectiveUser Where Username =  '"+username+"'"

   set rs_userlogin = db96.execute(sql)
   if rs_userlogin.eof = false then
        name =  rs_userlogin("EI_Title") & "" & rs_userlogin("EI_FirstName") &" "& rs_userlogin("EI_LastName") &" "& rs_userlogin("EI_DepartmentShort")
        user = rs_userlogin("EI_FirstName")
     If   rs_userlogin("EI_DepartmentShort") <>"MFG" and rs_userlogin("EI_DepartmentShort") <>"IT"  Then %>
    <script>
        $(document).ready(function() {
            Swal.fire({
                title: 'Oops...',
                text: "เข้าใช้งานได้เฉพาะ FOI และ MIS เท่านั้น!",
                icon: 'error',
                showCancelButton: false,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'OK'
            }).then((result) => {
                if (result.isConfirmed) {
                    location.href = "http://192.168.35.5/login.asp?href=http://192.168.35.5/Tank/scan/default.asp?T_ID=" & T_ID & "";
 
                }
            })
        });
    </script>

    <% 
 
     End if
 

    end if

    logout =  Request.Form("Logout")
 If logout  ="Logout"  Then
 For Each cookie in Response.Cookies
    Response.Cookies(cookie).Expires = DateAdd("d",-1,now())
    response.write("<script> window.location.reload()</script>") 
Next
 
 End if
 
  part_file = left(Request.ServerVariables("SCRIPT_NAME"),InStrRev(Request.ServerVariables("SCRIPT_NAME"),"/")) 
 
%>
<style> 
body {
  /* min-height: 75rem; */
  padding-top: 4.7rem; 

    }
</style>

 
<nav class="navbar navbar-light bg-light fixed-top shadow">
  <a class="navbar-brand" href="#"><i class="fa-solid fa-boxes-stacked"></i></a>
  <form class="form-inline" method="Post">
   <div>
             <%=name%> &nbsp;
            <input type="text" name="Logout" value="Logout" hidden="true">
            <button type="submit" class="btn btn-sm btn-outline-secondary">logout</button>
         </div>
  </form>
</nav>
  