class User < ActiveRecord::Base
  # Other devise modules are:
  # :token_authenticatable, :encryptable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :lockable, :timeoutable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, 
                  :password, 
                  :remember_me, 
                  :beta_user,
                  :first_name,
                  :last_name

  validates :first_name, :presence => true
  validates :last_name, :presence => true

end
