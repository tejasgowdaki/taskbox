class ProjectsController < ApplicationController

	before_action :authenticate_user!

	def index
		@projects = current_user.projects
	end

	def new
		@project = Project.new
	end

	def create
		@project = Project.new(project_param)
		@project.user_id = current_user.id
		if @project.save
			redirect_to project_path(@project), notice: "Successfully created" 
		else
			render action: "new"
		end
	end

	def show
		@project = current_user.projects.find(params[:id])
		@task = Task.new
	end

	def edit 
		begin
			@project = current_user.projects.find(params[:id])
		rescue ActiveRecord::RecordNotFound 
			redirect_to projects_path, notice: "Record not found"
		end
	end

	def update
		begin
			@project = current_user.projects.find(params[:id])
		rescue ActiveRecord::RecordNotFound 
			redirect_to projects_path, notice: "Record not found"
		end
		if @project.update_attributes(project_param)
			redirect_to project_path(@project), notice: "successfully updated"
		else
			render action: "edit"
		end
	end

	def destroy
		begin
			@project = current_user.projects.find(params[:id])
		rescue ActiveRecord::RecordNotFound 
			redirect_to projects_path, notice: "Record not found"
		end
		@project.destroy
		redirect_to projects_path, notice: "Successfully destroyed"
	end

	private

	def project_param
		params[:project].permit(:name, :description, :start_date, :client_id, :status, category_ids: [] )
	end

end
