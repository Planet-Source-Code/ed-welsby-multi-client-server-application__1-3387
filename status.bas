Attribute VB_Name = "status"
Sub update_status(message As String)
'this updates the status window with any new messages
main.status.AddItem "[" & f_time & "] " & message
main.status.ListIndex = (main.status.ListCount - 1)
End Sub
