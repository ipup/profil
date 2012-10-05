class CreateOnlineCvFields < ActiveRecord::Migration
  def self.up
    create_table :online_cv_fields do |t|
      t.integer :user_id
      t.string :field_name
      t.text :field_content
      t.integer :confidential

      t.timestamps
    end
  end

  def self.down
    drop_table :online_cv_fields
  end
end
