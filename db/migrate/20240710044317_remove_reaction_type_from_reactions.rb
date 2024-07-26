class RemoveReactionTypeFromReactions < ActiveRecord::Migration[7.1]
  def change
    remove_column :reactions, :reaction_type, :integer
  end
end
