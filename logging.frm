VERSION 5.00
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "TABCTL32.OCX"
Begin VB.Form settings_window 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Server Settings"
   ClientHeight    =   4065
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5670
   Icon            =   "logging.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   4065
   ScaleWidth      =   5670
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton default_settings 
      Caption         =   "Default"
      Height          =   375
      Left            =   120
      TabIndex        =   7
      Top             =   3600
      Width           =   1335
   End
   Begin VB.CommandButton apply_settings 
      Caption         =   "Apply"
      Height          =   375
      Left            =   4200
      TabIndex        =   6
      Top             =   3600
      Width           =   1335
   End
   Begin TabDlg.SSTab SSTab1 
      Height          =   3375
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   5415
      _ExtentX        =   9551
      _ExtentY        =   5953
      _Version        =   327681
      TabHeight       =   520
      TabCaption(0)   =   "General"
      TabPicture(0)   =   "logging.frx":030A
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).Control(0)=   "Frame2"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).ControlCount=   1
      TabCaption(1)   =   "NA"
      TabPicture(1)   =   "logging.frx":0326
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "Frame1"
      Tab(1).ControlCount=   1
      TabCaption(2)   =   "NA"
      TabPicture(2)   =   "logging.frx":0342
      Tab(2).ControlEnabled=   0   'False
      Tab(2).Control(0)=   "Frame3"
      Tab(2).ControlCount=   1
      Begin VB.Frame Frame3 
         Height          =   2775
         Left            =   -74880
         TabIndex        =   5
         Top             =   480
         Width           =   5175
      End
      Begin VB.Frame Frame1 
         Height          =   2775
         Left            =   -74880
         TabIndex        =   4
         Top             =   480
         Width           =   5175
      End
      Begin VB.Frame Frame2 
         Height          =   2775
         Left            =   120
         TabIndex        =   1
         Top             =   480
         Width           =   5175
         Begin VB.TextBox info_port 
            Alignment       =   2  'Center
            Height          =   285
            Left            =   240
            TabIndex        =   8
            Text            =   "TBA"
            Top             =   1320
            Width           =   1575
         End
         Begin VB.TextBox info_max 
            Alignment       =   2  'Center
            Height          =   285
            Left            =   240
            TabIndex        =   2
            Text            =   "TBA"
            Top             =   600
            Width           =   1575
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "Server Port : "
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
            Left            =   240
            TabIndex        =   9
            Top             =   1080
            Width           =   1155
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "Maximum Clients : "
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
            Left            =   240
            TabIndex        =   3
            Top             =   360
            Width           =   1590
         End
      End
   End
End
Attribute VB_Name = "settings_window"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub apply_settings_Click()
'change the settings

'change the max number of clients
If info_max <> "" Then
Let max_clients = info_max
If live_connections > max_clients Then MsgBox "Their are currently more users connect than the limit.", vbOKOnly, "Settings Notice"
End If

'change the server port
If info_port <> server_port And info_port <> "" Then change_server_port info_port



Unload Me
End Sub

Private Sub default_settings_Click()
info_max = default_max_clients
info_port = default_server_port
End Sub

Private Sub Form_Load()
'show the current settings

info_max = max_clients
info_port = server_port

End Sub

Private Sub info_max_Change()
'change max number of users

If info_max = "" Then Exit Sub

On Error GoTo ec
If info_max < 0 Then Let info_max = 0
If info_max > server_max_clients Then info_max = server_max_clients

Exit Sub
ec:
info_max.Text = max_clients

End Sub

Private Sub info_port_Change()


'change max number of users

If info_port = "" Then Exit Sub

On Error GoTo ec
If info_port < 1 Then Let info_port = 1
If info_port > 65535 Then info_port = 65535

Exit Sub
ec:
info_port = server_port


End Sub
