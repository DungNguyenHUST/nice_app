class PostSave < ApplicationRecord
    belongs_to :users
    belongs_to :posts
end
