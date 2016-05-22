App.room = App.cable.subscriptions.create "RoomChannel", {
  connected: ->
    # Called when the subscription is ready for use on the server
  disconnected: ->
    # Called when the subscription has been terminated by the server
  received: (data) -> $('#msg-table').append data['message']
	say: (message, contributor, room) -> @perform 'say', { message: message, contributor: contributor, room: room }
	vote: (id) -> @perform 'vote', { id: id }
	}

$(document).on 'click', (event) ->
	if(event.target.id == 'send-btn')
		message = document.getElementById("input-idea").value
		contributor = document.getElementById("input-contributor").value
		room = document.getElementById("input-room").value
		document.getElementById("input-idea").value = ''
		App.room.say(message, contributor, room)
	if(event.target.name == 'vote')
		App.room.vote(event.target.id)
