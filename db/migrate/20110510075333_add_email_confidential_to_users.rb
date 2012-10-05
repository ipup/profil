class AddEmailConfidentialToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :email_confidential, :integer
  end

  def self.down
    remove_column :users, :email_confidential
  end
end
