class CreateCustomizations < ActiveRecord::Migration
  def self.up
    create_table :customizations do |t|
      t.integer :user_id
      t.string :font_color

      t.timestamps
    end
  end

  def self.down
    drop_table :customizations
  end
end
