<%
  SET db71 = SERVER.CREATEOBJECT("ADODB.CONNECTION")
  'SET rs = SERVER.CREATEOBJECT("ADODB.RECORDSET") 
	db71.open "Provider=SQLOLEDB.1;Data Source=192.168.35.71;Initial Catalog=Hanger_repair;Persist Security Info=True;User ID=k2user;Pwd=password"

%>


