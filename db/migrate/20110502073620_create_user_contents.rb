class CreateUserContents < ActiveRecord::Migration
  def self.up
    create_table :user_contents do |t|
      t.integer :user_id
      t.string :picture
      t.integer :picture_confidential
      t.string :phone
      t.integer :phone_confidential
      t.text :address
      t.integer :address_confidential
      t.text :tiny_description
      t.text :description
      t.integer :description_confidential
      t.string :file_cv
      t.integer :file_cv_confidential

      t.timestamps
    end
    
    add_index :user_contents, :user_id, :unique => true
  end

  def self.down
    drop_table :user_contents
  end
end
