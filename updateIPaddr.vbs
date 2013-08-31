' \file 	updateIPaddr.vbs
' \author 	Pau Coma paucoma@paucoma.com
' \date:	2013-08-31
' 
' \description :	This script updates a dynamic dns system via webserver
'		REQUIRES:	* dh-dyndns.php to be on the webserver
'					* Followed instructions at http://wiki.dreamhost.com/Dynamic_DNS
'
' \usage :	Double click on the script and wait for it to finish
'			* The Script will log Requests and Responses in ".\updateIPlog.txt"

'Constants for Text Files
Const ForReading = 1, ForWriting = 2, ForAppending = 8

Dim sThisDirectory, oFs

' sThisDirectory	:	the directory the script is located.
' The added 1 character to subtract is the "\" 
sThisDirectory = Left(Wscript.ScriptFullName,Len(Wscript.ScriptFullName) - Len(Wscript.ScriptName) - 1)

Set oFs = CreateObject("Scripting.FileSystemObject")

Dim oXmlHttp, sGetUrl

Dim parBaseUrl,parPass,parIp,parHost
parBaseUrl = "http://webserver.com/dyndns.php"
parPass=""
'parIp="111.111.111.111" 'update addr statically, or leave empty to have the server grab the clients address
parIp="" ' Automatically finds it due to <php if(!$addr) { $addr=$_SERVER["REMOTE_ADDR"]; }
parHost="hostname.com" 'host you want to update the A record for

'wget "${base_url}?host=${host}&passwd=${pass}&ip=${ip}"

Set oXmlHttp = CreateObject("MSXML2.XMLHTTP")
sGetUrl = parBaseUrl & "?host=" & parHost & "&passwd=" & parPass & "&ip=" & parIp
WriteDebugLog("GET : " & sGetUrl)
oXmlHttp.open "GET", sGetUrl, False
oXmlHttp.send 
WriteDebugLog(oXmlHttp.responseText)
Set oXmlHttp = nothing


Private Function asTimestamp(aDate, aTime)
	asTimestamp=Year(aDate)&"."&Right("0"&Month(aDate),2)&"."&Right("0"&Day(aDate),2)&" "&Right("0" & Hour(aTime), 2) & ":" & Right("0" & Minute(aTime), 2) & ":" & Right("0" & Second(aTime), 2)
	'  & " -" & utcOffsetSeconds() &"s"
End Function
Private Function debugLogFilename()
	debugLogFilename = sThisDirectory & "\updateIPlog.txt"
End Function
' write logMsg to log  file for debugging
Private Sub WriteDebugLog(logMsg)
	Dim logFile, DebugLog
	logFile = debugLogFilename()
	If oFs.FileExists(logFile) Then
		Set DebugLog = oFs.OpenTextFile(logFile,ForAppending)
	Else
		Set DebugLog = oFs.CreateTextFile(logFile, False)
	End If
	DebugLog.WriteLine "[" & asTimestamp(Date,Time) & "] " & logMsg
	DebugLog.Close
End Sub