class TagFollow < ApplicationRecord
	belongs_to :tags, optional: true 
end
