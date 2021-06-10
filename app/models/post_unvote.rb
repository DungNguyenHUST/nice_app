class PostUnvote < ApplicationRecord
    belongs_to :posts, optional: true 
end
