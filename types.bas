Attribute VB_Name = "types"

'this is the data-type for each client.
'it keeps a record of everybody connected
'and also stores data on what socket they
'are using, customize for your needs.

Type client_type

'socket they are using, 0 if not used
socket As Integer

'time they connected
connected_at As String

'remember when his last command was
idle_since As String


End Type

'this creates an array for each possible client
Public client(server_max_clients) As client_type
