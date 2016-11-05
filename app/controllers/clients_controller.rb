class ClientsController < ApplicationController

	def index
		@clients = current_user.clients
	end

	def new
		@client = Client.new 
	end

	def create
		@client = Client.new(client_param)
		@client.user_id = current_user.id
		if @client.save
			redirect_to clients_path
		else
			render action: "new"
		end
	end

	def show
		begin
			@client = current_user.clients.find(params[:id])
		rescue ActiveRecord::RecordNotFound
			redirect_to clients_path, notice: "Record not found"
		end
	end

	private

	def client_param
		params[:client].permit(:name, :mobile, :website, :company, :email)
	end

end
