class TasksController < ApplicationController

	def create
		@task = Task.new(task_param)
		if @task.save
			redirect_to project_path(@task.project_id), notice: "Successfully created"
		else
			render "edit"
		end
	end

	private

	def task_param
		params[:task].permit(:title, :is_completed, :due_date, :project_id)
	end

end
