class PostVote < ApplicationRecord
    belongs_to :posts, optional: true 
end
