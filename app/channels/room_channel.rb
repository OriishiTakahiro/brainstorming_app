# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'room_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def say(data)
		message = Message.create(content: data['message'], contributor: data['contributor'], room_id: data['room'])
		count = Message.where(room_id: data['room']).size
		partial_html = ApplicationController.renderer.render(partial: 'messages/message', locals: {message: message })
		dat = { message: partial_html, count: count }
		ActionCable.server.broadcast 'room_channel', dat
  end

	def vote(data)
		message = Message.find_by(id: data['id'])
		message.update( voted: (message.voted+1) )
		dat = { voted: message.voted, id: message.id }
		ActionCable.server.broadcast 'room_channel', dat
	end


end
