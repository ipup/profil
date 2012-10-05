class RemoveTinyDescriptionFromUserContents < ActiveRecord::Migration
  def self.up
    remove_column :user_contents, :tiny_description
  end

  def self.down
    add_column :user_contents, :tiny_description, :text
  end
end
