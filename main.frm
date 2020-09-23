VERSION 5.00
Object = "{248DD890-BB45-11CF-9ABC-0080C7E7B78D}#1.0#0"; "MSWINSCK.OCX"
Begin VB.Form main 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Server Demo - By Pirotic"
   ClientHeight    =   3165
   ClientLeft      =   45
   ClientTop       =   615
   ClientWidth     =   9750
   Icon            =   "main.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   3165
   ScaleWidth      =   9750
   StartUpPosition =   2  'CenterScreen
   Begin MSWinsockLib.Winsock sock 
      Index           =   0
      Left            =   9240
      Tag             =   "0"
      Top             =   2760
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
   End
   Begin MSWinsockLib.Winsock disallow 
      Left            =   8640
      Top             =   2760
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
   End
   Begin VB.Frame Frame1 
      Caption         =   " Information "
      Height          =   2775
      Left            =   120
      TabIndex        =   1
      Top             =   120
      Width           =   2055
      Begin VB.CommandButton advanced 
         Caption         =   "Client Information"
         Height          =   375
         Left            =   120
         TabIndex        =   6
         Top             =   2280
         Width           =   1815
      End
      Begin VB.Label live_connections_info 
         Caption         =   "N/A"
         Height          =   255
         Left            =   120
         TabIndex        =   5
         Top             =   1080
         Width           =   1815
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Clients Connected :"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   120
         TabIndex        =   4
         Top             =   840
         Width           =   1680
      End
      Begin VB.Label sockets_loaded_info 
         Caption         =   "N/A"
         Height          =   255
         Left            =   120
         TabIndex        =   3
         Top             =   600
         Width           =   1815
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Sockets Loaded :"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   120
         TabIndex        =   2
         Top             =   360
         Width           =   1515
      End
   End
   Begin VB.ListBox status 
      BackColor       =   &H00FFFFFF&
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2700
      Left            =   2280
      TabIndex        =   0
      TabStop         =   0   'False
      Top             =   120
      Width           =   7335
   End
   Begin VB.Menu servertab 
      Caption         =   "Server"
      Begin VB.Menu settingstab 
         Caption         =   "Settings"
      End
      Begin VB.Menu tabthang 
         Caption         =   "-"
      End
      Begin VB.Menu reset_server_tab 
         Caption         =   "Reset"
      End
      Begin VB.Menu tabthing 
         Caption         =   "-"
      End
      Begin VB.Menu shutdown_server 
         Caption         =   "Exit"
      End
   End
   Begin VB.Menu debugtab 
      Caption         =   "Debug"
      Begin VB.Menu start_telnet 
         Caption         =   "TelNet Connect"
      End
   End
End
Attribute VB_Name = "main"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub advanced_Click()
wininfo.Show
End Sub

Private Sub Form_Load()

'start up the server
start_server

'update info
update_info

End Sub

Private Sub Form_Unload(Cancel As Integer)
'when the program ends, close all the sockets.
close_all_sockets
Unload wininfo
Unload Me
End
End Sub

Private Sub reset_server_tab_Click()
reset_server
End Sub

Private Sub settingstab_Click()
'show the settings window
settings_window.Show
End Sub

Private Sub shutdown_server_Click()
Unload Me
End Sub

Private Sub sock_Close(Index As Integer)
'Log out clients once they have quit
logout_client Index, "Connection long"
End Sub

Private Sub sock_DataArrival(Index As Integer, ByVal bytesTotal As Long)
'incomming data,to recive it and send it to get decoded
Dim new_data As String
sock(Index).GetData new_data
DoEvents
decode_data new_data, Index

End Sub

Private Sub sock_Error(Index As Integer, ByVal Number As Integer, Description As String, ByVal Scode As Long, ByVal Source As String, ByVal HelpFile As String, ByVal HelpContext As Long, CancelDisplay As Boolean)
'Log out clients if error on port
logout_client Index, "Error - " & Description
End Sub

Private Sub sock_ConnectionRequest(Index As Integer, ByVal requestid As Long)
'Login a new user on a connection request

If Index = "0" Then

'show in status
'update_status ">> Incomming Connection Request <<"

'login new user
new_connection requestid
DoEvents


End If

End Sub



Private Sub start_telnet_Click()

AppActivate Shell("telnet 127.0.0.1 " & server_port, vbNormalNoFocus)



End Sub
