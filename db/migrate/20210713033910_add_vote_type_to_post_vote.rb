class AddVoteTypeToPostVote < ActiveRecord::Migration[6.1]
  def change
    add_column :post_votes, :vote_type, :integer, :default => -1
  end
end
