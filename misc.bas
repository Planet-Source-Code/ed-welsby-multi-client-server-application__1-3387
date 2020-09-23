Attribute VB_Name = "misc"
Function get_socket(clientid As Integer) As Integer
'returns the socket which the specified clientid is using

get_socket = client(clientid).socket

End Function

Function get_clientid(socket As Integer) As Integer
'returns the clientid of the client using the specified socket

get_clientid = main.sock(socket).Tag

End Function

Function f_time() As String
'returns time in a nice format

f_time = Format(Time, "hh:mm:ss")

End Function


Sub update_info()

'updates the information on the main form
main.sockets_loaded_info.Caption = count_sockets
main.live_connections_info.Caption = live_connections

End Sub


Sub close_all_sockets()
'close down every socket
'(not designed for restart, deseigned for when sombody closes the program)

Dim i As Integer
For i = 0 To (count_sockets - 1)
main.sock(i).Close
Next i

'show its been shutdown.
update_status "*** Server ShutDown ***"



End Sub

Sub reset_server()
'this totally resets the server.

'show its reset in status
update_status "*** Server Reset ***"

'turn off the main connection socket
main.sock(0).Close

'disconnect all the users
For i = 1 To max_clients
If client(i).socket <> 0 Then logout_client client(i).socket, "Server Reset"
Next i

'start up the main socket again
main.sock(0).Listen

End Sub

Sub start_server()
On Error GoTo ec
'this just starts the main connection socket up to listen

'load settings
set_up_settings

main.sock(0).LocalPort = server_port
main.sock(0).Listen

'show its started in the status
update_status "*** Server Started *** (" & main.sock(0).LocalIP & ":" & server_port & ")"

Exit Sub
ec:
MsgBox "Unable To Start Server - Port In Use", vbExclamation + vbOKOnly, "Error Starting Server"

End Sub

Sub set_up_settings()
'this simply sets up all the settings

'set the maxmimum number of clients
max_clients = default_max_clients
server_port = default_server_port

End Sub
Sub change_server_port(port As Long)
On Error GoTo ec


main.sock(0).Close
main.sock(0).LocalPort = port
main.sock(0).Listen
server_port = info_port
update_status "*** Server Port Changed To - " & server_port

'error controll
Exit Sub
ec:
MsgBox "Error Changing Server Port."
update_status "*** Error Forced Server Port To Remain At - " & server_port
main.sock(0).Close
main.sock(0).LocalPort = server_port
main.sock(0).Listen

End Sub
