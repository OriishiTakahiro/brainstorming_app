class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(dat)
		if(dat.include? :message)
			ActionCable.server.broadcast 'room_channel', message: dat[:message], count: dat[:count]
		elsif(dat.include? :voted)
			ActionCable.server.broadcast 'room_channel', voted: dat[:voted], id: dat[:id]
		end
  end

end
