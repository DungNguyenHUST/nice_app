class PostFollow < ApplicationRecord
    belongs_to :posts, optional: true
end
