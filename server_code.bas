Attribute VB_Name = "login_logout"
'this bas file contains the connection information which
'allows more than 1 user to join, and leave. also handles
'their accounts.

Sub new_connection(requestid As Long)
'new connection, so give them a socket

'socket for new user to have
Dim use_socket As Integer

'check if the server is full (with clients) or not
If live_connections >= max_clients Then disallow_connection requestid, message_1: Exit Sub

'search the loaded sockets to see if any are long
For i = 1 To (main.sock.Count - 1)
If main.sock(i).Tag = "0" Then
use_socket = i
GoTo found_sock
End If
Next i

'no sockets free so create a new socket
Dim socket_to_create As Integer
socket_to_create = main.sock.Count
Load main.sock(socket_to_create)
use_socket = socket_to_create


found_sock:

'log them in (if no socket found then act as if it were full)
If login_client(use_socket, requestid) = False Then disallow_connection requestid, message_1: Exit Sub
'update info
update_info

End Sub

Function login_client(socket As Integer, requestid As Long) As Boolean
'client connected, so now find him a clientid and setup
'his own account, returns if he managed to log in or not

For i = 1 To max_clients
If client(i).socket = "0" Then
'found an empty client





'set client settings
client(i).connected_at = f_time
client(i).idle_since = f_time
client(i).socket = socket

'tag the socket to remember the clientID
main.sock(socket).Tag = i

'connect them on the chosen socket
main.sock(socket).Close
main.sock(socket).Accept requestid

'User logged in ok (show in status)
update_status "Client " & i & " Logged In (" & main.sock(user_socket).RemoteHostIP & ")"

'recount live-connections
live_connections = live_connections + 1

'send welcome message
send_data socket, message_2





login_client = True
Exit Function
End If
Next i
'All sockets are in use, so return as false

End Function

Sub kickout_client(socket As Integer, notice As String)
'if you log them out and what them to know the reason.

send_data socket, notice
logout_client socket, notice


End Sub


Sub logout_client(socket As Integer, reason As String)
'client has disconnected, so close
'his socket, and blank out his clientid
'so sombody else can use it.
'the reason is simply their for status purposes.

'disconnect him
main.sock(socket).Close

'clear his account (remember its the SOCKET, not clientID)
client(main.sock(socket).Tag).connected_at = "N/A"
client(main.sock(socket).Tag).idle_since = "N/A"
client(main.sock(socket).Tag).socket = "0"


'User logged out (show in status)
update_status "Client " & main.sock(socket).Tag & " Logged Out (" & reason & ")"

'Unasign his socket
main.sock(socket).Tag = "0"




'recount live-connections
live_connections = live_connections - 1

'update info
update_info

End Sub

Sub disallow_connection(requestid As Long, reason As String)
'if you dont want sombody to be allowed to connect,
'instead of just not envoking the new_connection command
'envoke this as it lets them connect to a special socket,
'which'll then tell them the reason they cannot connect
'and then disconnect them from intself.
'ideal for 'server full' style messages

'User logged in ok (show in status)
update_status "Client Rejected (" & reason & ")"

'if no reason given, dont try to tell him it
If reason = "" Then Exit Sub


main.disallow.Close
main.disallow.Accept requestid
DoEvents

main.disallow.SendData reason
DoEvents

main.disallow.Close

End Sub


Function count_sockets() As Integer
'show the number of sockets loaded

count_sockets = main.sock.Count

End Function


Sub count_live_connections()
'recount the connections (not used anymore)


'count how many are connected
Dim temp As Integer

For i = 1 To (main.sock.Count - 1)
If main.sock(i).State <> scklong Then temp = temp + 1
Next i

'set it
live_connections = temp

End Sub

