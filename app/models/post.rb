class Post < ApplicationRecord
    mount_uploader :image, ImageUploader
    has_many :post_votes, dependent: :destroy
    has_many :post_unvotes, dependent: :destroy
    has_many :post_saves, dependent: :destroy
    has_many :post_comments, as: :commentable
end
