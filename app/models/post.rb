class Post < ApplicationRecord
    has_many :post_votes, dependent: :destroy
    has_many :post_unvotes, dependent: :destroy
end
