class AddFieldtitleToCustomizations < ActiveRecord::Migration
  def self.up
    add_column :customizations, :color_field_title, :string
    add_column :customizations, :font_field_title, :string
  end

  def self.down
    remove_column :customizations, :color_field_title
    remove_column :customizations, :font_field_title
  end
end
