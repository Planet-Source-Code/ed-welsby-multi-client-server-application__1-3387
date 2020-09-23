Attribute VB_Name = "channels"
'this is an optional module to handle channels in a server, such as IRC protocal.

Public Const max_people_in_room_default = 100 'default limit value
Public Const max_channels = 100 'max channels that can be created
Public Const access_level_required_to_create_channels = 1
Public Const max_channels_per_user = 10 'max chans a user can be in

Type channel_type

clients(max_people_in_room) As Integer 'people in the room
channel As String      'name of channel
topic As String        'topic of channel
created_by As String   'who made it
created_time As String 'when was it made
moderated As Boolean   'is it moderated
invisible As Boolean   'is it invisible
key As String          'does it have a key needed to enter
password As String     'whats the op password
limit As Integer

End Type

'create the array
Public channel(max_channels) As channel_type

Function create_room(clientid As Integer, name As String) As Boolean
'user wants to make a room, return if its made


If client(clientid).access_level >= access_level_required_to_create_channels Then

For i = 1 To max_channels
If channel(i).channel = "" Then
'found an empty room

channel(i).channel = name
channel(i).created_by = client(clientid).nick
channel(i).created_time = f_time
channel(i).invisible = False
channel(i).key = ""
channel(i).moderated = False
channel(i).password = "default"
channel(i).topic = "No Topic Set"
channel(i).limit = max_people_in_room_default

create_room = True
Exit Sub
End If
Next i
'no free room spaces
create_room = False


Else
'cannot create channel (not correct level)
create_room = False

End If

End Function
