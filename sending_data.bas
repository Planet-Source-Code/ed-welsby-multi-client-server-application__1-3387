Attribute VB_Name = "sending_data"
Sub send_data(socket As Integer, data As String)
'use this to send data out to 1 socket.
'all of my server code will use this.
If data = "" Then Exit Sub

main.sock(socket).SendData data
DoEvents

End Sub

Sub mass_send(data As String, exception_socket As Integer)
'this sends data out to EVERY client connected,
'except for the 'exception_socket' socket. leave
'exception_socket' as '0' if you want no exceptions.

'send data to every connected socket
Dim i As Integer
For i = 1 To (main.sock.Count - 1)
If main.sock(i).State = sckConnected And i <> exception_socket Then send_data i, data
Next i

End Sub

Sub send_data_to_clientid(clientid As Integer, data As String)
'use this to send data to a clientid, saves you having
'to find out their socket.

'simple, but saves time
send_data get_socket(clientid), data

End Sub



