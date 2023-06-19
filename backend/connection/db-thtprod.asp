<%

    SET dbFOI = SERVER.CREATEOBJECT("ADODB.CONNECTION") 
    
    dbFOI.open "Provider=SQLOLEDB.1;Data Source=192.168.35.39;Initial Catalog=Base_Process;User ID=sa;Pwd=sasa"
      
%>
