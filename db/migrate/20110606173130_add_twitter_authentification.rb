class AddTwitterAuthentification < ActiveRecord::Migration
  def self.up
    remove_column :user_contents, :twitter_username
    
    add_column :user_contents, :twitter_token, :text
    add_column :user_contents, :twitter_secret, :text
  end

  def self.down
    remove_column :user_contents, :twitter_token
    remove_column :user_contents, :twitter_secret
    
    add_column :user_contents, :twitter_username, :string
  end
end
