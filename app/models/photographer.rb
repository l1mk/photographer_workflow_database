class Photographer < ActiveRecord::Base
  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods
  has_secure_password
  validates :username, :presence => true,
                       :uniqueness => true
  validates :email,    :presence => true,
                       :uniqueness => true
  validates :password, :presence => true
  has_many :sessions
  has_many :clients, through: :sessions

end
