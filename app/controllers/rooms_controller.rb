class RoomsController < ApplicationController

	require 'json'

	def list
		page = params.has_key?(:page) ? params[:page] : 1
		@rooms = Room.page(page).per(8).order('id DESC')
		@count = Room.count
	end

  def show
		@messages = Message.where(room_id: params[:id]).order('id DESC')
		@room = Room.find_by(id: params[:id])
		@room.update( name: @room.name )
  end

	def overview
		@rooms = Room.last(8)
		@num_msg_list = @rooms.map{ |room| Message.where(room_id: room.id).count }
	end

	def update_overview
		if(params.has_key? :rooms)
			rooms = JSON.parse params[:rooms]
			render json: rooms.map{ |room| [room, Message.where(room_id: room).count] }.to_h
		else
			render json: { error: "please send list of room's id" }
		end
	end

	def new
		form = params[:room]
		if(form[:passwd] != form[:confpw]) then 
			redirect_to action: :list, data: { alert: '確認用パスワードが削除用パスワードと一致しません' }
		else
			room = Room.create(name: form[:name], passwd: form[:passwd])
			redirect_to action: :show, id: room.id
		end
	end

	def delete
		room = Room.find_by( id: params[:id] )
		room.delete
		redirect_to action: :list
	end

end
