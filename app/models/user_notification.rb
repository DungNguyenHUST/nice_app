class UserNotification < ApplicationRecord
	belongs_to :users, optional: true 
end
