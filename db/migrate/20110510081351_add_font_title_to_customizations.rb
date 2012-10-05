class AddFontTitleToCustomizations < ActiveRecord::Migration
  def self.up
    add_column :customizations, :font_title, :string
  end

  def self.down
    remove_column :customizations, :font_title
  end
end
