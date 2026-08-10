class AddIndexToUsersEmail < ActiveRecord::Migration[8.1]
  def change
    add_index :users, :email, unique: true, if_not_exists: true
  end
end
