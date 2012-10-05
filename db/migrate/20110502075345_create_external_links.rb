class CreateExternalLinks < ActiveRecord::Migration
  def self.up
    create_table :external_links do |t|
      t.integer :user_id
      t.string :icon
      t.string :url
      t.integer :confidential

      t.timestamps
    end
    
    add_index :external_links, :user_id, :unique => true
  end

  def self.down
    drop_table :external_links
  end
end
