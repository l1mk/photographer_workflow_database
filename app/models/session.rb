class Session < ActiveRecord::Base
  belongs_to :photographer
  belongs_to  :client
  
end
