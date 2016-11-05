class Project < ActiveRecord::Base

	has_many :tasks

	has_many :project_categories
	has_many :categories, through: :project_categories


	belongs_to :client
	belongs_to :user

	validates_presence_of :name
	#validates_presence_of :client_id
	#validates_uniqueness_of :name
	validates_length_of :description, minimum: 10

	validate :check_status_on_create, on: :create
	validate :check_start_date, on: :create
	validate :check_client_project_count, on: :create
	validate :check_uniqueness_of_name, on: :create


	def completed_tasks
		self.tasks.where('is_completed = ?', true) 
	end

	def incompleted_tasks
		self.tasks.where('is_completed = ?', false)
	end

	def over_due_tasks
		self.tasks.where('is_completed = ? and due_date < ?', false, Date.today)
	end

	private

	def check_status_on_create
		if self.status != "new"
			errors.add(:status, " is not new")
		end
	end

	def check_start_date
		if !(self.start_date.nil?) && (self.start_date > Date.today + 1.week)
			errors.add(:start_date, " is invalid")
		end
	end

	def check_client_project_count
		project_count = Project.where('client_id = ?', self.client_id).count
		if project_count >= 2
			errors.add(:client_id, " already has 2 projects")
		end
	end


	def check_uniqueness_of_name

		project_names = Project.pluck('name')
		if project_names.include?(self.name)
			errors.add(:name, "already exist")
		end
	end
=begin

		if !(Project.where('name = ?', self.name).nil?)
			errors.add(:name, "already exist")
		end	
=end




end
