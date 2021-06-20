class UserNotification < ApplicationRecord
	belongs_to :user, optional: true 
end
