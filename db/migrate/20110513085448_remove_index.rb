class RemoveIndex < ActiveRecord::Migration
  def self.up
    remove_index :external_links, :user_id
    add_index :external_links, :user_id
  end

  def self.down
    remove_index :external_links, :user_id
    add_index :external_links, :user_id, :unique => true
  end
end
