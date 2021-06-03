class PostUnvote < ApplicationRecord
    belongs_to :users
    belongs_to :posts
end
