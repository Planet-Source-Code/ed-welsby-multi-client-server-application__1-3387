VERSION 5.00
Begin VB.Form wininfo 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Client Information"
   ClientHeight    =   4935
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6150
   Icon            =   "Info.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   4935
   ScaleWidth      =   6150
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton refresh_list 
      Caption         =   "Refresh &List"
      Height          =   375
      Left            =   240
      TabIndex        =   10
      Top             =   120
      Width           =   1815
   End
   Begin VB.ComboBox selected_id 
      Height          =   315
      Left            =   3360
      Style           =   2  'Dropdown List
      TabIndex        =   1
      Top             =   240
      Width           =   2655
   End
   Begin VB.Frame Frame1 
      Caption         =   "  Client Settings "
      Height          =   4215
      Left            =   120
      TabIndex        =   0
      Top             =   600
      Width           =   5895
      Begin VB.TextBox info_ip 
         Appearance      =   0  'Flat
         Height          =   285
         Left            =   240
         Locked          =   -1  'True
         TabIndex        =   11
         TabStop         =   0   'False
         Top             =   2400
         Width           =   1695
      End
      Begin VB.CommandButton refresh_button 
         Caption         =   "&Refresh"
         Height          =   375
         Left            =   4440
         TabIndex        =   9
         Top             =   3720
         Width           =   1335
      End
      Begin VB.TextBox info_idle_since 
         Appearance      =   0  'Flat
         Height          =   285
         Left            =   240
         Locked          =   -1  'True
         TabIndex        =   5
         TabStop         =   0   'False
         Top             =   1800
         Width           =   1695
      End
      Begin VB.TextBox info_connected_at 
         Appearance      =   0  'Flat
         Height          =   285
         Left            =   240
         Locked          =   -1  'True
         TabIndex        =   4
         TabStop         =   0   'False
         Top             =   1200
         Width           =   1695
      End
      Begin VB.TextBox info_socket 
         Appearance      =   0  'Flat
         Height          =   285
         Left            =   240
         Locked          =   -1  'True
         TabIndex        =   3
         TabStop         =   0   'False
         Top             =   600
         Width           =   1695
      End
      Begin VB.Label Label5 
         AutoSize        =   -1  'True
         Caption         =   "IP:"
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
         TabIndex        =   12
         Top             =   2160
         Width           =   255
      End
      Begin VB.Label Label4 
         AutoSize        =   -1  'True
         Caption         =   "Idle Since:"
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
         TabIndex        =   8
         Top             =   1560
         Width           =   930
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         Caption         =   "Connected At:"
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
         TabIndex        =   7
         Top             =   960
         Width           =   1230
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Socket:"
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
         TabIndex        =   6
         Top             =   360
         Width           =   675
      End
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Client ID :"
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
      Left            =   2400
      TabIndex        =   2
      Top             =   240
      Width           =   870
   End
End
Attribute VB_Name = "wininfo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Load()

'get the list on load
refresh_list_Click

End Sub

Private Sub refresh_button_Click()
'update info
selected_id_Click
End Sub

Private Sub refresh_list_Click()

selected_id.Clear

'fill the selection list with the possible clientIDs
For i = 1 To max_clients
If client(i).socket <> "0" Then selected_id.AddItem i
Next i

'select the first item
If selected_id.ListCount > 0 Then selected_id.ListIndex = "0"


End Sub

Private Sub selected_id_Click()
'show the info on the selected client

If selected_id = "" Then Exit Sub
If selected_id < 1 Then Exit Sub

info_connected_at = client(selected_id).connected_at
info_idle_since = client(selected_id).idle_since
info_socket = client(selected_id).socket
info_ip = main.sock(client(selected_id).socket).RemoteHostIP

End Sub
