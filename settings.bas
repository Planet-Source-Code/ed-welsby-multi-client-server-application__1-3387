Attribute VB_Name = "settings"


'maximum ammount of clients

'the maximum clients the server will handle
Public Const server_max_clients = 200

'the default maximum number of clients
Public Const default_max_clients = 20
Public max_clients As Integer

'port for clients to connect to
Public Const default_server_port = "6000"
Public server_port As Long

Public live_connections As Integer
