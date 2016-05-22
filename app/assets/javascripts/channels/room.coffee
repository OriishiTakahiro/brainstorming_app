App.room = App.cable.subscriptions.create "RoomChannel", {
  connected: ->
    # Called when the subscription is ready for use on the server
  disconnected: ->
    # Called when the subscription has been terminated by the server
  received: (data) ->	$('#messages').append data['message']
	say: (message, contributor) -> @perform 'say', { message: message, contributor: contributor }
	}

$(document).on 'click', (event) ->
	if(event.target.id == 'send-btn')
		message = document.getElementById("input-idea").value
		contributor =  document.getElementById("input-contributor").value
		document.getElementById("input-idea").value = ''
		App.room.say(message, contributor)
