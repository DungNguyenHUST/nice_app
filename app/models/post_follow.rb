class PostFollow < ApplicationRecord
    belongs_to :post, optional: true
end
