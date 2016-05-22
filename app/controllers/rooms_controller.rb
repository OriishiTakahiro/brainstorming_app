class RoomsController < ApplicationController

	def list
		@rooms = Room.all.order("updated_at DESC")
	end

  def show
		@messages = Message.where(room_id: params[:id])
		@room = Room.find_by(id: params[:id])
		@room.update( name: @room.name )
  end

	def new
		form = params[:room]
		if(form[:passwd] != form[:confpw]) then 
			redirect_to action: :list, alert: '確認用パスワードが削除用パスワードと一致しません' 
		else
			room = Room.create(name: form[:name], passwd: form[:passwd])
			redirect_to action: :show, id: room.id
		end
	end

end
