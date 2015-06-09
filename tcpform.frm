VERSION 5.00
Object = "{248DD890-BB45-11CF-9ABC-0080C7E7B78D}#1.0#0"; "MSWINSCK.OCX"
Begin VB.Form tcpform 
   BackColor       =   &H00FF8080&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "tcp protocol"
   ClientHeight    =   2460
   ClientLeft      =   3675
   ClientTop       =   2580
   ClientWidth     =   3930
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   2460
   ScaleWidth      =   3930
   Begin MSWinsockLib.Winsock Winsock 
      Left            =   3480
      Top             =   2040
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
   End
   Begin VB.Frame Frame1 
      BackColor       =   &H00FFFFFF&
      Height          =   2415
      Left            =   25
      TabIndex        =   0
      Top             =   -25
      Width           =   3855
      Begin VB.TextBox HostIp 
         BackColor       =   &H00FFC0C0&
         Height          =   285
         Left            =   1560
         TabIndex        =   6
         Text            =   "localhost"
         Top             =   240
         Width           =   1215
      End
      Begin VB.TextBox Text2 
         Height          =   285
         Left            =   120
         TabIndex        =   5
         Top             =   2050
         Width           =   3615
      End
      Begin VB.TextBox Text1 
         Height          =   1455
         Left            =   120
         Locked          =   -1  'True
         MultiLine       =   -1  'True
         ScrollBars      =   2  'Vertical
         TabIndex        =   4
         Top             =   590
         Width           =   3615
      End
      Begin VB.CommandButton Command1 
         Caption         =   "connect"
         Height          =   255
         Left            =   2760
         TabIndex        =   3
         Top             =   240
         Width           =   975
      End
      Begin VB.TextBox Port 
         BackColor       =   &H00FFC0C0&
         Height          =   285
         Left            =   640
         TabIndex        =   2
         Text            =   "2000"
         Top             =   240
         Width           =   900
      End
      Begin VB.Line Line1 
         BorderColor     =   &H00FF8080&
         BorderStyle     =   2  'Dash
         BorderWidth     =   5
         X1              =   0
         X2              =   3840
         Y1              =   50
         Y2              =   50
      End
      Begin VB.Label Label1 
         BackColor       =   &H00FF8080&
         Caption         =   "port:"
         Height          =   255
         Left            =   120
         TabIndex        =   1
         Top             =   240
         Width           =   495
      End
   End
End
Attribute VB_Name = "tcpform"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
If Command1.Caption = "connect" Then
  Winsock.RemotePort = Port.Text
  Winsock.RemoteHost = HostIp.Text
  Winsock.Connect
  Command1.Caption = "disconnect"
  Port.Enabled = False
Else
  Winsock.Close
  Command1.Caption = "connect"
  Port.Enabled = True
End If
End Sub

Private Sub Text2_KeyUp(KeyCode As Integer, Shift As Integer)
On Error Resume Next
If KeyCode = vbKeyReturn And Len(Text2) > 0 Then
  Winsock.SendData Text2
  Text1.SelText = Winsock.LocalHostName & ": " & Text2 & vbCrLf
  Text1.SelStart = Len(Text1)
  Text2 = ""
End If
End Sub

Private Sub Winsock_Close()
Winsock.Close
End Sub

Private Sub Winsock_DataArrival(ByVal bytesTotal As Long)
Dim MessageBuffer As String
Winsock.GetData MessageBuffer
Text1.SelText = "[" & Winsock.RemoteHostIP & "] " & MessageBuffer & vbCrLf
Text1.SelStart = Len(Text1)
End Sub
