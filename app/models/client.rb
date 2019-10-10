class Client < ActiveRecord::Base
  #extend Slugifiable::ClassMethods
  #include Slugifiable::InstanceMethods

  has_many :sessions
  has_many :photographers, through: :sessions


end
