class TopicReport < ApplicationRecord
    belongs_to :topic, optional: true
end
