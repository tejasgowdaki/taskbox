class TasksController < ApplicationController

	def create
		@task = Task.new(task_param)
		if @task.save
			redirect_to project_path(@task.project_id), notice: "Successfully created"
		else
			render action: "new"
		end
	end

	def update
		@task = Task.find(params[:id])
		@task.update_attributes(task_param)
		if @task.is_completed
			Notification.task_completed(@task).deliver
		else
			Notification.task_reopened(@task).deliver
		end
		redirect_to :back
	end

	def mark_as_complete
		task = Task.find(params[:task_id])
		task.update_attributes(is_completed: true)
		Notification.task_completed(task).deliver
		redirect_to :back, notice: "Successfully completed task"
	end

	def mark_as_incomplete
		task = Task.find(params[:task_id])
		task.update_attributes(is_completed: false)
		Notification.task_reopened(task).deliver
		redirect_to :back, notice: "Successfully updated task as incomplete"
	end


	private

	def task_param
		params[:task].permit(:title, :is_completed, :due_date, :project_id)
	end

end
