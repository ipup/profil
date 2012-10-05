class AddImgBackgroundToCustomizations < ActiveRecord::Migration
  def self.up
    add_column :customizations, :img_background, :string
  end

  def self.down
    remove_column :customizations, :img_background
  end
end
