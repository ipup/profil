class AddPseudoToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :pseudo, :string
  end

  def self.down
    remove_column :users, :pseudo
  end
end
