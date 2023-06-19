<!--#include file = "../../lib/aspJSON1.19.asp"-->
<!--#include file = "../../backend/connection/db.asp"-->
<% 
    username                = Request.Cookies("LOGON_USER") 
    H_ID                    = Request.Form("H_ID")
    chasing_rails           = Request.Form("chasing_rails")
    adjust_clampdistance    = Request.Form("adjust_clampdistance")
    makenew_carbonbrush     = Request.Form("makenew_carbonbrush")
    smallwheel_change       = Request.Form("smallwheel_change")
    Makefastener_bothsides  = Request.Form("Makefastener_bothsides")
    perm                    = Request.Form("perm")
    center                  = Request.Form("center")
    Makenew_lefthandgrip    = Request.Form("Makenew_lefthandgrip")
    Madenew_righthandgrip   = Request.Form("Madenew_righthandgrip")
    make_newcore            = Request.Form("make_newcore")
    change_powercord        = Request.Form("change_powercord")
    change_base             = Request.Form("change_base")
    bigwheel_change         = Request.Form("bigwheel_change")
    change_busbar           = Request.Form("change_busbar")
    put_allwheels           = Request.Form("put_allwheels")
    other                   = Request.Form("other")
    data                    = Request.Form("data")
  Dim show
  Detaildate =    (Year(NOW()) &"-"& Month(NOW()) &"-"& day(NOW()) &" "& Time)




    If data = "insert" Then 
      

     If  chasing_rails="" and adjust_clampdistance ="" and makenew_carbonbrush ="" and smallwheel_change ="" and Makefastener_bothsides ="" and perm ="" and center ="" and Makenew_lefthandgrip ="" and Madenew_righthandgrip ="" and make_newcore ="" and change_powercord ="" and change_base ="" and bigwheel_change ="" and change_busbar ="" and put_allwheels ="" and other =""  Then 
          show = "11"
      Else 
       
      sql = "INSERT INTO H_Repairdetail (H_ID,Chasing_rails,Adjust_clampdistance,Makenew_carbonbrush,Smallwheel_change,Makefastener_bothsides " &_ 
      ",Perm,Center,Makenew_lefthandgrip,Madenew_righthandgrip,Make_newcore,Hhange_powercord,Change_base,Bigwheel_change " &_
      ",Change_busbar,Put_allwheels,Other,Detaildate,Username) " &_
      " VALUES('"&H_ID&"','"&chasing_rails&"','"&adjust_clampdistance&"','"&makenew_carbonbrush&"','"&smallwheel_change&"'," &_
      " '"&Makefastener_bothsides&"','"&perm&"','"&center&"','"&Makenew_lefthandgrip&"','"&Madenew_righthandgrip&"'," &_
      " '"&make_newcore&"','"&change_powercord&"','"&change_base&"','"&bigwheel_change&"','"&change_busbar&"'," &_
      " '"&put_allwheels&"','"&other&"','"&Detaildate&"' ,'"&Username&"')" 

        on error resume next

        db.Execute(sql)
 
       
        if err<>0 Then
  
        Response.Write (Err.Description)    
        response.write("0")
        show = "0"

        Else
        
        show = "1" 

        End if
      
      
      End If

 
 
        Json =""
        Json = Json & "{" 
        Json = Json & """data"": "& show &"  "& vbcrlf  
        Json = Json & "}"
        
        Response.Write Json 


    else 
    
    
    
    End if 


 %>