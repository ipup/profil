class MergeConfidentialInUserContents < ActiveRecord::Migration
  def self.up
    remove_column :user_contents, :phone_confidential
    remove_column :user_contents, :address_confidential
    
    add_column :user_contents, :info_confidential, :boolean
  end

  def self.down
    remove_column :user_contents, :info_confidential
    
    add_column :user_contents, :address_confidential, :boolean  
    add_column :user_contents, :phone_confidential, :boolean
  end
end
