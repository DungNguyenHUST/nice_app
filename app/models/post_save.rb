class PostSave < ApplicationRecord
    belongs_to :posts, optional: true 
end
