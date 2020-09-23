Attribute VB_Name = "incomming_data"
Option Compare Text 'lose cap sensitivity for this module

Sub decode_data(data As String, socket As Integer)
'a socket has sent some data to the server, write your code
'to translate the data here..

'first update the idle information
client(get_clientid(socket)).idle_since = f_time

'now decode the data

'if mid(data,1,3) = "SAY" then... etc etc


End Sub
