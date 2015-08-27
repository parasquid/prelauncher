class AddReferrerIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :referrer_id, :integer
    add_index :users, :referrer_id
  end
end
