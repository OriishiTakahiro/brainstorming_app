receivedDat = (data) ->
		console.log data
		console.log data['message']
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

sayMsg = ->
	message = document.getElementById("input-idea").value
	contributor = document.getElementById("input-contributor").value
	room = document.getElementById("input-room").value
	document.getElementById("input-idea").value = ''
	App.room.say(message, contributor, room)

$(document).on 'click', (event) ->
	if(event.target.id == 'send-btn')
		sayMsg()
	if(event.target.name == 'vote')
		App.room.vote(event.target.id)

$(document).on 'keypress', (event) ->
	if(event.keyCode is 13)
		sayMsg
