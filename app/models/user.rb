class User < ApplicationRecord
  include Clearance::User
  has_many :roles_users, dependent: :destroy
  has_many :roles, through: :roles_users
  has_many :comments, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true


  has_many :blog_posts, dependent: :destroy

  def super_user?
    roles.pluck(:name).include?("SUPER USER")
  end

  def member?
    roles.pluck(:name).include?("MEMBER")
  end
end
