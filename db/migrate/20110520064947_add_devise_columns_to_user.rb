class AddDeviseColumnsToUser < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.confirmable
    end
  end

  def self.down
    # the columns below are manually extracted from devise/schema.rb.
    change_table :users do |t|
      t.remove :confirmation_token
      t.remove :confirmed_at
      t.remove :confirmation_sent_at
    end
  end
end
