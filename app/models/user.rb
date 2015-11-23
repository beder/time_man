class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :recoverable, :rememberable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,:trackable, :validatable

  enum role: %i(user manager admin)

  after_initialize :set_default_role

  has_many :activities, dependent: :destroy

  def set_default_role
    self.role ||= :user if self.new_record?
  end
end
