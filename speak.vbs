Dim message
message = WScript.Arguments(0)
Set sapi = CreateObject("sapi.spvoice")
sapi.Speak message
