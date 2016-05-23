receivedDat = (data) ->
		if( data['message'] )
			$('#msg-table').prepend data['message']
			$('#count-idea').text(data['count'] + " ideas")
		else if( data['voted'] )
			$('#voted-' + data['id']).text(data['voted'])

App.room = App.cable.subscriptions.create "RoomChannel", {
  connected: ->
    # Called when the subscription is ready for use on the server
  disconnected: ->
    # Called when the subscription has been terminated by the server
  received: (data) -> receivedDat(data)
	say: (message, contributor, room) -> @perform 'say', { message: message, contributor: contributor, room: room }
	vote: (id) -> @perform 'vote', { id: id }
	}

# get text from each input-form and post message information via App.room.say
sayMsg = ->
	message = document.getElementById("input-idea").value
	contributor = document.getElementById("input-contributor").value
	room = document.getElementById("input-room").value
	document.getElementById("input-idea").value = ''
	App.room.say(message, contributor, room)

$(document).on 'click', (event) ->
	console.log event.target.name
	if(event.target.id == 'send-btn')
		sayMsg()
	if(event.target.name == 'vote')
		App.room.vote(event.target.id)
	if(event.target.name == 'copy')
		$('#input-idea').val( $('#message-' + event.target.id).text() )

# execute sayMsg() when pressed Ctrl + Enter
$ ->
	$('#input-idea').on( 'keypress', (event) ->
		if(event.ctrlKey && event.which is 13)
			sayMsg()
)
