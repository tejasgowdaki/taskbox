class User < ActiveRecord::Base

	has_many :clients, dependent: :destroy
	has_many :projects, dependent: :destroy
	has_many :categories
	has_many :announcements

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
