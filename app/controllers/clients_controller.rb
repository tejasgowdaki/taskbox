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
		@client.gender = get_gender(@client.name)
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

	def export
		@clients = current_user.clients
	end

	def export_client_details
		@client = current_user.clients.find(params[:client_id])
	end

	def validate_form
		if params[:mobile]
			@client = Client.find_by_mobile(params[:mobile]);
		end
	end

	private

	def client_param
		params[:client].permit(:name, :mobile, :website, :company, :email)
	end

	def get_gender(name)
		response = HTTParty.get("https://www.gender-api.com/get?name=#{name}&key=pRPLCejozFwCHFbVCR")
		return response.parsed_response["gender"]
	end

end
