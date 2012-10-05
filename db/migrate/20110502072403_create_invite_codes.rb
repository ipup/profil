class CreateInviteCodes < ActiveRecord::Migration
  def self.up
    create_table :invite_codes do |t|
      t.integer :user_id
      t.string :code
      t.text :commentary
      t.integer :use_counter

      t.timestamps
    end
  end

  def self.down
    drop_table :invite_codes
  end
end
