class AddBackgroundMosaicToCustomizations < ActiveRecord::Migration
  def self.up
    add_column :customizations, :background_mosaic, :boolean, :default => 'false'
  end

  def self.down
    remove_column :customizations, :background_mosaic
  end
end
