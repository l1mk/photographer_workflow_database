class Client < ActiveRecord::Base
  validates :email,    :presence => true,
                       :uniqueness => true
  has_many :sessions
  has_many :photographers, through: :sessions

end
