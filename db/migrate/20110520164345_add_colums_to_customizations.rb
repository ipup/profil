class AddColumsToCustomizations < ActiveRecord::Migration
  def self.up
    remove_column :customizations, :font_color
    
    add_column :customizations, :color_text_card, :string
    add_column :customizations, :color_bground, :string
    add_column :customizations, :color_lines, :string
    add_column :customizations, :color_text_lines, :string
    add_column :customizations, :color_card, :string
    add_column :customizations, :color_button, :string
    add_column :customizations, :color_title, :string
    
    # add_column :customizations, :font_title, :string - Already Added in previous migrations
    add_column :customizations, :font_card, :string
    add_column :customizations, :font_lines, :string
  end

  def self.down
    add_column :customizations, :font_color, :string
    
    remove_column :customizations, :color_text_card
    remove_column :customizations, :color_bground
    remove_column :customizations, :color_lines
    remove_column :customizations, :color_text_lines
    remove_column :customizations, :color_card
    remove_column :customizations, :color_button
    
    remove_column :customizations, :font_card
    remove_column :customizations, :font_lines
  end
end
