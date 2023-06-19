<% 

Public Function getJsonFromReq
    If Request.ServerVariables("CONTENT_TYPE") = "application/json" Then
        bytecount = Request.TotalBytes
        bytes = Request.BinaryRead(bytecount)        
        getJsonFromReq = convertByteToString(bytes)
    End If
End Function

Public Function convertByteToString(bytes)
    Set stream = Server.CreateObject("ADODB.Stream")
        stream.Type = 1 'adTypeBinary              
        stream.Open()                                   
            stream.Write(bytes)
            stream.Position = 0                             
            stream.Type = 2 'adTypeText                
            stream.Charset = "utf-8"                      
            convertByteToString = stream.ReadText() 'here is your json as a string                
        stream.Close()
    Set stream = nothing
End Function


Function convertPlantIDToString(plant)
	Select Case trim(plant)
		case "1100" 
			word ="KCE"
		case "2000" 
			word ="KCEI"
		case "3000" 
			word ="KCET"
    End Select
	convertPlantIDToString = word
End Function

Function convertPlantStringToID(plant)
	Select Case trim(plant)
		case "KCE" 
			word ="1100"
		case "KCEI" 
			word ="2000"
		case "KCET" 
			word ="3000"
	End Select
	convertPlantStringToID = word
End Function

Function GetMonthEn(mon)
	Select case trim(mon)
		case 1 : word ="January" 
		case 2 : word ="February" 
		case 3 : word ="March" 
		case 4 : word ="April" 
		case 5 : word ="May" 
		case 6 : word ="June" 
		case 7 : word ="July" 
		case 8 : word ="August" 
		case 9 : word ="September" 
		case 10 : word ="October" 
		case 11 : word ="November" 
		case else word ="December"
	end Select	
	
	GetMonthEn = word
End function

Function GetMonthTh(mon)
	Select case trim(mon)
		case 1 : word ="มกราคม" 
		case 2 : word ="กุมภาพันธ์" 
		case 3 : word ="มีนาคม" 
		case 4 : word ="เมษายน" 
		case 5 : word ="พฤษภาคม" 
		case 6 : word ="มิถุนายน" 
		case 7 : word ="กรกฎาคม" 
		case 8 : word ="สิงหาคม" 
		case 9 : word ="กันยายน" 
		case 10 : word ="ตุลาคม" 
		case 11 : word ="พฤศจืกายน" 
		case else word ="ธันวาคม"
	end Select	
	
	GetMonthTh = word
End function

Function Base64Encode(sText)
    Dim oXML, oNode
    Set oXML = CreateObject("Msxml2.DOMDocument.3.0")
    Set oNode = oXML.CreateElement("base64")
    oNode.dataType = "bin.base64"
    oNode.nodeTypedValue = Stream_StringToBinary(sText)
    Base64Encode = oNode.text
    Set oNode = Nothing
    Set oXML = Nothing
End Function

Function Base64Decode(text)
    Dim oXML, oNode
    Set oXML = CreateObject("Msxml2.DOMDocument.3.0")
    Set oNode = oXML.CreateElement("base64")
    oNode.dataType = "bin.base64"
    oNode.text = text
    Base64Decode = Stream_BinaryToString(oNode.nodeTypedValue)
    Set oNode = Nothing
    Set oXML = Nothing
End Function

Function Stream_StringToBinary(Text)
	Const adTypeText = 2
	Const adTypeBinary = 1
	Dim BinaryStream 'As New Stream
	Set BinaryStream = CreateObject("ADODB.Stream")
		BinaryStream.Type = adTypeText
		BinaryStream.CharSet = "us-ascii"
		BinaryStream.Open
		BinaryStream.WriteText Text
		BinaryStream.Position = 0
		BinaryStream.Type = adTypeBinary
		BinaryStream.Position = 0
	Stream_StringToBinary = BinaryStream.Read
	Set BinaryStream = Nothing
End Function

Function Stream_BinaryToString(Binary)
	Const adTypeText = 2
	Const adTypeBinary = 1
	Dim BinaryStream 'As New Stream
	Set BinaryStream = CreateObject("ADODB.Stream")
		BinaryStream.Type = adTypeBinary
		BinaryStream.Open
		BinaryStream.Write Binary
		BinaryStream.Position = 0
		BinaryStream.Type = adTypeText
		BinaryStream.CharSet = "us-ascii"
	
	Stream_BinaryToString = BinaryStream.ReadText
  	Set BinaryStream = Nothing
End Function
 
'แปล Date time จาก วันที่เวลาให้เป็น เหลือแค่เวลา 2/25/2021 12:09:54 AM เหลือเป็น 12:09:54
Function getTimeFromDate(datetime)
	timein_work=Split(datetime,";")
  	time_loop =""
	for each times in timein_work
        show_time = Split(times," ")
		time_loop = time_loop & show_time(1) & " "
	next 
	getTimeFromDate = time_loop
 End Function


' ฟังก์ชัน DataDate
Function DataDate(TK_Date, T_Change, T_Period)
    Dim ad, dateToday, adddate, datemonth3
    
    Select Case T_Period
		Case "hour"
            ad = "h" 
        Case "day"
            ad = "d" 
        Case "month"
            ad = "m"
        Case "weeks"
            ad = "ww"
        Case Else
            ad = "yyyy"
    End Select
 
	dateToday = Right(Year(Now()), 4) & Right("00" & Month(Now()), 2) & Right("00" & Day(Now()), 2)
    adddate = DateAdd(ad, T_Change, CDate(TK_Date))
    datemonth = Right("00" & CStr(Day(adddate)), 2) & "/" & Right("00" & CStr(Month(adddate)), 2) & "/" & CStr(Year(adddate))+1086
    datemonth = datemonth & " " & Right("00" & Hour(adddate), 2) & ":" & Right("00" & Minute(adddate), 2) & ":" & Right("00" & Second(adddate), 2)
 
   DataDate = datemonth
End Function
  
'แปลง Date เป็นเวลาปัจจุบัน สแดงเป็น 23/11/2566 
Function DateNow(TK_Date)
    Dim tkDate, dateParts, day, month, year, hour, minute, second
    
    'แยกวันที่และเวลาจากพารามิเตอร์ TK_Date
    dateParts = Split(TK_Date, " ")
    tkDate = dateParts(0)
    tkTime = dateParts(1)
    
    'แยกส่วนของวันที่
    dateParts = Split(tkDate, "-")
    day = dateParts(2)
    month = Right("0" & dateParts(1), 2)
    year = dateParts(0)
    
    'แยกส่วนของเวลา
    timeParts = Split(tkTime, ":")
    hour = timeParts(0)
    minute = timeParts(1)
    second = timeParts(2)
    
    'ปรับปีให้เป็นปี พ.ศ.
    year = year + 543
    
    'สร้างรูปแบบวันที่และเวลาใหม่
    tkDate =  day & "/"  & month &"/" & year & " " & hour & ":" & minute & ":" & second
    DateNow = tkDate
End Function


Function GenerateQRCode(T_ID)
    Dim qrcodeScript
    qrcodeScript = "var qrcode = new QRCode(""qrcode" & T_ID & """, {"
    qrcodeScript = qrcodeScript & "text: ""http://192.168.35.5/Tank/Scan/default.asp?T_ID=" & T_ID & ""","
    qrcodeScript = qrcodeScript & "width: 100,"
    qrcodeScript = qrcodeScript & "height: 100,"
    qrcodeScript = qrcodeScript & "colorDark: ""#1F8A70"","
    qrcodeScript = qrcodeScript & "colorLight: ""#FFFBF5"","
    qrcodeScript = qrcodeScript & "correctLevel: QRCode.CorrectLevel.L"
    qrcodeScript = qrcodeScript & "});"

    GenerateQRCode = "<script>" & qrcodeScript & "</script>"
End Function

%>