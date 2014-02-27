class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :name
  validates_uniqueness_of :name, :email, case_sensitive: false
  before_create :assign_role

  def assign_role
  	self.add_role :user if self.roles.first.nil?
  end
end
