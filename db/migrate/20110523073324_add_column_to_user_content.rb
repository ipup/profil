class AddColumnToUserContent < ActiveRecord::Migration
  def self.up
    add_column :user_contents, :twitter_username, :string
    add_column :user_contents, :facebook_token, :text
    add_column :user_contents, :linkedin_token, :text
    add_column :user_contents, :linkedin_secret, :text
  end

  def self.down
    remove_column :user_contents, :twitter_username
    remove_column :user_contents, :facebook_token
    remove_column :user_contents, :linkedin_token
    remove_column :user_contents, :linkedin_secret
  end
end
