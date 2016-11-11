class AnnouncementsController < ApplicationController

	def index
		@announcements = current_user.announcements
	end

	def new
		@announcement = Announcement.new
	end

	def create
		@announcement = Announcement.new(announcement_param)
		if @announcement.save
			Notification.new_announcement(@announcement).deliver
			redirect_to announcments_path
		else
			render action: "new"
		end
	end

	private

	def announcement_param
		params[:announcement].permit(:title, :body, :user_id)
	end

end
