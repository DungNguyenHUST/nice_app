class PostUnvote < ApplicationRecord
    belongs_to :post, optional: true 
end
