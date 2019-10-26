class Client < ActiveRecord::Base
  #extend Slugifiable::ClassMethods
  #include Slugifiable::InstanceMethods
  validates :email,    :presence => true,
                       :uniqueness => true

  has_many :sessions
  has_many :photographers, through: :sessions


end
