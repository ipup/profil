class AddTitleToExternalLinks < ActiveRecord::Migration
  def self.up
    add_column :external_links, :title, :string
  end

  def self.down
    remove_column :external_links, :title
  end
end
