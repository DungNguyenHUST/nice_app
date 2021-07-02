class TopicFollow < ApplicationRecord
    belongs_to :topic, optional: true 
end
