class PostLink < ApplicationRecord
    belongs_to :post, optional: true
end
