class TagFollow < ApplicationRecord
	belongs_to :tag, optional: true 
end
